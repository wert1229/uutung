<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	var mseq = "${me.mseq}";

	$(function(){
		
		$("#btn-chat").click(function(){
			Send();
		});
		
		$("#content").keydown(function(evt){
			
			if(evt.keyCode==13) {
				Send();
			}	
		});
		
		var culist = JSON.parse('${culist}');		//ChatUnread 안읽은 채팅 리스트
		
		for(var i in culist) {
			
			$(".empNo").each(function(){
				
				if($(this).val()==culist[i].sender) {
					
					$(this).siblings(".alarm").text(culist[i].unread);
				}
			});
		}	
		
		$(".partner").click(function(){
			
			$(".chat").html("");
			
			var receiverMseq = $(this).siblings(".empNo").val();
			var alarm = $(this).siblings(".alarm");
			
			$.ajax({
				type:"POST",
				url:"${path}/chat/getlog",
				data: {"receiverMseq" : receiverMseq},
				dataType: "json",
				success: function(logs){
					var appender = "";
					
					for(var i in logs) {
						
						if(logs[i].sender == mseq) { //내꺼면
						
							appender+= '<li class="right clearfix">';
							appender+= '<span class="chat-img pull-right">';
							appender+= '    <img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />';
							appender+= '</span>';
							appender+= '<div class="chat-body clearfix">';
							appender+= '    <div class="header">';
							appender+= '        <small class="text-muted">';
							appender+= '            <i class="fa fa-clock-o fa-fw"></i> '+logs[i].regdate;
							appender+= '        </small>';
							appender+= '        <strong class="pull-right primary-font">'+logs[i].senderName+'</strong>';
							appender+= '    </div>';
							appender+= '    <p class="pull-right">';
							appender+= logs[i].content;
							appender+= '    </p>';
							appender+= '</div>';
							appender+= '</li>';
						}
						else {
							
							appender+= '<li class="left clearfix">';
							appender+= '<span class="chat-img pull-left">';
							appender+= '    <img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />';
							appender+= '</span>';
							appender+= '<div class="chat-body clearfix">';
							appender+= '    <div class="header">';
							appender+= '        <strong class="primary-font">'+logs[i].senderName+'('+logs[i].senderPos+')'+'</strong>';
							appender+= '        <small class="pull-right text-muted">';
							appender+= '            <i class="fa fa-clock-o fa-fw"></i> '+logs[i].regdate;
							appender+= '        </small>';
							appender+= '    </div>';
							appender+= '    <p>';
							appender+= logs[i].content;
							appender+= '    </p>';
							appender+= '</div>';
							appender+= '</li>';
						}
					}
					
					$(".chat").html(appender);
					$("#scroll").scrollTop($("#scroll")[0].scrollHeight);
					$(alarm).text("");
					$("#content").removeAttr("readonly");
					loadTopnavMsgAlarm();
				} 
			});
		});

		var selectedMseq = "${selectedMseq}";
		
		if(selectedMseq != ""){
			
			$(".empNo").each(function(){
				
				if($(this).val() == selectedMseq){
					
					$(this).siblings(".partner").click();
				}	
			});
		}	
	});

	var sock = new SockJS("${path}/echo");
	
	sock.onopen = onOpen;
	
	sock.onclose = onClose;
	
	sock.onmessage = onMessage;
	
	function onOpen(){
		
		sock.send("first:"+mseq);
	}
	
	function onClose(evt){
		
		sock.close();
	}
	
	function onMessage(evt){
		
		var chat = JSON.parse(evt.data);

		var appender = "";

		var partner = $("input[type='radio']:checked").siblings(".empNo").val();
		
		if(chat.sender == partner) {
			
			appender+= '<li class="left clearfix">';
			appender+= '<span class="chat-img pull-left">';
			appender+= '    <img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />';
			appender+= '</span>';
			appender+= '<div class="chat-body clearfix">';
			appender+= '    <div class="header">';
			appender+= '        <strong class="primary-font">'+chat.senderName+'('+chat.senderPos+')'+'</strong>';
			appender+= '        <small class="pull-right text-muted">';
			appender+= '            <i class="fa fa-clock-o fa-fw"></i> '+chat.regdate;
			appender+= '        </small>';
			appender+= '    </div>';
			appender+= '    <p>';
			appender+= chat.content;
			appender+= '    </p>';
			appender+= '</div>';
			appender+= '</li>';
			
			$(".chat").append(appender);
			$("#scroll").scrollTop($("#scroll")[0].scrollHeight);
			
			$.ajax({
				type:"POST",
				url:"${path}/chat/updateCheck",
				data: {"cseq" : chat.cseq},
				dataType: "text",
				success: function(result){
					
				}
			})
		}
		else {
			
			$(".empNo").each(function(){
				
				if($(this).val()==chat.sender) {
					
					var alarm = $(this).siblings(".alarm");
					
					if($(alarm).text()=="") {
						
						$(alarm).text("1");
					}
					else {
						
						$(alarm).text(parseInt($(alarm).text())+1);
					}
				}
			});
		}
	}
	
	function Send(){
		
		var content = $("#content").val();
		
		if(content==""){
			return false;
		}
		
		var date = getTimeStamp();
		
		var chat={};
		
		chat.sender = mseq;
		chat.senderName = "${me.name}";
		chat.senderPos = "${me.position}";
		chat.receiver = $("input[type='radio']:checked").siblings(".empNo").val();
		chat.content = content;
		chat.regdate = date;
		
		sock.send(JSON.stringify(chat));
		
		var appender = "";
		
		appender+= '<li class="right clearfix">';
		appender+= '<span class="chat-img pull-right">';
		appender+= '    <img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />';
		appender+= '</span>';
		appender+= '<div class="chat-body clearfix">';
		appender+= '    <div class="header">';
		appender+= '        <small class="text-muted">';
		appender+= '            <i class="fa fa-clock-o fa-fw"></i> '+chat.regdate;
		appender+= '        </small>';
		appender+= '        <strong class="pull-right primary-font">'+chat.senderName+'</strong>';
		appender+= '    </div>';
		appender+= '    <p class="pull-right">';
		appender+= chat.content;
		appender+= '    </p>';
		appender+= '</div>';
		appender+= '</li>';
		
		$(".chat").append(appender);
		$("#scroll").scrollTop($("#scroll")[0].scrollHeight);
		$("#content").val("");
	}
	
	function getTimeStamp() {
		
		var d = new Date();
		var s =
		  leadingZeros(d.getFullYear(), 4) + '-' +
		  leadingZeros(d.getMonth() + 1, 2) + '-' +
		  leadingZeros(d.getDate(), 2) + ' ' +
		
		  leadingZeros(d.getHours(), 2) + ':' +
		  leadingZeros(d.getMinutes(), 2) + ':' +
		  leadingZeros(d.getSeconds(), 2);
		
		return s;
	}
	
	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();
		
		if (n.length < digits) {
			
			for (i = 0; i < digits - n.length; i++) {
		    	zero += '0';
			}	
		}
		return zero + n;
	}
</script>
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
	<%@include file="/resources/jspf/topnav.jspf"%>
    <%@include file="/resources/jspf/sidenavGroup.jspf"%>
       
    <div id="page-wrapper">

    	<div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <div class="panel panel-primary" style="margin-top: 30px">
                    <div class="panel-heading">
                    	그룹 메신저
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                    	<div class="row">
				            <div class="col-lg-8">
				                <div class="chat-panel panel panel-info">
				                    <div class="panel-heading">
				                    	채팅 내용
				                    </div>
                    				<div id="scroll" class="panel-body">
			                            <ul class="chat">
			                            	<li>대화 대상을 선택해주세요</li>
			                            </ul>
			                        </div>
			                        <!-- /.panel-body -->
			                        <div class="panel-footer">
			                            <div class="input-group">
			                                <input id="content" type="text" class="form-control input-sm" placeholder="메세지를 입력하세요" readonly />
			                                <span class="input-group-btn">
			                                    <button class="btn btn-warning btn-sm" id="btn-chat">
													보내기			                                      
			                                    </button>
			                                </span>
			                            </div>
			                        </div>
			                        <!-- /.panel-footer -->
                    			</div>
                    		</div>
                    		
                    		<div class="col-lg-4">
				                <div class="panel panel-info">
				                    <div class="panel-heading">
				                    	사내 멤버
				                    </div>
                    				<div class="panel-body" style="overflow: auto;">
                    					<div class="list-group" >
                    						<c:forEach items="${mlist}" var="m">
	                    						<a href="#" class="list-group-item">
				                                    <input type="radio" name="partner" class="partner">
				                                    <i class="fa fa-user fa-fw"></i> ${m.name} <i class="alarm" style="color: red; font-weight: bold;"></i>
				                                    <input type="hidden" class="empNo" value="${m.mseq}">
				                                    <span class="pull-right text-muted small"><em>${m.position}</em>
				                                    </span>
				                                </a>
                    						</c:forEach>
			                            </div>
                    				</div>
                    			</div>
                    		</div>
                    	</div>			
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
		</div>
    </div>       
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>
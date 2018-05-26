<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<script>
var fixedProductList=[];
var searchList=[];
var childWin;

$(function(){
	
	$(".showBranch").change(function(){
	
		var bseq = $(this).val();
		
		if($(this).is(":checked")){
			//나타나게
			$(".b-"+bseq).show();
			
		}else{
			//들어가게
			$(".b-"+bseq).hide();
		}
	});
	
	$(".favorite").click(function(){
		//별바꾸고 , 체크하고, 디스에이블 만든다.
		if($(this).hasClass("glyphicon-star-empty")){
			
			$(this).removeClass("glyphicon-star-empty").addClass("glyphicon-star");
			$(this).prev().prev().prop("checked", true).attr("disabled","disabled");
			$(this).prev().prev().trigger("change");
			
		}else{
			
			$(this).removeClass("glyphicon-star").addClass("glyphicon-star-empty");
			$(this).prev().prev().removeAttr("disabled");
		}
	});
	
	$(document).on("change", ".fixProduct", function(){
	
		if($(this).is(":checked")){
			//색 변하고 고정리스트에 추가시킨다.
			$(this).parent().parent().css("background-color", "#B7F0B1");
			fixedProductList.push($(this).parent().parent());
			
		}else{
			//색 풀고 고정리스트에서 뺀다.
			$(this).parent().parent().css("background-color", "white");
			
			for(var i in fixedProductList) {
				
				if($(fixedProductList[i]).attr("class") == $(this).parent().parent().attr("class")){

					fixedProductList.splice(i, 1);
				}
			}
		}
	});
	
	$("#search").click(function(){
		
		var key = $("#key").val();
		
		$("#base .pname").each(function(){
			
			var pname = $(this).text();
			
			if(pname.search(key) != -1) {
				
				checkFixedList($(this));
			}
		});
		
		showSearch();
	});
	
	$("#fake").html($("#base").html());
	$("#base").hide();
	$("#fake").show();
	
});

function checkFixedList(one) {
	
	for(var i in fixedProductList) {
		
		if( $(fixedProductList[i]).attr("class") == $(one).parent().attr("class")) {

			return;						
		}
	}
	
	searchList.push($(one).parent());
}


function showSearch() {
	
	var fixedContent="";
	var searchContent="";
	
	for(var i in fixedProductList){
	
		fixedContent += '<tr class="'+$(fixedProductList[i]).attr("class")+'"style="background-color: #B7F0B1">';
		fixedContent += fixedProductList[i].html();
		fixedContent += '</tr>';
	}
	
	for(var i in searchList){
		
		searchContent += '<tr class="'+$(searchList[i]).attr("class")+'">';
		searchContent += searchList[i].html();
		searchContent += '</tr>';
	}
	
	$("#fake").html(fixedContent);
	$("#fake .fixProduct").prop("checked",true);
	$("#fake").append(searchContent);
	
	searchList=[];
}

//모달로
function history(bseq, pseq)
{
	$.ajax({
		type:"POST",
		url:"${path}/history",
		data: {"bseq" : bseq, "pseq" : pseq},
		dataType: "json",
		success: function(result){
			
			var history = result.hlist;
			var branchName = result.bname;
			var content ="";
			
			if(history.length > 0)
			{
				content += '<div class="container">';
				content += '<div class="row">';
				content += '    <div class="col-md-9">';
				content += '        <div class="panel panel-default">';
				content += '            <div class="panel-heading">';
		        content += '                <h3 class="panel-title">'+branchName+'</h3>';
		        content += '            </div>';
		        content += '            <div class="panel-body">';
		        content += '               <table class="table table-striped table-bordered table-hover" id="testTable">';
		        content += '					<thead>';
		        content += '						<tr>';
		        content += '							<th>상대</th>';
		        content += '							<th>물품명</th>';
		        content += '							<th>이동 수량</th>';
				content += '							<th>이동 후 잔고</th>';
				content += '							<th>거래 종류</th>';
				content += '							<th>날짜</th>';
				content += '						</tr>';
				content += '					</thead>';
				content += '					<tbody>';
				
				for(var i in history)
				{
					content += '<tr>';
					content += '<td>'+history[i].target+'</td>';
					content += '<td>'+history[i].pname+'</td>';
					content += '<td>'+history[i].quantity+'</td>';
					content += '<td>'+history[i].balance+'</td>';
					content += '<td>'+history[i].kind+'</td>';
					content += '<td>'+history[i].regdate+'</td>';
					content += '</tr>';
					
				}	
				content += '					</tbody>';
				content += '				</table>';
				content += '            </div>';
				content += '        </div>';
				content += '    </div>';
				content += '</div>';
				content += '</div>';
			}
			else
			{
				content = "<span><strong>재고 내역이 존재하지 않습니다</strong></span>";
			}
			
			$(".modal-body").html(content);
			
			$("#modal-btn").click();
		} 
	});
}

window.onunload=function(){
	childWin.close();
}

</script>
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
	<%@include file="/resources/jspf/topnav.jspf"%>
    <%@include file="/resources/jspf/sidenavJaego.jspf"%>
       
    <div id="page-wrapper">

    	<div class="row">
            <div class="col-lg-12">
                <div class="panel panel-primary" style="margin-top: 30px">
                    <div class="panel-heading">
                    	재고 조회
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                    
	                    <div class="col-md-3" style="margin-bottom : 30px;">
	                   		<div class="form-group input-group" style="width:300px;">
                                <input id="key" class="form-control">
                                <span class="input-group-btn">
                                    <button id="search" class="btn btn-primary" type="button">검색</button>
                                </span>
                            </div>
	                    </div>
	                    
                    	<div class="col-md-9" style="margin-bottom : 30px;">
	                    	<button class="btn btn-success" data-toggle="collapse" data-target="#branchList">지점보기</button>
							<div id="branchList" class="collapse">
								<c:forEach items="${balanceList}" var="b" end="6">
									<input type="checkbox" class="showBranch" checked="checked" value="${b.bseq}">
                              		<b>${b.bname}</b>
                              		<span class="glyphicon glyphicon-star-empty favorite" style="color:#FFBB00"></span>
                              	</c:forEach>
							</div> 
                    	</div>
                    	
                        <table class="table table-bordered table-hover" id="testTable">
                            <thead>
                                <tr>
                                	<th>#</th>
                                	<c:forEach items="${balanceList}" var="b" end="6">
                                		<th class="b-${b.bseq}">${b.bname}</th>
                                	</c:forEach>
                                </tr>
                            </thead>
                            <tbody id="base">
                            	<c:forEach items="${balanceList}" var="b" varStatus="status">
                            		<c:if test="${status.index % 7 == 0}">
	                           			<tr class="p-${b.pseq}">
	                           				<th class="pname" style="width: 15%;"><input type="checkbox" class="fixProduct" style="margin-right:5px;">${b.pname}</th>
	                           		</c:if>
	                                    	<td class="b-${b.bseq}" onclick="history('${b.bseq}','${b.pseq}')">${b.balance}</td>
	                                <c:if test="${status.index % 7 == 6}">
	                           			</tr>
	                           		</c:if>
                                </c:forEach>
                            </tbody>
                            <tbody id="fake">
                            </tbody>
                        </table>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
		</div>
		
		<!-- 모달을 위한 공간 !-->		
		<button id="modal-btn" class="btn btn-default" data-target="#layerpop" data-toggle="modal" style="display:none"></button>
		<div class="modal fade" id="layerpop" >
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <!-- header -->
		      <div class="modal-header">
		        <!-- 닫기(x) 버튼 -->
		        <button type="button" class="close" data-dismiss="modal">×</button>
		        <!-- header title -->
		        <h4 class="modal-title">재고 내역</h4>
		      </div>
		      <!-- body -->
		      <div class="modal-body">
		            Body
		      </div>
		      <!-- Footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
		
    </div>       
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>
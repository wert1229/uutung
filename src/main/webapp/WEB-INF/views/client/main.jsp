<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<title>Insert title here</title>
<script>

var table;

$(function(){
	
	table = $("#testTable").DataTable();
	
	var pg = "${pg}";
	
	if(pg!=""){
		
		table.page(pg).draw();
	}
	
    $("#reg").click(function(){
		
		childWin = window.open("${path}/client/addClient", "addBranch",
				"width=600, height=600, top=200, left=600, resizable=no, location=no");
	});
	
	
	$("#deletebtn").click(function(){
		
		var delnums=[];
		
		 $("input[type='checkbox']:checked").each(function(){
			 var delnum =$(this).parent().siblings(".cseq").text();
			 
			 delnums.push(delnum);
		 });
		
		$.ajax({
			
			url: "delclist.do", 
			type: "POST",
			data: {"num" : JSON.stringify(delnums)}, 
		    dataType: "text",
			success: function(delData){
				if(delData== "ok"){
				
					alert("삭제되었습니다.");
					location.href="${path}/client/main";	
				}else{
					
					alert("삭제를 실패하였습니다.")
				}
			}
		});
	});
});

function update(num){
	
	var page = table.page();
	
	window.open("${path}/client/update?num="+num+"&pg="+page,"update","width=600, height=600, top=200, left=600, resizable=no, location=no");
}
</script>
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
                    	거래처 관리
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="testTable">
                            <thead>
                                <tr>
                                	<th class="">선택</th>
                                    <th>거래처 번호</th>
                                    <th>거래처명</th>
                                    <th>거래처대표</th>
                                    <th>거래처 번호</th>
                                    <th>거래처 위치</th>
                                    <th>비고</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${clist}" var="c">
                            		<tr>
                            			
	                                    <td><input type="checkbox"></td>
	                                    <td class="cseq">${c.cseq}</td>
	                                    <td class="name"><a onclick="update(${c.cseq})" href="#">${c.name}</a></td>
										<td class="owner">${c.owner}</td>
										<td class="phone">${c.phone}</td>
										<td class="location">${c.location}</td>
										<td class="note">${c.note}</td>
	                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
                     <div class="col-md-4">
                   		
                   		<button id="reg" type="button" class="btn btn-primary" style="margin-right:10px;">등록</button>
               	    	<button id="deletebtn" type="button" class="btn btn-default" style="margin-right:10px;">선택 삭제</button>
               	    	<button id="excel" type="button" class="btn btn-default">엑셀 다운</button>
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
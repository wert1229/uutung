<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<script>
	
$(function(){
	
	var page = "${page}";
	
	if(page=="") {
		page = 1;
	} else {
		page = parseInt(page);
	}
		
 	$("#testTable").DataTable().page(page-1).draw('page');
 	
	$("#reg").click(function(){
		
		window.open("${path}/branch/new", "addBranch",
				"width=600, height=600, top=200, left=600, resizable=no, location=no");
	});
	
	$("#excel").click(function(){
		
		location.href="${path}/excel";
	});
	
	$("#del").click(function(){
		
		var checkedList=[];
		var page = $(".paginate_button.active a").text();
		
		$("input[type='checkbox']:checked").each(function() {
			
			var bseq = $(this).parent().text(); 

			checkedList.push(bseq);
		});
		
		if(checkedList.length==0) {
			alert("선택된 항목이 없습니다!");
			return;
		}
			
		$.ajax({
			type:"POST",
			url:"${path}/delete",
			data: JSON.stringify(checkedList),
			contentType : 'application/json; charset=utf-8', 
			success: function(result){
				
				if(result==true)
				{
					location.href="${path}/branch/"+page;
				}	
			} 
		});
	});
	
});

function detail(one)
{
	var page = $(".paginate_button.active a").text();
	
	var bseq = $(one).parent().prev().text();
	
	window.open("${path}/branch/edit?page="+page+"&bseq="+bseq, "addBranch",
			"width=600, height=600, top=200, left=600, resizable=no, location=no");
}
</script>
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
	<%@include file="/resources/jspf/topnav.jspf"%>
    <%@include file="/resources/jspf/sidenavGyulJae.jspf"%>
       
    <div id="page-wrapper">

    	<div class="row">
            <div class="col-lg-12">
                <div class="panel panel-primary" style="margin-top: 30px">
                    <div class="panel-heading">
                    	내가 올린 결재
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="testTable">
                            <thead>
                                <tr>
                                    <th>결재 번호</th>
                                    <th>제목</th>
                                    <th>비고</th>
                                    <th>등록일</th>
                                    <th>만료일</th>
                                    <th>진행 현황</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${afmlist}" var="a">
                            		<tr>
	                                    <td>${a.seq}</td>
	                                    <td><a onclick="detail(this)" style="cursor: pointer;">${a.title}</a></td>
	                                    <td>${a.note}</td>
	                                    <td>
	                                    	<fmt:parseDate var="regdate" value="${a.regdate}" pattern="yyyy-MM-dd HH:mm:ss" />
	                                    	<fmt:formatDate value="${regdate}" type="date" pattern="yyyy-MM-dd HH:mm" />
	                                    </td>
	                                    <td>
	                                    	<fmt:parseDate var="expdate" value="${a.expdate}" pattern="yyyy-MM-dd HH:mm:ss" />
	                                    	<fmt:formatDate value="${expdate}" type="date" pattern="yyyy-MM-dd" />
	                                    </td>
	                                    <td><strong class="primary-font">${a.state}</strong></td>
	                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
                     <div class="col-md-4">
                   		<button id="reg" type="button" class="btn btn-primary" style="margin-right:10px;">등록</button>
               	    	<button id="del" type="button" class="btn btn-default" style="margin-right:10px;">선택 삭제</button>
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
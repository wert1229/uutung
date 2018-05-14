<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<title>Insert title here</title>
<script>
	$(function(){
		$("#search").click();
	})
	
	function search(){
		var key = $("#key").val();

		$.ajax({
			type:"POST",
			url:"${path}/searchClient",
			dataType : 'json',
			data: { "key" : key},
			success: function(clist){
				var content="";
				
				if(clist.length != 0)
				{	
					content+='<table class="table table-striped table-bordered table-hover" id="testTable">';
					content+='<thead><tr><th>거래처코드</th><th>이름</th><th>대표</th><th>연락처</th><th>담당자</th><th>비고</th></tr></thead>';
					content+='<tbody>';
					
					for(var i in clist){
						content+='<tr onclick="select(this)">';
						content+='<td>'+ clist[i].cseq +'</td>';
						content+='<td>'+ clist[i].name +'</td>';
						content+='<td>'+ clist[i].owner +'</td>';
						content+='<td>'+ clist[i].phone +'</td>';
						content+='<td>'+ '담당자아무개' +'</td>';
						content+='<td>'+ clist[i].note +'</td>';
						content+='</tr>';
						
					}
					
					content+='</tbody>';
					content+='</table>';
				}
				else
				{
					content="검색 결과가 없습니다!"	;
				}
				
				$("#content").html(content);
				
				$("#testTable").DataTable({
					searching : false,
					ordering : false,
					lengthChange : false,
					info : false
				});
			} 
		});
	}
	
	function select(one){
		var client = $(one).children("td");
		
		var cseq = $(client).eq(0).text();
		var name = $(client).eq(1).text();
		var owner = $(client).eq(2).text();;
		var phone = $(client).eq(3).text();;
		var charge = $(client).eq(4).text();;
		var note = $(client).eq(5).text();;
		
		$("#cseq", opener.document).val(cseq);
		$("#name", opener.document).text(name);
		$("#owner", opener.document).text(owner);
		$("#phone", opener.document).text(phone);
		$("#charge", opener.document).text(charge);
		$("#note", opener.document).text(note);
		
		window.close();
	}
</script>
</head>
<body>
	<div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">거래처 검색</h3>
                    </div>
                    <div class="panel-body">
	                    <div class="form-group input-group">
	                        <input type="text" id="key" class="form-control" value="${key}">
	                        <span class="input-group-btn">
	                            <button id="search" class="btn btn-default" type="button" onclick="search()"><i class="fa fa-search"></i>
	                            </button>
	                        </span>
	                    </div>
	                    <div id="content">
	                    	
	                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
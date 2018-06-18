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
	});
	
	function search(){
		var key = $("#key").val();
		
		$.ajax({
			type:"POST",
			url:"${path}/branch/searchBranch",
			dataType : 'json',
			data: { "key" : key},
			success: function(blist){
				var content="";
				
				if(blist.length != 0)
				{	
					content+='<table class="table table-striped table-bordered table-hover" id="testTable">';
					content+='<thead><tr><th>매장코드</th><th>매장명</th><th>관리자</th><th>연락처</th><th>주소</th></tr></thead>';
					content+='<tbody>';
					
					for(var i in blist){
						content+='<tr onclick="select(this)">';
						content+='<td>'+ blist[i].bseq +'</td>';
						content+='<td>'+ blist[i].name +'</td>';
						content+='<td>'+ blist[i].managerPos + ' ' + blist[i].managerName + '('+blist[i].manager+')' +'</td>';
						content+='<td>'+ blist[i].phone +'</td>';
						content+='<td>'+ blist[i].location +'</td>';
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
		
		var branch = $(one).children("td");
		
		var bseq = $(branch).eq(0).text();
		var name = $(branch).eq(1).text();
		var manager = $(branch).eq(2).text();
		var phone = $(branch).eq(3).text();
		var location = $(branch).eq(4).text();
		
		$("#bseq", opener.document).val(bseq);
		$("#name", opener.document).text(name);
		$("#manager", opener.document).text(manager);
		$("#phone", opener.document).text(phone);
		$("#location", opener.document).text(location);
		
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
                        <h3 class="panel-title">매장 검색</h3>
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
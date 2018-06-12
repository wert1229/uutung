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
			url:"${path}/client/searchClient",
			dataType : 'json',
			data: { "key" : key},
			success: function(clist){
				var content="";
				
				alert(clist.length);
				
				if(clist.length != 0)
				{	
					content+='<table class="table table-striped table-bordered table-hover" id="testTable">';
					content+='<thead><tr><th>거래처번호</th><th>거래처명</th><th>거래처대표</th><th>거래처번호</th><th>거래처주소</th></tr></thead>';
					content+='<tbody>';
					
					for(var i in clist){
						alert(clist[i].name);
						content+='<tr>';
						content+='<td><a onclick=insertClient(this) style="cursor: pointer;">'+ clist[i].cseq +'</a></td>';
						content+='<td>'+ clist[i].name +'</td>';
						content+='<td>'+ clist[i].owner +'</td>';
						content+='<td>'+ clist[i].phone +'</td>';
						content+='<td>'+ clist[i].location +'</td>';
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
	
	function insertClient(one){
		var cseq = $(one).text();
		
		alert(cseq);
		$("#cseq", opener.document).val(cseq);
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
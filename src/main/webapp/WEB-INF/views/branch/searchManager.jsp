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
			url:"${path}/searchManager",
			dataType : 'json',
			data: { "key" : key},
			success: function(mlist){
				var content="";
				
				if(mlist.length != 0)
				{	
					content+='<table class="table table-striped table-bordered table-hover" id="testTable">';
					content+='<thead><tr><th>사번</th><th>이름</th><th>직급</th></tr></thead>';
					content+='<tbody>';
					
					for(var i in mlist){
						content+='<tr onclick="select(this)">';
						content+='<td>'+ mlist[i].mseq +'</td>';
						content+='<td>'+ mlist[i].name +'</td>';
						content+='<td>'+ mlist[i].position +'</td>';
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
			} 
		});
	}
	
	function select(one){
		
		var value = $(one).children("td:eq(0)").text();
		
		$("#manager", opener.document).val(value);
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
                        <h3 class="panel-title">담당자 검색</h3>
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
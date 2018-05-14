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
			url:"${path}/searchProduct",
			dataType : 'json',
			data: { "key" : key},
			success: function(plist){
				var content="";
				
				if(plist.length != 0)
				{	
					content+='<table class="table table-striped table-bordered table-hover" id="testTable">';
					content+='<thead><tr><th>물품코드</th><th>품목명</th><th>분류</th><th>비고</th></tr></thead>';
					content+='<tbody>';
					
					for(var i in plist){
						content+='<tr onclick="select(this)">';
						content+='<td>'+ plist[i].pseq +'</td>';
						content+='<td>'+ plist[i].name +'</td>';
						content+='<td>'+ plist[i].category +'</td>';
						content+='<td>'+ plist[i].note +'</td>';
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
				}).page.len(10).draw();
			} 
		});
	}
	
	function select(one){
		var no = parseInt("${no}")-1;
		var product = $(one).children("td");
		
		var pseq = $(product).eq(0).text();
		var name = $(product).eq(1).text();
		var category = $(product).eq(2).text();;
		var note = $(product).eq(3).text();;
		
		$(".productList:eq("+no+") .pseq", opener.document).val(pseq);
		$(".productList:eq("+no+") .name", opener.document).text(name);
		$(".productList:eq("+no+") .category", opener.document).text(category);
		$(".productList:eq("+no+") .note", opener.document).val(note);
		
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
                        <h3 class="panel-title">품목 검색</h3>
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
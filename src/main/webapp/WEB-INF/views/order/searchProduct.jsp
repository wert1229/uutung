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
		var cseq = opener.document.getElementById("cseq").value;
			
		$.ajax({
			type:"POST",
			url:"${path}/order/searchProduct",
			dataType : 'json',
			data: { "key" : key,
					"cseq" : cseq },
			success: function(elist){
				var content="";
				
				if(elist.length != 0)
				{	
					content+='<table class="table table-striped table-bordered table-hover" id="testTable">';
					content+='<thead><tr><th>물품코드</th><th>품목명</th><th>분류</th><th>단가</th><th>비고</th></tr></thead>';
					content+='<tbody>';
					
					for(var i in elist){
						content+='<tr onclick="select(this)">';
						content+='<td>'+ elist[i].pseq +'</td>';
						content+='<td>'+ elist[i].name +'</td>';
						content+='<td>'+ elist[i].category +'</td>';
						content+='<td>'+ elist[i].price +'</td>';
						content+='<td>'+ elist[i].note +'</td>';
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
		var category = $(product).eq(2).text();
		var price=  $(product).eq(3).text();
		var note = $(product).eq(4).text();
		
		$("#pno", opener.document).val(no);
		$("#pseq", opener.document).val(pseq);
		$("#pname", opener.document).val(name);
		$("#pcategory", opener.document).val(category);
		$("#price",opener.document).val(price);
		$("#pnote", opener.document).val(note);
		
		window.opener.valueInsert();
		
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
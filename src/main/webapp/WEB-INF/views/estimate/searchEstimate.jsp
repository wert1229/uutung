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
			url:"${path}/searchEstimate",
			dataType : 'json',
			data: { "key" : key},
			success: function(elist){
				var content="";
				
				if(mlist.length != 0)
				{	
					content+='<table class="table table-striped table-bordered table-hover" id="searchEstimateTable">';
					content+='<thead><tr><th>견적코드</th><th>가격</th><th>품목코드</th><th>거래처코드</th></tr></thead>';
					content+='<tbody>';
					
					for(var i in elist){
						content+='<tr onclick="select(this)">';
						content+='<td>'+ elist[i].eseq +'</td>';
						content+='<td>'+ elist[i].price +'</td>';
						content+='<td>'+ elist[i].productSq +'</td>';
						content+='<td>'+ elist[i].clientSq +'</td>';
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
				
				$("#searchEstimateTable").DataTable({
					searching : false,
					ordering : false,
					lengthChange : false,
					info : false
				});
			} 
		});
	}
	
	function select(one){
		var eseq = $(one).children("td:eq(0)").text();
		var price = $(one).children("td:eq(2)").text();
		
		var value = eseq +" ("+price+")";
		
		$("#productSq", opener.document).val(value);
		$("#estimate", opener.document).val(eseq);
		
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
                        <h3 class="panel-title">견적 검색</h3>
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
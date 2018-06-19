<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<script>

var childWin

$(function(){
	
	var page = "${page}";
	var pseq = "${pseq}";
		
	if(page=="") {
		page = 1;
	} else {
		page = parseInt(page);
	}
	
	$("#detailEstimateTable").DataTable().page(page-1).draw('page');
	
	$("#reg").click(function(){
		childWin = window.open("${path}/estimate/new?pseq="+pseq, "addEstimate",
				"width=600, height=600, top=200, left=700, resizable=no, location=no");
	});
	
	$("#excel").click(function(){
		
		location.href="${path}/estimate/eExcelDownload";
	});
	
	$("#del").click(function(){
		
		var checkedList=[];
		var page = $(".paginate_button.active a").text();
		
		$("input[type='checkbox']:checked").each(function() {
			
			var eseq = $(this).parent().siblings(".eseq").text(); 
			checkedList.push(eseq);
		});
		
		if(checkedList.length==0) {
			alert("선택된 항목이 없습니다!");
			return;
		}
			
		$.ajax({
			type:"POST",
			url:"${path}/estimate/delEstimate",
			data: JSON.stringify(checkedList),
			contentType : 'application/json; charset=utf-8', 
			success: function(result){
				
				if(result==true)
				{
					alert("삭제되었습니다.");
					location.href="${path}/estimate/detail?page="+page+"&pseq="+pseq;
				}	
			} 
		});
	});
	
	$("#ok").click(function(){
		
		var checkedList=[];
		var page = $(".paginate_button.active a").text();
		
		$("input[type='checkbox']:checked").each(function() {
			
			var eseq = $(this).parent().siblings(".eseq").text();
			
			checkedList.push(eseq);
			
		});
		
		if(checkedList.length==0) {
			alert("선택된 항목이 없습니다!");
			return;
		}
			
		$.ajax({
			type:"POST",
			url:"${path}/estimate/okEstimate",
			data: JSON.stringify(checkedList),
			contentType : 'application/json; charset=utf-8', 
			success: function(result){
				
				if(result==true)
				{
					alert("승인되었습니다.");
					location.href="${path}/estimate/detail?page="+page+"&pseq="+pseq;
				}	
			} 
		});
	});
	
	$("#cancle").click(function(){
		$(opener.location).attr("href", "${path}/estimate?page="+page);
		window.close();
	});
});

window.onunload=function(){
	childWin.close();
};

function edit(one)
{
	var page = $(".paginate_button.active a").text();
	
	var eseq = $(one).parent().prev().text();
	
	window.open("${path}/estimate/edit?page="+page+"&eseq="+eseq, "editEstimate",
			"width=600, height=600, top=200, left=600, resizable=no, location=no");
}

function detailProduct(one)
{
	var page = $(".paginate_button.active a").text();
	
	var opseq = $(one).text();  
	
	var pseq = opseq.substring(opseq.indexOf("(")+1, opseq.indexOf(")"));
	
	window.open("${path}/product/edit?page="+page+"&pseq="+pseq, "detailProduct",
			"width=600, height=600, top=200, left=600");
}

function detailClient(one)
{
	var page = $(".paginate_button.active a").text();
	
	var ocseq = $(one).text(); 
	var cseq = ocseq.substring(ocseq.indexOf("(")+1, ocseq.length-1);
	
	window.open("${path}/client/edit?page="+page+"&cseq="+cseq, "detailClient",
			"width=1500, height=auto, top=200, left=600, resizable=no, location=no");
}
</script>
<title>견적 품목</title>
</head>
<body>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">견적 품목</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
    	<div class="panel panel-primary" style="margin-top: 30px">
        	<div class="panel-heading">
            	견적 품목
			</div>
            <div class="panel-body">
            	<table class="table table-striped table-bordered table-hover" id="detailEstimateTable">
                	<thead>
                    	<tr>
                        	<th>선택</th>
                            <th>견적코드</th>
                            <th>가격</th>
                            <th>품명(품목코드)</th>
                            <th>거래처명(거래처코드)</th>
                            <th>상태</th>
						</tr>
					</thead>
                    <tbody>
                    	<c:forEach items="${elist}" var="e">
							<tr>
								<td><input type="checkbox"></td>
								<td class="eseq">${e.eseq}</td>
								<td class="price">
									<a class="edit" onclick="edit(this)" style="cursor: pointer;">${e.price}</a>
								</td>
								<td class="productSq">
									<a class="detailProduct" onclick="detailProduct(this)" style="cursor: pointer;">${e.productName} (${e.productSq})</a>
								</td>
								<td class="clientSq">${e.clientName} (${e.clientSq})</td>
								<td class="eState">${e.state}</td>
							</tr>							
						</c:forEach>
					</tbody>
				</table>
                <div class="col-md-8">
                	<button id="reg" type="button" class="btn btn-primary" style="margin-right:10px;">등록</button>
                    <button id="del" type="button" class="btn btn-danger" style="margin-right:10px;">선택 삭제</button>
               	    <button id="excel" type="button" class="btn btn-default" style="margin-right:10px;">엑셀 다운</button>
               	    <button id="ok" type="button" class="btn btn-success">견적 승인</button>
               	    <button id="cancle" type="button" class="btn btn-warning">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
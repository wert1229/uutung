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
	
	if(page=="") {
		page = 1;
	} else {
		page = parseInt(page);
	}
	
	$("#mainEstimateTable").DataTable().page(page-1).draw('page');
	
	$("#reg").click(function(){
		
		childWin = window.open("${path}/estimate/new", "addEstimate",
				"width=600, height=600, top=200, left=600, resizable=no, location=no");
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
					location.href="${path}/estimate?page="+page;
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
					location.href="${path}/estimate?page="+page;
				}	
			} 
		});
	});
});

/* window.onunload=function(){
	childWin.close();
}; */

function edit(one)
{
	var page = $(".paginate_button.active a").text();
	
	var eseq = $(one).parent().prev().text();
	
	alert(eseq);
	
	window.open("${path}/estimate/edit?page="+page+"&eseq="+eseq, "addEstimate",
			"width=600, height=600, top=200, left=600, resizable=no, location=no");
}

function detailProduct(one)
{
	var page = $(".paginate_button.active a").text();
	
	var pseq = $(one).text(); // () 안의 코드만 빼올 수 있는지 
	
	alert(pseq);
	
	window.open("${path}/product/edit?page="+page+"&pseq="+pseq, "addEstimate",
			"width=600, height=600, top=200, left=600, resizable=no, location=no");
}

function detailClient(one)
{
	var page = $(".paginate_button.active a").text();
	
	var cseq = $(one).text(); // () 안의 코드만 빼올 수 있는지
	
	alert(cseq);
	
	window.open("${path}/client/edit?page="+page+"&cseq="+cseq, "addEstimate",
			"width=600, height=600, top=200, left=600, resizable=no, location=no");
}
</script>
<title>견적 관리</title>
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
                    	견적 관리
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="mainEstimateTable">
                            <thead>
                                <tr>
                                    <th>선택</th>
                                    <th>견적코드</th>
                                    <th>가격</th>
                                    <th>품명(품목코드)</th>
                                    <th>거래처명(거래처코드)</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${elist}" var="e">
									<tr>
										<td><input type="checkbox"></td>
										<td class="eseq">${e.eseq}</td>
										<td class="price"><a class="edit" onclick="edit(this)" style="cursor: pointer;">${e.price}</a></td>
										<%-- <td class="productSq">${e.productSq}</td>
										<td class="clientSq">${e.clientSq}</td> --%>
										<td class="productSq">
											<%-- <p type="hidden" value="${e.productSq}">${e.productSq}</p> --%>
											<a class="detailProduct" onclick="detailProduct(this)" style="cursor: pointer;">${e.productName} (${e.productSq})</a>
										</td>
										<td class="clientSq"><a class="detailClient" onclick="detailClient(this)" style="cursor: pointer;">${e.clientName} (${e.clientSq})</a></td>
									</tr>							
								</c:forEach>
                            </tbody>
                        </table>
                     <div class="col-md-4">
                    		<button id="reg" type="button" class="btn btn-primary" style="margin-right:10px;">등록</button>
                    		<button id="del" type="button" class="btn btn-default" style="margin-right:10px;">선택 삭제</button>
               	    		<button id="excel" type="button" class="btn btn-default" style="margin-right:10px;">엑셀 다운</button>
               	    		<button id="ok" type="button" class="btn btn-success">견적 승인</button>
                     </div>
                    </div>
                </div>
            </div>
		</div>
    </div>       
</div>
</body>
</html>
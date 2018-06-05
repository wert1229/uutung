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
	
	$("#mainProductTable").DataTable().page(page-1).draw('page');
	
	/* $("#popupImg").click(function(){
		
		childWin = window.open("${product.img}", "width=600, height=600, top=200, left=600, resizable=no, location=no");
		
	}); */
	
	$("#reg").click(function(){
		
		childWin = window.open("${path}/product/new", "addProduct",
				"width=600, height=800, top=100, left=600, resizable=no, location=no");
	});
	
	$("#excel").click(function(){
		
		location.href="${path}/product/pExcelDownload";
	});
	
	$("#del").click(function(){
		
		var checkedList=[];
		var page = $(".paginate_button.active a").text();
		
		$("input[type='checkbox']:checked").each(function() {
			
			var pseq = $(this).parent().siblings(".pseq").text(); 
			checkedList.push(pseq);
		});
		
		if(checkedList.length==0) {
			alert("선택된 항목이 없습니다!");
			return;
		}
			
		$.ajax({
			type:"POST",
			url:"${path}/product/delProduct",
			data: JSON.stringify(checkedList),
			contentType : 'application/json; charset=utf-8', 
			success: function(result){
				
				if(result==true)
				{
					alert("삭제되었습니다.");
					location.href="${path}/product?page="+page;
				}	
			} 
		});
	});
});

window.onunload=function(){
	childWin.close();
};

function edit(one)
{
	var page = $(".paginate_button.active a").text();
	
	var pseq = $(one).parent().prev().text();
	
	window.open("${path}/product/edit?page="+page+"&pseq="+pseq, "addProduct",
			"width=600, height=800, top=100, left=600, resizable=no, location=no");
}

function popupImg(one)
{
	var page = $(".paginate_button.active a").text();
	
	var img = $(one).prev().val();
	
	alert(img);
	
	img = img.substr(5);
	
	alert(img);
	
	window.open("${path}"+img, "addProduct", "width=600, height=800, top=100, left=600, resizable=no, location=no");
}
</script>
<title>Product Main</title>
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
                    	품목 관리
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="mainProductTable">
                            <thead>
                                <tr>
                                    <th>선택</th>
                                    <th>품목 코드</th>
                                    <th>품명</th>
                                    <th>이미지</th>
                                    <th>분류</th>
                                    <th>비고</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${plist}" var="p">
									<tr>
										<td><input type="checkbox"></td>
										<td class="pseq">${p.pseq}</td>
										<td class="name"><a class="edit" onclick="edit(this)" style="cursor: pointer;">${p.name}</a></td>
										<td class="img">
											<c:if test="${!empty p.img}">
												<%-- <a href="${p.img}" target="new">Y</a> --%>
												<input id="popup" type="hidden" value="${p.img}">
												<a onclick="popupImg(this)" style="cursor:pointer;">Y</a>
											</c:if>
											<c:if test="${empty p.img}">
												N
											</c:if>
										</td>
										<td class="category">${p.category}</td>
										<td class="note">${p.note}</td>
										<td class="state">${p.state}</td>
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
                </div>
            </div>
		</div>
    </div>       
</div>
</body>
</html>
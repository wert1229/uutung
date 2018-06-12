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
	
});

window.onunload=function(){
	childWin.close();
};

function detailEstimate(one) {
	/* var page = $(".paginate_button.active a").text(); */
	
	var pseq = $(one).parent().prev().text(); 
	window.open("${path}/estimate/detail?pseq="+pseq, "detailEstimate",
			"width=800px, height=600px, top=100, left=300, resizable=no, location=no");
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
                                    <th>품목코드</th>
                                    <th>품명</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${plist}" var="p">
									<c:if test="${p.state=='Y'}">
									<tr>
										<td class="productSq">${p.pseq}</td>
										<td class="productName">
											<a class="detailEstimate" onclick="detailEstimate(this)" style="cursor: pointer;">${p.name}</a>
										</td>
										<td class="productState">${p.state}</td>
									</tr>
									</c:if>							
								</c:forEach>
                            </tbody>
                        </table>
                     <!-- <div class="col-md-4">
                    	<button id="reg" type="button" class="btn btn-primary" style="margin-right:10px;">견적품목등록</button>
                     </div> -->
                    </div>
                </div>
            </div>
		</div>
    </div>       
</div>
</body>
</html>
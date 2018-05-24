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
 	$("#testTable").DataTable();
 	
/* 	$("#excel").click(function(){
		
		location.href="${path}/move/excel";
	}); */
	
	$("#reg").click(function(){
		
		location.href="${path}/order/addorder";
	});

	
});


function detailorder(ocseq)
{
	childWin = window.open("${path}/order/orderdetail?ocseq="+ocseq, "",
		"width=800, height=600, top=300, left=800, resizable=no, location=no");
}


</script>
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
                    	발주 조회
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="testTable">
                            <thead>
                                <tr>
                                    <th>발주 번호</th>
                                    <th>제목</th>
                                    <th>거래처명</th>
                                    <th>품목명</th>
                                    <th>납기일</th>
									<th>진행 현황</th>
                  
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${olist}" var="o">
                            		<tr>
	                                    <td>${o.ocseq}</td>
	                                    <td>${o.title}</td>
	                                    <td>${o.name}</td>
	                                    <td><a onclick="detailorder('${o.ocseq}')" style="cursor: pointer">${o.note}</a></td>
	                                  	<td>${o.estdate}</td>
	                                    <td><strong class="primary-font"></strong>${o.state}</td>
	                       
	                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
                     <div class="col-md-4">
                   		<button id="reg" type="button" class="btn btn-primary" style="margin-right:10px;">등록</button>
               	    	<button id="excel" type="button" class="btn btn-default">엑셀 다운</button>
                     </div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
		</div>
    </div>       
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>
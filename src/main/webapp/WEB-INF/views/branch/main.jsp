<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<script>
$(function(){
	$("#testTable").DataTable();
	
	$("#reg").click(function(){
		
		window.open("${path}/branch/new", "addBranch",
				"width=600, height=600, top=200, left=600, resizable=no, location=no");
	});
	
	$("#excel").click(function(){
		
		location.href="${path}/excelDownload";
	});
});
</script>
<title>Insert title here</title>
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
                    	매장 관리
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="testTable">
                            <thead>
                                <tr>
                                    <th>매장 코드</th>
                                    <th>매장 이름</th>
                                    <th>매장 관리자</th>
                                    <th>매장 연락처</th>
                                    <th>매장 위치</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${blist}" var="b">
                            	
                            	</c:forEach>
                                <tr>
                                    <td><input type="checkbox">1</td>
                                    <td><a href="#">Mark</a></td>
                                    <td>Otto</td>
                                    <td>@mdo</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Jacob</td>
                                    <td>Thornton</td>
                                    <td>@fat</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>Larry</td>
                                    <td>the Bird</td>
                                    <td>@twitter</td>
                                </tr>
                            </tbody>
                        </table>
                     <div class="col-md-4">
                   		<button id="reg" type="button" class="btn btn-primary" style="margin-right:10px;">등록</button>
               	    	<button id="excel" type="button" class="btn btn-danger">엑셀 다운</button>
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
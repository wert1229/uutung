<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<script>
var childWin;

$(function(){
	
 	$("#testTable").DataTable();
 	
	$("#excel").click(function(){
		
		location.href="${path}/move/excel";
	});
	
	$("#reg").click(function(){
		
		location.href="${path}/move/new";
	});
});

function detail(mseq)
{
	childWin = window.open("${path}/move/mldetail?mseq="+mseq, "searchThings",
		"width=600, height=600, top=300, left=800, resizable=no, location=no");
}

window.onunload=function(){
	childWin.close();
}
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
                    	재고 이동 조회
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover" id="testTable">
                            <thead>
                                <tr>
                                    <th>결재 코드</th>
                                    <th>제목</th>
                                    <th>대상 매장</th>
                                    <th>물품</th>
                                    <th>종류</th>
                                    <th>물품 납기일</th>
                                    <th>진행 현황</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${mtdlist}" var="m">
                            		<tr>
	                                    <td>${m.mseq}</td>
	                                    <td>${m.title}</td>
	                                    <td>${m.branchName}</td>
	                                    <td><a onclick="detail('${m.mseq}')" style="cursor: pointer">${m.note}</a></td>
	                                    <td>${m.kind}</td>
	                                    <td>${m.estdate}</td>
	                                    <td><strong class="primary-font">${m.state}</strong></td>
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
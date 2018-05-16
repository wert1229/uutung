<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<title>Insert title here</title>
<script>
var childWin;

$(function(){
	var flag = "${flag}";
	var page = "${page}";
	
	if(flag =="1")
	{
		$(opener.location).attr("href", "${path}/branch?page="+page);
		window.close();			
	}	
	
	$("#search").click(function(){
		
		childWin = window.open("${path}/branch/searchManager", "searchManager",
				"width=400, height=500, top=300, left=800, resizable=no, location=no");
	});
});

window.onunload=function(){
	childWin.close();
};
</script>
</head>
<body>
<div id="wrapper">
	<div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">매장 수정</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-info">
                	<div class="panel-heading">
                		입력
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${path}/branch/edit" method="POST">
                                	<input type="hidden" name="bseq" value="${branch.bseq}">
                                	<input type="hidden" name="page" value="${page}">
                                	<div class="form-group">
                                        <label>매장명</label>
                                        <input name="name" class="form-control" placeholder="Enter Name" value="${branch.name}" required>
                                    </div>
                                    <label>담당자</label>
                                    <div class="form-group input-group">
                                        <input id="managerName" class="form-control" placeholder="Use Search" value="${branch.manager} (${branch.managerName})" required readonly>
                                        <input type="hidden" id="manager" name="manager" value="${branch.manager}">
                                        <span class="input-group-btn">
                                            <button id="search" class="btn btn-default" type="button"><i class="fa fa-search"></i>
                                            </button>
                                        </span>
                                    </div>
                                    <div class="form-group">
                                        <label>매장 연락처</label>
                                        <input name="phone" class="form-control" placeholder="Enter Phone" value="${branch.phone}" required >
                                    </div>
                                    <div class="form-group">
                                        <label>매장 위치</label>
                                        <input name="location" class="form-control" placeholder="Enter Location" value="${branch.location}" required >
                                    </div>
                                    <button type="submit" class="btn btn-lg btn-info btn-outline col-lg-offset-5">수정</button>
                                </form>
                    		</div>
                    		<!-- /.col-md-offset-4 -->
                    	</div>
                    	<!-- /.row -->	
                	</div>
                	<!-- /.panel-body -->
                </div>
                <!-- /.panel panel-info -->
            </div>
            <!-- /.col-lg-12 -->    
        </div>
        <!-- /.row -->
    </div>
    <!-- /#page-wrapper -->        
</div>
 <!-- /#wrapper -->
</body>
</html>
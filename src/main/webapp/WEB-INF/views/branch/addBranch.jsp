<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<title>Insert title here</title>
<script>
	
</script>
</head>
<body>
<div id="wrapper">
	<div id="page-wrapper" style="margin: 0 500px 0 500px">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">매장 등록</h1>
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
                                <form role="form" action="${path}/branch" method="POST">
                                	<div class="form-group">
                                        <label>매장명</label>
                                        <input name="name" class="form-control" placeholder="Enter Name" >
                                    </div>
                                 	<div class="form-group">
                                        <label>담당자</label>
                                        <input name="manager" type="password" class="form-control" placeholder="Enter Manager" >
                                    </div>
                                    <div class="form-group">
                                        <label>매장 연락처</label>
                                        <input name="phone" class="form-control" placeholder="Enter Phone" >
                                    </div>
                                    <div class="form-group">
                                        <label>매장 위치</label>
                                        <input name="location" class="form-control" placeholder="Enter Location" >
                                    </div>
                                    <button type="submit" class="btn btn-lg btn-info btn-outline col-lg-offset-5">등록</button>
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
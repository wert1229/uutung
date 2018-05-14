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
		var flag = "${flag}";
		
		if(flag =="1")
		{
			$(opener.location).attr("href", "${path}/branch");
			window.close();
		}	
		
		$("#search").click(function(){
			var key = $("#manager").val();
			
			window.open("${path}/searchManager?key="+key, "searchManager",
					"width=400, height=500, top=300, left=800, resizable=no, location=no");
		});
	});
</script>
</head>
<body>
<div id="wrapper">
	<div id="page-wrapper">
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
                                        <input name="name" class="form-control" placeholder="Enter Name" required>
                                    </div>
                                    <label>담당자</label>
                                    <div class="form-group input-group">
                                        <input id="managerName" class="form-control" placeholder="Use Search" required readonly>
                                        <input type="hidden" id="manager" name="manager" >
                                        <span class="input-group-btn">
                                            <button id="search" class="btn btn-default" type="button"><i class="fa fa-search"></i>
                                            </button>
                                        </span>
                                    </div>
                                    <div class="form-group">
                                        <label>매장 연락처</label>
                                        <input name="phone" class="form-control" placeholder="Enter Phone" required >
                                    </div>
                                    <div class="form-group">
                                        <label>매장 위치</label>
                                        <input name="location" class="form-control" placeholder="Enter Location" required >
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
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
	
	if(flag=="1"){
		var pg = "${pg}";
		
		$(opener.location).attr("href", "${path}/client/main"); 
		
		window.close();
	}
});
</script>
</head>
<body>
<div id="wrapper">
	<div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">거래처 등록</h1>
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
                                <form role="form" action="${path}/client/addClient" method="POST">
                              <!--   	<div class="form-group">
                                        <label>거래처 번호</label>
                                        <input name="cseq" class="form-control" required >
                                     </div> -->
                                	
                                	<div class="form-group">
                                        <label>거래처명</label>
                                        <input name="name" class="form-control" placeholder="Enter Name" required>
                                    </div>
                                      <div class="form-group">
                                        <label>거래처 대표</label>
                                        <input name="owner" class="form-control" placeholder="Enter Owner" required>
                                    </div>
                                    <div class="form-group">
                                        <label>거래처 위치</label>
                                        <input name="location" class="form-control" placeholder="Enter Location" required >
                                    </div>
                                    <div class="form-group">
                                        <label>거래처 연락처</label>
                                        <input name="phone" class="form-control" placeholder="Enter Phone" required >
                                    </div>
                                          <div class="form-group">
                                        <label>비고</label>
                                        <input name="note" class="form-control" placeholder="Enter Note" required >
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
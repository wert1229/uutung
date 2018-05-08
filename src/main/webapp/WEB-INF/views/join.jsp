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
                <h1 class="page-header">회원가입</h1>
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
                                <form role="form" action="#" method="POST">
                                	<div class="form-group">
                                        <label>이메일</label>
                                        <input class="form-control" placeholder="Enter Email" >
                                    </div>
                                 	<div class="form-group">
                                        <label>비밀번호</label>
                                        <input type="password" class="form-control" placeholder="Enter Password" >
                                    </div>
                                    <div class="form-group">
                                        <label>이름</label>
                                        <input class="form-control" placeholder="Enter Name" >
                                    </div>
                                    <div class="form-group">
                                        <label>연락처</label>
                                        <input class="form-control" placeholder="Enter PhoneNumber" >
                                    </div>
                                    <div class="form-group">
                                        <label>소속</label>
                                        <input class="form-control" placeholder="Enter Dept" >
                                    </div>
                                    <div class="form-group">
                                        <label>직급</label>
                                        <select class="form-control">
                                        	<option>인턴</option>
                                            <option>사원</option>
                                            <option>대리</option>
                                            <option>과장</option>
                                            <option>차장</option>
                                            <option>부장</option>
                                            <option>계약직</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>사진</label>
                                        <div style="width:150px; height:180px; border: 1px solid black"></div>
                                        <input type="file">
                                    </div>
                                    <button type="submit" class="btn btn-lg btn-info btn-outline col-lg-offset-5">회원가입</button>
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
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
		$("#email").keyup(function(){
			var reg=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			var email=$("#email").val();
			var div = $("#email").parent();
			
			if(email==''){
				$(div).removeClass("has-error");
				$(div).removeClass("has-success");
				return;
			}
			
			if(reg.test(email)==false){
				$(div).removeClass("has-success");
				$(div).addClass("has-error");
				
				return;
			}else{
				$(div).removeClass("has-error");
				$(div).addClass("has-success");
				
				return;
			}
		});
		
		$("#submit").click(function(){
			if($("#email").hasClass("has-error")){
				alert("이메일 형식이 올바르지 않습니다.");
				return false;
			}
		});
		
		$("#search").click(function(){
			var key = $("#dept").val();
			
			window.open("${path}/searchBranch?key="+key, "branch",
					"width=400, height=500, top=300, left=800, resizable=no, location=no");
		})
		
		$("#upload").change(function(){
			var formData = new FormData();
			formData.append("file",$("#upload")[0].files[0]);
			
			$.ajax({
				type: "POST",
		        url: "${path}/profilePic",
		        data: formData,
		        dataType: "text",
		        processData: false,
		        contentType: false,
		        success: function(data) {
		        	var fileName = data.substring(data.indexOf("uploadImg")+10);
		        	var imgPath = '${path}/uploadImg/'+fileName;
		        	var content = '<img src="'+imgPath+'">';
		        	$("#displayImg").html(content);
		        	$("#imgPath").val(imgPath);
		        }
			});
			
		})
		
	})
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
                                <form role="form" action="${path}/join" method="POST" enctype="multipart/form-data">
                                	<div class="form-group">
                                        <label class="control-label">이메일</label>
                                        <input id="email" name="email" class="form-control" placeholder="Enter Email" required>
                                    </div>
                                 	<div class="form-group">
                                        <label>비밀번호</label>
                                        <input name="pwd" type="password" class="form-control" placeholder="Enter Password" required >
                                    </div>
                                    <div class="form-group">
                                        <label>이름</label>
                                        <input name="name" class="form-control" placeholder="Enter Name" required>
                                    </div>
                                    <div class="form-group">
                                        <label>연락처</label>
                                        <input name="phone" class="form-control" placeholder="Enter PhoneNumber" required >
                                    </div>
                                    <label>소속</label>
                                    <div class="form-group input-group">
                                        <input name="dept" id="dept" class="form-control" placeholder="Enter Dept" required>
                                        <span class="input-group-btn">
                                            <button id="search" class="btn btn-default" type="button"><i class="fa fa-search"></i>
                                            </button>
                                        </span>
                                    </div>
                                    <div class="form-group">
                                        <label>직급</label>
                                        <select name="position" class="form-control">
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
                                        <div id="displayImg" style="width:150px; height:180px; border: 1px solid black"></div>
                                        <input id="upload" type="file" name="file" required>
                                        <input id="imgPath" type="hidden" name="img">
                                    </div>
                                    <button id="submit" type="submit" class="btn btn-lg btn-info btn-outline col-lg-offset-5">회원가입</button>
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
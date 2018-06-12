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
		$(opener.location).attr("href", "${path}/product?page="+page);
		window.close();			
	}	
	
	$("#search").click(function(){
		
		childWin = window.open("${path}/product/searchProduct", "searchProduct",
				"width=400, height=500, top=300, left=800, resizable=no, location=no");
	});
	
	$("#editImg").change(function(){
		var formData = new FormData();
		formData.append("file",$("#editImg")[0].files[0]);
		
		$.ajax({
			type: "POST",
	        url: "${path}/product/productImg",
	        data: formData,
	        dataType: "text",
	        processData: false,
	        contentType: false, 
	        success: function(data) {
	        	var fileName = data.substring(data.indexOf("uploadImg")+10);
	        	var imgPath = '/uploadImg/'+fileName;
	        	$("#imgName").val(imgPath);
	        }
		});
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
                <h1 class="page-header">품목 수정</h1>
            </div>
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
                                <form role="form" action="${path}/product/edit" method="POST">
                                	<input type="hidden" name="pseq" value="${product.pseq}">
                                	<input type="hidden" name="page" value="${page}">
                                	<div class="form-group">
                                        <label>품명</label>
                                        <input name="name" class="form-control" placeholder="Enter Name" value="${product.name}" required>
                                    </div>
                                    <label>품목 이미지</label>
                                    <div class="form-group">
                                    	<input type="hidden" name="img" id="imgName" value="${product.img}">
                                        <input id="editImg" name="file" class="form-control" type="file">
                                    </div>
                                    <div class="form-group">
                                        <label>분류</label>
                                        <select name="category" class="form-control" required>
											<option value="1">패션의류/잡화</option>
											<option value="2">뷰티</option>
											<option value="3">식품</option>
										</select>
                                    </div>
                                    <div class="form-group">
                                        <label>비고</label>
                                        <input name="note" class="form-control" placeholder="Enter Feature" value="${product.note}" required >
                                    </div>
                                    <div class="form-group">
                                        <label>상태</label>
                                        <select name="state" class="form-control" placeholder="${product.state}" value="${product.state}" required>
                                        	<option value="Y">Y</option>
                                        	<option value="N">N</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-lg btn-info btn-outline col-lg-offset-5">수정</button>
                                </form>
                    		</div>
                    	</div>
                	</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
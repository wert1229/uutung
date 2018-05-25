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
	
	if(flag =="1")
	{
		$(opener.location).attr("href", "${path}/product");
		window.close();			
	}	
	
	$("#search").click(function(){
		
		childWin = window.open("${path}/product/searchProduct", "searchProduct",
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
                <h1 class="page-header">품목 등록</h1>
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
                                <form role="form" action="${path}/product" method="POST">
                                	<div class="form-group">
                                        <label>품명</label>
                                        <input name="name" class="form-control" placeholder="Enter Name" required>
                                    </div>
                                    <label>품목 이미지</label>
                                    <div class="form-group">
                                        <input name="img" class="form-control" placeholder="Use Submit" type="file" required>
                                    </div>
                                    <div class="form-group">
                                        <label>분류</label>
                                        <select name="category" class="form-control" required>
											<option value="fashion">패션의류/잡화</option>
											<option value="beauty">뷰티</option>
											<option value="food">식품</option>
										</select>
                                    </div>
                                    <div class="form-group">
                                        <label>비고</label>
                                        <input name="note" class="form-control" placeholder="Enter Feature" required >
                                    </div>
                                    <div class="form-group">
                                        <label>상태</label>
                                        <input name="state" class="form-control" placeholder="N" value="N" required readonly>
                                    </div>
                                    <button type="submit" class="btn btn-lg btn-info btn-outline col-lg-offset-5">등록</button>
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
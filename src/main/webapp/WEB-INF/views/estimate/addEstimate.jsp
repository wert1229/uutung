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
		$(opener.location).attr("href", "${path}/estimate");
		window.close();			
	}	
	
	$("#search").click(function(){
		
		childWin = window.open("${path}/estimate/searchEstimate", "searchEstimate",
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
                <h1 class="page-header">견적 등록</h1>
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
                                <form role="form" action="${path}/estimate" method="POST">
                                    <label>가격</label>
                                	<div class="form-group">
                                        <input name="price" class="form-control" placeholder="Enter Price" required>
                                    </div>
                                    <div class="form-group">
	                                    <label>품목 일련번호</label>
                                        <input name="productSq" class="form-control" placeholder="Enter Product_Seq" required>
                                    </div>
                                    <div class="form-group">
	                                    <label>거래처 일련번호</label>
                                        <input name="clientSq" class="form-control" placeholder="Enter Client_Seq" required>
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
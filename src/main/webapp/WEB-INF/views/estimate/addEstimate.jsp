<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<title>견적등록</title>
<script>
var childWin;
$(function(){
	var flag = "${flag}";
	var pseq = "${pseq}";
	
	if(flag =="1") {
		$(opener.location).attr("href", "${path}/estimate/detail?pseq="+pseq);
		window.close();			
	}	
	
	$("#searchClient").click(function(){
		
		childWin = window.open("${path}/estimate/searchEstimate", "searchEstimate",
		"width=600, height=800, top=100, left=800, resizable=no, location=no");
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
                		등록
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="${path}/estimate" method="POST">
                                    <label>거래처</label>
                                    <div class="form-group input-group">
				                        <input id="cseq" class="form-control" name="clientSq" placeholder="Use Search" required readonly>
		                                <input type="hidden" name="manager" >
		                                <span class="input-group-btn">
		                                	<button id="searchClient" class="btn btn-default" type="button">
		                                		<i class="fa fa-search"></i>
		                                    </button>
		                                </span>
				                    </div>
                                    <label>가격</label>
                                	<div class="form-group">
                                        <input id="price" name="price" class="form-control" placeholder="Enter Price" required>
                                    </div>
                                    <div class="form-group">
	                                    <label>품목 일련번호</label>
                                        <input name="productSq" class="form-control" placeholder="${pseq}" value="${pseq}" required readonly>
                                    </div>
                                    <div class="form-group">
	                                    <label>상태</label>
                                        <input id="state" name="state" class="form-control" placeholder="N" value="N" required readonly>
                                    </div>
                                    <button type="submit" id="regEstimate" class="btn btn-lg btn-info btn-outline col-lg-offset-5">등록</button>
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
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
		$("#testTable").DataTable({
			searching : false,
			ordering : false,
			lengthChange : false,
			info : false
		}).page.len(10).draw();
	})



</script>
</head>
<body>
	<div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">품목 리스트</h3>
                    </div>
                    <div class="panel-body">
	                    <table class="table table-striped table-bordered table-hover" id="testTable">
							<thead>
								<tr>
									<th>물품코드</th>
									<th>물품명</th>
									<th>분류</th>
									<th>수량</th>
									<th>단가</th>
									<th>금액</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${olist}" var="o">
									<tr>
										<td>${o.pseq}</td>
										<td>${o.name}</td>
										<td>${o.category}</td>
										<td>${o.amount}</td>
										<td>${o.price}</td>
										<td>${o.totalprice}</td>
										<td>${o.note}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
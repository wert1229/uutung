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
	<div class="container" style="background-color : white; border : 1px solid black">
        <div class="row">
	               <div class="col-lg-12">
	                   <h1 class="page-header">결재서</h1>
	               </div>
	               <!-- /.col-lg-12 -->
	           </div>
	           <!-- /.row -->
	           <div class="row">
	               <div class="col-lg-12">
	                   <div class="panel panel-info">
	                       <div class="panel-heading">
	                    		재고 이동
	                       </div>
	                   </div>
	                   <!-- /.panel -->
	               </div>
	               <!-- /.col-lg-12 -->
	           </div>
	
	            <!-- /.row -->
	            <div class="row">
	                 <div class="col-lg-6">
	                    <div class="panel panel-default">
	                        <div class="panel-heading" align="center">
	                             	대상 정보
	                        </div>
	                        <!-- /.panel-heading -->
	                        <div class="panel-body">
	                            <div class="table-responsive table-bordered" >
	                                <table class="table">
	                                    <thead>
	                                        <tr>
	                                            <th>매장 코드</th>
	                                            <td>${m.branchSq}</td>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                        <tr>
	                                            <th style="padding: 12px">지점명</th>
	                                            <td id="name">${m.branchName}</td>
	                                        </tr>
	                                        <tr>
	                                            <th style="padding: 12px">지점 관리자</th>
	                                            <td id="manager">${m.manager}</td>
	                                        </tr>
	                                        <tr>
	                                            <th style="padding: 12px">연락처</th>
	                                            <td id="phone">${m.phone}</td>
	                                        </tr>
	                                         <tr>
	                                            <th style="padding: 12px">주소</th>
	                                            <td id="location">${m.location}</td>
	                                        </tr>
	                                        <tr>
	                                            <th>종류</th>
	                                            <td id="kind">${m.kind}</td>
	                                        </tr>
	                                    </tbody>
	                                </table>
	                            </div>
	                            <!-- /.table-responsive -->
	                        </div>
	                        <!-- /.panel-body -->
	                    </div>
	                    <!-- /.panel -->
	                </div>
	                
	                
	                <!-- /.col-lg-6 -->
	                <div class="col-lg-6">
	                    <div class="panel panel-default">
	                        <div class="panel-heading" align="center">
	                              	결재 기본정보
	                        </div>
	                        <!-- /.panel-heading -->
	                        <div class="panel-body">
	                            <div class="table-responsive table-bordered">
	                                <table class="table">
	                                    <thead>
	                                    	<tr>
	                                            <th>결재번호</th>
	                                            <td>${m.mseq}</td>
	                                        </tr>
	                                        <tr>
	                                            <th>제목</th>
	                                            <td>${m.title}</td>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                        <tr>
	                                            <th>작성자</th>
	                                            <td>${m.slaveName}(${m.slaveSq})</td>
	                                        </tr>
	                                        <tr>
	                                            <th>결재자</th>
	                                            <td>
	                                            	<c:forEach items="${madlist}" var="ma">
	                                            		${ma.approverName}[
	                                            		<c:if test="${ma.state == 'Y'}">
	                                            			<i class="fa fa-check fa-fw"></i>
	                                            		</c:if>
	                                            		<c:if test="${ma.state == 'R'}">
	                                            			<i class="fa fa-times fa-fw"></i>
	                                            		</c:if>]
	                                            	</c:forEach>
	                                        	</td>
	                                        </tr>
	                                        <tr>
	                                            <th>납기 일자</th>
	                                            <td>${m.estdate}</td>
	                                        </tr>
	                                        <tr>
	                                            <th>결재 만료 일자</th>
	                                            <td>
	                                            	<fmt:parseDate var="expdate" value="${m.expdate}" pattern="yyyy-MM-dd HH:mm:ss" />
	                                    			<fmt:formatDate value="${expdate}" type="date" pattern="yyyy-MM-dd" />
	                                            </td>
	                                        </tr>
	                                    </tbody>
	                                </table>
	                            </div>
	                            <!-- /.table-responsive -->
	                        </div>
	                        <!-- /.panel-body -->
	                    </div>
	                    <!-- /.panel -->
	                </div>
	                <!-- /.col-lg-6 -->
	              
	                <div class="col-lg-12">
	                    <div class="panel panel-default">
	                        <div class="panel-heading" align="center">
	                               	물품 정보
	                        </div>
	                        <!-- /.panel-heading -->
	                        <div class="panel-body">
	                            <div class="table-responsive">
	                                <table class="table table-striped table-bordered table-hover">
	                                    <thead>
	                                        <tr>
	                                            <th>#</th>
	                                            <th>물품코드</th>
	                                            <th>물품명</th>
	                                            <th>분류</th>
	                                            <th>수량</th>
	                                            <th>비고</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="productList">
	                                        <c:forEach items="${mldlist}" var="ml" varStatus="status">
			                            		<tr>
			                            			<td>${status.count}</td>
				                                    <td>${ml.productSq}</td>
				                                    <td>${ml.productName}</td>
				                                    <td>${ml.category}</td>
				                                    <td>${ml.quantity}</td>
				                                    <td>${ml.note}</td>
				                                </tr>
			                            	</c:forEach>
	                                    </tbody>
	                                </table>
	                            </div>
	                            <!-- /.table-responsive -->
	                        </div>
	                        <!-- /.panel-body -->
	                    </div>
	                    <!-- /.panel -->
	                </div>
	            </div>
    </div>
</body>
</html>
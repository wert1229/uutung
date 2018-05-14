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
			$(opener.location).attr("href", "${path}/branch");
			window.close();
		}	
		
		$("#searchBranch").click(function(){
			
			childWin = window.open("${path}/move/searchBranch", "searchThings",
					"width=600, height=600, top=300, left=800, resizable=no, location=no");
		});
		
		$("#searchApprovers").click(function(){
			
			childWin = window.open("${path}/move/searchApprovers", "searchThings",
					"width=600, height=600, top=300, left=800, resizable=no, location=no");
		});
		
		$(".searchProduct").on("click", function(){
			
			var no = $(this).parents("td").siblings(".no").text();
			
			childWin = window.open("${path}/move/searchProduct?no="+no, "searchThings",
					"width=600, height=600, top=300, left=800, resizable=no, location=no");
		});
		
		$(".addList").on("click", function(){
			
			
		});
		
		
	});
	
	window.onunload=function(){
		childWin.close();
	};
</script>
</head>
<body>
<div id="wrapper">
	<%@include file="/resources/jspf/topnav.jspf"%>
    <%@include file="/resources/jspf/sidenavJaego.jspf"%>

	<div id="page-wrapper">
		<div class="col-lg-8 col-lg-offset-2" style="border: 1px solid black">
        <div class="row">
               <div class="col-lg-12">
                   <h1 class="page-header">재고 이동 발주서</h1>
               </div>
               <!-- /.col-lg-12 -->
           </div>
           <!-- /.row -->
           <div class="row">
               <div class="col-lg-12">
                   <div class="panel panel-info">
                       <div class="panel-heading">
                    		입력
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
                            <div class="table-responsive table-bordered">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>매장 코드</th>
                                            <td>
                                            	<div class="form-group input-group" style="padding: 0px; margin: 0px">
	                                            	<input id="bseq" class="form-control" placeholder="Use Search" required readonly>
	                                        		<input type="hidden" name="manager" >
	                                        		<span class="input-group-btn">
	                                            		<button id="searchBranch" class="btn btn-default" type="button"><i class="fa fa-search"></i>
	                                            		</button>
	                                        		</span>
                                        		</div>
                                        	</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>지점명</th>
                                            <td id="name"></td>
                                        </tr>
                                        <tr>
                                            <th>지점 관리자</th>
                                            <td id="manager"></td>
                                        </tr>
                                        <tr>
                                            <th>연락처</th>
                                            <td id="phone"></td>
                                        </tr>
                                         <tr>
                                            <th>주소</th>
                                            <td id="location"></td>
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
                                            <th>제목</th>
                                            <td><input class="form-control"></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>작성자</th>
                                            <td>${slave}(${sessionScope.loginSeq})</td>
                                        </tr>
                                        <tr>
                                            <th>결재자</th>
                                            <td>
                                            	<div class="form-group input-group" style="padding: 0px; margin: 0px">
	                                            	<input id="approversName" class="form-control" placeholder="Use Search" required readonly>
	                                        		<input id="approversSeq" type="hidden" name="approversSeq" >
	                                        		<input id="approversPos" type="hidden" name="approversPos" >
	                                        		<span class="input-group-btn">
	                                            		<button id="searchApprovers" class="btn btn-default" type="button"><i class="fa fa-list-alt"></i>
	                                            		</button>
	                                        		</span>
                                        		</div>
                                        	</td>
                                        </tr>
                                        <tr>
                                            <th>납기 일자</th>
                                            <td><input type="date"></td>
                                        </tr>
                                        <tr>
                                            <th>결재 만료 일자</th>
                                            <td><input type="date"></td>
                                        </tr>
                                        <tr>
                                            <th>비고</th>
                                            <td><input class="form-control"></td>
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
                               	물품 정보입력
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
                                    <tbody>
                                        <tr class="productList">
                                            <td class="no"><button class="btn btn-default btn-xs addList"><i class="fa fa-caret-down"></i></button>1</td>
                                            <td>
                                            	<div class="form-group input-group" style="padding: 0px; margin: 0px;">
	                                            	<input class="form-control pseq" placeholder="Use Search" required readonly>
	                                        		<span class="input-group-btn">
	                                            		<button class="btn btn-default searchProduct" type="button"><i class="fa fa-search"></i>
	                                            		</button>
	                                        		</span>
                                        		</div>
                                            </td>
                                            <td class="name"></td>
                                            <td class="category"></td>
                                            <td><input type="number" min="1" style="width: 100px; margin: 0px;"></td>
                                            <td><input class="form-control note" placeholder="비고" readonly></td>
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
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->        
</div>
 <!-- /#wrapper -->
</body>
</html>
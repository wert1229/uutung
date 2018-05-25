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

	var products = [];
	
	var timestamp = + new Date();

	$(function(){

		products.push({"no" : 1 , "productSq" : "" , "name" : "" , "category" : "", "quantity" : "" , "price" : "" , "totalPrice" : "" , "note" : ""});
		draw();
		
		$("#oseq").val("O"+timestamp);
		
		$("#searchClient").click(function(){
			
			if(products[0].productSq != "" || products.length > 1){

				alert("거래처를 변경하시면 작성된 물품리스트가 갱신됩니다.");
			}
			
			childWin = window.open("${path}/order/searchClient", "searchThings",
			"width=600, height=600, top=300, left=800, resizable=no, location=no");
		});
	 
		
		$("#searchApprovers").click(function(){
		
			childWin = window.open("${path}/order/searchApprovers", "searchThings",
					"width=600, height=600, top=300, left=800, resizable=no, location=no");
		});
		
		
		$(document).on("click", ".searchProduct", function(){
			
			if($("#cseq").val()==''){
				
				alert("거래처 먼저 선택해주세요");
				return false;
			}
			
			var no = $(this).parents("td").siblings(".no").text();
			
			childWin = window.open("${path}/order/searchProduct?no="+no, "searchThings",
					"width=600, height=600, top=300, left=800, resizable=no, location=no");
		});
		
		$(document).on("keyup", ".amount", function(){
			
			var amount = $(this).val();
			var price = $(this).parent().next().children().val();
			var totalPrice = $(this).parent().next().next().children();
			
			var total = amount * price;
			
			$(totalPrice).val(total);
		});
		
		$(document).on("click", ".addList", function(){
			
			saveNowAmount();
			
			var no = $(this).parents(".no").text();
			no= parseInt(no);
			
			var blank = {"no" : no+1 , "productSq" : "" , "name" : "" , "category" : "", "quantity" : "" , "price" : "" , "totalPrice" : "" , "note" : ""}
			
			products.splice(no, 0, blank);
			
			draw();
		});
		
		

	});


	function draw()
	{
		var content ="";
		
		for(var i in products)
		{
			var j = parseInt(i)+1;
			
			content += '<tr>';
            content += '<td class="no"><button class="btn btn-default btn-xs addList"><i class="fa fa-caret-down"></i></button>'+j+'</td>';
            content += '<td>'+products[i].productSq+'</td>';
            content += '<td>';
            content += '<div class="form-group input-group" style="padding: 0px; margin: 0px;">';
            content += '<input class="form-control" placeholder="Use Search" value="'+products[i].name+'" required readonly>';
            content += '<span class="input-group-btn">';
            content += '<button class="btn btn-default searchProduct" type="button"><i class="fa fa-search"></i>';
            content += '</button>';
            content += '</span>';
        	content += '</div>';
            content += '</td>';
            content += '<td>'+products[i].category+'</td>';
            content += '<td><input class="form-control amount" type="number" min="1" value="'+products[i].quantity+'" " ></td>';
            content += '<td><input class="form-control price" type="number" min="1" value="'+products[i].price+'" " readonly></td>';
            content += '<td><input class="form-control totalPrice" type="number" min="1" value="'+products[i].totalPrice+'" " readonly></td>';
            content += '<td><input class="form-control note" placeholder="비고" value="'+products[i].note+'" readonly></td>';
         	content += '</tr>';
		}	
		
		$("#productList").html(content);
	}
	
	function valueInsert()
	{
		saveNowAmount();
		
		var no = $("#pno").val();
		var productSq = $("#pseq").val();
		var name = $("#pname").val();
		var category = $("#pcategory").val();
		var price = $("#price").val();
		var note = $("#pnote").val();
		
		products[no].productSq = productSq;
		products[no].name = name;
		products[no].category = category;
	    products[no].price = price;
		products[no].note = note;
		
		draw();
	}
	
	function saveNowAmount()
	{
		for(var i in products)
		{
			//alert($(".amount").eq(i).val());
			//alert($(".totalPrice").eq(i).val());
			products[i].quantity = $(".amount").eq(i).val();
			products[i].totalPrice = $(".totalPrice").eq(i).val();
		}
	}
	
	
	function clearProductList()
	{
		products = [];
		products.push({"no" : 1 , "productSq" : "" , "name" : "" , "category" : "", "quantity" : "" , "price" : "" , "totalPrice" : "" , "note" : ""});
		draw();
	}
	
	function submit()
	{
		if("${sessionScope.loginSeq}"=="")
		{
			alert("로그인 세션이 만료되었습니다.");
			return;
		}
		
		saveNowAmount();
		
		var map ={};
		
		var order = {};
		var orderAprv = [];
		var orderList = [];
		
		var ocseq = $("#oseq").val();
		var title = $("#title").val();
		var slaveSq = "${sessionScope.loginSeq}";
		var estdate = $("#estdate").val();
		var expdate = $("#expdate").val();
		var clientSq = $("#cseq").val();
		var note = $("#note").val();
		
		for(var i in products)
		{	
			products[i].orderSq = ocseq;
			
			if(products[i].productSq != "" && products[i].quantity != "" && products[i].quantity != "0")
			{
				orderList.push(products[i]);
			}
		}
		
		if(orderList.length==0)
		{
			alert("최소한 한개의 물품은 등록해야합니다!");
			
			return false;
		}	
		
		var listNum = orderList.length-1;
		var note;
		
		if(orderList.length > 1)
		{
			note = orderList[0].name + " 외 " + listNum + "건";
		}
		else
		{
			note = orderList[0].name;
		}
		
		order.ocseq = ocseq;
		order.title = title;
		order.slaveSq = slaveSq;
		order.estdate = estdate;
		order.expdate = expdate;
		order.clientSq = clientSq;
		order.note = note;

		
		var approversSeq = $("#approversSeq").val();
		
		if(clientSq=="" || ocseq=="" || title=="" || approversSeq=="" || expdate=="" || estdate=="")
		{
			alert("빈 항목이 존재합니다!");
			
			return false;
		}
		
		var approvers = approversSeq.trim().split(" ");
		
		for(var i in approvers)
		{
			var temp = {};
			
			temp.approver = approvers[i];
			temp.orderSq = ocseq;
			temp.priority = i;
			
			orderAprv.push(temp);
		}
		
		map.order = order;
		map.orderAprv = orderAprv;
		map.orderList = orderList;
		
		var mapJson = JSON.stringify(map); 
		alert(mapJson);
		
		$.ajax({
			type:"POST",
			url:"${path}/order/main",
			data: mapJson ,
			contentType : 'application/json; charset=utf-8',
			success: function(result){
				if(result)
				{
					alert("작성되었습니다.");
					location.href="${path}/order/main";
				}
				else
				{
					alert("내부 오류 발생!");
					return false;
				}
			} 
		});
	}
	
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
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2" style="border: 1px solid black">
	        	<div class="row">
	               <div class="col-lg-12">
	                   <h1 class="page-header">발주서 등록</h1>
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
	                            <div class="table-responsive table-bordered" >
	                                <table class="table">
	                                    <thead>
	                                        <tr>
	                                            <th>거래처 번호</th>
	                                            <td>
	                                            	<div class="form-group input-group" style="padding: 0px; margin: 0px">
		                                            	<input id="cseq" class="form-control" placeholder="Use Search" required readonly>
		                                        		<input type="hidden" name="manager" >
		                                        		<span class="input-group-btn">
		                                            		<button id="searchClient" class="btn btn-default" type="button"><i class="fa fa-search"></i>
		                                            		</button>
		                                        		</span>
	                                        		</div>
	                                        	</td>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                        <tr>
	                                            <th style="padding: 12px">거래처명</th>
	                                            <td id="name"></td>
	                                        </tr>
	                                        <tr>
	                                            <th style="padding: 12px">거래처 대표</th>
	                                            <td id="owner"></td>
	                                        </tr>
	                                        <tr>
	                                            <th style="padding: 12px">거래처 번호</th>
	                                            <td id="phone"></td>
	                                        </tr>
	                                         <tr>
	                                            <th style="padding: 12px">거래처 주소</th>
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
	                                            <th>결재번호</th>
	                                            <td><input id="oseq" class="form-control" readonly></td>
	                                        </tr>
	                                        <tr>
	                                            <th>제목</th>
	                                            <td><input id="title" class="form-control"></td>
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
	                                            <td><input id="estdate" type="date"></td>
	                                        </tr>
	                                        <tr>
	                                            <th>결재 만료 일자</th>
	                                            <td><input id="expdate" type="date"></td>
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
	                               	발주 정보입력
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
	                                            <th>단가</th>
	                                            <th>금액</th>
	                                            <th>비고</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody id="productList">
	                                        
	                                    </tbody>
	                                </table>
	                            </div>
	                            <!-- /.table-responsive -->
	                            <div class="row">
									<div class="col-lg-offset-10">
										<button type="button" class="btn btn-lg btn-primary" onclick="submit()">작성 완료</button>
									</div>		    
							    </div>
	                        </div>
	                        <!-- /.panel-body -->
	                    </div>
	                    <!-- /.panel -->
	                </div>
	            </div>
        	</div>
        </div>
    </div>
    <!-- /#page-wrapper -->        
</div>
<!-- /#wrapper -->
 
<input id="pno" type="hidden">
<input id="pseq" type="hidden">
<input id="pname" type="hidden">
<input id="pcategory" type="hidden">
<input id="price" type="hidden">
<input id="pnote" type="hidden">
 
</body>
</html>
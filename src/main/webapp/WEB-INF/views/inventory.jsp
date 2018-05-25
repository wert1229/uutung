<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<script>
$(function(){
	
	var modalLine = "";
	
	/*branchList를 동적으로 사용하기위해 새로운 배열 생성  */
	var branchList = new Array();

 	<c:forEach items="${branchList}" var="list">
		var branch = {"seq":"${list.bseq}", "name":"${list.name}","phone":"${list.phone}","location":"${list.location}", "check":1, "manager":"${list.manager}"};
		branchList.push(branch);
	</c:forEach>
	
 	var memberList = new Array();

	<c:forEach items="${memberList}" var="list">
		var member = {"seq":"${list.mseq}","name":"${list.name}", "email":"${list.email}"};
		memberList.push(member);
	</c:forEach>
	
 	for(var i=0; i<branchList.length; i++){
		for(var j=0; j<memberList.length; j++){
			if(branchList[i].manager == memberList[j].seq){
				modalLine += '<div class="modal fade" id="modalBran_'+branchList[i].seq+'" role="dialog">';
				modalLine += '<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button>';
				modalLine += '<h4 class="modal-title">지점정보</h4></div>';
				modalLine += '<div class="modal-body">';
				modalLine += '지점명 : ' + branchList[i].name + '<br>';
				modalLine += '담당 매니저 : ' + memberList[j].name + ' ('+memberList[j].email+')<br>';
				modalLine += '연락처 : ' + branchList[i].phone + '<br>';
				modalLine += '주소 : ' + branchList[i].location + '<br>';
				modalLine += '</div>';
				modalLine += '<div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div></div></div></div>';
				break;
			}			
		}
		
 		
		
 	}
	
	
	/*itemList를 동적으로 사용하기위해 새로운 배열 생성  */
 	var itemBList = new Array();

	<c:forEach items="${balanceList}" var="list">
		var itemB = {"seq":"${list.iseq}","fseq":"${list.pseq}", "bseq":"${list.bseq}", "balance": ${list.balance} };
		itemBList.push(itemB);
		alert(itemB.seq);
	</c:forEach> 

	
	
	/*itemNameList를 동적으로 사용하기위해 새로운 배열 생성  */
 	var itemNList = new Array();
 	
 	
	<c:forEach items="${productList}" var="list">
		var itemN = {"seq":"${list.pseq}", "name":"${list.name}", "check":0, "note":"${list.note}"};
		itemNList.push(itemN);
		
		modalLine += '<div class="modal fade" id="modalPro_'+itemN.seq+'" role="dialog">';
		modalLine += '<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button>';
		modalLine += '<h4 class="modal-title">제품정보</h4></div>';
		modalLine += '<div class="modal-body">';
		modalLine += itemN.note;
		modalLine += '</div>';
		modalLine += '<div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div></div></div></div>';		
	</c:forEach>
	
	var historyList = new Array();
	

	<c:forEach items="${inventoryList}" var="list">
		var history = {"bseq":"${list.bseq}", "cseq":"${list.cseq}", "pseq":"${list.pseq}", "quantity":${list.quantity},"balance":${list.balance}, "kind":"${list.kind}", "state":"${list.state}", "regdate":"${list.regdate}"};
		historyList.push(history);
	</c:forEach> 

	
	
	for(var i=0; i<branchList.length; i++){
		for(var j=0; j<itemNList.length; j++){
			
			modalLine += '<div class="modal fade" id="modalHist_'+branchList[i].seq+'_'+itemNList[j].seq+'" role="dialog">';
			modalLine += '<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button>';
			modalLine += '<h4 class="modal-title">제품정보</h4></div>';
			modalLine += '<div class="modal-body">';
			modalLine += '<table class="table-hover table-bordered" width="auto"><tr><td>상대 지점</td><td>제품명</td><td>이동수량</td><td>전체 수량</td><td>거래 종류</td><td>상태</td><td>날짜</td></tr>';
			
			
			for(var k=0; k<historyList.length;k++){
				if(branchList[i].seq==historyList[k].bseq && itemNList[j].seq==historyList[k].pseq){
					var check = 0;
					for(var l=0; l<branchList.length; l++){
						if(historyList[k].cseq == branchList[l].seq){
							modalLine += '<tr><td>'+branchList[l].name + '</td>';
							check++;
							break;
						}
					}
					if(check == 0){
						modalLine += '<tr><td>공급처</td>';
					}
					modalLine += '<td>'+itemNList[j].name+'</td>';
					modalLine += '<td>'+historyList[k].quantity+'</td>';
					modalLine += '<td>'+historyList[k].balance+'</td>';
					modalLine += '<td>'+historyList[k].kind+'</td>';
					modalLine += '<td>'+historyList[k].state+'</td>';
					modalLine += '<td>'+historyList[k].regdate+'</td></tr>';
				}
			}
			modalLine += '</table>';
			modalLine += '</div>';
			modalLine += '<div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div></div></div></div>';
		}		
	}

	$(".modal-sec").html(modalLine);	

	/*표 만드는 함수 */
 	makeTable();
	
	
	/*창고 체크박스를 한번 클릭했을 시 동작  */
	$(".branch").click(function(){
		if($(this).attr("checked")=="checked"){
			$(this).removeAttr("checked");
			$(this).next().next().css({"color":"black", "cursor":"default"});
		}
		else{
			$(this).attr("checked","checked");
			$(this).next().next().css({"color":"#FFBB00", "cursor":"pointer"});
		}
  		makeTable();
	});
	
	
	/*창고 체크박스를 더블 클릭했을 시 동작  */
	$(".branch").dblclick(function(){
		if($(this).attr("checked")=="checked"){
			$(this).removeAttr("checked");
			$(this).next().next().css({"color":"black", "cursor":"default"});
		}
		else{
			$(this).attr("checked","checked");
			$(this).next().next().css({"color":"#FFBB00", "cursor":"pointer"});
		}
  		makeTable();
	});
	
	
	/*즐겨찾기 버튼을 눌렀을때 반응  */
  	$(".favor").click(function(){
  		if($(this).prev().prev().attr("checked")=="checked"){
			if($(this).attr("title")=="1"){
				$(this).attr("class","glyphicon glyphicon-star favor");
				$(this).attr("title","2");
				$(this).prev().prev().attr("disabled","disabled");
			}
			else{
				$(this).attr("class","glyphicon glyphicon-star-empty favor");
				$(this).attr("title","1");
				$(this).prev().prev().removeAttr("disabled");
			}
  		}
	});

  	
	
	
	
	
	
	/*검색 버튼 눌렀을 때  */
 	$(".item-search-btn").click(function(){
		makeTable();
	});

	
   	function makeTable(){
  		
  		$(".table").remove();
  		var firstLine = '<tr><td></td>';
  		var checkBrN = 0;
  		for(var i=0; i<branchList.length; i++){
   			if($("#"+branchList[i].seq).attr("checked")=="checked"){
  				branchList[i].check = 1;
  				checkBrN++;
  				firstLine+= '<td><span data-toggle="modal" data-target="#modalBran_'+branchList[i].seq+'">'+branchList[i].name+"</span></td>";
  			}
  			else{
  				branchList[i].check = 0;
  			}
  		}
  		firstLine += "</tr>";
  		
  		
  		
  		
		var word = $(".item-search-txt").val().trim();
		
		var frontBLine = "";
		var backBLine = "";
		for(var i=0; i<itemNList.length; i++){
			var lineSaver = "";
   			if(itemNList[i].check == 1){
   				lineSaver += '<tr style="background-color: #B7F0B1;"><td>';
   				lineSaver += '<input type="checkbox" class="itemN-chb" checked="checked" id="'+itemNList[i].seq+'">';
   				lineSaver += '<span data-toggle="modal" data-target="#modalPro_'+itemNList[i].seq+'">'+itemNList[i].name+"<br>("+itemNList[i].seq+")</span></td>";

   			}
   			
   			else{
   				if(word != null && word != ""){
   					if(itemNList[i].name == word){
   						lineSaver += '<tr><td>';
   						lineSaver += '<input type="checkbox" class="itemN-chb" id="'+itemNList[i].seq+'">';
   						lineSaver += '<span data-toggle="modal" data-target="#modalPro_'+itemNList[i].seq+'">'+itemNList[i].name+"<br>("+itemNList[i].seq+")</span></td>";

   					}
   				}
   				else{
   					lineSaver += '<tr><td>';
					lineSaver += '<input type="checkbox" class="itemN-chb" id="'+itemNList[i].seq+'">';
					lineSaver += '<span data-toggle="modal" data-target="#modalPro_'+itemNList[i].seq+'">'+itemNList[i].name+"<br>("+itemNList[i].seq+")</span></td>";

   				}
   			}
   			
   			
   			if(lineSaver != ""){
  				for(var j=0; j<branchList.length; j++){
  					if(branchList[j].check==1){
  						for(var k=0; k<itemBList.length; k++){
  							if(itemNList[i].seq == itemBList[k].fseq && branchList[j].seq == itemBList[k].bseq){
  								lineSaver += '<td><span data-toggle="modal" data-target="#modalHist_'+branchList[j].seq+'_'+itemNList[i].seq+'">'+itemBList[k].balance+'</span></td>';
  							}
  						}
  					}
  				}
   			}
   			if(itemNList[i].check == 1){
   				frontBLine += lineSaver + "</tr>";
   			}
   			else{
   				backBLine += lineSaver + "</tr>";
   			}
  			
   			
  		}

  		
		var table = '<table class="table table-hover table-bordered" width="auto">';
		table+= firstLine;
		table+= frontBLine;
		table+= backBLine;
		table+= "</table>";
		
		$(".table-sec").html(table);

		$("table").css("width","auto");
		$("th").css({"width":"auto", "height":"auto"});
		$("td").css({"width":"130px", "height":"60px", "text-align":"center"});
		
		
		

		/*아이템 체크박스를 한번 클릭했을 시 동작  */
 		$(".itemN-chb").click(function(){
			if($(this).attr("checked")=="checked"){
				$(this).removeAttr("checked");
				$(this).parent().parent().css("background-color", "white");
				var temp = $(this).attr("id");
				for(var i=0; i<itemNList.length; i++){
					if(itemNList[i].seq == temp){
						itemNList[i].check = 0;
						break;
					}
				}
				
			}
			else{
				$(this).attr("checked","checked");
				$(this).parent().parent().css("background-color", "#B7F0B1");
				var temp = $(this).attr("id");
				for(var i=0; i<itemNList.length; i++){
					if(itemNList[i].seq == temp){
						itemNList[i].check = 1;
						break;
					} 
				}
			}
		});
		
		
		/*아이템 체크박스를 더블 클릭했을 시 동작  */
 		$(".itemN-chb").dblclick(function(){
			if($(this).attr("checked")=="checked"){
				$(this).removeAttr("checked");
				$(this).parent().parent().css("background-color", "white");
				var temp = $(this).attr("id");
				for(var i=0; i<itemNList.length; i++){
					if(itemNList[i].seq == temp){
						itemNList[i].check = 0;
						break;
					}
				}
				
			}
			else{
				$(this).attr("checked","checked");
				$(this).parent().parent().css("background-color", "#B7F0B1");
				var temp = $(this).attr("id");
				for(var i=0; i<itemNList.length; i++){
					if(itemNList[i].seq == temp){
						itemNList[i].check = 1;
						break;
					} 
				}
			}
		});
  	} 
	
});

</script>

<title>Insert title here</title>
<style type="text/css">
.favor{
	color : #FFBB00;
	cursor:pointer;
}
.table-sec{
	width: auto; 
}
</style>
</head>
<body>
<div id="wrapper">
	<%@include file="/resources/jspf/topnav.jspf"%>
    <%@include file="/resources/jspf/sidenavJaego.jspf"%>
    <div id="page-wrapper">
    <br>
    	<div class="btn-bar">
			<button class="btn btn-success" data-toggle="collapse" data-target="#branchList">Collapsible</button>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="text" class="item-search-txt"> <button class="btn btn-primary item-search-btn">검색</button>
			<div id="branchList" class="collapse">
				<c:forEach items="${branchList}" var="list">
					<input type="checkbox" class="branch" id="${list.bseq}" checked="checked"/>
					<label for="${list.bseq}">${list.name}</label>
 					<span class="glyphicon glyphicon-star-empty favor" title="1"></span>
					&nbsp;&nbsp;
				</c:forEach>
			</div> 
        </div>
        <br><br>
        <div class="table-sec">
        </div>
        <div class="modal-sec">
        </div>
           
           
           
           
           
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>
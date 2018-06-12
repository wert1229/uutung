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
		var branch = {"seq":"${list.bseq}", "name":"${list.name}","phone":"${list.phone}","location":"${list.location}", "check":1,"star":0, "manager":"${list.manager}"};
		branchList.push(branch);
	</c:forEach>
	
	var jsBranchList = getCookie("jsonBranch");
	if(jsBranchList != null && jsBranchList !=""){
		for(var i=0; i<branchList.length; i++){
			branchList[i].check = 0;
		}
		
		var favList = JSON.parse(jsBranchList);

		var starCount = 0;
		for(var i=0; i<branchList.length; i++){
			for(var j=0; j<favList.length; j++){
				if(branchList[i].seq == favList[j].seq){
					if(favList[j].star == 1){
						branchList[i].check = 1;
						branchList[i].star = 1;
						starCount = 1;
					}
				}
			}
		}
		if(starCount == 0){
			for(var i=0; i<branchList.length; i++){
				branchList[i].check = 1;
			}
		}
		
	}
	
	
	
	var clientList = new Array();

 	<c:forEach items="${clientList}" var="list">
		var client = {"seq":"${list.cseq}", "name":"${list.name}"};
		clientList.push(client);
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
			modalLine += '<h4 class="modal-title">거래 내역</h4></div>';
			modalLine += '<div class="modal-body">';
			modalLine += '<table class="table-hover table-bordered" width="auto"><tr><td>상대 지점</td><td>제품명</td><td>이동수량</td><td>전체 수량</td><td>거래 종류</td><td>상태</td><td>날짜</td></tr>';
			
			
			for(var k=0; k<historyList.length;k++){
				if(branchList[i].seq==historyList[k].bseq && itemNList[j].seq==historyList[k].pseq){
					if(historyList[k].kind != '발주'){
						for(var l=0; l<branchList.length; l++){
							if(historyList[k].cseq == branchList[l].seq){
								modalLine += '<tr><td>'+branchList[l].name + '</td>';
								break;
							}
						}
					}
					else{
						for(var l=0; l<clientList.length; l++){
							if(historyList[k].cseq == clientList[l].seq){
								modalLine += '<tr><td>'+clientList[l].name + '</td>';
								break;
							}
						}
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
	
	modalLine += '<div class="modal fade" id="modalHist_empty" role="dialog">';
	modalLine += '<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button>';
	modalLine += '<h4 class="modal-title">거래내역</h4></div>';
	modalLine += '<div class="modal-body">';
	modalLine += '거래내역이 없습니다.';
	modalLine += '</div>';
	modalLine += '<div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div></div></div></div>';

	$(".modal-sec").html(modalLine);	

	/*지점 버튼 만드는 함수  */
	makeBranchBtn();
	
	/*표 만드는 함수 */
 	makeTable();
	
 	
	
	
	/*창고 체크박스를 한번 클릭했을 시 동작  */
	$(".branch").click(function(){
		var checkSeq = $(this).attr("id");
		if($(this).attr("checked")=="checked"){
			$(this).removeAttr("checked");
			$(this).next().next().css({"color":"black", "cursor":"default"});
			for(var i=0; i<branchList.length; i++){
				if(branchList[i].seq == checkSeq){
					branchList[i].check = 0;
					break;
				}
			}
		}
		else{
			$(this).attr("checked","checked");
			$(this).next().next().css({"color":"#FFBB00", "cursor":"pointer"});
			for(var i=0; i<branchList.length; i++){
				if(branchList[i].seq == checkSeq){
					branchList[i].check = 1;
					break;
				}
			}
		}
		
  		makeTable();
	});
	
	
	/*창고 체크박스를 더블 클릭했을 시 동작  */
	$(".branch").dblclick(function(){
		var checkSeq = $(this).attr("id");
		if($(this).attr("checked")=="checked"){
			$(this).removeAttr("checked");
			$(this).next().next().css({"color":"black", "cursor":"default"});
			for(var i=0; i<branchList.length; i++){
				if(branchList[i].seq == checkSeq){
					branchList[i].check = 0;
					break;
				}
			}
		}
		else{
			$(this).attr("checked","checked");
			$(this).next().next().css({"color":"#FFBB00", "cursor":"pointer"});
			for(var i=0; i<branchList.length; i++){
				if(branchList[i].seq == checkSeq){
					branchList[i].check = 1;
					break;
				}
			}
		}
  		makeTable();
	});
	
	
	/*즐겨찾기 버튼을 눌렀을때 반응  */
  	$(".favor").click(function(){
  		var checkSeq = $(this).prev().prev().attr("id");
  		if($(this).prev().prev().attr("checked")=="checked"){
			if($(this).attr("title")=="0"){
				$(this).attr("class","glyphicon glyphicon-star favor");
				$(this).attr("title","1");
				$(this).prev().prev().attr("disabled","disabled");
				for(var i=0; i<branchList.length; i++){
					if(branchList[i].seq == checkSeq){
						branchList[i].star = 1;
						break;
					}
				}
				
			}
			else{
				$(this).attr("class","glyphicon glyphicon-star-empty favor");
				$(this).attr("title","0");
				$(this).prev().prev().removeAttr("disabled");
				for(var i=0; i<branchList.length; i++){
					if(branchList[i].seq == checkSeq){
						branchList[i].star = 0;
						break;
					}
				}
			}
  		}
  		var jsonBranch = JSON.stringify(branchList);
  		setCookie("jsonBranch", jsonBranch, 365);
	});

  	
	
	
	
	
	
	/*검색 버튼 눌렀을 때  */
 	$(".item-search-btn").click(function(){
		makeTable();
	});
	
	

	/* 지점 버튼 만들어버리긔  */
	function makeBranchBtn(){
// 		$(".branch-sec").remove();	
		var branchLine = '';

			for(var i=0; i<branchList.length; i++){
				if(branchList[i].star == 1){
					branchLine += '<input type="checkbox" class="branch" id="'+branchList[i].seq+'" checked="checked" disabled="disabled"/>';
					branchLine += '<label for="'+branchList[i].seq+'">'+branchList[i].name+'</label>';
					branchLine += '<span class="glyphicon glyphicon-star favor" id="star'+branchList[i].seq+'" title="1"></span>&nbsp;&nbsp;';
				}
				else{
					if(branchList[i].check == 0){
						branchLine += '<input type="checkbox" class="branch" id="'+branchList[i].seq+'"/>';
						branchLine += '<label for="'+branchList[i].seq+'">'+branchList[i].name+'</label>';
						branchLine += '<span class="glyphicon glyphicon-star-empty favor" id="star'+branchList[i].seq+'" title="0"></span>&nbsp;&nbsp;';
					}
					else{
						branchLine += '<input type="checkbox" class="branch" id="'+branchList[i].seq+'" checked="checked"/>';
						branchLine += '<label for="'+branchList[i].seq+'">'+branchList[i].name+'</label>';
						branchLine += '<span class="glyphicon glyphicon-star-empty favor" id="star'+branchList[i].seq+'" title="0"></span>&nbsp;&nbsp;';
					}
				}
			}
		$(".branch-sec").html(branchLine);
	}
	
	
	/* 쿠키 저장 함수  */
	function setCookie(cname, cvalue, exdays){
	    var d = new Date();
	    d.setTime(d.getTime() + (exdays*24*60*60*1000));
	    var expires = "expires="+ d.toUTCString();
	    document.cookie = cname + "=" + cvalue + "; " + expires + "; path=/";
	}
	
	
	
	/* 쿠키 얻는 함수  */
	function getCookie(cname){
	    var name = cname + "=";
	    var decodedCookie = decodeURIComponent(document.cookie);
	    var ca = decodedCookie.split(';');
	    for(var i=0; i<ca.length; i++)
	    {
	        var c = ca[i];
	        while(c.charAt(0) == ' ')
	        {
	            c = c.substring(1);
	        }
	        if(c.indexOf(name) == 0)
	        {
	            return c.substring(name.length, c.length);
	        }
	    }
	    return "";
	}
	
	
   	function makeTable(){

   		
  		
  		$(".table").remove();
  		var firstLine = '<tr><td class="bold-sec"></td>';
  		var checkBrN = 0;
  		for(var i=0; i<branchList.length; i++){
   			if($("#"+branchList[i].seq).attr("checked")=="checked"){
  				branchList[i].check = 1;
  				if($("#star"+branchList[i].seq).attr("title")=="1"){
  					branchList[i].star = 1;
  				}
  				else{
  					branchList[i].star = 0;
  				}
  				checkBrN++;
  				firstLine+= '<td class="bold-sec"><span data-toggle="modal" data-target="#modalBran_'+branchList[i].seq+'">'+branchList[i].name+"</span></td>";
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
   				lineSaver += '<tr style="background-color: #B7F0B1;"><td class="bold-sec">';
   				lineSaver += '<input type="checkbox" class="itemN-chb" checked="checked" id="'+itemNList[i].seq+'">';
   				lineSaver += '<span data-toggle="modal" data-target="#modalPro_'+itemNList[i].seq+'">'+itemNList[i].name+"<br>("+itemNList[i].seq+")</span></td>";

   			}
   			
   			else{
   				if(word != null && word != ""){
   					var indexCheck = itemNList[i].name.indexOf(word);
   					if(indexCheck != -1){
   						lineSaver += '<tr><td class="bold-sec">';
   						lineSaver += '<input type="checkbox" class="itemN-chb" id="'+itemNList[i].seq+'">';
   						lineSaver += '<span data-toggle="modal" data-target="#modalPro_'+itemNList[i].seq+'">'+itemNList[i].name+"<br>("+itemNList[i].seq+")</span></td>";

   					}
   				}
   				else{
   					lineSaver += '<tr><td class="bold-sec">';
					lineSaver += '<input type="checkbox" class="itemN-chb" id="'+itemNList[i].seq+'">';
					lineSaver += '<span data-toggle="modal" data-target="#modalPro_'+itemNList[i].seq+'">'+itemNList[i].name+"<br>("+itemNList[i].seq+")</span></td>";

   				}
   			}
   			
   			
   			if(lineSaver != ""){
  				for(var j=0; j<branchList.length; j++){
  					if(branchList[j].check==1){
  						var check = 0;
  						for(var k=0; k<itemBList.length; k++){
  							if(itemNList[i].seq == itemBList[k].fseq && branchList[j].seq == itemBList[k].bseq){
  								lineSaver += '<td><span data-toggle="modal" data-target="#modalHist_'+branchList[j].seq+'_'+itemNList[i].seq+'">'+itemBList[k].balance+'</span></td>';
  								check++;
  								break;
  							}
  						}
  						if(check == 0){
  							lineSaver += '<td><span data-toggle="modal" data-target="#modalHist_empty">0</span></td>';
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
  		$(".bold-sec").css({"font-weight":"bold", "background-color":"#E6FFFF"});
		
		
		

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
.panel{
	width : auto;
}
</style>
</head>
<body>
<div id="wrapper">
	<%@include file="/resources/jspf/topnav.jspf"%>
    <%@include file="/resources/jspf/sidenavJaego.jspf"%>
    <div id="page-wrapper">
	    <div class="panel panel-primary" style="margin-top: 30px">
			<div class="panel-heading">
				품목 관리
			</div>
	    	<div class="panel-body">
		    	<div class="btn-bar">
					<button class="btn btn-primary" data-toggle="collapse" data-target="#branchList">지점 선택</button>
					&nbsp;&nbsp;
					<input type="text" class="item-search-txt"> <button class="btn btn-primary item-search-btn">검색</button>
					<div id="branchList" class="collapse branch-sec">
		
					</div> 
		        </div>
		        <br>
		        <div class="table-sec">
		        </div>
		        <div class="modal-sec">
		        </div>
	        </div>   
	           
	           
	           
	    </div>       
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
</body>
</html>
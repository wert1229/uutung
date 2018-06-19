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
		$("#search").click();
		initApprovers();
	})

	function search(){
		var key = $("#key").val();

		$.ajax({
			type:"POST",
			url:"${path}/searchManager",
			dataType : 'json',
			data: { "key" : key},
			success: function(mlist){
				var content="";
				
				if(mlist.length != 0)
				{	
					content+='<table class="table table-striped table-bordered table-hover" id="testTable">';
					content+='<thead><tr><th>사번</th><th>지점</th><th>이름</th><th>직급</th></tr></thead>';
					content+='<tbody>';
					
					for(var i in mlist){
						content+='<tr onclick="select(this)">';
						content+='<td>'+ mlist[i].mseq +'</td>';
						content+='<td>'+ mlist[i].deptName +'</td>';
						content+='<td>'+ mlist[i].name +'</td>';
						content+='<td>'+ mlist[i].position +'</td>';
						content+='</tr>';
						
					}
					
					content+='</tbody>';
					content+='</table>';
				}
				else
				{
					content="검색 결과가 없습니다!"	;
				}
				
				$("#content").html(content);
				
				$("#testTable").DataTable({
					searching : false,
					ordering : false,
					lengthChange : false,
					info : false
				}).page.len(5).draw();
			} 
		});
	}
	
	var approvers = [];
	
	function initApprovers() {
		
		var mseqs = $("#approversSeq", opener.document).val().trim().split(" ");
		var names = $("#approversName", opener.document).val().trim().split(" ");
		var positions = $("#approversPos", opener.document).val().trim().split(" ");

		if(mseqs != "")
		{	
			for(var i in mseqs)
			{
				var member = {"mseq" : mseqs[i] , "name" : names[i] , "position" : positions[i]};
	
				approvers.push(member);
			}	
			
			draw();
		}
	}
	
	
	function select(one){
		var member =  $(one).children("td");
		
		var writer = "${sessionScope.loginSeq}";
		var mseq = $(member).eq(0).text();
		var name = $(member).eq(2).text();
		var position = $(member).eq(3).text();
		
		if(writer==mseq)
		{
			alert("자신은 들어갈 수 없습니다.");
			return false;
		}
		for(var i in approvers)
		{
			if(approvers[i].mseq==mseq)
			{
				alert("이미 존재합니다.");
				return false;
			}
		}
		
		var mem = {"mseq" : mseq , "name" : name, "position" : position};
		
		approvers.push(mem);
		
		draw();
	}
	
	function draw()
	{
		var content = "";
		
		content+='<table class="table table-striped table-bordered table-hover">';
		content+='<thead><tr><th>사번</th><th>이름</th><th>직급</th></tr></thead>';
		content+='<tbody>';
		
		for(var i in approvers)
		{
			content+='<tr onclick="deleteAprv(this)">';
			content+='<td>'+ approvers[i].mseq +'</td>';
			content+='<td>'+ approvers[i].name +'</td>';
			content+='<td>'+ approvers[i].position +'</td>';
			content+='</tr>';
		}
		
		content+='</tbody>';
		content+='</table>';
		
		$("#approversReged").html(content);
	}
	
	function deleteAprv(one)
	{
		var mseq = $(one).children("td").eq(0).text();
		
		for(var i in approvers)
		{
			if(approvers[i].mseq==mseq)
			{
				approvers.splice(i,1);
			}
		}
		
		draw();
	}
	
	function submit()
	{
		var names = "";
		var mseqs = "";
		var positions = "";
		
		for(var i in approvers)
		{
			names += approvers[i].name+" ";
			mseqs += approvers[i].mseq+" ";
			positions += approvers[i].position+" ";
		}

		$("#approversName",opener.document).val(names);
		$("#approversSeq",opener.document).val(mseqs);
		$("#approversPos",opener.document).val(positions);
		
		window.close();
	}
	
</script>
</head>
<body>
	<div class="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        	결재자
                    </div>
                </div> 
            </div>   
        </div>         
		<div class="row">
			<div class="col-xs-6">
		      	<div class="panel panel-default">
					<div class="panel-heading">
						등록
					</div>
					<div class="panel-body">
						<div id="approversReged">
						
						
						</div>
					</div>
				</div>
		    </div>
		    <div class="col-xs-6">
		    	<div class="panel panel-default">
		 			 <div class="panel-heading">
		 		     	 검색
		 			 </div>
		 			 <div class="panel-body">
		             	<div class="form-group input-group">
		                	<input type="text" id="key" class="form-control" value="${key}">
							<span class="input-group-btn">
		    					<button id="search" class="btn btn-default" type="button" onclick="search()"><i class="fa fa-search"></i>
		                 		</button>
	            			</span>
		         		</div>
				        <div id="content">
				         	
				        </div>
					</div>
				</div>
		    </div>
		    <div class="row">
				<div class="col-xs-offset-5">
					<button type="button" class="btn btn-primary" onclick="submit()">등록</button>
				</div>		    
		    </div>
        </div>         	
    </div>
</body>
</html>
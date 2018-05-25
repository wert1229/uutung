<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/resources/jspf/links.jspf"%>
<title>Insert title here</title>
<script>
	$(function()
	{
		$("#form").submit(function(event)
		{
			event.preventDefault();
			
			$.ajax(
			{
				type:"POST",
				url:"${path}/login/valid",
				data: 
				{
					email: $("#email").val(),
					pwd: $("#pwd").val()
				},
				success: function(login) 
				{
					if(login==false)
					{
						alert("일치하는 정보가 존재하지않습니다.");
					}
					else
					{
						$("#form").unbind('submit').submit();
					}
				}
			});
		});
		
		var remember = '${remember}';
		
		if(remember!="" && remember!="0")
		{
			$("#email").val(remember);
			$("#remember").attr("checked", true);
		}	
		
	});

</script>
</head>
<body>
	<div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">로그인이 필요합니다.</h3>
                    </div>
                    <div class="panel-body">
                        <form id="form" role="form" action="${path}/login" method="POST">
                            <fieldset>
                                <div class="form-group">
                                    <input id="email" class="form-control" placeholder="이메일" name="email" type="email" autofocus required>
                                </div>
                                <div class="form-group">
                                    <input id="pwd" class="form-control" placeholder="비밀번호" name="pwd" type="password" value="" required>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input id="remember" name="remember" type="checkbox" value="Remember Me">Remember Me
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <button type="submit" class="btn btn-lg btn-success btn-block">로그인</button>
                                <a href="${path}/join" class="btn btn-lg btn-info col-md-offset-4" style="margin-top:5px">회원가입</a>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
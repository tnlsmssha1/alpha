<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
<style type="text/css">
h1{
	text-align: center;
}
section{
	width: 50%;
	margin: auto;
}
form{
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
}
fieldset{
	margin: 20px 0px;
	border-radius: 30px;
	width:280px;
}

input{
	padding: 10px;
	margin: 10px;
}

.error{
	font-size: 1.5em;
	color: red;
	padding: 0.5em;
}
</style>
</head>
<body>
<section>
	<h1>Login</h1>
	<hr>
	<c:if test="${param.error == ''}">
		<div class="error">사용자ID 또는 비밀번호를 확인해 주세요.</div>
    </c:if>
	<form action="/login" method="post">
		<fieldset>
			<legend><label for="id">ID/PASSWORD</label></legend>
			<input id="id" name="username" placeholder="ID"/>
			<input id="pw" type="password" name="password" placeholder="PASSWORD"/>
		</fieldset>
			<input type="submit" value="로그인">
	</form>
</section>
</body>
</html>
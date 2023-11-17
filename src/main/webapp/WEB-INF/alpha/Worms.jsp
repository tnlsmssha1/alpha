<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/webjars/jquery/jquery.js"></script>
<title>zigzag.jsp</title>
<link rel="stylesheet" href="/css/zigzag.css">
<script type="text/javascript" src="/js/zigzag.js"></script>
</head>
<body>
<h1>Worms</h1>
<button id="btnCreate">Create</button>
<table id="surface">
	<tbody>
	<c:forEach var="list" items="${surface}">
		<tr>
		<c:forEach var="alpha" items="${list}">
			<td style="color: white; background: white;">${alpha.ch}</td>
		</c:forEach>
		</tr>
	</c:forEach>
	</tbody>
</table>

</body>
</html>
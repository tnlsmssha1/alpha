<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fill.jsp</title>
<style type="text/css">
h1{
	text-align: center;
}
#surface{
	margin: auto;

 	border: 1px solid red;
 	border-collapse: collapse;
 	
  	background: url('/media/alpha.png');
 	background-repeat: round;
 	 
	font-family: monospace;
	font-size: 2em;
}
#surface td:hover{
	position: relative;
	
	top: 0px;
	left: 0px;
	animation-name: curl;
	animation-duration: 4s;
	animation-fill-mode: both;
}
@keyframes curl{
	0%{
		transform: rotate(0deg) scale(1)
	}
	50%{
		transform: rotate(360deg) scale(5)
	}
	100%{
		transform: rotate(0deg) scale(1)
	}
}

</style>
<script type="text/javascript">

</script>
</head>
<body>
<h1>Curl</h1>
<table id="surface" onmousedown="event.preventDefault();" oncontextmenu="event.preventDefault();">
	<tbody>
	<c:forEach var="row" items="${surface}">
		<tr>
		<c:forEach var="alpha" items="${row}">
			<td style="color: ${alpha.fg}; background: ${alpha.bg}">${alpha.ch}</td>
		</c:forEach>
		</tr>
	</c:forEach>
	</tbody>
</table>
</body>
</html>
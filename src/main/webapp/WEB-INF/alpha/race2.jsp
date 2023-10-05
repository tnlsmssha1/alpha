<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>race2.jsp</title>
<style type="text/css">
#track{
	font-family: monospace;
	border-collapse: collapse;
}
</style>
<script type="text/javascript">
	function peopleAdd(){
		let xhr= new XMLHttpRequest();
		xhr.open('GET','/alpha/data2');
		xhr.responseType='json';
		xhr.onload= e=>{
			let alpha=xhr.response;
			console.log(alpha);
		}
		xhr.send();
	}
	function startBtn_click(e){
		console.log("start...")
		peopleAdd();
	}
	
	function show(alpha){
		let td=surface.rows[alpha.line-1].cells[alpha.column-1];
		td.style.color=alpha.fg;
		td.style.background=alpha.bg;
		td.innerText=alpha.ch;
	}
	function hide(alpha){
		let td=surface.rows[alpha.line-1].cells[alpha.column-1];
		td.style.color='black';
		td.style.background='black';
		td.innerText=alpha.ch;
	}
</script>
</head>
<body>
<h1>Race</h1>
<hr>
<button id="start" onclick="startBtn_click(event)">Start</button>
<button id="clear">Clear</button>
<hr>
<table border="1" width="400">
	<thead>
	<tr>
		<th>totalLaps</th><th>player</th><th>seconds</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td id="totallaps" align="right">0</td>
		<td id="player" align="right">0</td>
		<td id="seconds" align="right">0</td>
	</tr>
	</tbody>
</table>
<hr>
<table id="track">
	<c:forEach var="row" items="${ground}">
		<tr>
		<c:forEach var="alpha" items="${row}">
			<td style="color: black; background: black">${alpha.ch}</td>
		</c:forEach>
		</tr>
	</c:forEach>
</table>
</body>
</html>
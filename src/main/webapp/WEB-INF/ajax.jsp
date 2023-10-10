<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax.list</title>
<style type="text/css">
table{
/* 	border-collapse:collapse; */
/* 	font-family: monospace; */
}
</style>
<!-- JSON(Javascript Object Notation) -->
<script type="text/javascript">
window.onload=function(){
	function sync(){
		btn.disabled=true;
		let xhr=new XMLHttpRequest();
		xhr.open('GET', '/alpha', false);
		xhr.send();
		let alpha=JSON.parse(xhr.responseText);
		let td= surface.rows[alpha.line-1].cells[alpha.column-1];
		td.style.color=alpha.fg;
		td.style.background=alpha.bg;
		td.innerText=alpha.ch;
		btn.disabled=false;
	}
	
	function async(){
		btn.disabled=true;
		let xhr=new XMLHttpRequest();
		xhr.open('GET','/alpha');
		xhr.send();
		xhr.onload=function(e){
			let alpha=JSON.parse(xhr.responseText);
			let td= surface.rows[alpha.line-1].cells[alpha.column-1];
			td.style.color=alpha.fg;
			td.style.background=alpha.bg;
			td.innerText=alpha.ch;
			btn.disabled=false;
		}
	}
	
	btn.onclick= async;
// 	btn.onclick= sync;
	
	setInterval(function() {
		let cnt=no.innerText;
		no.innerText=++cnt;
	}, 1000);
	
}
</script>
</head>
<body>
<h1>Alpha Generato1r</h1>
<hr>
<button id="btn">ajax</button>
<span id="no">0</span>
<hr>
<table id="surface">
	<c:forEach var="row" items="${surface}">
		<tr>
		<c:forEach var="a" items="${row}">
			<td style="color:black; background:black">${a.ch}</td>
		</c:forEach>
		</tr>
	</c:forEach>
</table>
</body>
</html>
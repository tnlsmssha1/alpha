<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/webjars/jquery/jquery.js"></script>
<title>fill.jsp</title>
<style type="text/css">
body{
	height: 2000px;
}
#surface{
 	border-collapse: collapse;
	font-family: monospace;
 	border: 1px solid red;
 	margin: auto;
 	margin-top: 20px;
}
#setTable{
	width: 480px;
	margin: auto;
	text-align: center;
}
#setcount{
	width: 50px; 
}

#parent_btn{
 	margin-top: 15px;
} 
table:nth-of-type(1) {
 	margin: auto;
 	margin-top: 15px;
 	width: 480px;
}
/* input:nth-of-type(4) { */
/* 	background: red; */
/* } */
</style>
<script type="text/javascript">
function startBtn_click(e){
	console.log("start...")
	start.disabled=true; 
	clear.disabled=true;
	
	let stid=setInterval(function() {
		seconds.innerText=++seconds.innerText;		
	},1000)
	
	let tid=setInterval(function() {
		forCount.innerText=++forCount.innerText;
		let setCount=$('#setcount').attr('value');
		
		if(count.innerText==setCount){ 
			clearInterval(tid);
			clearInterval(stid);
			start.disabled=true;	
			clear.disabled=false;
			checkBtn.disabled=false;
			return; 
		}
		
		let xhr=new XMLHttpRequest();
		xhr.open('GET','/alpha/data')
		xhr.responseType='json';
		xhr.onload= e=>{
			let alpha = xhr.response;
			console.log(alpha);
			let td=surface.rows[alpha.line-1].cells[alpha.column-1];
			
			if(td.style.color=='black' && td.style.background=='black'){
				count.innerText=++count.innerText;				
				td.style.color=alpha.fg;
				td.style.background=alpha.bg;
				td.innerText=alpha.ch;
			}
		}
		xhr.send();
	}, 10);
}

function clearBtn_click(e){
	console.log("clear...")
	
	for(let row of surface.rows){
		for(let td of row.cells){
			td.style.color='black'
			td.style.background='black'
		}
	}
	forCount.innerText=0;
    count.innerText=0;
    seconds.innerText=0;
    $('#setL').attr('value','')
    $('#setC').attr('value','')
    $('#setcount').attr('value','')
}

window.onload= () => {
	if($('#setL').attr('value')==''&&$('#setC').attr('value')==''){
		start.disabled=true;
		clear.disabled=true;
	}else{
		start.disabled=false;
		clear.disabled=false;
		checkBtn.disabled=true;
		setL.disabled=true
		setC.disabled=true
		setcount.disabled=true
	}
}
</script>
</head>
<body>
<h1 align="center">Table Maker[김현민]</h1>
<form id="setTable" action="http://localhost:8080/alpha/fill">
	<fieldset>
	<legend>Table Size&Count</legend>
		<label for="setL">Line:</label>
		<input id="setL" name="setline" type="number" min="1" max="50" value="${param.setline}">
		<label for="setC">Column:</label>
		<input id="setC" name="setcolumn" type="number" min="1" max="50" value="${param.setcolumn}">
		<label for="setcount">Count:</label>
		<input id="setcount" name="setcount" type="number" value="${param.setcount}">
<!-- 		onchange 속성을 사용해서 수정 가능여부 확인 필요 -->
		<button id="checkBtn" type="submit">제출</button>
		<div id="parent_btn">
			<button id="start" onclick="startBtn_click(event)">Start</button>
			<button id="clear" onclick="clearBtn_click(event)">Clear</button>
		</div>
	</fieldset>
</form>
<table border="1">
<thead>
	<tr>
		<th>forCount</th><th>count</th><th>seconds</th>
	</tr>
</thead>
	<tr>
		<td id="forCount" align="center">0</td>
		<td id="count"    align="center">0</td>
		<td id="seconds"  align="center">0</td>
	</tr>
</table>
<table id="surface" onmousedown="event.preventDefault();" oncontextmenu="event.preventDefault();">
	<tbody>
	<c:forEach var="i" begin="1" end="${param.setline}">
		<tr>
		<c:forEach var="j" begin="1" end="${param.setcolumn}">
		<c:set var="alpha" value="${surface[i][j]}" />
			<td style="color: ${alpha.fg}; background: ${alpha.bg}">${alpha.ch}</td>
		</c:forEach>
		</tr>
	</c:forEach>
	</tbody>
</table>
</body>
</html>
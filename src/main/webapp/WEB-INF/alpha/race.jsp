<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>race.jsp</title>
<style type="text/css">
#surface{
	font-size: 1.4em;
	font-family: monospace;
	border-collapse: collapse;
	background-color: red; 
	background-image: url('/img/BackgroundFront.png'), url('/img/BackgroundBack.png');
	background-size: 100%;
	background-repeat: no-repeat;
}
#surface td{
	opacity: 0.7;
}
#startBtn{
	padding: 5px 20px 5px 20px;
}
section > table{
	float: left;
	margin: 10px;
}
</style>
<script type="text/javascript">
function chAdd(alpha){
	let surface2Tbody=surface2.querySelector('tbody');
	let tr=document.createElement('tr');
	let no=document.createElement('td');
	let ch=document.createElement('td');
	let raps=document.createElement('td');
	
	tr.append(no);
	tr.append(ch);
	tr.append(raps);
	surface2Tbody.append(tr);
	
	no.innerText=tr.parentElement.rows.length;
	
	ch.innerText=alpha.ch;
	no.align='center';
	ch.align='center';
	ch.style.color=alpha.fg;
	ch.style.background=alpha.bg;
	raps.align='right';
	
	raps.innerText=0;
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
function race(alpha){
	let speed=Math.random()*300+100;
	let direction=0;//0=right 1=down 2=left 3=up
	
	alpha.line=1;
	alpha.column=1;
	
	let td=surface.rows[alpha.line-1].cells[alpha.column-1];
	td.style.color=alpha.fg;
	td.style.background=alpha.bg;
	td.innerText=alpha.ch;
	
	setTimeout(function move() {
		
		hide(alpha);
		
		
		switch(direction){
		case 0: //right
			alpha.column++;
			break;
		case 1: //down
			alpha.line++;
			break;
		case 2: //left
			alpha.column--;
			break;
		case 3: //up
			alpha.line--;
			break;
		}
		
		show(alpha);
		
		if(alpha.line==1&&alpha.column==40)
			direction=1
		else if(alpha.line==20&&alpha.column==40)
			direction=2
		else if(alpha.line==20&&alpha.column==1)
			direction=3
		else if(alpha.line==1&&alpha.column==1){
			direction=0
			totallaps.innerText=++totallaps.innerText;			
		}
		
		setTimeout(move,speed)
	}, speed)
}

window.onload=function(){
	startBtn.onclick=e=>{
		player.innerText=++player.innerText;
		fetch('/alpha/data')
		.then(response=>response.json())
		.then(alpha=>{
			race(alpha);
			chAdd(alpha);
			if(player.innerText==1){
				setInterval(function() {
					seconds.innerText=++seconds.innerText
				},1000)
			}
		})
	}
}
</script>
</head>
<body>
<h1>Race => fetch활용</h1>
<hr>
<button id="startBtn">Start</button>
<hr>
<table border="1" width="300">
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
<section>
<table id="surface2" border="1" width="200">
	<thead>
		<tr>
			<th>no</th><th>ch</th><th>raps</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<table id="surface" onmousedown="event.preventDefault();" oncontextmenu="event.preventDefault();">
	<tbody>
	<c:forEach var="i" begin="0" end="${surface.size()-1}">
		<tr>
			<c:forEach var="j" begin="0" end="${surface.get(i).size()-1}">
				<c:set var="alpha" value="${surface[i][j]}"/>
				<td style="color: black; background: black;">${surface[i][j].ch}</td>
			</c:forEach>
		</tr>
	</c:forEach>
	</tbody>
</table>
</section>
</body>
</html>
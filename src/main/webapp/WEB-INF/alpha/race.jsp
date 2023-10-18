<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html >
<head>
<meta charset="UTF-8">
<title>race.jsp</title>
<style type="text/css">
#raceSetting{
	display: inline-block;
	position: relative;
}

#raceSetting input{
	width: 30px;
	text-align: right;
}

#surface {
	border-collapse: collapse;
	
	font-family: monospace;
	font-size: 1.5em;
	
	background-image: url('/img/잔디.jpg');
	background-repeat: no-repeat;
	
/* 	position: absolute; */
}

#surface td {
 	opacity: 0.7; 
}

section > #surface{
	margin: auto;
}

#startBtn {
	padding: 5px 10px;
}
</style>
<script type="text/javascript">

function race(alpha) {
	console.log("race()..." + alpha)
	let speed = Math.random()*200 + 10;
	let direction = 0; // 0 : right, 1: down, 2: left, 3: up
	
	alpha.line = 1;
	alpha.column = 1;
	
	let td = surface.rows[alpha.line-1].cells[alpha.column-1];
	td.style.color = alpha.fg;
	td.style.background = alpha.bg;
	td.innerText = alpha.ch;
	
	let tr 		= document.createElement('tr');
	let tdNo 		= document.createElement('td');
	let tdAlpha 	= document.createElement('td');
	let tdCount 	= document.createElement('td');
	
	tr.append(tdNo);
	tr.append(tdAlpha);
	tr.append(tdCount);
	
	window.stat.tBodies[0].append(tr);
	
	tdNo.align 	 = 'right';
	tdAlpha.align = 'right';
	tdCount.align = 'right';
	
	tdNo.innerText = tr.parentElement.rows.length;

	tdAlpha.innerText = alpha.ch;
	tdAlpha.style.color = alpha.fg;
	tdAlpha.style.background = alpha.bg;
	
	tdCount.innerText = 0;
		
	setTimeout(function move() {
		let td = surface.rows[alpha.line-1].cells[alpha.column-1];
		td.style.color = 'black';
		td.style.background = 'black';
		
		switch(direction) {
		case 0:	// RIGHT
			alpha.column++;
			break;
		case 1:	// DOWN
			alpha.line++;
			break;
		case 2:	// LEFT
			alpha.column--;
			break;
		case 3:	// UP
			alpha.line--;
			break;
		}

		td = surface.rows[alpha.line-1].cells[alpha.column-1];
		td.style.color = alpha.fg;
		td.style.background = alpha.bg;
		td.innerText = alpha.ch;
		
		if (alpha.line==1 && alpha.column==1) {
			direction = 0; // right
			roundCount.innerText = ++roundCount.innerText;
			tdCount.innerText = ++tdCount.innerText;
		} else if (alpha.line==1 && alpha.column==40)
			direction = 1; // down
		else if (alpha.line==20 && alpha.column==40)
			direction = 2; // left
		else if (alpha.line==20 && alpha.column==1)
			direction = 3; // up
		
		setTimeout(move, speed);
	}, speed);
	
	count.innerText = ++count.innerText;
	if (count.innerText == 1) {
		setInterval(function() {
			ellipse.innerText = ++ellipse.innerText;
		}, 1000);
	}
}

window.onload = function() {
	
	startBtn.onclick = async e => {
		let response=fetch('/alpha/data')
		let alpha=response.json();
		race(alpha);
	}
	
}
</script>
</head>
<body>
<h1 align="center">Race</h1>
<form id="raceSetting" action="http://localhost:8080/alpha/race">
<fieldset>
<legend>Race Setting</legend>
	<label for="player">Player</label>
	<input name="player" type="number" value="${param.player}">
	<label for="lap">Lap</label>
	<input name="lap" type="number" value="${param.lap}">
	<button id="startBtn">Start</button>
</fieldset>
</form>

<section>
<table id="stat" border="1">
	<thead>
		<tr>
			<th>no</th><th>alpha</th><th>Round Count</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<table id="surface" onmousedown="event.preventDefault();" oncontextmenu="event.preventDefault();">
	<tbody>
	<c:forEach var="i" begin="0" end="${surface.size()-1}" >
		<tr>
		<c:forEach var="j" begin="0" end="${surface.get(i).size()-1}">
			<c:set var="alpha" value="${surface[i][j]}"/>
			<td style="color: black; background: black;">${alpha.ch}</td>
		</c:forEach>
		</tr>
	</c:forEach>
	</tbody>
</table>
</section>
</body>
</html>
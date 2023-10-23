<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html >
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/webjars/jquery/jquery.js"></script>
<title>race.jsp</title>
<style type="text/css">
body{
	height: 1000px
}
#raceSetting{
	text-align: center;
	width: 250px;
	margin: auto;
}

#raceSetting input{
	width: 50px;
	text-align: right;
}
#raceSetting+div{
	text-align: center;
	margin: 10px;
}

#surface {
	margin: auto;
	border-collapse: collapse;
	
	font-family: monospace;
	font-size: 1.5em;
	
	background-image: url('/img/잔디.jpg');
	background-repeat: no-repeat;
	
}

#surface td {
 	opacity: 0.7; 
}

#stat{
	position: absolute;
	display: inline-block;
	left: 100px;
}

section > #surface{
	margin: auto;
}

</style>
<script type="text/javascript">
function sleep(millis){
	return new Promise((resolve, reject)=>{
		setTimeout(resolve, millis)
	});
}

class Race{
	constructor(id){
		this.id=id;
		this.speed = Math.random()*200+10;
		this.direction = 0;
		this.round=0;
	}
	
	show(){
		let td=surface.rows[this.alpha.line-1].cells[this.alpha.column-1]
		td.style.color=this.alpha.fg;
		td.style.background=this.alpha.bg;
		td.innerText=this.alpha.ch;
	}
	
	hide(){
		let td=surface.rows[this.alpha.line-1].cells[this.alpha.column-1]
		td.style.color='black';
		td.style.background='black';
	}
	
	addCh(){
		let tr 			= document.createElement('tr');
		let tdNo 		= document.createElement('td');
		let tdAlpha 	= document.createElement('td');
		
		tr.append(tdNo);
		tr.append(tdAlpha);
		
		window.stat.tBodies[0].append(tr);
		
		tdNo.align 	 = 'center';
		tdAlpha.align = 'center';
		
		tdNo.innerText = tr.parentElement.rows.length;

		tdAlpha.innerText = this.alpha.ch;
		tdAlpha.style.color = this.alpha.fg;
		tdAlpha.style.background = this.alpha.bg;
	}
	
	
	move(){
		this.hide();
		
		switch(this.direction) {
		case 0:	// RIGHT
			this.alpha.column++;
			break;
		case 1:	// DOWN
			this.alpha.line++;
			break;
		case 2:	// LEFT
			this.alpha.column--;
			break;
		case 3:	// UP
			this.alpha.line--;
			break;
		}
		
		this.show();
		
		if (this.alpha.line==1 && this.alpha.column==1) {
			this.direction = 0; // right
			this.round=++this.round;
		} else if (this.alpha.line==1 && this.alpha.column==40)
			this.direction = 1; // down
		else if (this.alpha.line==20 && this.alpha.column==40)
			this.direction = 2; // left
		else if (this.alpha.line==20 && this.alpha.column==1)
			this.direction = 3; // up
	}
	
	
	
	async run(){
		let startSec=Date.now();
		let response=await fetch('/alpha/data');
		this.alpha=await response.json();
		
		this.alpha.line=1;
		this.alpha.column=1;
		
		this.show();
		
		for(;;){
			await sleep(this.speed);
			this.move()
			if($('input[name=lap]').val()==this.round){
				console.log(this.id)
				let stopSec=Date.now();
				let finishSec=parseInt(stopSec-startSec)/1000;
				
				let statTable = document.querySelector('#stat tbody');
	            let row = document.createElement('tr');
	            let tdNo = document.createElement('td');
	            let tdAlpha = document.createElement('td');
	            let timeTd = document.createElement('td');
	            
	            tdNo.align = 'center';
	            tdAlpha.align = 'center';
	            timeTd.align = 'center';

	            tdNo.innerText = statTable.rows.length + 1; // 현재 행의 순서
	            tdAlpha.innerText = this.alpha.ch;
	            tdAlpha.style.color = this.alpha.fg;
	            tdAlpha.style.background = this.alpha.bg;
	            timeTd.innerText = finishSec

	            row.appendChild(tdNo);
	            row.appendChild(tdAlpha);
	            row.appendChild(timeTd);

	            statTable.appendChild(row);
				
				console.log("stop!....")
				break;
			}
		}
	}
}
window.onload=()=>{
	startBtn.onclick = e => {
		startBtn.disabled=true
		for(let i=0;i<parseInt($('input[name=player]').val());i++){
			let race=new Race(i);
			race.run();
		}
	}
	
	clearBtn.onclick= e=>{
		startBtn.disabled=false;
		$('#surface td').css('color','black')
		$('#surface td').css('background','black')
		$('#stat tbody').empty()
		$('input[name=lap]').val('')
		$('input[name=player]').val('')
	}
}
</script>
</head>
<body>
<h1 align="center">Race</h1>
<form id="raceSetting" action="http://localhost:8080/alpha/race2">
<fieldset>
<legend>Race Setting</legend>
	<label for="player">Player</label>
	<input name="player" type="number" min="1" value="${param.player}">
	<label for="lap">Lap</label>
	<input name="lap" type="number" min="1" value="${param.lap}">
	
</fieldset>
</form>
<div>
	<button id="startBtn">Start</button>
	<button id="clearBtn">Clear</button>
</div>
<section>
<table id="stat" border="1">
	<thead>
		<tr>
			<th>Rank</th><th>Alpha</th><th>Sec</th>
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
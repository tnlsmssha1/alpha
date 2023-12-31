<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/webjars/jquery/jquery.js"></script>
<title>cross.jsp</title>
<style type="text/css">
body{
 	height: 2500px;
}
section > table{
 	float: left; 
 	margin: 10px; 
}
select{
	width: 100px;
}
#makeAlpha{
	text-align: center;
}
#makeAlpha input{
	width: 93px;
}
#surface3{
	top: 280px;
	left: 0px;
}
#surface2{
	top: 350px;
	left: 0px;
}
#surface{
	display: flex;
	justify-content: flex-start;
	align-items: center;
	border-collapse: collapse;
	font-family: monospace;
	font-size: 120%;
}

#createBtn{
	display: block;
	margin: auto;
}
</style>
<script type="text/javascript">
function sleep(millis){
	return new Promise(function(resolve, reject) {
		setTimeout(resolve, millis);
	});
}

class Cross{
	constructor(){
		this.direction=parseInt($('select[name=direction]').val());
		this.speed=parseInt($('input[name=speed]').val())*100;
	}
	
	show(){
		let td=surface.rows[this.alpha.line-1].cells[this.alpha.column-1]
		td.style.color=this.alpha.fg;
		td.style.background=this.alpha.bg;
		td.innerText=this.alpha.ch;
	}
	
	hide(){
		let td=surface.rows[this.alpha.line-1].cells[this.alpha.column-1];
		td.style.color='black';
		td.style.background='black';
		td.innerText=this.alpha.ch;
	}
	
	addCh(){
		let tr=document.createElement('tr');
		let tdNo=document.createElement('td');
		let tdCh=document.createElement('td');
		
		tr.append(tdNo);
		tr.append(tdCh);
		surface2.tBodies[0].append(tr);
		
		tdNo.innerText=madeAlpha.innerText;
		tdCh.innerText=this.alpha.ch;
		
		
		tdCh.align='center'
		tdNo.align='center'
		tdCh.style.color=this.alpha.fg;
		tdCh.style.background=this.alpha.bg;
		
		
	}
	
	move(){
		this.hide();
		
		switch(this.direction){
		case 0: //right
			this.alpha.column++;
			break;
		case 1: //down
			this.alpha.line++;
			break;
		case 2: //left
			this.alpha.column--;
			break;
		case 3: //up
			this.alpha.line--;
			break;
		}
		
		if(this.alpha.line==0||this.alpha.line==21||this.alpha.column==0||this.alpha.column==41){
			return false;
		}
		
		this.show();
		return true;
	}
	
	async run(){
		let response=await fetch('/alpha/data');
		this.alpha=await response.json();
		
		this.alpha.line=10;
		this.alpha.column=20;
		this.alpha.ch=$('select[name=alphaCh]').val();
		this.alpha.fg=$('select[name=alphaFg]').val();
		this.alpha.bg=$('select[name=alphaBg]').val();
		
		this.addCh();
		this.show();
		for(;;){
			await sleep(this.speed);
			if(!this.move())
				break;
		}
	}
}

window.onload= ()=>{
	createBtn.onclick= ()=>{
		madeAlpha.innerText=++madeAlpha.innerText;
		let cross=new Cross();
		cross.run();
	}
}
</script>
</head>
<body>
<h1 align="center">Alpha Maker</h1>
<section>
<table id="makeAlpha" style="border: 1px solid black">
	<thead>
		<tr>
			<th>목록</th>
			<th>옵션</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>글자</td>
			<td>
				<select name="alphaCh">
					<c:forEach var="i" begin="0" end="25">
					<c:set var="ch" value="<%=\"\"+(char)('A'+(Integer)(pageContext.getAttribute(\"i\")))%>" />
						<option>${ch}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>색깔</td>
			<td>
				<select name="alphaFg">
					<option>Black</option>
					<option>Red</option>
					<option>Green</option>
					<option>Yellow</option>
					<option>Blue</option>
					<option>Magenta</option>
					<option>Cyan</option>
					<option>White</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>배경색</td>
			<td>
				<select name="alphaBg">
					<option>Black</option>
					<option>Red</option>
					<option>Green</option>
					<option>Yellow</option>
					<option>Blue</option>
					<option>Magenta</option>
					<option>Cyan</option>
					<option>White</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>속도</td>
			<td>
				<input name="speed" type="number" min="1" max="10" value="${param.speed}">
			</td>
		</tr>
		<tr>
			<td>방향</td>
			<td>
				<select name="direction">
						<option value="0">RIGHT</option>
						<option value="1">DOWN</option>
						<option value="2">LEFT</option>
						<option value="3">UP</option>
				</select>
			</td>
		</tr>
		<tr>
			<td style="border-top: 1px solid black;" colspan="2">
				<button type="button" id="createBtn">생성</button>
			</td>
		</tr>
	</tbody>
</table>

<table id="surface3" border="1">
	<thead>
		<tr>
			<th>madeAlpha</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td id="madeAlpha" align="center">0</td>
		</tr>
	</tbody>
</table>
<table id="surface2" border="1">
	<thead>
		<tr>
			<th>no</th><th>ch</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</section>


<table id="surface" onmousedown="event.preventDefault();" oncontextmenu="event.preventDefault();">
	<tbody>
		<c:forEach var="i" begin="0" end="${surface.size()-1}">
		<tr>
			<c:forEach var="alpha" items="${surface[i]}">
				<td style="color: black; background: black">${alpha.ch}</td>
			</c:forEach>
		</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>
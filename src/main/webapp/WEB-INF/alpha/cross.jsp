<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cross.jsp</title>
<style type="text/css">
body{
/* 	background-image: url('/media/alpha.png'), url('/media/small.png')	 */
}
#surface{
	border-collapse: collapse;
	font-family: monospace;
	font-size: 160%;
	
/* 	border: 15px outset red; */
}
#surface td{
	opacity: 0.8;
}
section > table{
	float: left;
	margin: 10px;
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
		this.direction=parseInt(Math.random()*4);
// 		this.direction=1
		this.speed=Math.random()*300+10;
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
// 			surface2.rows[1].remove();
			return false;
		}
		
		this.show();
		return true;
	}
	
	automode(){
		
	}
	
	async run(){
// 		console.log("count="+this.count)
		let response=await fetch('/alpha/data');
		this.alpha=await response.json();
		
		this.alpha.line=10;
		this.alpha.column=20;
		
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
		if(autobox.checked){
		}
		cross.run();
		
		if(madeAlpha.innerText==1){
			setInterval(function() {
				sec.innerText=++sec.innerText;
			}, 1000)
		}
	}
}
</script>
</head>
<body>
<h1>async/await + class</h1>
<hr>
<button id="createBtn">Create</button>
<label for="autobox">AUTO</label>
<input id="autobox" type="checkbox">
<hr>
<section>
<table id="surface3" border="1" width="300">
	<thead>
		<tr>
			<th>madeAlpha</th><th>seconds</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td id="madeAlpha" align="right">0</td>
			<td id="sec" align="right">0</td>
		</tr>
	</tbody>
</table>
<table id="surface2" border="1" width="100">
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fill.jsp</title>
<style type="text/css">
#surface{
 	border-collapse: collapse;
	font-family: monospace;
 	border: 1px solid red;
}

/* #parent_btn{ */
/* 	text-align: center; */
/* } */
</style>
<script type="text/javascript">
function startBtn_click(e){
	console.log("start...")
	start.disabled=true; 
	clear.disabled=true;// start버튼을 클릭시 더이상 클릭이 되지 않도록 비활성화
	
	let stid=setInterval(function() {
		seconds.innerText=++seconds.innerText;		
	},1000) // start버튼을 클릭하게되면 seconds의 숫자가 1초씩 증가
	
	let tid=setInterval(function() {
		forCount.innerText=++forCount.innerText;//Interval이 실행 될 때마다 forcount가 증가하면서 테이블에 있는 forcount의 수가 증가함
		//document.querySelector('#setL').value setL에 있는 값을 불러 올 수 있음
		if(count.innerText==800){ // count가 800이 되는 순간 진행중이던 Interval이 종료되는 코드
			clearInterval(tid);// alpha를 찍어내던 Interval이 종료됨
			clearInterval(stid);// seconds의 Interval이 종료됨
			start.disabled=false;	
			clear.disabled=false;// 비활성화 되어 있던 버튼을 다시 활성화 함
			return; // return이 없다면 아래의 코드가 한번 더 실행될 수도 있음
		}
		
		let xhr=new XMLHttpRequest();// ajax를 이용한 alpha를 생성함
		xhr.open('GET','/alpha/data')
		xhr.responseType='json';
		xhr.onload= e=>{
			let alpha = xhr.response;
			console.log(alpha);
			let td=surface.rows[alpha.line-1].cells[alpha.column-1];
			
			if(td.style.color=='black' && td.style.background=='black'){ //기존 table의 color, background가 black인 경우 count를 증가시키면서 새롭게 불러운 alpha를 찍음
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
}
</script>
</head>
<body>
<h1 align="center">Fill[김현민]</h1>
<hr>
<form id="setTable" action="http://localhost:8080/alpha/fill">
<label for="setL">Line:</label>
<input id="setL" name="setline" type="number" min="1" max="100" value="${param.setline}">
<label for="setC">Column:</label>
<input id="setC" name="setcolumn" type="number" min="1" max="100" value="${param.setcolumn}">
<label for="setcount">Count:</label>
<input id="setcount" name="setcount" type="number" value="${param.setcount}">
<input type="submit" value="확인">
</form>
<div id="parent_btn">
<button id="start" onclick="startBtn_click(event)">Start</button>
<button id="clear" onclick="clearBtn_click(event)">Clear</button>
</div>
<hr>
<table border="1" width="250">
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
<hr>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fill.jsp</title>
<style type="text/css">
#surface, #surface2{
 	border-collapse: collapse;
	font-family: monospace;
  	background: url('/media/alpha.png');
 	background-repeat: round; 
 	border: 5px solid red;
}
#surface td{
	opacity: 0.5
}
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
// 	for(let i=0;i<surface.rows.length;i++){
// 		for(let j=0;j<surface.rows[i].cells.length;j++){
// 			surface.rows[i].cells[j].style.color='black';
// 			surface.rows[i].cells[j].style.background='black';
// 		}
// 	}
	
// 	for(let row of surface.rows){
// 		for(let td of row.cells){
// 			td.style.color='black'
// 			td.style.background='black'
// 		}
// 	}

	Array.from(surface.rows).forEach(function(row) {
		Array.from(row.cells).forEach(function(td) {
			td.style.color='black'
			td.style.background='black'
		})
	})// 위 2개의 for문과 1개의 forEach문은 새롭게 찍어둔 alpha의 color, backgroud를 black으로 초기화 하는 코드
	forCount.innerText =0;
    count.innerText =0;
    seconds.innerText=0; // 기존 측정된 값들을 0으로 초기화 함
}
</script>
</head>
<body>
<h1>Spring MVC + XMLHttpRequest</h1>
<hr>
<button id="start" onclick="startBtn_click(event)">Start</button>
<button id="clear" onclick="clearBtn_click(event)">Clear</button>
<hr>
<table border="1" width="500">
<thead>
	<tr>
		<th>forCount</th><th>count</th><th>seconds</th>
	</tr>
</thead>
	<tr>
		<td id="forCount" align="right">0</td>
		<td id="count"    align="right">0</td>
		<td id="seconds"  align="right">0</td>
	</tr>
</table>
<hr>
<table id="surface" onmousedown="event.preventDefault();" oncontextmenu="event.preventDefault();">
<!-- 함수가 아닌 태그 안에 이벤트가 들어갈 경우 e가 아닌 event로 작성해야 인식 함 -->
<!-- onmousedown은 오른쪽클릭으로 하는 드래그를 불가하게끔, oncontextmenu는 오른쪽 클릭을 했을 때 나오는 메뉴를 나오지 않게 함 -->
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
<hr>
<table id="surface2"> <!-- surface의 테이블과 같지만 향상된 forEach와 기존 forEach 의 차이이다-->
	<tbody>
		<c:forEach var="i" begin="0" end="19">
		<tr>
			<c:forEach var="j" begin="0" end="39">
			<c:set var="alpha" value="${surface[i][j]}"/>
				<td style="color: ${alpha.fg}; background:${alpha.bg}">${alpha.ch}</td>
			</c:forEach>
		</tr>
		</c:forEach>
	</tbody>	
</table>
</body>
</html>
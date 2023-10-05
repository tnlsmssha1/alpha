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
 	border: 1px solid red;
 	border-collapse: collapse;
 	
  	background: url('/media/alpha.png');
 	background-repeat: round;
 	 
	font-family: monospace;
	
}
#surface td{
	position: relative;
	
	transition: left 2s 500ms, transform 4s;
	top: 0px;
	left: 0px;
	
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
		
		if(count.innerText==800){
			clearInterval(tid);
			clearInterval(stid);
			start.disabled=false;	
			clear.disabled=false;
			
			Array.from(surface.rows).forEach(function(row) {
				Array.from(row.cells).forEach(function(td) {
				    td.style.left='0px';
				})
			})
			
			return;
		}
		
		let xhr=new XMLHttpRequest();
		xhr.open('GET','/ani/data')
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
				td.style.left='500px'
				td.style.transform=`rotate(\${360*10}deg)`;
			}
		}
		xhr.send();
	}, 10);
}
function clearBtn_click(e){
	console.log("clear...")

	Array.from(surface.rows).forEach(function(row) {
		Array.from(row.cells).forEach(function(td) {
			td.style.color='black'
			td.style.background='black'
		    td.style.left='0px';
		})
	})
	forCount.innerText =0;
    count.innerText =0;
    seconds.innerText=0;
}
</script>
</head>
<body>
<h1>transition/Position</h1>
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
</body>
</html>
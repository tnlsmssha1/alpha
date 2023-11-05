<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/webjars/jquery/jquery.js"></script>
<title>placeholder.jsp</title>
<style type="text/css">
h1{
	text-align: center;
}
#setimg{
	display:flex;
	justify-content: center;
	align-items: center;
	position:relative;
	margin: 30px 30px;
}
input{
	width:60px;
	text-align: center;
}

#button{
	margin: 10px 10px;
	text-align: center;
}
</style>
<script type="text/javascript">
function createClick(){
	create.disabled=true;
	clear.disabled=false;
	let color=document.querySelector('#color').value;
	let bColor=document.querySelector('#bColor').value;
	let width=document.querySelector('#width').value;
	let height=document.querySelector('#height').value;
	console.log(color+" "+bColor+" "+width+" "+height);
	
	let body=document.querySelector('body');
	let img=document.createElement('img');
	img.setAttribute('alt','xxx')
	img.setAttribute('src',`http://via.placeholder.com/\${width}X\${height}/\${color}/\${bColor}`)
	img.style.display = 'block'; 
    img.style.margin = '0 auto'; 
    img.style.textAlign = 'center';
	body.appendChild(img);
}
function clearClick(){
	create.disabled=false;
	clear.disabled=true;
	let img=document.querySelector('img').remove();
	let color=document.querySelector('#color').value='';
	let bColor=document.querySelector('#bColor').value='';
	let width=document.querySelector('#width').value='';
	let height=document.querySelector('#height').value='';
	
}
</script>
</head>
<body>
<h1>PLACE HOLDER</h1>
	<div id="setimg">
		<label for="color">bColor: </label>
		<input id="color" name="color" value="${param.color}" type="text" maxlength="6"/>
		<label for="bColor">Color: </label>
		<input id="bColor" name="bColor" value="${param.bColor}" type="text" maxlength="6"/>
		<label for="width">WIDTH:</label>
		<input id="width" name="width" type="number" min="1" max="500" value="${param.width}">
		<label for="height">HEIGHT:</label>
		<input id="height" name="height" type="number" min="1" max="500" value="${param.height}">
	</div>
<div id="button">
<button id="create" name="create" type="button" onclick="createClick()">생성</button>
<button id="clear" name="clear" type="button" onclick="clearClick()">초기화</button>
</div>	

</body>
</html>
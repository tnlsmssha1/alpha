<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cube.jsp</title>
<style type="text/css">
h1{
	text-align: center;
}
body{
	height: 1000px;
}
.perspective{
	display: inline-block;
	margin-top: 15%;
	margin-left: 40%;
	
	perspective: 500px;
}
.cube{
	display: inline-block;
	
	transform-style: preserve-3d;
  	animation: rotate 10s infinite linear; 
	
}
.perspective2{
 	display: inline-block; 
	margin: 100px 0px 0px 100px;
	
	
	perspective: 600px;
}
.cube2{
 	display: inline-block;
	position:relative;
	top: 50px;
	left: 50px;
	transform-style: preserve-3d;
   	animation: rotate 6s infinite linear;  
	
}
.base{
	width: 200px;
	height: 200px;
	font-size: 1em;
	text-align: center;
	line-height: 200px;
}
.base2{
	width: 100px;
	height: 100px;
	font-size: 1em;
	text-align: center;
	line-height: 100px;
}
.front, .back, .left, .right, .top, .bottom, .front2, .back2, .left2, .right2, .top2, .bottom2{
	position: absolute;
	top: 0px;
	left:0px;
	opacity: 0.7;
}
.front2, .back2, .left2, .right2, .top2, .bottom2{
	transform-origin: center center;
}
.front{
	transform: translateZ(100px);
	border: 2px solid red;
}

.back{
	transform: rotateY(180deg) translateZ(100px);
	border: 2px solid red;
}

.left{
	transform: rotateY(-90deg) translateZ(100px);
	border: 2px solid red;
}

.right{
	transform: rotateY(90deg) translateZ(100px);
	border: 2px solid red;
}

.top{
	transform: rotateX(90deg) translateZ(100px);
	border: 2px solid red;
}

.bottom{
	transform: rotateX(-90deg) translateZ(100px);
	border: 2px solid red;
}

.front2{
	transform: translateZ(50px);
	background: red;
}

.back2{
	transform: rotateY(180deg) translateZ(50px);
	background: blue;
}

.left2{
	transform: rotateY(-90deg) translateZ(50px);
	background: green;
}

.right2{
	transform: rotateY(90deg) translateZ(50px);
	background: purple;
}

.top2{
	transform: rotateX(90deg) translateZ(50px);
	background: yellow;
}

.bottom2{
	transform: rotateX(-90deg) translateZ(50px);
	background: gray;
}

@keyframes rotate{
	from{
		transform: rotateX(0deg) rotateY(0deg) rotateZ(0deg);
	}
	to{
		transform: rotateX(360deg) rotateY(360deg) rotateZ(360deg);
	}
}


</style>
</head>
<body>
<h1>CUBE</h1>
<section class="perspective">
	<article class="cube">
			<article class="cube2">
				<div class="base2">김현민</div>
				<div class="base2 front2"></div>
				<div class="base2 back2"></div>
				<div class="base2 left2"></div>
				<div class="base2 right2"></div>
				<div class="base2 top2"></div>
				<div class="base2 bottom2"></div>
			</article>
		<div class="base"></div>
		<div class="base front"></div>
		<div class="base back"></div>
		<div class="base left"></div>
		<div class="base right"></div>
		<div class="base top"></div>
		<div class="base bottom"></div>
	</article>
</section>
</body>
</html>
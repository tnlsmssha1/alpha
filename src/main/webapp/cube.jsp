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
	animation: rotate 7s infinite linear;
	
}
.perspective2{
	display: inline-block;
	margin: 100px 0px 0px 100px;
	
	perspective: 500px;
}
.cube2{
	display: inline-block;
	
	transform-style: preserve-3d;
 	animation: rotate 7s infinite linear;
	
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
		<div class="base"></div>
		<div class="base front"></div>
		<div class="base back"></div>
		<div class="base left"></div>
		<div class="base right"></div>
		<div class="base top"></div>
		<div class="base bottom"></div>
		<article class="cube2">
			<div class="base2">Base</div>
			<div class="base2 front2">Front</div>
			<div class="base2 back2">Back</div>
			<div class="base2 left2">Left</div>
			<div class="base2 right2">Right</div>
			<div class="base2 top2">Top</div>
			<div class="base2 bottom2">Bottom</div>
		</article>
	</article>
</section>
</body>
</html>
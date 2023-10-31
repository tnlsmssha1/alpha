<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<link rel="icon" type="image/png" href="/favicon.png">
<link rel="stylesheet" href="/css/cube.css">
<style type="text/css">
nav{
	position:fixed;
	top: 0px;
	left: 0px;
	
	width: 100%;
	height: 90px;
	background: white;
}
.menu{
	display: flex;
	list-style-type: none;
	text-align:center;
	
	align-items: flex-start;
	position: fixed;
	width: 100%;
	top: 10px;
	left: 10px;
	
	z-index: 1;
}
.menu-item{
/* 	min-width: 150px; 아래 코드와 같은 기능을 한다. */
	width: 150px;
	flex-shrink: 0;
}
.menu-item:hover > .menu-title{
	font-size: 1.4em;
	font-weight:900;
}
.menu-item:hover > .sub-menu{
	border-radius: 25px;
	background: rgb(255,188,43);
	max-height: 300px;
	
	transition: max-height 2s;
}
.menu-item:nth-last-child(2){
	margin-left: auto;
/* 	margin-right: 10px; */
}
.menu-title{
	padding: 10px;
	font-size: 15pt;
}
.menu-title>a{
	display: block;
	text-decoration: none;
	color: black;
}
.sub-menu{
	max-height: 0px;
	overflow: hidden;
	list-style: none;
	padding-left: 0px;

}
.sub-menu-item>a{
	display: block;
	text-decoration: none;
	color: black;
	padding: 10px;
	font-size: 12pt;
}

.sub-menu-item:hover > a {
	font-size: 1.4em;
	background: rgb(216,160,41);
}

iframe{
	margin-top: 100px;
}

.backColor{
	width: 100%;
	height:100px;
}

</style>
<script type="text/javascript" src="/webjars/jquery/jquery.min.js"></script>
<script type="text/javascript">
function resize(){
	let iframe=document.querySelector('iframe')
	iframe.style.height=getComputedStyle(iframe.contentDocument.documentElement).height
}

$(document).ready(function() {
	setInterval(resize, 100);
})

</script>
</head>
<body>

<nav>
<ul class="menu">
<!-- 	<li style="padding: 0px 20px;"> -->
<!-- 	<a href=""> -->
<%-- 		<section class="perspective"> --%>
<!-- 			<article class="cube"> -->
<!-- 				<div class="base">Home</div> -->
<!-- 				<div class="base front"></div> -->
<!-- 				<div class="base back"></div> -->
<!-- 				<div class="base left"></div> -->
<!-- 				<div class="base right"></div> -->
<!-- 				<div class="base top"></div> -->
<!-- 				<div class="base bottom"></div> -->
<!-- 			</article> -->
<%-- 		</section> --%>
<!-- 	</a>	 -->
<!-- 	</li> -->
	
	<li class="menu-item">
		<div class="menu-title">Alpha</div>
		<ol class="sub-menu">
			<li class="sub-menu-item"><a target="content" href="/alpha/fill">Table Maker</a></li>
			<li class="sub-menu-item"><a target="content" href="/alpha/cross">Alpha Maker</a></li>
			<li class="sub-menu-item"><a target="content" href="/alpha/race">Race</a></li>
			<li class="sub-menu-item"><a target="content" href="/alpha/zigzag">Worms</a></li>
		</ol>
	</li>
	
	<li class="menu-item">
		<div class="menu-title">Animation</div>
		<ol class="sub-menu">
			<li class="sub-menu-item"><a target="content" href="/ani/fill">CURL</a></li>
			<li class="sub-menu-item"><a target="content" href="/cube.jsp">CUBE</a></li>
			<li class="sub-menu-item"><a target="content" href="/placeholder.jsp">placeholder</a></li>
		</ol>
	</li>
	
	<li class="menu-item">
		<div class="menu-title">React</div>
		<ol class="sub-menu">
			<li class="sub-menu-item"><a target="content" href="/fill.jsp">FILL</a></li>
			<li class="sub-menu-item"><a target="content" href="/sort.jsp">SORT</a></li>
			<li class="sub-menu-item"><a target="content" href="/move.jsp">MOVE</a></li>
			<li class="sub-menu-item"><a target="content" href="/ping.jsp">PING</a></li>
			<li class="sub-menu-item"><a target="content" href="/flow.jsp">FLOW</a></li>
			<li class="sub-menu-item"><a target="content" href="/rest/dept">dept</a></li>
		</ol>
	</li>
	
	<li class="menu-item">
		<div class="menu-title">Employee</div>
		<ol class="sub-menu">
			<li class="sub-menu-item"><a target="content" href="/dept/list">dept</a></li>
			<li class="sub-menu-item"><a target="content" href="/emp/list">emp</a></li>
		</ol>
	</li>
	
	<li class="menu-item">
		<div class="menu-title">City</div>
		<ol class="sub-menu">
			<li class="sub-menu-item"><a target="content" href="/city/list">city</a></li>
			<li class="sub-menu-item"><a target="content" href="/country/list">country</a></li>
		</ol>
	</li>
	<sec:authorize access="isAnonymous()">
	<li class="menu-item">
		<div class="menu-title">
			<a href="/login">Login</a>
		</div>
	</li>
	<li class="menu-item">
		<div class="menu-title">
			<a href="/register">Register</a>
		</div>
	</li>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
	<li class="menu-item">
		<div class="menu-title">
			<a href="/logout">Logout</a>
		</div>
	</li>
	<li class="menu-item">
		<div class="menu-title">
			<a href="#"><sec:authentication property="name"/></a>
		</div>
	</li>
	</sec:authorize>
</ul>
</nav>
<iframe src="/cube.jsp"
		name="content" 
		width="100%"
		scrolling="no"
		frameborder="0"
		sendbox="allow-same-origin"
		onload="resize()">
</iframe>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
<style type="text/css">
*{
	padding: 10px;
}
#heading{
	color: red;
}
td{
	border: 1px solid red; 
}
#heading, td{
	text-decoration: overline;
}
table td{
	text-decoration: underline;	
}

tbody>tr:hover {
	background: blue;
}
</style>
<script type="text/javascript">
function setRegions(regions){
	console.log(regions);//정상입력 확인 용도
	let region=document.forms[0].region;//form에서 region이라는 select를 가져오기위함
	region.innerText='';//기존에 입력되어 있는 값을 공백으로 초기화
	let regionParam=new URL(location.href).searchParams.get('region') //url에 입력되어 있는 region의 값을 가져오기 위 
	let option=document.createElement('option'); 
	option.value='';
	option.innerText='전체';
	// continent를 선택하였을때 기본으로 전체가 표시되게 하기 위함
	
	if(regionParam==null || regionParam=='')
		option.selected=true;
	
	region.append(option)
	
	for(let r of regions){
		let option=document.createElement('option');
		option.value=r;
		option.innerText=r;
		if(r==regionParam)
			option.selected=true;
		region.append(option);
	} // continent를 선택한 경우 region의 목록을 만들어 주기 위함 
}


window.onload=function(){
	let continent=document.forms[0].continent;
	continent.onchange=function(){
		console.log(this.value);
		let xhr=new XMLHttpRequest();
		xhr.open('GET',`/country/regions?continent=\${this.value}`);
		xhr.send();
		xhr.onload=e=>{
			setRegions(JSON.parse(xhr.responseText))
		}
	}
	continent.onchange();//continent의 값이 변경되면 region목록을 새로 불러오기 위해서 사용
	
}
</script>
</head>
<body>
<h1 id="heading">1.Country List</h1>
<hr>
<form action="/country/list">
<select name="continent">
	<c:choose>
	<c:when test="${empty param.continent}">
		<option value="" selected="selected">전체</option>
	</c:when>
	<c:otherwise>
		<option value="">전체</option>
	</c:otherwise>
	</c:choose>
	<c:forEach var="continent" items="${continents}">
	<c:choose>
	<c:when test="${param.continent eq continent}">
		<option value="${continent}" selected="selected">${continent}</option>
	</c:when>
	<c:otherwise>
		<option value="${continent}">${continent}</option>
	</c:otherwise>
	</c:choose>
	</c:forEach>
</select>
<select name="region">
<!-- option은 javascript에서 ajax를 이용하여 만들었음 -->
</select>
<input type="submit" value="조회">
</form>
<hr>
<table border="1">
	<thead>
		<tr>
			<th>No</th>
			<th>code</th>
			<th>name</th>
			<th>continent</th>
			<th>region</th>
			<th>surfaceArea</th>
			<th>indepYear</th>
			<th>population</th>
			<th>lifeExpectancy</th>
			<th>gnp</th>
			<th>gnpOld</th>
			<th>localName</th>
			<th>governmentForm</th>
			<th>headOfState</th>
			<th>capital1</th>
			<th>code2</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="c" items="${list}" varStatus="status">
	<tr>
		<td>${status.count}</td>
		<td>${c.code}</td>
		<td>${c.name}</td>
		<td>${c.continent}</td>
		<td>${c.region}</td>
		<td>${c.surfaceArea}</td>
		<td>${c.indepYear}</td>
		<td>${c.population}</td>
		<td>${c.lifeExpectancy}</td>
		<td>${c.gnp}</td>
		<td>${c.gnpOld}</td>
		<td>${c.localName}</td>
		<td>${c.governmentForm}</td>
		<td>${c.headOfState}</td>
		<td>${c.capital1}</td>
		<td>${c.code2}</td>
	</tr>
	</c:forEach>
	</tbody>
</table>
</body>
</html>
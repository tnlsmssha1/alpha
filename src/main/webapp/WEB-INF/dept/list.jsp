<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
h1{
	text-align: center;
}
#search{
	text-align: center;
	margin: 15px 0px;
}
table{
	margin: auto;
}
</style>
<title>list.jsp</title>
</head>
<body>
<h1>Dept List</h1>
<form id="search" action="/dept/list">
	<input type="text" name="search">
	<input type="submit" value="부서검색">
</form>
<table border="1" width="500">
	<thead>
		<tr>
			<th>deptno</th>
			<th>dname</th>
			<th>loc</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="dept" items="${list}">
		<tr>
			<td>${dept.deptno}</td>
			<td>${dept.dname}</td>
			<td>${dept.loc}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<form id="search" action="/dept/list">
	<input type="text" name="search">
	<input type="submit" value="부서검색">
</form>
</body>
</html>
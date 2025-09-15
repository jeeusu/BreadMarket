<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">

<style>
	@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
	* { font-family: "IBM Plex Sans KR", sans-serif; }
</style>

</head>
<body>
	<div class="container py-4">
		<%@include file="AdminMenu.jsp"%>
		<div class="jumbotron">
			<div class="container">
				<h2 class="alert alert-danger">오류가 발생하였습니다.</h2>
			</div>
		</div>
		
		<div class="container">
			<p><%=request.getRequestURL() %></p>
			<p> <a href="breads.jsp" class="btn btn-secondary">메뉴&raquo;</a>
		</div>
	</div>
</body>
</html>
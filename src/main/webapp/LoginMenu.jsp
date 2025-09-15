<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>BreadMarket</title>

<style>
	@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
	* { font-family: "IBM Plex Sans KR", sans-serif; }
</style>
</head>
<%
String id=(String)session.getAttribute("userID");
%>
<body>
	
	<nav class="navbar bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="BreadList.jsp">
		    	<img src="/images/homeicon.jpg" alt="Logo" width="40" height="32" class="d-inline-block align-text-top">
		    	BreadMarket
		  	</a>
		  
			<ul class="nav justify-content-end">
				<li class="nav-item"><a class="nav-link" href="UserPage.jsp"><%=id %></a></li>
				<li class="nav-item"><a class="nav-link" href="BreadList.jsp">목록보기</a></li>
				<li class="nav-item"><a class="nav-link" href="Cart.jsp">장바구니</a></li>
				<li class="nav-item"><a class="nav-link" href="BoardList.do">게시판</a></li>
				<li class="nav-item"><a class="nav-link" href="UserLogout.jsp">로그아웃</a></li>
			</ul>
		</div>
	</nav>
</body>
</html>
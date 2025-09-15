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
<%
String id =	(String)session.getAttribute("userID");
String pwd =(String)session.getAttribute("userPW");
%>
</head>
<body>
	<div class="container py-4">
	<% if(id==null||pwd==null) { %>
		<jsp:include page="menu.jsp" />
	<%} else { 
			id =(String)session.getAttribute("userID"); %>
		<jsp:include page="LoginMenu.jsp" />
	<% } %>
		<%
			String greeting="BreadMarket에 오신 것을 환영합니다.";
			String tagline ="Welcome to Web Market!"; 
		%>
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=greeting %></h1>
				<p class="col-md-8 fs-4">BreadMarket</p>
			</div>
		</div>	
		
		<div class="row align-items-md-stretsc text-center">
			<div class="col-md-12">
				<div class="h-100 p-3">
					<a href="BreadList.jsp" class="btn btn-secondary" role="button">메뉴 보러가기&raquo;</a>
					<h3><%=tagline %></h3>
					
					<%
						Date day = new java.util.Date();
						String am_pm;
						int hour =day.getHours();
						int minute=day.getMinutes();
						int second = day.getSeconds();
						
						if(hour/12==0)
							am_pm="AM";
						else {
							am_pm="PM";
							hour=hour-12;
						}
						
						String CT=hour + ":"+minute+":"+second+" "+am_pm;
						out.println("현재 접속 시각: "+CT+"\n");
					%>
				</div>
			</div>
		</div>
	
		<%@ include file="footer.jsp" %>
	</div>
</body>
</html>


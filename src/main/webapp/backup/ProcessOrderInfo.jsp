<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>주문 완료</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: "IBM Plex Sans KR", sans-serif; }

	</style>
</head>
<%
request.setCharacterEncoding("utf-8");

String id =(String)session.getAttribute("userID");

Cookie address = new Cookie("address",URLEncoder.encode(request.getParameter("address"),"utf-8"));
Cookie deliveryinfo = new Cookie("deliveryinfo",URLEncoder.encode(request.getParameter("deliveryinfo"),"utf-8"));

address.setMaxAge(24*60*60);
deliveryinfo.setMaxAge(24*60*60);

response.addCookie(address);
response.addCookie(deliveryinfo);

response.sendRedirect("OrderInfo.jsp");
%>
<body>

</body>
</html>
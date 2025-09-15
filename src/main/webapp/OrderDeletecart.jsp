<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="dbconn.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLDecoder" %>
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
<body>
<%
request.setCharacterEncoding("utf-8");

String id =(String)session.getAttribute("userID");

String deletesql = ""+"DELETE FROM cart WHERE id=?";
PreparedStatement deleteps = conn.prepareStatement(deletesql);
deleteps.setString(1,id);

int deleterows = deleteps.executeUpdate();

if(deleterows>0) {
	System.out.print("카트 삭제 완료"); %>
	<jsp:forward page="BreadList.jsp?id<%=id %>"/>
<%
}
%>
</body>
</html>
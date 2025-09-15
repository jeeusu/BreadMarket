<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="dbconn.jsp" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>장바구니</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: "IBM Plex Sans KR", sans-serif; }

	</style>
</head>
<%
String id =	(String)session.getAttribute("userID");
String bname = request.getParameter("bname");
String value = request.getParameter("value");
int amount=0;

if(value.equals("minus")) {
	String sql = ""+"SELECT amount FROM cart WHERE bname=? AND id=? ";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setString(1,bname);
	ps.setString(2, id);
	
	ResultSet rs = ps.executeQuery();
	if(rs.next()) {
		amount=rs.getInt("amount");
		
		amount--;
		
		sql ="" +"UPDATE cart SET amount=? WHERE bname=? AND id=? ";
		ps=conn.prepareStatement(sql);
		ps.setInt(1,amount);
		ps.setString(2,bname);
		ps.setString(3, id);
		
		int rows = ps.executeUpdate();
		
		if(rows>0) %>
			<jsp:forward page="Cart.jsp">
				<jsp:param value="success" name="statement"/>
			</jsp:forward>
		<% } else { %>
			<jsp:forward page="Cart.jsp">
				<jsp:param value="failure" name="statement"/>
			</jsp:forward>
		<% }
} else if(value.equals("plus")) {
	String sql = ""+"SELECT amount FROM cart WHERE bname=? AND id=? ";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setString(1,bname);
	ps.setString(2,id);
	
	ResultSet rs = ps.executeQuery();
	if(rs.next()) {
		amount=rs.getInt("amount");
		
		amount++;
		
		sql ="" +"UPDATE cart SET amount=? WHERE bname=? AND id=? ";
		ps=conn.prepareStatement(sql);
		ps.setInt(1,amount);
		ps.setString(2,bname);
		ps.setString(3,id);
		
		int rows = ps.executeUpdate();
		
		if(rows>0) %>
			<jsp:forward page="Cart.jsp">
				<jsp:param value="success" name="statement"/>
			</jsp:forward>
		<% } else { %>
			<jsp:forward page="Cart.jsp">
				<jsp:param value="failure" name="statement"/>
			</jsp:forward>
		<% }
}
%>
<body>

</body>
</html>
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
String pwd =(String)session.getAttribute("userPW");
String bname =request.getParameter("bname");
int price=0;
int amount=1;

String sql = ""+"SELECT amount FROM cart WHERE id=? AND bname=? ";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1,id);
ps.setString(2,bname);

ResultSet rs= ps.executeQuery();

if(rs.next()) {
	amount=rs.getInt("amount");
	amount+=1;
	
	sql=""+"UPDATE cart SET amount=? WHERE id=? AND bname=? ";
	ps=conn.prepareStatement(sql);
	ps.setInt(1,amount);
	ps.setString(2,id);
	ps.setString(3,bname);
	
	int rows = ps.executeUpdate();
	
	if(rows>0) { %>
		<jsp:forward page="Bread.jsp?bname=<%=bname %>" >
			<jsp:param value="complete" name="complete" />
		</jsp:forward>
	<% } 
} else {
	amount=1;
	sql =""+"SELECT price FROM bread WHERE bname=? ";
	ps=conn.prepareStatement(sql);
	ps.setString(1,bname);
	
	rs=ps.executeQuery();
	if(rs.next()) {
		price = rs.getInt("price");
	}
	
	sql=""+"INSERT INTO cart(id, bname, price, amount) VALUES (?, ?, ?, ?) ";
	ps=conn.prepareStatement(sql);
	ps.setString(1,id);
	ps.setString(2,bname);
	ps.setInt(3,price);
	ps.setInt(4,amount);
	
	int rows = ps.executeUpdate();
	
	if(rows>0) { %>
		<jsp:forward page="Bread.jsp?bname=<%=bname %>" >
			<jsp:param value="complete" name="complete" />
		</jsp:forward>
	<% }
}

%>
<body>
</body>
</html>
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
	String price="";
%>
<body>
	<div class="container py-4">
		<jsp:include page ="LoginMenu.jsp">
			<jsp:param value="<%=id %>" name="id" />
		</jsp:include>
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">장바구니</h1>     
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item"><a href="LoginBreadList.jsp">메뉴</a></li>
			  <li class="breadcrumb-item active" aria-current="page">장바구니</li>
			</ol>
		</nav>
		
		<%
			String sql1 = ""+
						"SELECT price FROM bread WHERE bname=? ";
			PreparedStatement pstmt1 = conn.prepareStatement(sql1);
			pstmt1.setString(1,bname);
			
			ResultSet rs1 = pstmt1.executeQuery();
			if(rs1.next()) {
				price=rs1.getString("price");
				
				String sql2 = "" +
							"INSERT INTO cart VALUES (?, ?, ?) ";
				PreparedStatement pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1,id);
				pstmt2.setString(2, bname);
				pstmt2.setString(3, price);
				
				int rows = pstmt2.executeUpdate();
				if(rows>0) {
				%>
				<h1>장바구니 추가 완료</h1>
				<a href="BreadList.jsp" class="btn btn-secondary" role="button">계속 쇼핑하기&raquo;</a>
				<a href="Order.jsp" class="btn btn-secondary" role="button">주문하기&raquo;</a>
				<% } else {}
				if(pstmt2!=null)
					pstmt2.close();
			}else {}
			
			if(rs1 !=null)
				rs1.close();
			if(pstmt1!=null)
				pstmt1.close();
			if(conn!=null)
				conn.close();
		
		%>
		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>
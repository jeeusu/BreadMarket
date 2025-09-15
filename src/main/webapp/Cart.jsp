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
%>
<body>
	<div class="container py-4">
		<jsp:include page ="LoginMenu.jsp">
			<jsp:param value="<%=id %>" name="id" />
		</jsp:include>
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=id %>님의 장바구니</h1>     
	      	</div>
	    </div>
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">장바구니</li>
			</ol>
		</nav>
		
		<%
			String statement = request.getParameter("statement");
			if(statement!=null) {
				if(statement.equals("failure")) {
					out.println("<div class='alert alert-danger'>");
					out.println("수량 추가 실패");
					out.println("</div>");
				} else if(statement.equals("success")) {
					out.println("<div class='alert alert-success'>");
					out.println("수량 추가 완료");
					out.println("</div>");
				}
			}
		%>
		
		<div class="row align-items-md-stretch text-center">
			<div class="row">
				<table width="100%">
					<tr>
						<td align="left"><a href="DeleteCart.jsp?id=<%=id %>" class="btn btn-danger">전체 삭제하기</a></td>
						<td align="right"><a href="Order.jsp?id=<%=id %>" class="btn btn-success">주문하기</a></td>
					</tr>
				</table>
			</div>
			<div class="container text-center">
				<div style="padding-top:50px">
					<table class="table table-hover" style="text-align:center">
						<tr>
							<th class="text-center">제품명</th>
							<th class="text-center">가격</th>
							<th class="text-center">수량</th>
							<th class="text-center">소계</th>
							<th class="text-center">비고</th>
						</tr>
						<%
							int amount =0; //수량
							int price=0; //제품가격
							int sum=0; //소계
							int all =0; //총금액
							int delivery=0; //배달비
							
							String sql = ""+"SELECT bname, price, amount FROM cart WHERE id=? ";
							PreparedStatement ps = conn.prepareStatement(sql);
							ps.setString(1,id);
							
							ResultSet rs = ps.executeQuery();
							while(rs.next()) {
								amount=rs.getInt("amount");
								price=rs.getInt("price");
								sum=price*amount;
								all+=sum;
						%>
						<tr>
							<td><%=rs.getString("bname") %></td>
							<td><%=price %></td>
							<% if( amount >= 2) { %>
							<td><a href="Amount.jsp?bname=<%=rs.getString("bname") %>&value=minus" class="btn btn-light">-</a><%=amount %><a href="Amount.jsp?bname=<%=rs.getString("bname") %>&value=plus" class="btn btn-light">+</a></td>
							<% }else { %>
							<td><%=amount %><a href="Amount.jsp?bname=<%=rs.getString("bname") %>&value=plus" class="btn btn-light">+</a></td>
							<% } %>
							<td><%=sum %></td>
							<td><a href="DeleteCart.jsp?bname=<%=rs.getString("bname") %>" class="badge text-bg-danger">삭제</a></td>
						</tr>
						<%
							}
						 		if(all<20000)
						 			delivery=3000;
						 		else
						 			delivery=0;
					 			if (rs != null) 
					 				rs.close();
					 			if (ps != null)
					 				ps.close();
					 			if (conn != null)
					 				conn.close();
						%>
					</table>
				<div style="padding-top:10px">
					<table class="table table-hover" style="text-align:center">
						<tr>
							<td></td>
							<th>제품 가격
							<td></td>
							<th>배송비</th>
							<td></td>
						</tr>
						<tr>
							<td>총액</td>
							<td><%=all %>
							<td>+</td>
							<td><%=delivery %></td>
							<td><%=(all+delivery) %></td>
						</tr>
	 				</table>
	 			</div>
				</div>
			</div>
		</div>
		<a href="BreadList.jsp" class="btn btn-secondary">&laquo;쇼핑 계속하기</a>
		<%@ include file="footer.jsp" %>
	</div>
</body>
</html>
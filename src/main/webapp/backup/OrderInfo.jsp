<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="dbconn.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.ArrayList" %>
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
String mname="";
String phone="";
String address = "";
String deliveryinfo = "";
int price=0;
int sum=0;

Cookie[] cookies = request.getCookies();

if(cookies!=null) {
	for(int i=0;i<cookies.length;i++) {
		if(cookies[i].getName().equals("address"))
			address=cookies[i].getValue();
		else if(cookies[i].getName().equals("deliveryinfo"))
			deliveryinfo=cookies[i].getValue();
	}
}

String ordersql ="" +
				"SELECT mname, phone FROM member WHERE id=? ";
PreparedStatement orderpstmt = conn.prepareStatement(ordersql);
orderpstmt.setString(1, id);
ResultSet orderrs = orderpstmt.executeQuery();
if(orderrs.next()) {
	mname=orderrs.getString("mname");
	phone=orderrs.getString("phone");
}
System.out.print(id+""+mname+""+phone+""+address+""+deliveryinfo);
%>
<body>
	<div class="container py-4">
		<jsp:include page ="LoginMenu.jsp">
			<jsp:param value="<%=id %>" name="id" />
		</jsp:include>
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=id %>님, 주문을 완료하였습니다.</h1>     
	      	</div>
	    </div>
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item"><a href="Cart.jsp?id=<%=id%>">장바구니</a></li>
			  <li class="breadcrumb-item active" aria-current="page">주문</li>
			</ol>
		</nav>
		<div class="container text-center">
			<div class="row">
		    	<div class="col">
		    		<h3>주문자 정보</h3>
		      		<table class="table table-hover">
		      			<tr>
		      				<th class="text-center">이름</th>
		      				<th class="text-center"><%=mname %></th>
		      			</tr>
		      			<tr>
		      				<th class="text-center">전화번호</th>
		      				<th class="text-center"><%=phone %></th>
		      			</tr>
		      			<tr>
		      				<th class="text-center">배송지 주소</th>
		      				<th class="text-center"><%=address %></th>
		      			</tr>
		      			<tr>
		      				<th class="text-center">요청사항</th>
		      				<th class="text-center"><%=deliveryinfo %></th>
		      			</tr>
		      		</table>
		    	</div>
		    	<div class="col">
		    		<h3>주문 상품 정보</h3>
		    		<table class="table table-hover">
		    			<tr>
		    				<th class="text-center">상품명</th>
		    				<th class="text-center">수량</th>
		    			</tr>
		    			<%
			    			String breadsql=""+
			    					"SELECT bname, count(*), sum(price) FROM cart WHERE id=? GROUP BY bname ";
					    	PreparedStatement breadpstmt = conn.prepareStatement(breadsql);
					    	breadpstmt.setString(1, id);
					    	ResultSet breadrs = breadpstmt.executeQuery();
					    	while(breadrs.next()) {
								price=Integer.parseInt(breadrs.getString("sum(price)"));
								sum+=price;
		    			%>
		    			<tr>
		    				<th class="text-center"><%=breadrs.getString("bname") %>
		    				<th class="text-center"><%=breadrs.getString("count(*)") %></th>
		    				<th></th>
		    			</tr>
		    			<% }
					    	
					    	int delivery=0;
					    	if(sum>=20000)
					 			delivery=0;
					 		else 
					 			delivery=3000;
					 	%>
		    			<tr>
		    				<th class="text-center">총 금액</th>
		    				<th class="text-center"><%=(sum+delivery) %></th>
		    			<tr>
		    		</table>
		    	</div>
		  	</div>
		</div>
		<div class="text-center"><a href="BreadList.jsp?id=<%=id %>" class="btn btn-danger">홈으로 돌아가기</a></div>
		<%@ include file="footer.jsp" %>
		<%
			if(breadrs!=null)
				breadrs.close();
			if(breadpstmt!=null)
				breadpstmt.close();
			if(orderrs!=null)
				orderrs.close();
			if(orderpstmt!=null)
				orderpstmt.close();
			
			if(conn!=null) {
				conn.close();
			}
		%>
	</div>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>주문하기</title>
	<script type="text/javascript" src="BreadValidation.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>	
</head>
<%
String id=(String)session.getAttribute("userID");
%>
<body>
	<div class="container py-4">
		<jsp:include page ="LoginMenu.jsp">
			<jsp:param value="<%=id %>" name="id" />
		</jsp:include>
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=id %>님의 주문 정보</h1>     
	      	</div>
	    </div>
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item"><a href="Cart.jsp">장바구니</a></li>
			  <li class="breadcrumb-item active" aria-current="page">주문하기</li>
			</ol>
		</nav>
		
		<div class="row align-items-md-stretch">
			<div class="row">
				<table width="100%">
					<tr>
						<td align="left"><a href="Cart.jsp?id=<%=id %>" class="btn btn-danger">돌아가기</a></td>
						<td align="right"><a href="BreadList.jsp?id=<%=id %>" class="btn btn-success">주문 취소</a></td>
					</tr>
				</table>
			</div>
			<table class="table table-hover">
				<h3>주문 상품 정보</h3>
					<tr>
						<th class="text-center">제품명</th>
						<th class="text-center">가격</th>
						<th class="text-center">수량</th>
						<th class="text-center">소계</th>
					</tr>
					<%
						int amount =0; //수량
						int price=0; //제품가격
						int sum=0; //소계
						int all =0; //총금액
						int delivery=0; //배달비
						
						String breadsql=""+
								"SELECT bname, price, amount FROM cart WHERE id=? ";
						PreparedStatement breadpstmt = conn.prepareStatement(breadsql);
						breadpstmt.setString(1,id);
						
						ResultSet breadrs = breadpstmt.executeQuery();
						
						while(breadrs.next()) {
							price = breadrs.getInt("price");
							amount =breadrs.getInt("amount");
							sum=price*amount;
							all+=sum;
					%>
					<tr>
						<td class="text-center"><%=breadrs.getString("bname") %></td>
						<td class="text-center"><%=breadrs.getString("price") %></td>
						<td class="text-center"><%=amount %></td>
						<td class="text-center"><%=sum %></td>
					</tr>
					<%
						
			 			}
						if(all>=20000)
						 	delivery=0;
						 else 
						 	delivery=3000; %>
				</table>
				<table class="table table-hover" style="text-align:center">
					<tr>
						<td class="text-center"></td>
						<th class="text-center">상품가격</th>
						<td class="text-center"></td>
						<th class="text-center">배송비</th>
						<td class="text-center"></td>
					</tr>
					<tr>
						<td class="text-center">총액</td>
						<td class="text-center"><%=all %>
						<td class="text-center">+</td>
						<td class="text-center"><%=delivery %></td>
						<td class="text-center"><%=(all+delivery) %></td>
					</tr>
	 			</table>
	 			
				<form action="ProcessOrderInfo.jsp" name="orderInfo" method="post">
					<input type="hidden" name="id" value="<%=id %>">
					<h3>주문자 정보</h3>
					<%
						String usersql = "" +
									"SELECT mname, phone, address FROM member WHERE id=? ";
						PreparedStatement userpstmt = conn.prepareStatement(usersql);
						userpstmt.setString(1, id);
						ResultSet userrs= userpstmt.executeQuery();
	
						if(userrs.next()) {
					%>
					<div class="mb-3 row">
						<label class="col-sm-2">이름</label>
						<div class="col-sm-3"><%=userrs.getString("mname") %></div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2">번호</label>
						<div class="col-sm-3"><%=userrs.getString("phone") %></div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-2">주소</label> <!-- 쿠키로 넘기기 -->
						<div class="col-sm-3">
							<textarea name="address" id="address" cols="50" rows="2" placeholder="<%=userrs.getString("address") %>"></textarea>
						</div>
					</div>
					<% } %>
					<div class="mb-3 row">
						<label class="col-sm-2">배송 요청사항</label> <!-- 쿠키로 넘기기 -->
						<div class="col-sm-3">
							<input type="text" name="deliveryinfo" id="deliveryinfo" class="form-control">
						</div>
					</div>
					<p><input type="button" value="주문하기" onclick="CheckOrderInfo()">
				</form>
			</div>
		<%
			if(userrs!=null)
				userrs.close();
			if(userpstmt!=null)
				userpstmt.close();
			if(breadrs!=null)
				breadrs.close();
			if(breadpstmt!=null)
				breadpstmt.close();
			
			if(conn!=null)
				conn.close();
		%>
		<%@ include file="footer.jsp" %>
	</div>
</body>
</html>
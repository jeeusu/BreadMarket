<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>빵 상세 정보</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
		
		.bread {
			margin : auto;
			padding : 10px; }
			
		#information {
			margin : 20px;
		}
		
		button a{
			text-decoration: none;
			color:black; }
	</style>
</head>
<%
String bname = request.getParameter("bname");
String id =	(String)session.getAttribute("userID");
String pwd =(String)session.getAttribute("userPW");
%>
<body>
	<div class="container py-4">
		<% if(id==null||pwd==null) { %>
		<jsp:include page="menu.jsp" />
		<%} else { 
			id =(String)session.getAttribute("userID"); %>
		<jsp:include page="LoginMenu.jsp" />
		<% } %> 
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">상세 정보</h1>     
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item"><a href="BreadList.jsp">메뉴</a></li>
			  <li class="breadcrumb-item active" aria-current="page"><%=bname %></li>
			</ol>
		</nav>
	    	
		<%@ include file="dbconn.jsp" %>
		<div class="row align-items-md-strestch">
		
			<%
			 	String sql = "select bname, price, info, eatbydate, delivery, allergy, img from bread where bname=? ";
			 	PreparedStatement pstmt = conn.prepareStatement(sql);
			 	pstmt.setString(1,bname);
			 	
			 	ResultSet rs = pstmt.executeQuery();
				if (rs.next()) {		
			%>
			<div class="bread">	
				<div class="row">
					<div class="col" style="text-align:center">
				    	<img src="/images/<%=rs.getString("img") %>" width="350px"/>
				    </div>
				    
				    <div class="col align-content-center" id="information">
				     	<h1><b><%=rs.getString("bname") %></b></h1> 
						<h4><b><%=rs.getInt("price") %>원</b> </h4>
						<p><%=rs.getString("info") %> </p>
						<p><b>소비 기한 :</b> <%=rs.getString("eatbydate") %> </p>
						<p><b>배송비 :</b> <%=rs.getInt("delivery") %>원  <small>(2만원 이상 구매시 배송비 무료)</small> </p>
						<p><b>알레르기 정보 :</b> <%=rs.getString("allergy") %> </p> <% } %>
						<button type="button" class="btn btn-outline-secondary"><a href="order.jsp">주문하기</a></button>
						 <% if(id==null||pwd==null) { %>
						<button type="button" class="btn btn-outline-secondary"><a href="Login.jsp">장바구니</a></button>
						<% } else {%>
						<button type="button" class="btn btn-outline-secondary"><a href="AddCart.jsp?bname=<%=bname %>" >장바구니</a></button> <% } %>
						<button type="button" class="btn btn-outline-secondary"><a href="BreadList.jsp">목록 돌아가기</a></button>
				    </div>
				</div>
			
			 	<%
			 		if (rs != null) 
			 			rs.close();
			 		if (pstmt != null)
			 			pstmt.close();
			 		if (conn != null)
			 			conn.close();
			 	%>
		 	</div>
		 	<%@ include file="footer.jsp"%>
	 	</div>
 	</div>
</body>
</html>
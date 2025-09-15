<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Bread.Bread" %>
<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>빵 목록</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
</head>

<body>
	<div class="container py-4">
		<%@ include file ="AdminMenu.jsp" %> 
			
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
		      <div class="container-fluid py-5">
				  <h1 class="display-5 fw-bold">사용자용 메뉴</h1>     
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">사용자용 메뉴</li>
			</ol>
		</nav>
		
		<%@ include file="dbconn.jsp" %>
		 
		<div class="row align-items-md-stretch text-center">	
			<%
				Bread b = new Bread();
				String sql = "select * from bread";
		 		PreparedStatement pstmt = conn.prepareStatement(sql);
		 		ResultSet rs = pstmt.executeQuery();
		 		while (rs.next()) {
			%>
			
			<div class="col-md-4">
	        	<div class="h-100 p-2">
		        	<img src="/images/<%=rs.getString("img")%>" width="150px"/>	
		 			<h5><b><%=rs.getString("bname")%></b></h5>
		 			<p><%=rs.getInt("price")%>원
		 			<br><%=rs.getString("info")%>
		 			<p> <a href="AdminBread.jsp?id=<%=rs.getString("bname")%>" class="btn btn-secondary" role="button">상세정보&raquo;</a>
	 			</div>
	 		</div>
	 		<%
	 			}
		 		
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
</body>
</html>
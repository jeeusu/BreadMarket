<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>메뉴 삭제</title>
	
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

<body>
	<div class="container py-4">
		<%@ include file ="AdminMenu.jsp" %> 
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">메뉴 삭제</h1>     
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item"><a href="UpdateBreadList.jsp">상품관리</a></li>
			  <li class="breadcrumb-item active" aria-current="page">상품 삭제</li>
			</ol>
		</nav>
	    	
		<%@ include file="dbconn.jsp" %>
		<div class="row aligm-items-md-stresch">
		
			<%
				String id = request.getParameter("id");
			
			 	String sql = "select bname, price, info, eatbydate, delivery, allergy, img from bread where bname=? ";
			 	PreparedStatement pstmt = conn.prepareStatement(sql);
			 	pstmt.setString(1,id);
			 	
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
						<p><b>알레르기 정보 :</b> <%=rs.getString("allergy") %> </p>
						<a href="DeleteBreadProcess.jsp?id=<%=rs.getString("bname")%>" class="btn btn-secondary" role="button">삭제하기&raquo;</a>
						<a href="UpdateBreadList.jsp" class="btn btn-secondary" role="button">돌아가기&raquo;</a>
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
 	</div>
</body>
</html>
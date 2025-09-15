<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>회원가입</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
	
</head>

<body>
	<div class="container py-4">
		<%@ include file ="menu.jsp" %> 
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">회원가입</h1>     
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">회원가입</li>
			</ol>
		</nav>
	    
	    <div class="row align-items-md-stretch">
	    
	    <%@ include file="dbconn.jsp" %>
	    
	    <%
	    	request.setCharacterEncoding("utf-8");
	    	
			String id=request.getParameter("id");
	    	String pwd=request.getParameter("pwd");
	    	String mname=request.getParameter("mname");
	    	String birth=request.getParameter("birth");
	    	String phone=request.getParameter("phone");
	    	String address=request.getParameter("address");
	    	String email=request.getParameter("email");
	    			
	
			System.out.print(id +","+pwd+","+mname+","+birth+","+phone+","+address+","+email);
			
			String sql1 = "SELECT mname FROM member WHERE mname=? ";
			PreparedStatement pstmt1 = conn.prepareStatement(sql1);
		 	pstmt1.setString(1,mname);
		 	
		 	ResultSet rs = pstmt1.executeQuery();
		 	
		 	if(rs.next()) {
		 		%>
				<h1>이미 존재하는 회원입니다.</h1>
		 	<%}else {
	
	    	String sql2 = "INSERT INTO member VALUES (?,?,?,?,?,?,?) ";
	    	
	    	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		 	pstmt2.setString(1,id);
		 	pstmt2.setString(2,pwd);
		 	pstmt2.setString(3,mname);
		 	pstmt2.setString(4,birth);
		 	pstmt2.setString(5,phone);
		 	pstmt2.setString(6,address);
		 	pstmt2.setString(7,email);
		 	
	 		int rows = pstmt2.executeUpdate();
		 	
		 	if(rows>0) {
		 		
	    %>
	    <h1>회원가입이 완료되었습니다!</h1>
	    <a href="Login.jsp" class="btn btn-secondary" role="button" width="50px">로그인하기&raquo;</a>
	    <%} else { %>
	    <h1>회원가입에 실패했습니다...</h1>
	    <% }
		 	
		 	if (pstmt2 != null)
		 		pstmt2.close();
		 	if(pstmt1 != null)
		 		pstmt1.close();
		 	if (conn != null)
		 		conn.close();  }%>
	 	
	 	<%@ include file="footer.jsp" %>
	 	 </div>
	 </div>
</body>
</html>
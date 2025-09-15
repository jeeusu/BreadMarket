<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="dbconn.jsp" %>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>로그인</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
	
</head>

<body>
	<div class="container py-4">
		<%@ include file="menu.jsp" %>
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">로그인</h1>     
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">로그인</li>
			</ol>
		</nav>
		
	    <div class="row align-items-md-stretch text-center">
	    
	    <%	
		    request.setCharacterEncoding("utf-8");
	
			String id=request.getParameter("id");
			String pwd=request.getParameter("pwd");
			
			System.out.print(id +","+pwd);
			
			String sql = "SELECT id, pwd FROM member WHERE id=? AND pwd=? ";
			PreparedStatement pstmt = conn.prepareStatement(sql);
		 	pstmt.setString(1,id);
		 	pstmt.setString(2,pwd);
		 	
		 	ResultSet rs = pstmt.executeQuery();
		 	
		 	if(rs.next()) {
		 		id=rs.getString("id");
		 		pwd=rs.getString("pwd");
		 		
		 		session.setAttribute("userID",id);
		 		session.setAttribute("userPW",pwd);
		 		
		 		System.out.println(id+"사용자 로그인 성공");
		 	} else {
		 		System.out.println("사용자 로그인 실패");
		 		%>
		 		<jsp:forward page="Login.jsp" >
		 			<jsp:param name="loginfailed" value="loginfailed" ></jsp:param>
		 		</jsp:forward> <%
		 	}

		 	if(rs != null)
		 		rs.close();
		 	if(pstmt!= null)
		 		pstmt.close();
		 	if (conn != null)
		 		conn.close(); 
		 	
		 	String ckeckid=	(String)session.getAttribute("userID");
		 	String checkpwd=(String)session.getAttribute("userPW");
		 	
		 	if(ckeckid.equals(id)&&checkpwd.equals(pwd)) {
		 	%><jsp:forward page="BreadList.jsp"/> <%
		 	} else {
		 	%>
		 	<jsp:forward page="Login.jsp" >
		 		<jsp:param name="loginfailed" value="loginfailed" ></jsp:param>
		 	</jsp:forward>
		 	<% }  %>
		 		
		 </div>
		 <%@ include file="footer.jsp" %>
		 
	</div>

</body>
</html>
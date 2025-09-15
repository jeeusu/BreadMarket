<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>메뉴 삭제</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
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
		
	    <div class="row align-items-md-stretch">
	    <%@ include file="dbconn.jsp" %>
		
		    
		    <%
		    	request.setCharacterEncoding("utf-8");
				String bname = request.getParameter("id");
			
			 	String sql = "DELETE FROM bread WHERE bname=? ";
			 	PreparedStatement pstmt = conn.prepareStatement(sql);
			 	pstmt.setString(1,bname);
			 	
			 	int rows = pstmt.executeUpdate();
	
			 	if(rows>0) {
			 	%> <h1>메뉴 삭제를 완료하였습니다.</h1>
		    <% } else { %>
		    <h1>메뉴 삭제에 실패하였습니다...</h1>
		    <%}
			
			 	if(pstmt !=null )
			 		pstmt.close();
			 	if (conn != null)
			 		conn.close();
			 %>
			 
		 	<%@ include file="footer.jsp" %>
	 	</div>
	 </div>
</body>
</html>
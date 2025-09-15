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
	String bname=request.getParameter("bname");
	String user_id=request.getParameter("id");
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
			  <li class="breadcrumb-item"><a href="LoginBreadList.jsp">메뉴</a></li>
			  <li class="breadcrumb-item active" aria-current="page">장바구니</li>
			</ol>
		</nav>
	    
	    <%
	    	if(bname!=null&&user_id==null) {
	    		String sql="" +
	    				"DELETE FROM cart WHERE id=? AND bname=? ";
	    		PreparedStatement pstmt = conn.prepareStatement(sql);
	    		pstmt.setString(1,id);
	    		pstmt.setString(2,bname);
	    		
	    		int rows = pstmt.executeUpdate();
	    		if(rows>0) {%>
	    			<jsp:forward page="Cart.jsp?id=<%=id %>" /> <%
	    		}else { %>
		    		<jsp:forward page="Cart.jsp">
		    			<jsp:param name="error" value="error" ></jsp:param>
		    		</jsp:forward> <%
	    		} 
	    	}else if(bname==null&&user_id.equals(id)) {
	    		String sql=""+
	    				"DELETE FROM cart WHERE id=? ";
	    		PreparedStatement pstmt = conn.prepareStatement(sql);
	    		pstmt.setString(1,id);
	    		
	    		int rows = pstmt.executeUpdate();
	    		
	    		if(rows>0) { %>
	    			<jsp:forward page="Cart.jsp?id=<%=id %>" /> <%
	    		}else { %>
		    		<jsp:forward page="Cart.jsp">
		    			<jsp:param name="error" value="error"></jsp:param>
		    		</jsp:forward> <%
	    		} 
	    	} %>
		<%@ include file="footer.jsp" %>
	</div>
</body>
</html>
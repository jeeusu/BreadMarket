<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>회원 정보 수정</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
		
		.userinfo {
			border-radius:30px;
			box-sizing:border-box;
			margin:0 auto;
			width:100%;
			padding:20px;
			background:#f6f8f8;
		}
	</style>
	
</head>
<%
request.setCharacterEncoding("utf-8");
String id =(String)session.getAttribute("userID");
%>
<body>
	<div class="container py-4">
		<jsp:include page="LoginMenu.jsp">
			<jsp:param value="<%=id %>" name="id"/>
		</jsp:include>
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=id %>님의 마이페이지</h1>     
	      	</div>
	    </div>
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">마이페이지</li>
			</ol>
		</nav>
		<%
			String phone=request.getParameter("phone");
			String address=request.getParameter("address");
			String email=request.getParameter("email");
	
			if(phone!= null&&address==null&&email==null) {
				String sql =""+"UPDATE member SET phone=? WHERE id=? ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,phone);
				ps.setString(2,id);
				
				int rows=ps.executeUpdate();
				
				if(rows>0) { %>
				<jsp:forward page="UserPage.jsp">
					<jsp:param value="complete" name="complete" />
				</jsp:forward>
				<%
				}
				if(ps!=null)
					ps.close();
				
			}else if(phone== null&&address!=null&&email==null) {
				String sql =""+"UPDATE member SET address=? WHERE id=? ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,address);
				ps.setString(2,id);
				
				int rows=ps.executeUpdate();
				
				if(rows>0){
				%>
					<jsp:forward page="UserPage.jsp">
						<jsp:param value="complete" name="complete" />
					</jsp:forward>
				<%
				}
				if(ps!=null)
					ps.close();
			}else if(phone==null&&address==null&&email!=null) {
				String sql =""+"UPDATE member SET email=? WHERE id=? ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,email);
				ps.setString(2,id);
				
				int rows=ps.executeUpdate();
				
				if(rows>0){
				%>
				<jsp:forward page="UserPage.jsp">
					<jsp:param value="complete" name="complete" />
				</jsp:forward>
				<%
				}
				if(ps!=null)
					ps.close();
			}
		%>
		
	</div>
</body>
</html>
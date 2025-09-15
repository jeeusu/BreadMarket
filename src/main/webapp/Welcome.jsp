<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.Date" %>
<%@ include file="dbconn.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Bread Market</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>

<style>
	@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
	* { font-family: "IBM Plex Sans KR", sans-serif; }
</style>
<%
String id =	(String)session.getAttribute("userID");
String pwd =(String)session.getAttribute("userPW");
%>
</head>
<body>
	<div class="container py-4">
	<% if(id==null||pwd==null) { %>
		<jsp:include page="menu.jsp" />
	<%} else { 
			id =(String)session.getAttribute("userID"); %>
		<jsp:include page="LoginMenu.jsp" />
	<% } %>

		<div id="carouselExample" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
			<div class="carousel-inner">
				<div class="carousel-item active"><img src="img/breads.jpg" class="d-block w-100" alt="메인이미지1"></div>
				<div class="carousel-item"><img src="img/delivery.jpg" class="d-block w-100" alt="배송비"></div>
			</div>

			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
				<button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
  
		<div class="row align-items-md-stretsc text-center">
			<div class="col-md-12">
				<div class="h-100 p-3">
				<h2 style="margin:40px">인기메뉴</h2>
					<div class="row row-cols-4">
					
						<%
							String sql = ""+"SELECT bname, img, price FROM bread ORDER BY amount ASC LIMIT 4 ";
							PreparedStatement ps = conn.prepareStatement(sql);
							ResultSet rs = ps.executeQuery();
							while (rs.next()) {
						%>
						<div class="col">
				        	<div class="p-2">
					        	<a href="Bread.jsp?bname=<%=rs.getString("bname")%>"><img src="/images/<%=rs.getString("img")%>" width="150px"/>	</a>
					 			<h5><b><%=rs.getString("bname")%></b></h5>
					 			<p><%=rs.getString("price") %>원
				 			</div>
		 				</div>
		 				<% }
							if(rs!=null)
								rs.close();
							if(ps!=null)
								ps.close();
							if(conn!=null)
								conn.close();
						%>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="footer.jsp" %>
	</div>
</body>
</html>


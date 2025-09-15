<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="dbconn.jsp" %>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<script type="text/javascript" src="BreadValidation.js"></script>
	
	<title>메뉴 수정</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
	
</head>

<body>
	<div class="container py-4">
		
		<%@ include file ="AdminMenu.jsp" %> 
		
		<%
			String id = request.getParameter("id");
		
		 	String sql = "select bname, price, info, eatbydate, delivery, allergy, img from bread where bname=? ";
		 	PreparedStatement pstmt = conn.prepareStatement(sql);
		 	pstmt.setString(1,id);
		 	
		 	ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {		
		%>
	
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">상품관리</h1>    
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item"><a href="UpdateBreadList.jsp">상품관리</a></li>
			  <li class="breadcrumb-item active" aria-current="page"><%=id %> 수정</li>
			</ol>
		</nav>
	    
	    <div class="row align-items-md-stretch">
		    
			<form action="UpdateBreadProcess.jsp" name="breadinfo" method="post" enctype="multipart/form-data">
			<div class="mb-3 row">
				<label class="col-sm-2">메뉴 이름 :</label>
				<div class="col-sm-3">
					<input type="text" name="bname" id="bname" value="<%=rs.getString("bname") %>">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">가격 :</label>
				<div class="col-sm-3">
					<input type="text" name="price" id="price" value="<%=rs.getString("price") %>">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">상세 정보 :</label>
				<div class="col-sm-3">
					<textarea name="info" id="info" cols="50" rows="5" ><%=rs.getString("info") %></textarea>
				</div>
			</div>
			
			<div class="mb-3 row">
				<label class="col-sm-2">소비 기한 :</label>
				<div class="col-sm-3">
					<input type="text" name="eatbydate" value="<%=rs.getString("eatbydate") %>">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">배송비 :</label>
				<div class="col-sm-3">
					<input type="text" name="delivery" value="<%=rs.getString("delivery") %>">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">알레르기 정보 :</label>
				<div class="col-sm-3">
					<input type="text" name="allergy" value="<%=rs.getString("allergy") %>">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">이미지 :</label>
				<div class="col-sm-3">
					<input type="file" name="img" >
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-offset-2 col-sm-10">
					<input type="button" value="메뉴 수정" onclick="CheckUpdateBread()">
				</label>
			</div>
	
			</form>
		</div>	
		<%@ include file="footer.jsp" %>
		<%}
			if (rs != null) 
	 			rs.close();
	 		if (pstmt != null)
	 			pstmt.close();
	 		if (conn != null)
	 			conn.close(); %>
	</div>
</body>
</html>
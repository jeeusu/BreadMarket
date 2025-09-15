<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>관리자 로그인</title>
	<script type="text/javascript" src="validation.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
	
</head>
<body>
	<div class="container py-4">
		<%@include file="menu.jsp" %>
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">관리자 로그인</h1>
			</div>
		</div>
		
		<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">관리자 로그인</li>
			</ol>
		</nav>
		
		<div class="row align-items-md-stretch text-center">
			<div class="row justify-content-center align-items-center">
				<div class="h-199 p-5 col-md-6">
					<h3>Please sign in</h3>
					
					<%
						String error=request.getParameter("error");
						if(error!=null) {
							out.println("<div class='alert alert-danger'>");
							out.println("아이디와 비밀번호를 확인해 주세요");
							out.println("</div>");
						}
					%>
					
					<form class="form-sign" action="j_security_check" method="post">
						<div class="form-floating mb-3 row">
							<input type="text" class="form-control" name="j_username" required autofocus>
							<label for="floatingInput">ID</label>
						</div>
						<div class="form-floating mb-3 row">
							<input type="password" class="form-control" name="j_password" required autofocus>
							<label for="floatingInput">Password</label>
						</div>
						<button class="btn btn-lg btn-success" type="submit">로그인</button>
					</form>
				</div>
			</div>
		</div>
		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>
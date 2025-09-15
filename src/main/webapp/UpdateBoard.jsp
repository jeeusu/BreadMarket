<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ page import="Board.Board" %>
<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>게시판</title>
	<script>
	function CheckBoard() {
		var form=document.write;
		var title=form.title.value;
		var bcontent=form.bcontent.value;
		
		if(title=="") {
			alert("제목을 입력해주세요");
			form.title.select();
			return;
		}
		
		if(bcontent=="") {
			alert("내용을 입력해주세요");
			form.bcontent.select();
			return;
		}
		
		form.submit();
	}

	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
	
</head>
<%
request.setCharacterEncoding("utf-8");
String id =(String)session.getAttribute("userID");
String num = request.getParameter("num");
%>
<body>
	<div class="container py-4">
		<jsp:include page="LoginMenu.jsp">
			<jsp:param value="<%=id %>" name="id"/>
		</jsp:include>
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">게시판</h1>     
	      	</div>
	    </div>
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">게시판</li>
			</ol>
		</nav>
		
		<form action="UpdateBoardProcess.do?num=<%=num %>" method="post" name="write">
			<div class="mb-3 row">
				<label class="col-sm-2">아이디: <%=id %></label>
			</div>
			<div class="mb-3 row">
				<div class="col-sm-3">
					<label class="col-sm-2">제목:</label>
					<input type="text" name="title" id="title">
				</div>
			</div>
			<div class="mb-3 row">
				<div class="col-sm-3">
					<label class="col-sm-2">내용:</label>
					<textarea name="bcontent" id="bcontent" cols="50" rows="2" placeholder="내용을 입력해 주세요"></textarea>
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-offset-2 col-sm-10">
					<input type="button" value="수정하기" onclick="CheckBoard()" class="btn btn-success">
				</label>
			</div>
		</form>
		<%@ include file="footer.jsp" %>
	</div>
</body>
</html>
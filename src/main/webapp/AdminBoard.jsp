<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ page import="Board.Board" %>
<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>관리자 게시판</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
	
</head>
<%
request.setCharacterEncoding("utf-8");
String id =(String)session.getAttribute("userID");

Board board = (Board)request.getAttribute("board");
String num = String.valueOf(board.getNum());
String bid = board.getId();
String title = board.getTitle();
String bcontent =board.getBcontent();
String regist = board.getRegist();
String hit = String.valueOf(board.getHit());
%>
<body>
	<div class="container py-4">
		<jsp:include page="AdminMenu.jsp" />
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">관리자 게시판</h1>     
	      	</div>
	    </div>
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">관리자 게시판</li>
			</ol>
		</nav>
		
		<div class="row">
				<table width="100%">
					<tr>
						<td align="right"><a href="AdminDeleteBoard.do?num=<%=num %>" class="btn btn-danger">삭제하기</a></td>
					</tr>
				</table>
				<div style="padding:10px"></div>
		</div>
		<div class="mb-3 row">
			<div class="col-sm-3"><h3><%=title %></h3></div>
		</div>
		<hr>
		<div class="mb-3 row">
			<div class="row">
			   	<div class="col">작성자 | <%=bid %></div>
			    <div class="col">작성일 | <%=regist %></div>
			</div>
		</div>
		<hr>
		<div class="mb-3 row">
			<div class="col-sm-3">조회수 | <%=hit %></div>
		</div>
		<hr>
		<div class="mb-3 row">
			<div class="col-sm-3"><%=bcontent %></div>
		</div>
		<hr>
		
		<div class="row align-items-md-stretsc text-center">
			<div class="col-md-12">
				<div class="h-100 p-3">
					<a href="BoardList.do" class="btn btn-secondary" role="button">목록 돌아가기&raquo;</a>
				</div>
			</div>
		</div>
		<%@ include file="footer.jsp" %>
	</div>

</body>
</html>
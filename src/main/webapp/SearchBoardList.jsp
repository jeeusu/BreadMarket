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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		function CheckSearch() {
			var form=document.searchboard;
			var search = form.search.value;
			
			if(search=="") {
				alert("검색어를 입력해주세요");
				form.search.select();
				return;
			}
			
			form.submit();
		}
		
	</script>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
		
		.nondeco {
			text-decoration: none;
			color:black; }
	</style>
	
</head>
<%
request.setCharacterEncoding("utf-8");
String id =(String)session.getAttribute("userID");

ArrayList<Board> board = (ArrayList<Board>)request.getAttribute("board");
String search = request.getParameter("search");

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
			
		<div class="row align-items-md-stretch text-center">
			<div class="row">
				<table width="100%">
					<tr>
						<td align="right"><a href="WriteBoard.jsp?id=<%=id %>" class="btn btn-light">글 쓰기</a></td>
					</tr>
				</table>
			</div>
			<div class="container text-center">
				<div style="padding-top:20px">
					<table class="table table-hover" style="text-align:center">
						<tr>
							<th>번호</th>
							<th width="400px">제목</th>
							<th>작성자</th>
							<th>등록일</th>
						</tr>
						<%	
							int num=board.size()-1;
							for(int i=num;i>=0;i--) {
						%>
						<tr>
							<td><%=board.get(i).getNum() %></td>
							<td><a href="ShowBoard.do?num=<%=board.get(i).getNum() %>" class="text-decoration-none"><%=board.get(i).getTitle() %></a></td>
							<td><%=board.get(i).getId() %></td>
							<td><%=board.get(i).getRegist() %></td>
						</tr>
						<% } %>
					</table>
				</div>
			</div>
		</div>
		<form action="SearchBoard.do" method="post" name="searchboard" >
			<input type="text" name="search" id="search" placeholder="검색어를 입력하세요">
			<input type="button" value="검색" onclick="CheckSearch()">
		</form>
		<%@ include file="footer.jsp" %>			
	</div>
</body>
</html>
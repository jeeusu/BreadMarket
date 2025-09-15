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
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

int total_record = ((Integer) request.getAttribute("total_record")).intValue();
int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
int total_page = ((Integer) request.getAttribute("total_page")).intValue();

int start = 0;

if(pageNum==1)
	start = 1;
else 
	start = (pageNum-1)*11;	

ArrayList<Board> board = (ArrayList<Board>)request.getAttribute("board");
ArrayList<Board> searchboard = (ArrayList<Board>)request.getAttribute("searchboard");
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
						<td align="right"><a href="WriteBoard.jsp?id=<%=id %>" class="btn btn-primary">글 쓰기</a></td>
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
							<th>조회수</th>
							<th>등록일</th>
						</tr>
						<%
						
						if(search==null) {
							for(int i=0;i<board.size();i++) {
						%>
						<tr>
							<td><%=(start+i) %></td>
							<td><a href="ShowBoard.do?num=<%=board.get(i).getNum() %>" class="text-decoration-none"><%=board.get(i).getTitle() %></a></td>
							<td><%=board.get(i).getId() %></td>
							<td><%=board.get(i).getHit() %></td>
							<td><%=board.get(i).getRegist() %></td>
						</tr>
						<% }
						} else {
							for(int i=0;i<searchboard.size();i++) {
						%>
						<tr>
							<td><%=(start+i) %></td>
							<td><a href="ShowBoard.do?num=<%=searchboard.get(i).getNum() %>" class="text-decoration-none"><%=searchboard.get(i).getTitle() %></a></td>
							<td><%=searchboard.get(i).getId() %></td>
							<td><%=searchboard.get(i).getHit() %></td>
							<td><%=searchboard.get(i).getRegist() %></td>
						</tr>
						<% } }%>
					</table>
				</div>
			</div>
		</div>
		<% if(search!=null) { %>
		<div class="row">
			<table width="100%">
				<tr>
					<td align="right"><a href="BoardList.do" class="btn btn-primary">목록으로 돌아가기</a></td>
				</tr>
			</table>
		</div>
		<% } %>
		<div align="center">
			<c:set var="pageNum" value="<%=pageNum %>" />
			<c:forEach var="i" begin="1" end="<%=total_page%>">
				<a href="<c:url value="./BoardList.do?pageNum=${i}" /> ">
					<c:choose>
						<c:when test="${pageNum==i}">
							<font color='4C5317'><b> [${i}]</b></font>
						</c:when>
						<c:otherwise>
							<font color='4C5317'> [${i}]</font>

						</c:otherwise>
					</c:choose>
				</a>
			</c:forEach>
		</div>
		<div align="left">
			<form action ="SearchBoard.do" method="post">
				<select name="items" class="txt">
					<option value="subject">제목에서</option>
					<option value="content">본문에서</option>
					<option value="name">글쓴이에서</option>
				</select>
				<input type="text" name="search" id="search" placeholder="검색어를 입력하세요" />
				<input type="submit" id="search" name="search" class="btn btn-primary " value="검색 "/>
			</form>			
		</div>
		
		<%@ include file="footer.jsp" %>			
	</div>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>마이페이지</title>
	<script type="text/javascript" src="BreadValidation.js"></script>
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
		
		#order {
			vertical-align:middle;
			word-break: break-all;
		}
	</style>
	
</head>
<%
request.setCharacterEncoding("utf-8");
String id =(String)session.getAttribute("userID");
String str = "";
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
			String sql = "" +"SELECT mname, birth, phone, address, email FROM member WHERE id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
		%>

		<div class="userinfo">
			<%
				String complete = request.getParameter("complete");
				if(complete!=null) {
					if(complete.equals("complete")) {
						out.println("<div class='alert alert-success' style='text-align:center'>");
						out.println("<h3><b>회원 정보 수정 완료</b></h3>");
						out.println("</div>");
					}
				}
			%>
			<h4><b>회원 정보</b></h4>
			<hr>
			<div class="mb-3 row">
				<div class="col-sm-3"><%=rs.getString("mname") %></div>
			</div>
			<hr>
			<div class="mb-3 row">
				<div class="col-sm-3"><%=rs.getString("birth") %></div>
			</div>
			<hr>
			<form action="UpdateInfoProcess.jsp" method="post" style="overflow:hidden" name="phone">
				<input type="text" name="phone" id="phone" placeholder="<%=rs.getString("phone") %>">
				<input type="button" value="수정" onclick="CheckPhone()" style="float:right">
			</form>
			<hr>
			<form action="UpdateInfoProcess.jsp" method="post" style="overflow:hidden" name="address">
				<input type="text" name="address" id="address" placeholder="<%=rs.getString("address") %>">
				<input type="button" value="수정" onclick="CheckAddress()" style="float:right">
			</form>
			<hr>
			<form action="UpdateInfoProcess.jsp" method="post" style="overflow:hidden" name="email" >
				<input type="text" name="email" id="email" placeholder="<%=rs.getString("email") %>">
				<input type="button" value="수정" onclick="CheckEmail()" style="float:right">
			</form>	<% } %>
		</div>
		<div style="margin:20px"></div>
		
		<div class="userinfo">
			<h4><b>주문 내역</b></h4>
			<table class="table table-hover">
				<tr style="text-align:center">
					<th width="150px">주문 번호</th>
					<th>주문 내역</th>
					<th>금액</th>
					<th>배송지</th>
				</tr>
				<%
					String historysql=""+"SELECT content, price, oaddress, ordernum FROM orderhistory WHERE id=? ";
					PreparedStatement historyps = conn.prepareStatement(historysql);
					historyps.setString(1,id);
					
					ResultSet historyrs=historyps.executeQuery();
					while (historyrs.next()) {
						str=historyrs.getString("content");
						String arr[] = str.split(",");
				%>
				<tr height="50px" id="order" class="text-center">
					<td><%=historyrs.getString("ordernum") %></td>
					<td>
					<% for (int i=0;i<arr.length;i++) {
						if(i%2==0) {
					%><%=arr[i] %>
					<% }else if(i%2==1) {
					%><%=arr[i] %>개<br>
					<%} }%>
					</td>
					<td><%=historyrs.getString("price") %></td>
					<td><%=historyrs.getString("oaddress") %></td>
				</tr>
				<%} %>
			</table>
		</div>
		<div style="margin:20px"></div>
		<div class="row">
				<table width="100%">
					<tr>
						<td class="text-center"><a href="DeleteUser.jsp?id=<%=id %>" class="btn btn-danger" role="button">회원 탈퇴&raquo;</a></td>
					</tr>
				</table>
			</div>
		<%@ include file="footer.jsp" %>
	</div>
	<%
			
		if(rs!=null)
			rs.close();
		if(ps!=null)
			ps.close();
		
		if(historyrs!=null)
			historyrs.close();
		if(historyps!=null)
			historyps.close();
		
		if(conn!=null)
			conn.close();
	%>
</body>
</html>
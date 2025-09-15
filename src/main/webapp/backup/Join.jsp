<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>메뉴 등록</title>
	<script type="text/javascript" src="validation.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
	
</head>

<script>
	function idCheck() {
		var _id=$("#id").val();

		$.ajax({
			type:"post",
			async:true,
			url:"http://localhost:8090/Bread/MemberServlet",
			dataType:"text",
			data:{id:_id},
			success:function(data,textStatus) {
				if(data=="usable"){
					$("#message").text("사용할 수 있는 ID입니다.");
					$("#btnDuplecate").prop("disabled",true);
				}else {$("#message").text("사용할 수 없는 ID입니다."); } },
				error:function(data,textStatus) { alert("에러가 발생했습니다."); },
			complete:function(data, textStatus) {}
		});
	}
</script>

<body>
	<div class="container py-4">
		<fmt:setLocale value='<%=request.getParameter("language") %>' />
		<fmt:bundle basename="bundle.myBundle">
		<%@ include file ="menu.jsp" %>
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><fmt:message key="title_join"/></h1>   
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">회원가입</li>
			</ol>
		</nav>
	    
	    <div class="row align-items-md-stretch">
		    <div class="text-end">
		    	<a href="?language=ko">Korean</a>|<a href="?language=en">English</a>
		    </div>
		    	
			<form action="JoinProcess.jsp" name="join" method="post">
				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="id"/> :</label>
					<div class="col-sm-3">
						<input type="text" name="id" id="id">
						<input type="button" id="btnDuplecate" value="<fmt:message key="detail_id"/>" onclick="idCheck()">
						<div id="message"></div>
					</div>
				</div>

				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="pwd"/> :</label>
					<div class="col-sm-3">
						<input type="password" name="pwd" id="pwd">
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="mname"/> :</label>
					<div class="col-sm-3">
						<input type="text" name="mname">	
					</div>
				</div>
				
				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="email"/> :</label>
					<div class="col-sm-3">
						<input type="text" name="email" id="email">
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="phone"/> :</label>
					<div class="col-sm-3">
						<input type="text" name="phone" id="phone" maxlength="11">
						<p><small><fmt:message key="detail_phone"/></small></p>
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="birth"/> :</label>
					<div class="col-sm-3">
						<input type="text" name="birth" id="birth" maxlength="8">
						<p><small>(yyyymmdd)</small></p>
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-2"><fmt:message key="address"/> :</label>
					<div class="col-sm-3">
						<input type="text" name="address">
					</div>
				</div>
				<div class="mb-3 row">
					<label class="col-sm-offset-2 col-sm-10">
						<input type="button" value="<fmt:message key="button2"/>" onclick="CheckAddMember()">
					</label>
				</div>
			</form>
			
		</div>
	
		<%@ include file="footer.jsp" %>
		</fmt:bundle>
	</div>
</body>
</html>
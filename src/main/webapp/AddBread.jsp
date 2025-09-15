<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<script type="text/javascript" src="BreadValidation.js"></script>
	
	<title>메뉴 등록</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
</head>

<body>
	<div class="container py-4">
		<fmt:setLocale value='<%=request.getParameter("language") %>' />
		<fmt:bundle basename="bundle.myBundle">
		
		<%@ include file ="AdminMenu.jsp" %> 
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><fmt:message key="title_list"/></h1>    
	      	</div>
	    </div>
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">메뉴 등록</li>
			</ol>
		</nav>
	    
	    <div class="row align-items-md-stretch">
		    <div class="text-end">
		    	<a href="?language=ko">Korean</a>|<a href="?language=en">English</a>
		    	<a href="Logout.jsp" class="btn btn-sm btn-success pull right">Logout</a>
		    </div>
		    
			<form action="AddBreadProcess.jsp" name="breadinfo" method="post" enctype="multipart/form-data">
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="bname"/> :</label>
				<div class="col-sm-3">
					<input type="text" name="bname" id="bname">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="price"/> :</label>
				<div class="col-sm-3">
					<input type="text" name="price" id="price">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="info"/> :</label>
				<div class="col-sm-3">
					<textarea name="info" id="info" cols="50" rows="5" placeholder="<fmt:message key="placeholder"/>"> </textarea>
				</div>
			</div>
			
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="eatbydate"/> :</label>
				<div class="col-sm-3">
					<input type="text" name="eatbydate">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="delivery"/> :</label>
				<div class="col-sm-3">
					<input type="text" name="delivery">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="allergy"/> :</label>
				<div class="col-sm-3">
					<input type="text" name="allergy">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2"><fmt:message key="img"/> :</label>
				<div class="col-sm-3">
					<input type="file" name="img">
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-offset-2 col-sm-10">
					<input type="button" value="<fmt:message  key="button"/>" onclick="CheckAddBread()">
				</label>
			</div>
	
			</form>
		</div>	
		
		</fmt:bundle>
		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>
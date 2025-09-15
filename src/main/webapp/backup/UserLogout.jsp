<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<% 
	session.invalidate();
	
	if(request.isRequestedSessionIdValid()==true)
		System.out.print("세션 유효, 로그아웃 실패");
	else
		System.out.print("세션 유효하지 않음, 로그아웃 성공");
%>
<body>
	<jsp:forward page="BreadList.jsp" />
</body>
</html>
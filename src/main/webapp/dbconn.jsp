<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%> 
<%@ page import="javax.naming.*"%> 
<%@ page import="java.sql.*"%> 
<%
	Connection conn = null;	

	try {
		 Context ctx = new InitialContext();
		 DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/bread");
		 conn = ds.getConnection();

		
	} catch (SQLException ex) {
		out.println("데이터베이스 연결이 실패되었습니다.<br>");
		out.println("SQLException: " + ex.getMessage());
	}
		
%>
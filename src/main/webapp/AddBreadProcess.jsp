<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<html>
<head lang="ko">
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>메뉴 등록</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: font-family: "IBM Plex Sans KR", sans-serif; }
	</style>
	
</head>

<body>
	<div class="container py-4">
		<%@ include file ="AdminMenu.jsp" %> 
		
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">메뉴 등록</h1>      
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">메뉴 등록</li>
			</ol>
		</nav>
	    
	    <%@ include file="dbconn.jsp" %>
	    
	    <%
	    	String path = "C:/breadmarket";
	    
	    	DiskFileUpload upload = new DiskFileUpload();
			
			upload.setSizeMax(1200000);
			upload.setSizeThreshold(4096);
			upload.setRepositoryPath(path);
			
			List items = upload.parseRequest(request);
			
			Iterator params = items.iterator();
	    	
			String bname="";
	    	String price="";
	    	String info="";
	    	String eatbydate="";
	    	String delivery="";
	    	String allergy="";
	    	String fileName = "";
	    	
			while(params.hasNext()) {
				FileItem item =(FileItem) params.next();
				
				if(item.isFormField()) {
					String filename=item.getFieldName();
					if(filename.equals("bname"))
						bname=item.getString("utf-8");
					else if(filename.equals("price"))
						price=item.getString("utf-8");
					else if(filename.equals("info"))
						info=item.getString("utf-8");
					else if(filename.equals("eatbydate"))
						eatbydate=item.getString("utf-8");
					else if(filename.equals("delivery"))
						delivery=item.getString("utf-8");
					else if(filename.equals("allergy"))
						allergy=item.getString("utf-8");
				} else {
					fileName=item.getName();
					fileName=fileName.substring(fileName.lastIndexOf("//") +1);
					File file = new File(path+"/"+fileName);
					item.write(file);
				}
			}
			
			int rprice =Integer.parseInt(price);
			int rdelivery = Integer.parseInt(delivery);
			
			request.setCharacterEncoding("utf-8");
			
			System.out.print(bname +","+price+","+info+","+eatbydate+","+delivery+","+allergy);
			
			String sql1 = "SELECT bname FROM bread WHERE bname=? ";
			PreparedStatement pstmt1 = conn.prepareStatement(sql1);
		 	pstmt1.setString(1,bname);
		 	
		 	ResultSet rs1 = pstmt1.executeQuery();
		 	
		 	if(rs1.next()) {
		 		%>
				<h1>이미 등록되어 있는 메뉴입니다.</h1>
		 	<%}else {
	
	    	String sql2 = "INSERT INTO bread VALUES (?,?,?,?,?,?,?,?) ";
	    	
	    	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		 	pstmt2.setString(1,bname);
		 	pstmt2.setInt(2,rprice);
		 	pstmt2.setString(3,info);
		 	pstmt2.setString(4,eatbydate);
		 	pstmt2.setInt(5,rdelivery);
		 	pstmt2.setString(6,allergy);
		 	pstmt2.setString(7,fileName);
		 	pstmt2.setInt(8,100);
	
		 	int rows = pstmt2.executeUpdate();
		 	
		 	if(rows>0) {
		 		
	    %>
	    <h1>메뉴 등록이 완료되었습니다!</h1>
	    <%} else { %>
	    <h1>메뉴 등록에 실패했습니다...</h1>
	    <% } 
			if(rs1 !=null )
				rs1.close();
			
	 		if (pstmt2 != null)
	 			pstmt2.close();
	 		if (pstmt1 != null)
	 			pstmt1.close(); }
		 	
		 	String sql3 = "select bname, price, info, eatbydate, delivery, allergy, img from bread where bname=? ";
		 	PreparedStatement pstmt3 = conn.prepareStatement(sql3);
		 	pstmt3.setString(1,bname);
		 	
		 	ResultSet rs3 = pstmt3.executeQuery();
			if (rs3.next()) {		
		%>
		
		<div class="bread">	
			<div class="row">
				<div class="col" style="text-align:center">
			    	<img src="/images/<%=rs3.getString("img") %>" width="350px"/>
			    </div>
			    
			    <div class="col align-content-center" id="information">
			     	<h1><b><%=rs3.getString("bname") %></b></h1> 
					<h4><b><%=rs3.getInt("price") %>원</b> </h4>
					<p><%=rs3.getString("info") %> </p>
					<p><b>소비 기한 :</b> <%=rs3.getString("eatbydate") %> </p>
					<p><b>배송비 :</b> <%=rs3.getInt("delivery") %>원
					<p><b>알레르기 정보 :</b> <%=rs3.getString("allergy") %> </p>
			    </div>
			</div>
		
		 	<%
		 		} 
	
			if (pstmt3 != null)
	 			pstmt3.close();
			
		 	if (conn != null)
		 		conn.close(); 
		 	%>
	 	</div>
	 	<%@ include file="footer.jsp"%>
 	</div>
</body>
</html>
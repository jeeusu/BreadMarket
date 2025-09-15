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
				<h1 class="display-5 fw-bold">상품관리</h1>      
	      	</div>
	    </div>
	    
	    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			<ol class="breadcrumb">
			  <li class="breadcrumb-item"><a href="Welcome.jsp">홈</a></li>
			  <li class="breadcrumb-item active" aria-current="page">상품관리</li>
			</ol>
		</nav>
	    
	    <%@ include file="dbconn.jsp" %>
	    
	    <%
	    	String path = "C:/breadmarket";
	    
	    	DiskFileUpload upload = new DiskFileUpload();
			
			upload.setSizeMax(1000000);
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
			
			System.out.print(bname +","+price+","+info+","+eatbydate+","+delivery+","+allergy+","+fileName);
			
			String sql1 = "UPDATE bread SET bname=? , price=? , info=? , eatbydate=? , delivery=? , allergy=? , img=? WHERE bname=? ";
			PreparedStatement pstmt1 = conn.prepareStatement(sql1);
		 	pstmt1.setString(1,bname);
		 	pstmt1.setString(2,price);
		 	pstmt1.setString(3,info);
		 	pstmt1.setString(4,eatbydate);
		 	pstmt1.setString(5,delivery);
		 	pstmt1.setString(6,allergy);
		 	pstmt1.setString(7,fileName);
		 	pstmt1.setString(8,bname);
		 	
		 	int rows = pstmt1.executeUpdate();
		 	
		 	if(rows>0) {
		 	%> <h1>메뉴 수정이 완료되었습니다.</h1>
	    <% } else { %>
	    <h1>메뉴 수정에 실패하였습니다...</h1>
	    <%}
		 	String sql2 = "select bname, price, info, eatbydate, delivery, allergy, img from bread where bname=? ";
		 	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		 	pstmt2.setString(1,bname);
		 	
		 	ResultSet rs2 = pstmt2.executeQuery();
			if (rs2.next()) {		
		%>
		
		<div class="bread">	
			<div class="row">
				<div class="col" style="text-align:center">
			    	<img src="/images/<%=rs2.getString("img") %>" width="350px"/>
			    </div>
			    
			    <div class="col align-content-center" id="information">
			     	<h1><b><%=rs2.getString("bname") %></b></h1> 
					<h4><b><%=rs2.getInt("price") %>원</b> </h4>
					<p><%=rs2.getString("info") %> </p>
					<p><b>소비 기한 :</b> <%=rs2.getString("eatbydate") %> </p>
					<p><b>배송비 :</b> <%=rs2.getInt("delivery") %>원  <small>(2만원 이상 구매시 배송비 무료)</small> </p>
					<p><b>알레르기 정보 :</b> <%=rs2.getString("allergy") %> </p>
			    </div>
			</div>
		
		 	<%
		 		}
				
		 		if (rs2 != null) 
		 			rs2.close();
	
		 		if (pstmt2 != null)
		 			pstmt2.close();
		 		if (pstmt1 != null)
		 			pstmt1.close();
		 		
		 		if (conn != null)
		 			conn.close();
		 	%>
	 	</div>
	 	
	 	<%@ include file="footer.jsp" %>
	 </div>
</body>
</html>
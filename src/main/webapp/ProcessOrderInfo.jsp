<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<title>주문 완료</title>
	
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap');
		* { font-family: "IBM Plex Sans KR", sans-serif; }

	</style>
</head>
<%
request.setCharacterEncoding("utf-8");

String id =(String)session.getAttribute("userID");

String bread="";
int cartamount=0;
int breadamount=0;

Cookie address = new Cookie("address",URLEncoder.encode(request.getParameter("address"),"utf-8"));
Cookie deliveryinfo = new Cookie("deliveryinfo",URLEncoder.encode(request.getParameter("deliveryinfo"),"utf-8"));

address.setMaxAge(24*60*60);
deliveryinfo.setMaxAge(24*60*60);

response.addCookie(address);
response.addCookie(deliveryinfo);

response.sendRedirect("OrderInfo.jsp");

String stocksql = "" + "SELECT bname, amount FROM cart WHERE id=? ";
PreparedStatement stockps = conn.prepareStatement(stocksql);
stockps.setString(1,id);

ResultSet stockrs = stockps.executeQuery();
while(stockrs.next()) {
	bread = stockrs.getString("bname");
	cartamount=stockrs.getInt("amount");
	
	System.out.println("[1]메뉴:"+bread+"개수:"+cartamount);
	
	String amountsql = "" + "SELECT amount FROM bread WHERE bname=? ";
	PreparedStatement amountps = conn.prepareStatement(amountsql);
	amountps.setString(1,bread);
	
	ResultSet amountrs = amountps.executeQuery();
	if(amountrs.next()) {
		
		breadamount=Integer.parseInt(amountrs.getString("amount"));
		System.out.println("[2]메뉴:"+bread+"개수:"+breadamount);
	}
	breadamount= breadamount - cartamount;
	
	String updatesql = "" + "UPDATE bread SET amount=? WHERE bname=? ";
	PreparedStatement updateps = conn.prepareStatement(updatesql);
	updateps.setString(1,String.valueOf(breadamount));
	updateps.setString(2, bread);
	
	int updaterows = updateps.executeUpdate();
	
	if(updaterows>0) {
		System.out.println("[3]메뉴:"+bread+"개수:"+breadamount);
		System.out.println("재고 확인 및 주문 완료");
	}
	
	if(updateps!=null)
		updateps.close();
	if(amountrs!=null)
		amountrs.close();
	if(amountps!=null)
		amountps.close();
}

if(stockrs!=null)
	stockrs.close();
if(stockps!=null)
	stockps.close();
if(conn!=null)
	conn.close();
%>

<body>

</body>
</html>
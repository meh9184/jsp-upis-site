<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%@ include file="mallCartSession.jsp" %>
<%
	//해당 상품 번호(num)와 수량(stock)을 입력 받아서 카트에 수정한다.
	int num = Integer.parseInt( request.getParameter("num")) ; 
	int stock = Integer.parseInt( request.getParameter("stock")) ;
	mycart.EditProduct(num, stock) ;	
	response.sendRedirect("mallCartList.jsp"); 
%>
</body>
</html>
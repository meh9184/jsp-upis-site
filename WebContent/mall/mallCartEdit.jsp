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
	//�ش� ��ǰ ��ȣ(num)�� ����(stock)�� �Է� �޾Ƽ� īƮ�� �����Ѵ�.
	int num = Integer.parseInt( request.getParameter("num")) ; 
	int stock = Integer.parseInt( request.getParameter("stock")) ;
	mycart.EditProduct(num, stock) ;	
	response.sendRedirect("mallCartList.jsp"); 
%>
</body>
</html>
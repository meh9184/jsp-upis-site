<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="mallCartSession.jsp" %>
<%	
	//num : ��ǰ ��ȣ
	int num = Integer.parseInt( request.getParameter("num") ) ;

	//qty : ��ٱ��Ͽ� ���� ���� 
	int qty = Integer.parseInt( request.getParameter("qty") ) ;
	
	mycart.AddProduct(num, qty) ; //īƮ�� �ش� ��ǰ ���
	
	//�� ��ٱ��� ������ ���� ������ �����Ѵ�.
	//�׷��߸� �������̵��� �̷�������� ��ٱ��� ������ ��� �����ȴ�.
	session.setAttribute("mycart", mycart) ;
	
	response.sendRedirect("mallCartList.jsp");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
</body>
</html>
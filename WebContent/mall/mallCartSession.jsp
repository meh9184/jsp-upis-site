<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="my.shop.MyCartList"%>
<%
	//����ڰ� ��ǰ�� �ֹ��ϸ� ���ǿ� �����صд�.
	MyCartList mycart = (MyCartList)session.getAttribute("mycart") ;

	//���࿡ ���ǿ� ���ٸ�(��, ������ �ѹ��� ��ǰ�� ��ٱ��Ͽ� ���� ���� ����)
	if( mycart == null ){ 
		mycart = new MyCartList(); //����� ���� īƮ �غ�
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="my.shop.MyCartList"%>
<%
	//사용자가 상품을 주문하면 세션에 저장해둔다.
	MyCartList mycart = (MyCartList)session.getAttribute("mycart") ;

	//만약에 세션에 없다면(즉, 이전에 한번도 상품을 장바구니에 담은 적이 없다)
	if( mycart == null ){ 
		mycart = new MyCartList(); //사용자 전용 카트 준비
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
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="mallCartSession.jsp" %>
<%	
	//num : 상품 번호
	int num = Integer.parseInt( request.getParameter("num") ) ;

	//qty : 장바구니에 담을 수량 
	int qty = Integer.parseInt( request.getParameter("qty") ) ;
	
	mycart.AddProduct(num, qty) ; //카트에 해당 상품 담기
	
	//이 장바구니 정보를 세션 공간에 저장한다.
	//그래야만 페이지이동이 이루어지더라도 장바구니 정보는 계속 보존된다.
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
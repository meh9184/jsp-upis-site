<%@page import="my.shop.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="mall_top.jsp"%>
<%@ include file="mallCartSession.jsp" %>
<%
	String mode = request.getParameter("mode") ;
	if(mode == null){
	}else if( mode.equals("order") ){ //즉시 구매하기인 경우 카트에 추가하기
		int num = Integer.parseInt( request.getParameter("num") );
		int qty = Integer.parseInt( request.getParameter("qty") ); 
		mycart.AddProduct(num, qty);
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>	
</head>
<body>
<tr>
	<td valign="top" width="20%">		
		<img src="./../images/pontMall.png" width="160" height="60" > 
		<div id="tree">
		</div>
	</td> 
<td colspan="5" width="80%">

<table width=100% border=1 align=center>
	<tr class=m2>
		<td colspan=6 align=center><h4>결재 내역서 보기</h4></td>
	</tr> 
	<tr  class=m1>
		<th width="30%">상품명</th>
		<th width="10%">수량</th>
		<th width="20%">금액</th>
	</tr>
	<%
		int sumTotalPrice = 0; //내가 구매한 모든 물건들의 총합
		//carts : 내가 담은 모든 물건들
		Vector<ProductBean> carts = mycart.getAllProducts() ;
		if(carts == null || carts.size() == 0){
	%>
	<tr>
		<td colspan='3'>
			<b>주문하신 상품이 없습니다.</b>
			</td>
	</tr>	
	<%		
		}else{
			//바코드를 찍으면서 구매할 목록을 화면에 보여 준다.
			for(ProductBean cart : carts){
				//제품 항목별 금액을 총금액에 누적시킨다.
				sumTotalPrice += cart.getTotalPrice() ;
	%>
	<tr>
		<td align="center"><%=cart.getName()%></td>
		<td align="right"><%=cart.getStock()%>개</td>
		<td align="right"><%=df.format(cart.getTotalPrice())%>원</td>
	</tr>	
	<%				
			}
		}
	%>
	<% 
		// 장바구니에 담긴 모든 상품을 담아 놓은 vector
		session.setAttribute("carts", carts);  
	%>
	<tr class="m1">
		<td colspan=3 align=center><b>결재하실 총액은</b>:
			<font color=red><%=df.format(sumTotalPrice)%> 원<br></font>		
		</td>
	</tr>		 
</table>
<center>
	<input type="button" value="결재하기" align="middle"
		onclick="location.href='mallCalculate.jsp'">
</center>
</td>
<%@ include file="mall_bottom.jsp"%>
</body>
</html>
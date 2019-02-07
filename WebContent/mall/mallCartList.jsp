<%@page import="my.shop.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="mall_top.jsp"%>
<%@ include file="mallCartSession.jsp" %>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript">
		function cartEdit(num){	/* 해당 상품에 대한 주문 수량 수정 */		
			var stock = document.getElementById("stock").value ;
			location.href="mallCartEdit.jsp?num=" + num + "&stock=" + stock  ;
		}
	</script>
</head>
<body>
<tr>
	<td valign="top" width="20%">		
		<img src="./../images/pontCart.png" width="160" height="60" > 
		<div id="tree">
		</div>
	</td> 
<td colspan="5" width="80%">
<h3 align="center">장바구니 </h3>
<table width=100% border=1 align=center>
	<tr class="m2">
		<td colspan="6" align="center">
			<h4>장바구니 보기</h4>
		</td>
	</tr> 
	<tr class="m1">
		<th width="10%">번호</th>
		<th width="25%">상품명</th>
		<th width="15%">수량</th>
		<th width="20%">단가</th>
		<th width="20%">금액</th>
		<th width="10%">삭제</th>
	</tr>
	<% 
		//카트빈으로부터 장바구니 모든 상품 가져오기
		Vector<ProductBean> carts = mycart.getAllProducts();
	
		int sumTotalPrice = 0 ; //모든 상품의 총 판매 금액
		int sumTotalPoint = 0 ; //모든 상품의 총 판매 포인트	
	%>
	<% if( carts == null || carts.size() == 0 ){ %>
	<tr class="m1">
		<td colspan="6">
			선택된 상품이 없습니다.
		</td>
	</tr>	
	<% 
		}else{
			for(ProductBean cart : carts){ //각 상품마다	
				int totalPrice = cart.getTotalPrice() ; //총 금액을 구한다.
				sumTotalPrice += totalPrice ; //총 금액을 전체 금액에 누적시킨다.
				sumTotalPoint += cart.getTotalPoint() ; //총 적립 포인트
	%>
	<tr class="m1">
		<td width="10%" align="center"><%=cart.getNum()%></td>
		<%
			String pimage = cart.getImage();
			String imgpath = config.getServletContext().getRealPath( imgPath + pimage ) ;	
		%>
		<td width="25%" align="center">
			<img src="<%=imgpath%>" width="40" height="40">
			<br>				
			<%=cart.getName()%>			
		</td>
		<td width="15%" align="center" valign="middle">
			<input type="text" id="stock" size="2" name="stock" value="<%=cart.getStock()%>"> 개<br>
 			<input type="button" value="수정" onclick="cartEdit('<%=cart.getNum()%>')">	 
		</td>
		<td width="20%" align="right">
			<font color="blue">
				<%=df.format(cart.getPrice())%>원<br>
				<%=df.format(cart.getPoint())%> point
			</font>				
		</td>
		<td width="20%" align="right">
			<font color="red">
				<%=df.format(totalPrice)%>원<br>
				<%=df.format(cart.getTotalPoint())%> point
			</font>
		</td>
		<td width="10%" align="center">
			<a href="mallCartDelete.jsp?num=<%=cart.getNum()%>">삭제</a>
		</td>
	</tr>	
	<%	
			}
		} 
	%>
	<tr class=m1>
		<td colspan=4><b>장바구니 총액</b> :
			<font color="red">
				<%=df.format(sumTotalPrice)%> 원<br>
			</font>
			<font color="green">		
				총 적립 포인트 : [<%=df.format(sumTotalPoint)%>] point
			</font>
		</td>
		<td colspan=2>
			<a href="mallOrder.jsp">
				[주문하기]
			</a>
			<a href="mallMain.jsp">
				[계속 쇼핑]
			</a>
		</td>
	</tr>	
</table>

</td>
<%@ include file="mall_bottom.jsp"%>
</body>
</html>
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
	}else if( mode.equals("order") ){ //��� �����ϱ��� ��� īƮ�� �߰��ϱ�
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
		<td colspan=6 align=center><h4>���� ������ ����</h4></td>
	</tr> 
	<tr  class=m1>
		<th width="30%">��ǰ��</th>
		<th width="10%">����</th>
		<th width="20%">�ݾ�</th>
	</tr>
	<%
		int sumTotalPrice = 0; //���� ������ ��� ���ǵ��� ����
		//carts : ���� ���� ��� ���ǵ�
		Vector<ProductBean> carts = mycart.getAllProducts() ;
		if(carts == null || carts.size() == 0){
	%>
	<tr>
		<td colspan='3'>
			<b>�ֹ��Ͻ� ��ǰ�� �����ϴ�.</b>
			</td>
	</tr>	
	<%		
		}else{
			//���ڵ带 �����鼭 ������ ����� ȭ�鿡 ���� �ش�.
			for(ProductBean cart : carts){
				//��ǰ �׸� �ݾ��� �ѱݾ׿� ������Ų��.
				sumTotalPrice += cart.getTotalPrice() ;
	%>
	<tr>
		<td align="center"><%=cart.getName()%></td>
		<td align="right"><%=cart.getStock()%>��</td>
		<td align="right"><%=df.format(cart.getTotalPrice())%>��</td>
	</tr>	
	<%				
			}
		}
	%>
	<% 
		// ��ٱ��Ͽ� ��� ��� ��ǰ�� ��� ���� vector
		session.setAttribute("carts", carts);  
	%>
	<tr class="m1">
		<td colspan=3 align=center><b>�����Ͻ� �Ѿ���</b>:
			<font color=red><%=df.format(sumTotalPrice)%> ��<br></font>		
		</td>
	</tr>		 
</table>
<center>
	<input type="button" value="�����ϱ�" align="middle"
		onclick="location.href='mallCalculate.jsp'">
</center>
</td>
<%@ include file="mall_bottom.jsp"%>
</body>
</html>
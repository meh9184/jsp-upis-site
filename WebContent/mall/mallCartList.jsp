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
		function cartEdit(num){	/* �ش� ��ǰ�� ���� �ֹ� ���� ���� */		
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
<h3 align="center">��ٱ��� </h3>
<table width=100% border=1 align=center>
	<tr class="m2">
		<td colspan="6" align="center">
			<h4>��ٱ��� ����</h4>
		</td>
	</tr> 
	<tr class="m1">
		<th width="10%">��ȣ</th>
		<th width="25%">��ǰ��</th>
		<th width="15%">����</th>
		<th width="20%">�ܰ�</th>
		<th width="20%">�ݾ�</th>
		<th width="10%">����</th>
	</tr>
	<% 
		//īƮ�����κ��� ��ٱ��� ��� ��ǰ ��������
		Vector<ProductBean> carts = mycart.getAllProducts();
	
		int sumTotalPrice = 0 ; //��� ��ǰ�� �� �Ǹ� �ݾ�
		int sumTotalPoint = 0 ; //��� ��ǰ�� �� �Ǹ� ����Ʈ	
	%>
	<% if( carts == null || carts.size() == 0 ){ %>
	<tr class="m1">
		<td colspan="6">
			���õ� ��ǰ�� �����ϴ�.
		</td>
	</tr>	
	<% 
		}else{
			for(ProductBean cart : carts){ //�� ��ǰ����	
				int totalPrice = cart.getTotalPrice() ; //�� �ݾ��� ���Ѵ�.
				sumTotalPrice += totalPrice ; //�� �ݾ��� ��ü �ݾ׿� ������Ų��.
				sumTotalPoint += cart.getTotalPoint() ; //�� ���� ����Ʈ
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
			<input type="text" id="stock" size="2" name="stock" value="<%=cart.getStock()%>"> ��<br>
 			<input type="button" value="����" onclick="cartEdit('<%=cart.getNum()%>')">	 
		</td>
		<td width="20%" align="right">
			<font color="blue">
				<%=df.format(cart.getPrice())%>��<br>
				<%=df.format(cart.getPoint())%> point
			</font>				
		</td>
		<td width="20%" align="right">
			<font color="red">
				<%=df.format(totalPrice)%>��<br>
				<%=df.format(cart.getTotalPoint())%> point
			</font>
		</td>
		<td width="10%" align="center">
			<a href="mallCartDelete.jsp?num=<%=cart.getNum()%>">����</a>
		</td>
	</tr>	
	<%	
			}
		} 
	%>
	<tr class=m1>
		<td colspan=4><b>��ٱ��� �Ѿ�</b> :
			<font color="red">
				<%=df.format(sumTotalPrice)%> ��<br>
			</font>
			<font color="green">		
				�� ���� ����Ʈ : [<%=df.format(sumTotalPoint)%>] point
			</font>
		</td>
		<td colspan=2>
			<a href="mallOrder.jsp">
				[�ֹ��ϱ�]
			</a>
			<a href="mallMain.jsp">
				[��� ����]
			</a>
		</td>
	</tr>	
</table>

</td>
<%@ include file="mall_bottom.jsp"%>
</body>
</html>
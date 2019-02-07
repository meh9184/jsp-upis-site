<%@page import="my.shop.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="mall_top.jsp"%>
<jsp:useBean id="pdao" class="my.shop.ProductDao" />
<% 
	int num = -1 ;
	if( request.getParameter("num") != null ){		
		num = Integer.parseInt( request.getParameter("num"));	
	}
	
	ProductBean product = pdao.SelectByNum( num);
%>
<%
	String pimage = product.getImage();
	String imgpath = config.getServletContext().getRealPath( "/images/" + pimage ) ;	
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript">
		/* ��ǰ ��ȣ�� ��ǰ�� ������ �Ķ���ͷ� �Ѿ� ����. */
		
		function goCart(num){
			//��� �������� ��û ������ ������ ��� �޽����� ����.(���� ����)			
			//Number ��ü�� ���� �������� �ٲ� �ִ� �ڹ� ��ũ��Ʈ ��ü
			var qty = Number(document.myform.qty.value) ;
			var stock = Number( '<%=product.getStock()%>'  ) ;	
			if( qty > stock ){
				alert('��� ������ �����ϳ׿� �Ф�') ;				
			}else{
				//alert('�Ȳ���') ;
				document.myform.action = "<%=mall_folder%>/mallCartAdd.jsp?num=" + num;			
				document.myform.submit();
			}
		}	
		function goOrder(num){
			//��� ���Žÿ��� mode�� order���� �����Ѵ�.
			var qty = Number(document.myform.qty.value) ;
			var stock = Number( '<%=product.getStock()%>'  ) ;	
			if( qty > stock ){
				alert('��� ������ �����ϳ׿� �Ф�') ;				
			}else{
				//alert('�Ȳ���') ;
				document.myform.action = "<%=mall_folder%>/mallOrder.jsp?num=" + num + "&mode=order";
				document.myform.submit();
			}
		}
	</script>	
</head>
<body>
<tr>
	<td valign="top" width="20%">		
		<img src="./../images/pontMall.png" width="160" height="60" > 
		<div id="tree">
		</div>
	</td> 
<td colspan="5" width="80%">
<table border="3" width="95%" class="outline">
	<tr class="m1" align="center">
		<td colspan="2">
			<font color="green" size="3"><b>
				��ǰ [<%=product.getName().trim()%>]�� ����
			</b></font>
		</td>			
	</tr>
	<tr>
		<td align="center" class="m3" width="50%">
			<img src="<%=imgpath%>" width="200" height="200">
		</td>
		<td>
			<form name="myform" method="post">
			<table border="0"> 
				<tr>
					<td>�ڵ�(��ȣ)</td>
					<td><%=product.getCname()%>(<%=num%>)</td>
				</tr>
				<tr>
					<td>�̸�</td>
					<td><%=product.getName()%></td>
				</tr>
				<tr>
					<td>�ܰ�</td>
					<td><font color="red"><b><%=product.getPrice()%></b></font>��</td>
				</tr>
				<tr>
					<td>����Ʈ</td>
					<td><font color="red"><b>[<%=product.getPoint()%>]</b></font> point<br></td>
				</tr>
				<tr>
					<td>��� ����</td>
					<td><font color="red"><b>[<%=product.getStock()%>]</b></font><br></td>
				</tr>				
				<tr>
					<td>����</td>
					<td><input type=text name="qty" size="2" value="1">��</td>
				</tr>
				<tr>
					<br>
				</tr>
				<tr>
					<td colspan="2">
						<a href="javascript:goCart('<%=num%>');">
							<img src="./../images/cartBtn.png" border="0" width="100" height="45">
						</a>
						&nbsp;
						<a href="javascript:goOrder('<%=num%>');">
							<img src="./../images/orderBtn.png" border="0" width="100" height="45">
						</a>
					</td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			====================================
			<font color="green" size="3" face="�������" >��ǰ ����</font>
			====================================
			
			<br>
			<%=product.getContents()%>
		</td>
	</tr>	
</table>
</td>
<%@ include file="mall_bottom.jsp"%>

</body>
</html>
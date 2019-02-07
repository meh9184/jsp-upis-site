<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="pdao" class="my.shop.ProductDao" />
<%@page import="my.shop.ProductBean"%>
<%
	//��ǰ ��� ���⿡�� �Ѱ��ִ� ��ǰ ��ȣ �Ķ���� 
	int num = Integer.parseInt( request.getParameter("num")) ;

	//��ǰ ��ȣ�� �̿��Ͽ� ��ǰ �� ��ü�� ���� �޴´�.
	ProductBean product = pdao.getProductByNum( num ) ;
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
</head>
<body>
<%@include file="adm_top.jsp"%>
<tr>
<td colspan="6">
	<h3 align="center">��ǰ �� ����</h3>
	<table align="center" width="60%" border="2">
		<tr>
			<td align="center">ī�װ�</td>
			<td align="center">
				<%=product.getCname()%>
			</td>
		</tr>	
		<tr>
			<td align="center">��ǰ��</td>
			<td align="center"><%=product.getName()%></td>
		</tr>
		<tr>
			<td align="center">����ȸ��</td>
			<td align="center"><%=product.getCompany()%></td>
		</tr>
		<tr>
			<td align="center">�̹���</td>
			<td align="center">
				<%
					//���࿡ �̹����� ���̸� ����Ʈ �̹����� �����Ѵ�
					String image = product.getImage() ;
					String myimg = "";
					
					if( image == null ){ //�������� �������� ���� ��쿡�� ó������� �Ѵ�.
						myimg = apppath + imgPath + "\\heart.png" ;
					}else{
						myimg = saveDirectory + "\\" + image  ;	
					}
				%>
				<img src="<%=myimg%>" width="300" height="200">				
			</td>
		</tr>
		<tr>
			<td align="center">���</td>
			<td align="center"><%=product.getStock()%></td>
		</tr>
		<tr>
			<td align="center">�ܰ�</td>
			<td align="center"><%=product.getPrice()%></td>
		</tr>
		<tr>
			<td align="center">����</td>
			<td align="center">
				<%=product.getSpec()%>
			</td>
		</tr>
		<tr>
			<td align="center">��ǰ ����</td>
			<td align="center"><%=product.getContents()%></td>
		</tr>
		<tr>
			<td align="center">����Ʈ</td>
			<td align="center">
				<%=product.getPoint()%>
			</td>
		</tr>
		<tr>
			<td align="center">�԰� ����</td>
			<td align="center"><%=product.getInputdate()%></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="button" value="���� ȭ��" 
					onclick="javascript:history.back();">
			</td>
		</tr>		
	</table>	
</td>
</tr>
<%@include file="adm_bottom.jsp"%>
</body>
</html>
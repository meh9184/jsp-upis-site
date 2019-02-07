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
	<h3 align="center">��ǰ �����ϱ�</h3>
	<form action="prdUpdateProc.jsp" method="post" enctype="multipart/form-data">
	<table align="center">
		<tr>
			<td>ī�װ�</td>
			<td>
				<!-- ī�װ��� �б� �������� ���� �� ������ �ϴ�.  -->
				<input type="hidden" name="num" value="<%=product.getNum()%>">
				<input type="hidden" name="cnum" value="<%=product.getCnum()%>">
				<input type="text" name="cname" value="<%=product.getCname()%>" readonly="readonly">
			</td>
		</tr>	
		<tr>
			<td>��ǰ��</td>
			<td><input type="text" name="name" value="<%=product.getName()%>"></td>
		</tr>
		<tr>
			<td>����ȸ��</td>
			<td><input type="text" name="company" value="<%=product.getCompany()%>"></td>
		</tr>
		<tr>
			<td>�̹���</td>
			<td>
				<%
					//���� �̹����� ���� oldImage�� �����Ѵ�.
					//oldImage�� �Ķ���ͷ� �Ѱܼ�, �� �̹����� ���� ������ ������ �Ǿ��ٸ� ���������� �����ϵ��� �Ѵ�.
					//myimg : �� ���� ���� �̹��� �̸�
					String oldImage = product.getImage() ;
					String myimg = saveDirectory + "\\" + oldImage  ;
					//out.print( myimg ) ;
				%>
				<input type="hidden" name="oldImage" value="<%=oldImage%>">
				
				<img src="<%=myimg%>" width="120" height="120">
				<input type="file" name="image">
			</td>
		</tr>
		<tr>
			<td>���</td>
			<td><input type="text" name="stock" value="<%=product.getStock()%>"></td>
		</tr>
		<tr>
			<td>�ܰ�</td>
			<td><input type="text" name="price" value="<%=product.getPrice()%>"></td>
		</tr>
		<tr>
			<td>����</td>
			<td>
				<input type="text" name="spec" value="<%=product.getSpec()%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>��ǰ ����</td>
			<td><input type="text" name="contents" value="<%=product.getContents()%>"></td>
		</tr>
		<tr>
			<td>����Ʈ</td>
			<td>
				<input type="text" name="point" value="<%=product.getPoint()%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>�԰� ����</td>
			<td><input type="text" name="inputdate" value="<%=product.getInputdate()%>"></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="submit" value="����">
				<input type="reset" value="���">
			</td>
		</tr>		
	</table>
	</form>
</td>
</tr>
<%@include file="adm_bottom.jsp"%>
</body>
</html>
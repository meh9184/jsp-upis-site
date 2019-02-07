<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="adm_top.jsp"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="pdao" class="my.shop.ProductDao"/>
<%
	ArrayList<ProductBean> lists = pdao.getAllProduct() ; 
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript">
		function prdUpdate( num ){
			var resp = confirm('�����Ͻðڽ��ϱ�?') ;
			if( resp ){				
				location.href='prdUpdateForm.jsp?num=' + num ;
			}else{
				alert( '������ ����ϼ̽��ϴ�') ;
			}
		}
		function prdDelete( num, image ){
			var resp = confirm('�����Ͻðڽ��ϱ�?') ;
			if( resp ){
				location.href='prdDeleteProc.jsp?num=' + num + "&image=" + image ;
			}else{
				alert( '������ ����ϼ̽��ϴ�') ;
			}
		}
	</script>
</head>
<body>

<tr>

<td colspan="1" valign="top">
	<img src="./../images/pontPrdList.png" width="160" height="60" > 
	<br> <br> <br>
	<a href="<%=adm_folder%>/catList.jsp">- ī�װ� ���</a>
	<br> <br>
	<a href="<%=adm_folder%>/catRegisterForm.jsp">- ī�װ� ���</a>
	<br> <br>
	<a href="<%=adm_folder%>/prdList.jsp">- ��ǰ ���</a>
	<br> <br>
	<a href="<%=adm_folder%>/prdRegisterForm.jsp">- ��ǰ ���</a>	
</td>

<td colspan="5">
	<h3 align="center">��ǰ ���</h3>	
	<table align="center">
		<%=sep_product_list%>
		<tr>
			<td>ī�װ�</td> 
			<td>��ǰ��</td> 
			<td>����ȸ��</td> 
			<td>���</td> 
			<td>�ܰ�</td> 
			<td>����Ʈ</td>
			<td>�԰� ����</td>
			<td>����</td> 
			<td>����</td> 
		</tr>
		<%=sep_product_list%>
		<% 
			if( lists.size() == 0 ){
		%>
		<tr>
			<td colspan="10">
				��ǰ ����� �������� �ʽ��ϴ�.
			</td>
		</tr>
		<% 
			}else{
				for( ProductBean product : lists){
		%>
		<tr>
			<td><%=product.getCname()%></td>
			<td>
				<a href="prdDetailView.jsp?num=<%=product.getNum()%>">
					<%=product.getName()%>
				</a>
			</td>
			<td><%=product.getCompany()%></td>
			<td><%=product.getStock()%></td>
			<td><%=product.getPrice()%></td>
			<td><%=product.getPoint()%></td>
			<td><%=product.getInputdate()%></td>
			<td><input type="button" value="����" onclick="prdUpdate('<%=product.getNum()%>')"></td>
			
			<!-- ������ �� �������� �׸��� ������ �Ǿ�� �Ѵ�. �׷���, �̹����� �Ѱ� �ֵ��� �Ѵ� -->
			<td><input type="button" value="����" 
				onclick="prdDelete('<%=product.getNum()%>', '<%=product.getImage()%>')"></td>
			<%=sep_product_list%>
		</tr>
		<% 
				}
			}
		%>	
	</table>
</td>
</tr>
<%@include file="adm_bottom.jsp"%>
</body>
</html>
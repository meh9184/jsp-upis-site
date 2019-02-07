<%@page import="my.shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="adm_top.jsp"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="cdao" class="my.shop.CategoryDao"/>
<%
	ArrayList<CategoryBean> lists = cdao.getAllCategory() ; 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<tr>

<td colspan="1" valign="top">
	<img src="./../images/pontCatList.png" width="160" height="60" > 
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
	<h3 align="center">ī�װ� ���</h3>
	<table align="center">
		<%=sep_category_list%>
		<tr>
			<td>��ȣ</td>
			<td>�ڵ�</td>			
			<td>�̸�</td>
			<td>����</td>
			<td>����</td>
		</tr>
		<%=sep_category_list%>
		<%
			if( lists.size() == 0){
		%>
		<tr>
			<td colspan="3">
				ī�װ��� �������� �ʽ��ϴ�.
			</td>
		</tr>
		<% 
			}else{
				for(CategoryBean category : lists){
		%>
		<tr>
			<td><%=category.getCnum()%></td>
			<td><%=category.getCode()%></td>
			<td><%=category.getCname()%></td>
			<td><a href="catUpdateForm.jsp?cnum=<%=category.getCnum()%>">����</a></td>
			<td><a href="catDeleteProc.jsp?cnum=<%=category.getCnum()%>">����</a></td>
		</tr>
		<%=sep_category_list%>
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
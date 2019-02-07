<%@page import="my.shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="adm_top.jsp"%>
<jsp:useBean id="cdao" class="my.shop.CategoryDao" />
<%
	//catelists : ī�װ� ����� ��� �ִ� �÷���
	ArrayList<CategoryBean> catelists = cdao.getAllCategory() ;	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<tr>

<%
	if(loginfo.equals("admin")){
%>
<td colspan="1" valign="top">
	<img src="./../images/pontPrdReg.png" width="160" height="60" > 
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
	<form action="prdRegisterProc.jsp" method="post" enctype="multipart/form-data">
	<table align="center">
		<tr>
			<td>ī�װ�</td>
			<td>
				<select name="cnum">
				<% 
					for(CategoryBean cate : catelists){
				%>
					<option value="<%=cate.getCnum()%>"><%=cate.getCode()%>(<%=cate.getCname()%>)
				<%
					}					
				%>
				</select>
			</td>
		</tr>	
		<tr>
			<td>��ǰ��</td>
			<td><input type="text" name="name" value=""></td>
		</tr>
		<tr>
			<td>����ȸ��</td>
			<td><input type="text" name="company" value=""></td>
		</tr>
		<tr>
			<td>�̹���</td>
			<td><input type="file" name="image"></td>
		</tr>
		<tr>
			<td>���</td>
			<td><input type="text" name="stock" value=""></td>
		</tr>
		<tr>
			<td>�ܰ�</td>
			<td><input type="text" name="price" value=""></td>
		</tr>
		<tr>
			<td>����</td>
			<td>
				<select name="spec">
					<option value="none" selected="selected">NORMAL</option>
					<option value="HIT">HIT</option>
					<option value="NEW">NEW</option>
					<option value="BEST">BEST</option>
				</select>			
			</td>
		</tr>
		<tr>
			<td>��ǰ ����</td>
			<td><input type="text" name="contents" value=""></td>
		</tr>
		<tr>
			<td>����Ʈ</td>
			<td><input type="text" name="point" value=""></td>
		</tr>
		<tr>
			<td>�԰� ����</td>
			<td><input type="text" name="inputdate" value=""></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="submit" value="���">
				<input type="reset" value="���">
			</td>
		</tr>		
	</table>
	</form>
</td>
<%
	}else{
%>
<td colspan="1" valign="top">
	<br>
	<br>
	<br> <br>
	<br>
	<br> <br>
	<br>
	<br> <br>
	<br>
</td>

<td colspan="3">
	<h3 align="center">��ǰ ���</h3>
	<form action="prdRegisterProc.jsp" method="post" enctype="multipart/form-data">
	<table align="center">
		<tr>
			<td>ī�װ�</td>
			<td>
				<select name="cnum">
				<% 
					for(CategoryBean cate : catelists){
				%>
					<option value="<%=cate.getCnum()%>"><%=cate.getCode()%>(<%=cate.getCname()%>)
				<%
					}					
				%>
				</select>
			</td>
		</tr>	
		<tr>
			<td>��ǰ��</td>
			<td><input type="text" name="name" value=""></td>
		</tr>
		<tr>
			<td>����ȸ��</td>
			<td><input type="text" name="company" value=""></td>
		</tr>
		<tr>
			<td>�̹���</td>
			<td><input type="file" name="image"></td>
		</tr>
		<tr>
			<td>���</td>
			<td><input type="text" name="stock" value=""></td>
		</tr>
		<tr>
			<td>�ܰ�</td>
			<td><input type="text" name="price" value=""></td>
		</tr>
		<tr>
			<td>����</td>
			<td>
				<select name="spec">
					<option value="none" selected="selected">NORMAL</option>
					<option value="HIT">HIT</option>
					<option value="NEW">NEW</option>
					<option value="BEST">BEST</option>
				</select>			
			</td>
		</tr>
		<tr>
			<td>��ǰ ����</td>
			<td><input type="text" name="contents" value=""></td>
		</tr>
		<tr>
			<td>����Ʈ</td>
			<td><input type="text" name="point" value=""></td>
		</tr>
		<tr>
			<td>�԰� ����</td>
			<td><input type="text" name="inputdate" value=""></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="submit" value="���">
				<input type="reset" value="���">
			</td>
		</tr>		
	</table>
	</form>
</td>
<%
	}
%>
</tr>
<%@include file="adm_bottom.jsp"%>
</body>
</html>
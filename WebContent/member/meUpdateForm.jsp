<%@page import="mypkg.member.MemberBean"%>
<%@page import="mypkg.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="./../common/top.jsp" %>
<% request.setCharacterEncoding("EUC-KR") ; %>

<%
	String id = request.getParameter("id") ;
	MemberDao dao = new MemberDao();	
	MemberBean member = dao.getMemberById( id ) ;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>ȸ�� ���� </title>
	<script type="text/javascript" src="script.js"></script>
</head>
<body> 	

<tr>
<% 
	if( loginfo.equals("admin")){
%>
<td colspan="2" valign="top">
	<img src="./../images/pontUpdate.png" width="160" height="60" > 
	<br> <br> <br>
	<a href="<%=me_folder%>/meList.jsp">- ȸ�� ��� ��ȸ</a>
	<br> <br>
	<a href="<%=mall_folder%>/shopping_list.jsp">- �ֹ� ���� ��ȸ</a>
</td>
<% 
	}else{
%>
<td colspan="2" valign="top">
	<img src="./../images/pontUpdate.png" width="160" height="60" > 
	<br> <br> <br>
	<%=mem2%>
	<br> <br>
	<a href="<%=mall_folder%>/shopping_list.jsp">- �ֹ� ���� ��ȸ</a>
</td>
<% 
	}
%>
<td colspan="5" >
	
	<h3 align="center">ȸ�� ���� </h3>
	<form action="meUpdateProc.jsp" method="post" name="myform">
	<input type="hidden" name="mpoint" value="30">
	<table border="1" align="center" width="70%">
		<tr>
			<td width="25%" align="center">���̵�</td>
			<td width="75%" align="left">
				<input type="text" name="id" class="setdiaabledme" readonly="readonly" value="<%=member.getId()%>">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">�̸�</td>
			<td width="75%" align="left">
				<input type="text" name="name" value="<%=member.getName()%>">
			</td>
		</tr>
		<tr>
			<td align="center">��� ��ȣ</td>
			<td width="75%" align="left"><input type="password" name="password" value=""></td>
		</tr>
		<tr>
			<td width="25%" align="center">�й�</td>
			<td width="75%" align="left">
				<input type="text" name="salary" value="<%=member.getSalary()%>">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">���� ����</td>
			<td width="75%" align="left">
				<input type="text" name="hiredate" value="<%=member.getHiredate()%>">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">����</td>
			<td width="75%" align="left">
				<input type="radio" name="gender" value="��" checked="checked">����
				<input type="radio" name="gender" value="��">����
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">���</td>
			<td width="75%" align="left">
				<input type="checkbox" name="hobby" value="�">�
				<input type="checkbox" name="hobby" value="���ǰ���" checked="checked">���ǰ���
				<input type="checkbox" name="hobby" value="����">����
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">����</td>
			<td width="75%" align="left">
				<select name="job">
					<option value="-" selected="selected">-- �����ϼ��� --
					<option value="����">����
					<option value="�л�">�л�
					<option value="��Ÿ">��Ÿ
				</select>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">���� ��ȣ</td>
			<td width="75%" align="left">
				<input type="text"  class="setdiaabledme" name="zipcode" value="<%=member.getZipcode()%>">
				<input type="button" value="���� ��ȣ ã��" onclick="zipCheck();">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">�ּ�</td>
			<td width="75%" align="left">
				<input type="text"  class="setdiaabledme" size="50" name="address1" value="<%=member.getAddress1()%>">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">���� �ּ�</td>
			<td width="75%" align="left">
				<input type="text" name="address2" size="50" value="<%=member.getAddress2()%>">
			</td>
		</tr>		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="�����ϱ�">
				<input type="reset" value="���">
			</td>
		</tr>	
	</table>	
	</form>
</td>	
</tr>	
<%@include file="./../common/bottom.jsp" %>
</body>
</html>
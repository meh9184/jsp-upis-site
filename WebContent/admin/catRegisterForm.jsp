<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="adm_top.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<tr>

<td colspan="1" valign="top">
	<img src="./../images/pontCatReg.png" width="160" height="60" > 
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
	<form action="catRegisterProc.jsp" method="post" name="myform">
	<table align="center">
		<tr>
			<td align="center" width="30%">ī�װ� �ڵ�</td>
			<td width="70%">
				<input type="text" name="code" size="50">
			</td>
		</tr>
		<tr>
			<td align="center">ī�װ� �̸�</td>
			<td>
				<input type="text" name="cname" size="50">
			</td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="submit" value="���">
				&nbsp;&nbsp;&nbsp;
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
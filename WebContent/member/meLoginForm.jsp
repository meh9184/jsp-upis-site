<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="./../common/common.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>U.P.I.S</title>
		<style type="text/css">
		body {
			background-image:url(./../images/bg_login.jpg);
			background-repeat:repeat-x;
			background-attachment:fixed;
			background-position:left bottom;
		}
	</style>	
</head>
<body>
	<br>
	<br>
	
	<table align="center" border="0">
		<tr>
			<td>
				<img src="./../images/logo.png" width="250" height="100">
			</td>
			<td>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>			
		</tr>
	</table>
	<table align="center" border="0">
		<tr>
			<td>
				<img src="./../images/visual_s.png" width="900" height="300">
			</td>
		</tr>
	</table>
	
	<br>
	
	<table border="5" cellspacing="10" cellpadding="15" width="30%" align="center">
		<tr>
			<td colspan="8" align="center">
				<!-- gotopage는 로그인 이후에 이동할 페이지를 의미한다. -->
				<form method="post" action="meLoginProc.jsp">
					<input type="hidden" name="gotopage" value="<%=request.getParameter("gotopage")%>">
					ID &nbsp; <input type="text" name="id" value=""><br>
					P/W <input type="password" name="password" value=""><br><br>
					<input type="submit" value="로그인">
					&nbsp;&nbsp;&nbsp;
					<input type="reset" value="취소">
				</form>
				<br>
				<a href="<%=me_folder%>/meRegisterForm.jsp"> <img src="./../images/joinBtn.png" width="90" height="40"> </a>
			</td>
		</tr>
	</table>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="member" class="mypkg.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<jsp:useBean id="mdao" class="mypkg.member.MemberDao"></jsp:useBean>
<%@include file="./../common/top.jsp" %>	
<% 
	member = mdao.getMemberById(loginfo); 
	String mpoint = Integer.toString(member.getMpoint());	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<tr>
<td colspan="1" valign="top">
	<img src="./../images/pontHome.png" width="160" height="60" > 
</td>
<td colspan="5">
	<h3 align="center">사용자 Home</h3>
	<table align="center" border="0">
		<tr>
			<td colspan="9" align="center" width="100%">
				<img src="./../images/visual_s.png" width="800" height="300">
			</td>
		</tr> 
		<tr>
			<td colspan="9">
				<br>
			</td>
		</tr> 
		<tr>
			<td> &nbsp;&nbsp;&nbsp;&nbsp; </td>
			<td> &nbsp;&nbsp;&nbsp;&nbsp; </td>
			<td> &nbsp;&nbsp;&nbsp;&nbsp; </td>
			<td> &nbsp;&nbsp;&nbsp;&nbsp; </td>
			<td> &nbsp;&nbsp;&nbsp;&nbsp; </td>
			<td> &nbsp;&nbsp;&nbsp;&nbsp; </td>
			<td> &nbsp;&nbsp;&nbsp;&nbsp; </td>
			<td> &nbsp;&nbsp;&nbsp;&nbsp; </td>
			<td align="left">
				<font size="3" face="나눔고딕">접속 ID : <%=loginfo %> </font>
				<br><br>
				<font size="3" face="나눔고딕">보유 Point : <%=mpoint %> </font>
			</td>
		</tr>
	</table>
	<br>
</td>
</tr>

<%@include file="./../common/bottom.jsp" %>	
</body>
</html>
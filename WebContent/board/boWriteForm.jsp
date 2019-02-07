<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="./../common/top.jsp" %>
<% 
	if( session.getAttribute("loginfo") == null){
		String gotopage = bo_folder + "/boWriteForm.jsp" ;
		response.sendRedirect( me_folder + "/meLoginForm.jsp?gotopage=" + gotopage) ;		
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>제목</title>
</head>
<body>
<tr>
<td colspan="1" valign="top">
	<img src="./../images/pontBoard.png" width="160" height="60" > 
</td>
<td colspan="6" align="center">
	<h3 align="center">게시물 작성</h3>
	<form action="boWriteProc.jsp" method="post">
	<table align="center" width="80%" border="1">
		<tr>
			<td width="20%" align="left">글 제목</td>
			<td width="80%" align="left"><input type="text" size="20" name="subject"></td>
		</tr>
		<tr>
			<td width="20%">작성자</td>
			<td width="80%" align="left">
				<input type="text" size="20" class="setdiaabledme" name="writer" value="<%=loginfo%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td width="20%">비번</td>
			<td width="80%" align="left"><input type="password" size="20" name="password"></td>
		</tr>
		<tr>
			<td width="20%">글 내용</td>
			<td width="80%" align="left"><input type="text" size="50" name="content"></td>
		</tr>
		<tr>
			<td width="20%">작성 일자</td>
			<td width="80%" align="left"><input type="text" name="regdate" size="20" value=""></td> 
		</tr>		
		<tr>
			<td colspan="2">
				<input type="submit" value="글쓰기">
				<input type="reset" value="취소">
			</td>
		</tr>		
	</table>
	</form>
</td>
</tr>
<%@include file="./../common/bottom.jsp" %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="./../common/top.jsp" %>
<% 
	if( session.getAttribute("loginfo") == null){
		response.sendRedirect( me_folder + "/meLoginForm.jsp") ;
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
	<h3 align="center">댓글 달기</h3>
	<form action="boReplyProc.jsp" method="post">
	
	<!-- 히든 파라미터들 -->
	<input type="hidden" name="pageNumber" value="<%=request.getParameter("pageNumber")%>">
	<input type="hidden" name="groupno" value="<%=request.getParameter("groupno")%>">
	<input type="hidden" name="orderno" value="<%=request.getParameter("orderno")%>">
	<input type="hidden" name="depth" value="<%=request.getParameter("depth")%>">
	  
	<table border="1" align="center" width="60%">
		<tr>
			<td width="20%" align="center">제목</td>
			<td width="80%" align="left">
				<input type="text" name="subject" size="20" value="">
			</td>
		</tr>
		<tr>
			<td width="20%" align="center">작성자</td>
			<td width="80%" align="left">
				<input type="text" name="writer" 
					class="setdiaabledme" size="20" readonly="readonly" value="<%=loginfo%>">
			</td>
		</tr>
		<tr>
			<td width="20%" align="center">비번</td>
			<td width="80%" align="left">
				<input type="password" size="20" name="password" value="">
			</td>
		</tr>
		<tr>
			<td width="20%" align="center">글 내용</td>
			<td width="80%" align="left">
				<input type="text" name="content" size="50" value="">
			</td>
		</tr>
		<tr>
			<td width="20%" align="center">작성 일자</td>
			<td width="80%" align="left">
				<input type="text" name="regdate" size="20" value="">
			</td> 
		</tr>		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="댓글 작성">
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
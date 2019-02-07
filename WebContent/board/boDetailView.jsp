<%@page import="mypkg.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="./../common/top.jsp" %>
<% request.setCharacterEncoding("EUC-KR") ; %>
<% 
	if( session.getAttribute("loginfo") == null){
		/* String gotopage = bo_folder + "/boDetailView.jsp" ;
		response.sendRedirect( me_folder + "/meLoginForm.jsp?gotopage=" + gotopage) ;	 */
		response.sendRedirect( me_folder + "/meLoginForm.jsp" ) ;
	}
%>
<%
	int no = Integer.parseInt( request.getParameter("no")) ;	
%>
<jsp:useBean id="bdao" class="mypkg.board.BoardDao"></jsp:useBean>
<%
	int cnt = - 1; 
	BoardBean board = bdao.getBoardByNo(no);
	
	bdao.UpdateReadHit(no) ;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>제목</title>
</head>
<body>
<tr>
<td colspan="2" valign="top">
	<img src="./../images/pontBoard.png" width="160" height="60" > 
</td>
<td colspan="6" align="center">
	<h3 align="center">게시물 상세 보기</h3>
	<table align="center" width="85%" border="1">
		<tr>
			<td width="30%" align="center">글 제목</td>
			<td width="70%" align="left"><%=board.getSubject()%></td>
		</tr>
		<tr>
			<td width="30%">작성자</td>
			<td width="70%" align="left"><%=board.getWriter()%></td>
		</tr>
		<tr>
			<td width="30%">비번</td>
			<td width="70%" align="left"><%=board.getPassword()%></td>
		</tr>
		<tr>
			<td width="30%">글 내용</td>
			<td width="70%" align="left"><%=board.getContent()%></td>
		</tr>
		<tr>
			<td width="30%">작성 일자</td>
			<td width="70%" align="left"><%=board.getRegdate()%></td> 
		</tr>		
		<tr>
			<td colspan="2">
				<input type="button" value="뒤로 가기" onclick="javascript:history.back();">
			</td>
		</tr>		
	</table>
</td>
</tr>
<%@include file="./../common/bottom.jsp" %>

</body>
</html>
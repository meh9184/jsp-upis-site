<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="./../common/top.jsp" %>
<% 
	if( session.getAttribute("loginfo") == null){
		response.sendRedirect( me_folder + "/meLoginForm.jsp") ;
	}
%>
<%
	int no = Integer.parseInt( request.getParameter("no")) ;
%>
<jsp:useBean id="bdao" class="mypkg.board.BoardDao"></jsp:useBean>
<%
	int cnt = - 1; 
	cnt = bdao.DeleteBoard(no) ;
	
	String msg = "" ;
	String pageNumber = request.getParameter("pageNumber") ; 
	String url = "boList.jsp?pageNumber=" + pageNumber ;
	
	if( cnt != -1){
		msg = "昏力 己傍" ;
	}else{
		msg = "昏力 角菩" ;
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>力格</title>
</head>
<body>
<tr>
<td colspan="5" align="center">
	<script type="text/javascript">
		alert('<%=msg%>'); 
		
		location.href='<%=url%>';
		
	</script>
</td>
</tr>
<%@include file="./../common/bottom.jsp" %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="board" class="mypkg.board.BoardBean" />
<jsp:setProperty property="*" name="board"/>
<jsp:useBean id="bdao" class="mypkg.board.BoardDao" />
<%
	int cnt = -1 ;
	cnt = bdao.UpdateBoard(board) ; 
	
	String msg = "" ;
	String url = "" ;
	String pageNumber = request.getParameter("pageNumber") ; 
	
	if(cnt != -1 ){		
		msg = "���� ����" ;
		url = "boList.jsp?pageNumber=" + pageNumber ;
	}else{
		msg = "���� ����" ;
		url = "boUpdateForm.jsp?pageNumber=" + pageNumber + "&no=" + board.getNo() ;
	}		
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>����</title>
</head>
<body>
	<script type="text/javascript">
		alert('<%=msg%>'); 
		
		location.href='<%=url%>';		
	</script>
</body>
</html>
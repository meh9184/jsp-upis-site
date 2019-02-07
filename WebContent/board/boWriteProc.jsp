<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="board" class="mypkg.board.BoardBean" />
<jsp:setProperty property="*" name="board"/>
<jsp:useBean id="bdao" class="mypkg.board.BoardDao" />
<%
	int cnt = -1 ;
	cnt = bdao.InsertBoard(board) ; 
	
	String msg = "" ;
	String url = "" ;
	
	if(cnt != -1 ){
		msg = "입력 성공" ;
		url = "boList.jsp" ;
	}else{
		msg = "입력 실패" ;
		url = "boWriteForm.jsp" ;
	}		
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>제목</title>
</head>
<body>
	<script type="text/javascript">
		alert('<%=msg%>'); 
		
		location.href='<%=url%>';
		
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("EUC-KR") ; %>

<%@page import="mypkg.member.MemberDao"%>
<%
	MemberDao dao = new MemberDao();
	
	String id = request.getParameter("id") ;
	
	int cnt = -1 ;
	
	cnt = dao.DeleteMember( id ) ;
	
	String msg = "" ;
	String url = "meList.jsp" ;
	
	if(cnt != -1 ){
		msg = "삭제 성공" ;	
	}else{
		msg = "삭제 실패" ;		
	}	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		alert('<%=msg%>'); 
		
		location.href='<%=url%>';
		
	</script>
</body>
</html>











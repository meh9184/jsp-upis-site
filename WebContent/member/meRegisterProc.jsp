<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("EUC-KR") ; %>

<%@page import="mypkg.member.MemberBean" %>
<%@page import="mypkg.member.MemberDao"%>
<%
	MemberBean member = new MemberBean() ;
	member.setAddress1( request.getParameter("address1") ) ;
	member.setAddress2( request.getParameter("address2"));
	member.setGender( request.getParameter("gender"));
	member.setHiredate( request.getParameter("hiredate")) ;
	member.setId( request.getParameter("id"));
	member.setJob( request.getParameter("job"));
	member.setMpoint( Integer.parseInt( request.getParameter("mpoint"))) ;
	member.setName( request.getParameter("name"));
	member.setPassword( request.getParameter("password"));
	member.setSalary( Integer.parseInt(request.getParameter("salary")));
	member.setZipcode( request.getParameter("zipcode"));	
	
	//체크 박스
	String[] hobbies = request.getParameterValues("hobby");
	String hobby = "" ;
	
	if( hobbies == null ){
		hobby = "체크 좀 하시지ㅜㅜ";
	}else{
		for(int i=0 ; i < hobbies.length ; i++ ){
			hobby += hobbies[i] + "/" ;
		}	
	}	
	member.setHobby( hobby ) ;	 

	MemberDao dao = new MemberDao();
	
	int cnt = -1 ;
	
	cnt = dao.InsertMember( member ) ;
	
	String msg = "" ;
	String url = "" ;
	
	if(cnt != -1 ){
		msg = "입력 성공" ;
		url = "meLoginForm.jsp" ;
	}else{
		msg = "입력 실패" ;
		url = "registerForm.jsp" ;
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











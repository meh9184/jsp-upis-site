<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("EUC-KR") ; %>
<jsp:useBean id="member" class="mypkg.member.MemberBean" />
<jsp:setProperty property="*" name="member" />
<jsp:useBean id="mdao" class="mypkg.member.MemberDao" />

<%
	String loginfo = (String)session.getAttribute("loginfo") ;
	
	//체크 박스
	String[] hobbies = request.getParameterValues("hobby");
	String hobby = "";

	if (hobbies == null) {
		hobby = "체크 좀 하시지ㅜㅜ";
	} else {
		for (int i = 0; i < hobbies.length; i++) {
			hobby += hobbies[i] + "/";
		}
	}
	member.setHobby(hobby);

	int cnt = -1;

	cnt = mdao.UpdateMember(member);

	String msg = "";
	String url = "";

	if (cnt != -1) {
		msg = "수정 성공";
		if(loginfo.equals("admin"))
		{
			url = "meList.jsp";
		}
		else
		{
			url = "me.jsp";
		}
	} else {
		msg = "수정 실패";
		url = "meUpdateForm.jsp?id="+ member.getId();
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
	</script>
	<%
		response.sendRedirect( url ) ; 
	%>
</body>
</html>
















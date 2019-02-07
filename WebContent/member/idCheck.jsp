<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="mdao" class="mypkg.member.MemberDao"></jsp:useBean>
<jsp:useBean id="member" class="mypkg.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%
	//비번은 일단 아무거나 넣어 주어야 getSelectByMember 메소드에서 오류가 발생하지 않는다.
	member.setPassword(""); 

	int result = -1;
	result = mdao.getSelectByMember(member) ;
	String comment = null ;
	if( result == -1 ){
		comment = member.getId() + "는 사용 가능한 아이디입니다" ;
 	}else{
 		comment = member.getId() + "는 이미 존재합니다." ;
	}
%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<center>
	<%=comment%>
	<br><br>
	<input type="button" value="닫기" onclick="javascript:window.close();">
</center>	
</body>
</html>
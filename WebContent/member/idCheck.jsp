<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="mdao" class="mypkg.member.MemberDao"></jsp:useBean>
<jsp:useBean id="member" class="mypkg.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%
	//����� �ϴ� �ƹ��ų� �־� �־�� getSelectByMember �޼ҵ忡�� ������ �߻����� �ʴ´�.
	member.setPassword(""); 

	int result = -1;
	result = mdao.getSelectByMember(member) ;
	String comment = null ;
	if( result == -1 ){
		comment = member.getId() + "�� ��� ������ ���̵��Դϴ�" ;
 	}else{
 		comment = member.getId() + "�� �̹� �����մϴ�." ;
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
	<input type="button" value="�ݱ�" onclick="javascript:window.close();">
</center>	
</body>
</html>
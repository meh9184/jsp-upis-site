<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("EUC-KR"); %>
<%@include file="./../common/common.jsp" %>
<jsp:useBean id="member" class="mypkg.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<jsp:useBean id="mdao" class="mypkg.member.MemberDao"></jsp:useBean>
<%
	int cnt = -1 ;
	//빈 객체를 넘겨서 회원 존재 여부를 판단하는 메소드
	cnt = mdao.getSelectByMember(member) ;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>제목</title>
</head>
<body>
<%
	switch( cnt ){
	case 0:
%>
<script type="text/javascript">
	alert('비밀 번호가 일치하지 않습니다.');
	history.back();
</script>	
<%
		break ;
	case 1:		
		session.setAttribute("loginfo", member.getId()) ;
		String gotopage = request.getParameter("gotopage") ;
		String where = ""; //어느 페이지로 갈것인가?
		String msg =""; 
		if(gotopage.equals(null) || gotopage.equals("null") || gotopage.equals("") ){
			if( member.getId().equals("admin")){ //관리자
				where = adm_folder + "/admin.jsp" ;
				msg = "관리자로 로그인 성공" ;
			}else{ //일반 사용자
				where = me_folder + "/me.jsp" ;
				msg = "로그인 성공" ;
			}
		}else{
			where = gotopage ;
		}
%>
<script type="text/javascript">	
	alert('<%=msg%>');
	location.href='<%=where%>' ;
</script>		
<%
		break ;
	case -1 :
%>
<script type="text/javascript">
	alert('존재하지 않는 아이디입니다.');
	history.back();
</script>	
<%
		break ;
	}
%>
</body>
</html>
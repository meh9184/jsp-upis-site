<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("EUC-KR"); %>
<%@include file="./../common/common.jsp" %>
<jsp:useBean id="member" class="mypkg.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<jsp:useBean id="mdao" class="mypkg.member.MemberDao"></jsp:useBean>
<%
	int cnt = -1 ;
	//�� ��ü�� �Ѱܼ� ȸ�� ���� ���θ� �Ǵ��ϴ� �޼ҵ�
	cnt = mdao.getSelectByMember(member) ;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>����</title>
</head>
<body>
<%
	switch( cnt ){
	case 0:
%>
<script type="text/javascript">
	alert('��� ��ȣ�� ��ġ���� �ʽ��ϴ�.');
	history.back();
</script>	
<%
		break ;
	case 1:		
		session.setAttribute("loginfo", member.getId()) ;
		String gotopage = request.getParameter("gotopage") ;
		String where = ""; //��� �������� �����ΰ�?
		String msg =""; 
		if(gotopage.equals(null) || gotopage.equals("null") || gotopage.equals("") ){
			if( member.getId().equals("admin")){ //������
				where = adm_folder + "/admin.jsp" ;
				msg = "�����ڷ� �α��� ����" ;
			}else{ //�Ϲ� �����
				where = me_folder + "/me.jsp" ;
				msg = "�α��� ����" ;
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
	alert('�������� �ʴ� ���̵��Դϴ�.');
	history.back();
</script>	
<%
		break ;
	}
%>
</body>
</html>
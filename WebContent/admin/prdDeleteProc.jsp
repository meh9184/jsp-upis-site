<%@page import="mypkg.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("EUC-KR"); %>
<%@include file="./../common/common.jsp"%>
<jsp:useBean id="pdao" class="my.shop.ProductDao"></jsp:useBean>
<%
	int num = Integer.parseInt( request.getParameter("num")) ;
	String image = request.getParameter("image");
	
	//delFile ���� : �� ���� �󿡼� �����Ǿ�� �� ���� �̸� 
	String delFile = saveDirectory + "\\" + image ;
	//out.println( num + "<br>" ) ;
	//out.println( delFile + "<br>" ) ;
	
	int cnt = -1 ;
	cnt = pdao.DeleteProduct( num ) ;
	
	//�ش� ������ ������ �����Ѵٸ� ������ �����ϵ��� �Ѵ�.
	boolean bool =  FileUtil.DeleteFile( delFile ) ;
	out.println( bool + "<br>" ) ;
	
	String url = "", msg = "" ; 
	url = "prdList.jsp" ;
	if(cnt != -1 && bool ){
		//��񿡼� �����Ǹ� -1�� �ƴϰ�, ������ ���� �Ǿ��ٸ� bool = true�̴�.
		msg = "��ǰ ���� ����" ;
	}else{
		msg = "��ǰ ���� ����" ;
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
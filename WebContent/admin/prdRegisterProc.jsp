<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@include file="./../common/common.jsp"%>
<% request.setCharacterEncoding("EUC-KR") ; %>
<%
	//out.print( saveDirectory );
	//WebContent ���� ������ images ���� ������ ��������.
	int maxUpsize = 10 * 1024 * 1024 ; 
	String encStr = "EUC-KR" ;
	String loginfo = (String)session.getAttribute("loginfo") ;
	
	//DefaultFileRenamePolicy Ŭ���� : FileRenamePolicy �������̽��� ������ �� Ŭ���� 	
	out.print( "���� �̹��� ���ε�� ��� : <br>" + saveDirectory ) ;

	MultipartRequest mr = new MultipartRequest(
			request,
			saveDirectory, 
			maxUpsize, 
			encStr, 
			new DefaultFileRenamePolicy() );
%>
<jsp:useBean id="pdao" class="my.shop.ProductDao"></jsp:useBean>
<%
	int cnt = -1 ;
	cnt = pdao.InsertProduct( mr ) ;
	
	String url = "", msg = "" ; 
	if(cnt != -1){
		if(loginfo.equals("admin"))
			url = "prdList.jsp" ;
		else
			url = "./../mall/mallMain.jsp" ;
		msg = "��ǰ ��� ����" ;
	}else{
		url = "prdRegisterForm.jsp" ;
		msg = "��ǰ ��� ����" ;
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
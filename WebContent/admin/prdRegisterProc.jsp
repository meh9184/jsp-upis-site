<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@include file="./../common/common.jsp"%>
<% request.setCharacterEncoding("EUC-KR") ; %>
<%
	//out.print( saveDirectory );
	//WebContent 폴더 하위에 images 폴더 생성해 놓으세요.
	int maxUpsize = 10 * 1024 * 1024 ; 
	String encStr = "EUC-KR" ;
	String loginfo = (String)session.getAttribute("loginfo") ;
	
	//DefaultFileRenamePolicy 클래스 : FileRenamePolicy 인터페이스를 구현해 둔 클래스 	
	out.print( "실제 이미지 업로드될 경로 : <br>" + saveDirectory ) ;

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
		msg = "상품 등록 성공" ;
	}else{
		url = "prdRegisterForm.jsp" ;
		msg = "상품 등록 실패" ;
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
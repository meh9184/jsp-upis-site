<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@include file="./../common/common.jsp"%>
<% request.setCharacterEncoding("EUC-KR") ; %>
<%
	//out.print( saveDirectory );
	//oldImage 정보는 따로 변수에 저장한다.
	String oldImage = request.getParameter("oldImage") ;
	String image = request.getParameter("image") ;
	//out.print( oldImage + "/" + image ) ;

	int maxUpSize = 10 * 1024 *1024 ;
	String encStr = "EUC-KR" ;
	MultipartRequest mr = new MultipartRequest(
			request,
			saveDirectory, 
			maxUpSize, 
			encStr, 
			new DefaultFileRenamePolicy() );
%>
<jsp:useBean id="pdao" class="my.shop.ProductDao"></jsp:useBean>
<%
	int cnt = -1 ;
	cnt = pdao.UpdateProduct( mr ) ;
	
	String url = "", msg = "" ; 
	if(cnt != -1){
		url = "prdList.jsp" ;
		msg = "상품 수정 성공" ;
	}else{
		url = "prdUpdateForm.jsp" ;
		msg = "상품 수정 실패" ;
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
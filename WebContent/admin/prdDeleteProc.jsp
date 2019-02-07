<%@page import="mypkg.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("EUC-KR"); %>
<%@include file="./../common/common.jsp"%>
<jsp:useBean id="pdao" class="my.shop.ProductDao"></jsp:useBean>
<%
	int num = Integer.parseInt( request.getParameter("num")) ;
	String image = request.getParameter("image");
	
	//delFile 변수 : 웹 서버 상에서 삭제되어야 할 파일 이름 
	String delFile = saveDirectory + "\\" + image ;
	//out.println( num + "<br>" ) ;
	//out.println( delFile + "<br>" ) ;
	
	int cnt = -1 ;
	cnt = pdao.DeleteProduct( num ) ;
	
	//해당 폴더에 파일이 존재한다면 파일을 삭제하도록 한다.
	boolean bool =  FileUtil.DeleteFile( delFile ) ;
	out.println( bool + "<br>" ) ;
	
	String url = "", msg = "" ; 
	url = "prdList.jsp" ;
	if(cnt != -1 && bool ){
		//디비에서 삭제되면 -1이 아니고, 파일이 삭제 되었다면 bool = true이다.
		msg = "상품 삭제 성공" ;
	}else{
		msg = "상품 삭제 성공" ;
	}	
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>제목</title>
</head>
<body>
	<script type="text/javascript">
		alert('<%=msg%>'); 	
		location.href='<%=url%>';	
	</script>
</body>
</html>
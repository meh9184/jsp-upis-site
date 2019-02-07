<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//cnum : 삭제될 카테고리 번호
	int cnum = Integer.parseInt( request.getParameter("cnum")) ;
%>
<jsp:useBean id="cdao" class="my.shop.CategoryDao"></jsp:useBean>
<%
	int cnt = - 1; 
	cnt = cdao.DeleteCategory(cnum)  ;
	
	String msg = "" ;
	String url = "catList.jsp" ;
	
	if( cnt != -1){
		msg = "카테고리 삭제 성공" ;
	}else{
		msg = "카테고리 삭제 실패" ;
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
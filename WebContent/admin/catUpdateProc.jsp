<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="category" class="my.shop.CategoryBean"/>
<jsp:setProperty property="*" name="category"/>
<jsp:useBean id="cdao" class="my.shop.CategoryDao"/>
<%
	int cnt = -1 ;
	cnt = cdao.UpdateCategoy(category) ;
	
	String url = "", msg = "" ; 
	if(cnt != -1){
		url = "catList.jsp" ;
		msg = "카테고리 수정 성공" ;
	}else{
		url = "catUpdateForm.jsp" ;
		msg = "카테고리 수정 실패" ;
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
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="adm_top.jsp"%>
<jsp:useBean id="category" class="my.shop.CategoryBean"/>
<jsp:useBean id="cdao" class="my.shop.CategoryDao"/>
<%
	int cnum = Integer.parseInt(request.getParameter("cnum")) ;
	category = cdao.getCategoryByCnum( cnum ) ;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<tr>
<td colspan="6">
	<h3 align="center">카테고리 수정</h3>
	<form action="catUpdateProc.jsp" method="post">
	<input type="hidden" name="cnum" value="<%=category.getCnum()%>"> 
	<table align="center">
		<tr>
			<td align="center" width="30%">카테고리 코드</td>
			<td width="70%"><input type="text" name="code" value="<%=category.getCode()%>"></td>
		</tr>
		<tr>
			<td align="center">카테고리 이름</td>
			<td><input type="text" name="cname" value="<%=category.getCname()%>"></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="submit" value="등록">
				<input type="reset" value="취소">
			</td>
		</tr>		
	</table>
	</form>
</td>
</tr>
<%@include file="adm_bottom.jsp"%>
</body>
</html>
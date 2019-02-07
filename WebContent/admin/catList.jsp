<%@page import="my.shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="adm_top.jsp"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="cdao" class="my.shop.CategoryDao"/>
<%
	ArrayList<CategoryBean> lists = cdao.getAllCategory() ; 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<tr>

<td colspan="1" valign="top">
	<img src="./../images/pontCatList.png" width="160" height="60" > 
	<br> <br> <br>
	<a href="<%=adm_folder%>/catList.jsp">- 카테고리 목록</a>
	<br> <br>
	<a href="<%=adm_folder%>/catRegisterForm.jsp">- 카테고리 등록</a>
	<br> <br>
	<a href="<%=adm_folder%>/prdList.jsp">- 상품 목록</a>
	<br> <br>
	<a href="<%=adm_folder%>/prdRegisterForm.jsp">- 상품 등록</a>	
</td>

<td colspan="5">
	<h3 align="center">카테고리 목록</h3>
	<table align="center">
		<%=sep_category_list%>
		<tr>
			<td>번호</td>
			<td>코드</td>			
			<td>이름</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
		<%=sep_category_list%>
		<%
			if( lists.size() == 0){
		%>
		<tr>
			<td colspan="3">
				카테고리가 존재하지 않습니다.
			</td>
		</tr>
		<% 
			}else{
				for(CategoryBean category : lists){
		%>
		<tr>
			<td><%=category.getCnum()%></td>
			<td><%=category.getCode()%></td>
			<td><%=category.getCname()%></td>
			<td><a href="catUpdateForm.jsp?cnum=<%=category.getCnum()%>">수정</a></td>
			<td><a href="catDeleteProc.jsp?cnum=<%=category.getCnum()%>">삭제</a></td>
		</tr>
		<%=sep_category_list%>
		<% 
				}
			}
		%>				
	</table>
</td>
</tr>
<%@include file="adm_bottom.jsp"%>
</body>
</html>
<%@page import="mypkg.member.MemberBean"%>
<%@page import="mypkg.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="./../common/top.jsp" %>
<% request.setCharacterEncoding("EUC-KR") ; %>

<%
	String id = request.getParameter("id") ;
	MemberDao dao = new MemberDao();	
	MemberBean member = dao.getMemberById( id ) ;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>회원 수정 </title>
	<script type="text/javascript" src="script.js"></script>
</head>
<body> 	

<tr>
<% 
	if( loginfo.equals("admin")){
%>
<td colspan="2" valign="top">
	<img src="./../images/pontUpdate.png" width="160" height="60" > 
	<br> <br> <br>
	<a href="<%=me_folder%>/meList.jsp">- 회원 목록 조회</a>
	<br> <br>
	<a href="<%=mall_folder%>/shopping_list.jsp">- 주문 내역 조회</a>
</td>
<% 
	}else{
%>
<td colspan="2" valign="top">
	<img src="./../images/pontUpdate.png" width="160" height="60" > 
	<br> <br> <br>
	<%=mem2%>
	<br> <br>
	<a href="<%=mall_folder%>/shopping_list.jsp">- 주문 내역 조회</a>
</td>
<% 
	}
%>
<td colspan="5" >
	
	<h3 align="center">회원 수정 </h3>
	<form action="meUpdateProc.jsp" method="post" name="myform">
	<input type="hidden" name="mpoint" value="30">
	<table border="1" align="center" width="70%">
		<tr>
			<td width="25%" align="center">아이디</td>
			<td width="75%" align="left">
				<input type="text" name="id" class="setdiaabledme" readonly="readonly" value="<%=member.getId()%>">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">이름</td>
			<td width="75%" align="left">
				<input type="text" name="name" value="<%=member.getName()%>">
			</td>
		</tr>
		<tr>
			<td align="center">비밀 번호</td>
			<td width="75%" align="left"><input type="password" name="password" value=""></td>
		</tr>
		<tr>
			<td width="25%" align="center">학번</td>
			<td width="75%" align="left">
				<input type="text" name="salary" value="<%=member.getSalary()%>">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">생년 월일</td>
			<td width="75%" align="left">
				<input type="text" name="hiredate" value="<%=member.getHiredate()%>">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">성별</td>
			<td width="75%" align="left">
				<input type="radio" name="gender" value="남" checked="checked">남자
				<input type="radio" name="gender" value="여">여자
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">취미</td>
			<td width="75%" align="left">
				<input type="checkbox" name="hobby" value="운동">운동
				<input type="checkbox" name="hobby" value="음악감상" checked="checked">음악감상
				<input type="checkbox" name="hobby" value="공부">공부
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">직업</td>
			<td width="75%" align="left">
				<select name="job">
					<option value="-" selected="selected">-- 선택하세요 --
					<option value="교수">교수
					<option value="학생">학생
					<option value="기타">기타
				</select>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">우편 번호</td>
			<td width="75%" align="left">
				<input type="text"  class="setdiaabledme" name="zipcode" value="<%=member.getZipcode()%>">
				<input type="button" value="우편 번호 찾기" onclick="zipCheck();">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">주소</td>
			<td width="75%" align="left">
				<input type="text"  class="setdiaabledme" size="50" name="address1" value="<%=member.getAddress1()%>">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">세부 주소</td>
			<td width="75%" align="left">
				<input type="text" name="address2" size="50" value="<%=member.getAddress2()%>">
			</td>
		</tr>		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정하기">
				<input type="reset" value="취소">
			</td>
		</tr>	
	</table>	
	</form>
</td>	
</tr>	
<%@include file="./../common/bottom.jsp" %>
</body>
</html>
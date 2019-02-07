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
	<title>상세 보기</title>
	<script type="text/javascript">
		function back(){
			history.back() ;	
		}
	</script>
</head>
<body>
<tr>
<td colspan="5" align="center">
	<h3 align="center">상세 보기</h3>	
	<table border="1" align="center" width="70%">
		<tr>
			<td width="25%" align="center">아이디</td>
			<td width="75%" align="left">
				<%=member.getId()%>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">이름</td>
			<td width="75%" align="left">
				<%=member.getName()%>
			</td>
		</tr>
		<tr>
			<td align="center">비밀 번호</td>
			<td width="75%" align="left"><%=member.getPassword()%></td>
		</tr>
		<tr>
			<td width="25%" align="center">학번</td>
			<td width="75%" align="left">
				<%=member.getSalary()%>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">생년 월일</td>
			<td width="75%" align="left">
				<%=member.getHiredate()%>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">성별</td>
			<td width="75%" align="left">
				<%=member.getGender()%>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">취미</td>
			<td width="75%" align="left">
				<%=member.getHobby()%>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">직업</td>
			<td width="75%" align="left">
				<%=member.getJob()%>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">우편 번호</td>
			<td width="75%" align="left">
				<%=member.getZipcode()%>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">주소</td>
			<td width="75%" align="left">
				<%=member.getAddress1()%>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">세부 주소</td>
			<td width="75%" align="left">
				<%=member.getAddress2()%>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">포인트</td>
			<td width="75%" align="left">
				<%=member.getMpoint()%>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="뒤로 가기" 
					onclick="back();">
			</td>
		</tr>	
	</table>	
	</form>
</td>	
</tr>
<%@include file="./../common/bottom.jsp" %>	
</body>
</html>
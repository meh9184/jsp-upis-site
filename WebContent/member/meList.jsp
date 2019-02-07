<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("EUC-KR"); %>

<%@page import="mypkg.member.MemberDao" %>
<%@page import="mypkg.member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="./../common/top.jsp" %>
<%
	MemberDao dao = new MemberDao();
	ArrayList<MemberBean> lists = dao.getMemberList();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>meList.jsp</title>
</head>
<body>

<td colspan="1" valign="top">
	<img src="./../images/pontMemberList.png" width="160" height="60" > 
	<br> <br> <br>
	<a href="<%=me_folder%>/meList.jsp">- 회원 목록 조회</a>
	<br> <br>
	<a href="<%=mall_folder%>/shopping_list.jsp">- 주문 내역 조회</a>
</td>

<td colspan="5">
	<h3 align="center">회원 목록 조회</h3>
	<table align="center" border="0">
		<tr>
			<td align="center">아이디</td> <td>&nbsp;</td>
			<td align="center">이름</td> <td>&nbsp;</td>
			<td align="center">생년월일</td> <td>&nbsp;</td>
			<td align="center">성별</td> <td>&nbsp;</td>
			<td align="center">직업</td> <td>&nbsp;</td>
			<td align="center">포인트</td> <td>&nbsp;</td>
			<td align="center">삭제</td> <td>&nbsp;</td>
			<td align="center">수정</td> <td>&nbsp;</td>
		</tr>
		<tr>
		<%=separator%>
		</tr>
		<%
			if( lists.size() == 0 ){
		%>
		<tr>
			<td colspan="11">
				데이터 없음
			</td>
		</tr>
		<% 
			}else{
				for(MemberBean member : lists){
		%>
		<tr>
			<td align="center"><%=member.getId()%></td> <td>&nbsp;</td>
			<td align="center">
				<a href="meDetailView.jsp?id=<%=member.getId()%>">
					<%=member.getName()%>
				</a>
			</td> <td>&nbsp;</td>
			<td align="center"><%=member.getHiredate()%></td> <td>&nbsp;</td>
			<td align="center"><%=member.getGender()%></td> <td>&nbsp;</td>
			<td align="center"><%=member.getJob()%></td> <td>&nbsp;</td>
			<td align="center"><%=member.getMpoint()%></td> <td>&nbsp;</td>
			<td align="center"><a href="meDeleteProc.jsp?id=<%=member.getId()%>">삭제</a></td> <td>&nbsp;</td>
			<td align="center"><a href="meUpdateForm.jsp?id=<%=member.getId()%>">수정</a></td>   		
		</tr>
		<tr>
		<%=separator%>
		</tr>
		<% 
				}
			}
		%>
	</table>
</td>
<%@ include file="./../common/bottom.jsp" %>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="./../common/common.jsp"%>
<%
	String loginfo = (String)session.getAttribute("loginfo") ;
	String log = "", mem = "" , mem2 = "" ; 
	
	if( loginfo == null ){ //로그인한 사람이 없다.
		log = "<a href='" + me_folder + "/meLoginForm.jsp'><img src=\"./../images/btnLogout.png\" width=\"90\" height=\"30\" ></a>"	;
		mem = "<a href='" + me_folder + "/meRegisterForm.jsp'>회원 가입</a>" ;
		loginfo = "없음" ; 
		
	}else{ //누군가 로그인 했다.
		log = "<a href='" + me_folder + "/meLogout.jsp'><img src=\"./../images/btnLogout.png\" width=\"90\" height=\"30\" ></a>"	;
		mem = "<a href='" + me_folder + "/meUpdateForm.jsp?id=" + loginfo + "'><img src=\"./../images/btnMyPage.png\" width=\"150\" height=\"50\"></a>" ;		
		mem2= "<a href='" + me_folder + "/meUpdateForm.jsp?id=" + loginfo + "'>- 회원 정보 수정</a>" ;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>U.P.I.S</title>
<style type="text/css">
body {
<% if(loginfo.equals("admin")){ %>
	background-image: url(./../images/bg_admin.jpg);
<% }else{ %> 
	background-image: url(./../images/bg_nomal.jpg);
<% } %>
	background-repeat: repeat-x;
	background-attachment: fixed;
	background-position: left bottom;
}

</style>
</head>
<body>
	<table align="center" border="0"width="80%">
		<tr>
			<td align="right" ><%=log%> 
			</td>
		</tr>
	</table>
	<table border="0" cellspacing="10" cellpadding="15" width="80%" align="center">
<%
	if(loginfo.equals("admin")){
%>
	<tr>
		<td align="center"> <a href="<%=adm_folder%>/admin.jsp"> <img src="./../images/logo.png" width="200" height="75" > </a></td>
		<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td align="center"  width="25%"><a href="<%=mall_folder%>/mallMain.jsp"> <img src="./../images/btnMall.png" width="140" height="50" > </a></td>	
		<td align="center"  width="25%"><a href="<%=bo_folder%>/boList.jsp"> <img src="./../images/btnBoard.png" width="140" height="50" > </a></td>
		<td align="center"  width="25%"><a href="<%=me_folder%>/meList.jsp"> <img src="./../images/btnSearch.png" width="140" height="50" > </a></td>	
		<td align="center"  width="25%"><a href="<%=adm_folder%>/catList.jsp"> <img src="./../images/btnManagement.png" width="140" height="50" > </a></td>
	</tr>
<%
	}else{
%> 
	<tr>
		<td align="center"> <a href="<%=me_folder%>/me.jsp"> <img src="./../images/logo.png" width="230" height="75" > </a></td>
		<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td align="center"  width="25%"><a href="<%=mall_folder%>/mallMain.jsp"> <img src="./../images/btnMall.png" width="140" height="50" > </a></td>	
		<td align="center"  width="25%"><a href="<%=bo_folder%>/boList.jsp">  <img src="./../images/btnBoard.png" width="140" height="50" > </a></td>
		<td align="center"  width="25%"><a href="<%=mall_folder%>/mallCartList.jsp">  <img src="./../images/btnCart.png" width="140" height="50" >  </a></td>	
		<td align="center"  width="25%"><%=mem%></td>
	</tr>
<%
	}
%>
</body>
</html>
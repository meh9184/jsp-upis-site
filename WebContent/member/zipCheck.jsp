<%@page import="mypkg.board.Paging"%>
<%@page import="mypkg.ZipcodeBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="mzip" class="mypkg.ZipcodeDao"/>
<%	
	String finddong = request.getParameter("dong");

	/* String pageNumber = request.getParameter("pageNumber") ;
	String pageSize = request.getParameter("pageSize") ;
	int totalCount = mzip.getTotalCount( finddong ) ;
	String url = "zipCheck.jsp" ;
	
	Paging pageInfo = new Paging( pageNumber,  pageSize, totalCount, url); */

	Vector<ZipcodeBean> zipcodeList = mzip.getZipcodeList(finddong);
	//Vector<ZipcodeBean> zipcodeList = mzip.getZipcodeList(finddong, pageInfo.getBeginRow(), pageInfo.getEndRow());
	//if(zipcodeList == null){out.print("zipcodeList가 널이야"); }
	int totalSize = zipcodeList.size(); 
	//out.print("총 검색된 우편 번호 갯수 : " + totalSize ) ;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script language="JavaScript" src="script.js"></script>
</head>
<body bgcolor="#FFFFCC">
<center>
<!-- 검색 버튼 결과를 자신에게 보여주므로 action 속성은 자신의 이름 -->
<b>우편 번호 찾기</b>
<form name="zipForm" method="post" action="zipCheck.jsp">
<table>
	<tr>
		<td><br>
			동이름 입력 : <input name="dong" type="text" value="">
			<input type="button" value="검색" onclick="dongCheck();">
		</td>
	</tr>	
<%
	if ( totalSize > 0 ) {//항목이 존재하는 경우
		for(int i = 0 ; i < totalSize ; i++){
			ZipcodeBean zipBean = (ZipcodeBean)zipcodeList.elementAt(i);
			String zipcode = zipBean.getZipcode();
			String sido = zipBean.getSido().trim();
			String gugun = zipBean.getGugun().trim();
			String dong = zipBean.getDong().trim();
			String bunji = zipBean.getBunji().trim();
			String address = sido + " " + gugun + " " + dong + " " + bunji ;
%>
	<tr>
		<td align="left">
			<a href="javascript:sendAddress('<%=zipcode%>','<%=address%>')">
				<%=zipcode%>&nbsp;<%=address%>
			</a>
		</td>
	</tr>	
<%
		}//end for
%>
	<tr>
		<td align="center">
			<br><a href="javascript:this.close();">닫기</a>
		</td>
	</tr>	
<% 
	}else{
%>
	<tr><td align="center"><br>검색된 결과가 없습니다.</td></tr>
<%
	}
%>
</table>	

</form>
</center>
</body>
</html>
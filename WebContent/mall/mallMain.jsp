<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="mall_top.jsp"%>
<% 
	if( session.getAttribute("loginfo") == null){
		//로그인한 정보가 없으면, 로그인 페이지로 이동하세요.
		//여기서 gotopage 변수는, 로그인을 하고 나서 다시 이동할 페이지를 의미한다.
		String gotopage = mall_folder + "/mallMain.jsp" ;
		response.sendRedirect( me_folder + "/meLoginForm.jsp?gotopage=" + gotopage) ;
	}
%>
<%@page import="my.shop.ProductBean"%>
<jsp:useBean id="pdao" class="my.shop.ProductDao"></jsp:useBean>
<% 

	//사용자가 좌측 메뉴의 카테고리 리스트 중에 1개를 눌렀다.
	String category = request.getParameter("category") ;  
	
	if(category == null){ //파라미터가 넘어 오지 않는 경우에는 전체(all)를 본다
		category = "all" ;	
	}
	
	int colsu = 5 ; //테이블 태그의 열(column)수		
	request.setAttribute("category", category) ;
	request.setAttribute("colsu", colsu) ;
	
	//viewPage : 해당 상품을 클릭했을 때 이동할 페이지
	request.setAttribute("viewPage", "mallProductView.jsp") ;
	
	//stable : <table> 태그 형식의 상품 목록 리스트
	String stable = pdao.SelectByCategory( request );
		 
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>쇼핑몰 </title>
	<script type="text/javascript" src="script.js"></script>
</head>
<body>
<tr>
	<td valign="top" width="20%">		
		<img src="./../images/pontMall.png" width="160" height="60" > 
		<div id="tree">
		</div>
	</td> 
	<td colspan="5" width="80%">
		<h3 align="center">쇼핑몰 </h3>
		<div id="contents">
			<%=stable%>
		</div>
		<% if( ! loginfo.equals("admin") ) { %>	
		<a href="<%=adm_folder%>/prdRegisterForm.jsp"> <img src="./../images/prdRegisterBtn.png" width="90" height="40"> </a>
		<%} %>
	</td>
<%@ include file="mall_bottom.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="mall_top.jsp"%>
<% 
	if( session.getAttribute("loginfo") == null){
		//�α����� ������ ������, �α��� �������� �̵��ϼ���.
		//���⼭ gotopage ������, �α����� �ϰ� ���� �ٽ� �̵��� �������� �ǹ��Ѵ�.
		String gotopage = mall_folder + "/mallMain.jsp" ;
		response.sendRedirect( me_folder + "/meLoginForm.jsp?gotopage=" + gotopage) ;
	}
%>
<%@page import="my.shop.ProductBean"%>
<jsp:useBean id="pdao" class="my.shop.ProductDao"></jsp:useBean>
<% 

	//����ڰ� ���� �޴��� ī�װ� ����Ʈ �߿� 1���� ������.
	String category = request.getParameter("category") ;  
	
	if(category == null){ //�Ķ���Ͱ� �Ѿ� ���� �ʴ� ��쿡�� ��ü(all)�� ����
		category = "all" ;	
	}
	
	int colsu = 5 ; //���̺� �±��� ��(column)��		
	request.setAttribute("category", category) ;
	request.setAttribute("colsu", colsu) ;
	
	//viewPage : �ش� ��ǰ�� Ŭ������ �� �̵��� ������
	request.setAttribute("viewPage", "mallProductView.jsp") ;
	
	//stable : <table> �±� ������ ��ǰ ��� ����Ʈ
	String stable = pdao.SelectByCategory( request );
		 
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>���θ� </title>
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
		<h3 align="center">���θ� </h3>
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
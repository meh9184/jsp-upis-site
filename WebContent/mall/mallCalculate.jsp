<%@page import="mypkg.member.MemberBean"%>
<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="odao" class="my.shop.OrderDao"></jsp:useBean>
<%@ include file="./../common/common.jsp" %>
<%@ include file="mallCartSession.jsp" %>
<% 
	//mid : ���ǿ� �����ϴ� ȸ�� ���̵�
	//loginfo : �α��� �ÿ� ���� ������ �����͸� �����߾���.
	String mid = (String)session.getAttribute("loginfo") ; //loginfo
	Vector<ProductBean> carts = (Vector)session.getAttribute("carts");
	int cnt = -1;
	
	//ȸ���� ���̵�� �ֹ� ����Ʈ�� �Ѱܼ� ����Ѵ�.
	cnt = odao.InsertOrder(mid, carts) ;
	
	String msg ;
	String url ;		
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% 
	if(cnt != -1){
		msg = "�ֹ� �Ϸ��߽��ϴ�." ;
		url = "mall_main.jsp" ;
		//����� ��������, �� īƮ�� ���빰�� ��쵵�� �Ѵ�.
		session.removeAttribute("carts") ;
		
		// vector���� �����͸� �����.
		mycart.RemoveAllProduct(); 
%>
<script type="text/javascript">
	alert("<%=msg%>");
	var resp = confirm('����Ͻðڽ��ϱ�?') ;
	if(resp){ /* ��� �����Ϸ��� ���θ� ���� ȭ������ �̵� */ 
		location.href = "<%=mall_folder%>/mallMain.jsp" ;
	}else{
		location.href = "<%=me_folder%>/meLogout.jsp" ;
	}	
</script>
<%
	}else{
		msg = "�ֹ� ����" ;
		url = mall_folder + "/mallMain.jsp" ;
		response.sendRedirect( url ) ;	
	}
%>
</body>
</html>
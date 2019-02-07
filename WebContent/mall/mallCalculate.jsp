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
	//mid : 세션에 존재하는 회원 아이디
	//loginfo : 로그인 시에 세션 영역에 데이터를 저장했었다.
	String mid = (String)session.getAttribute("loginfo") ; //loginfo
	Vector<ProductBean> carts = (Vector)session.getAttribute("carts");
	int cnt = -1;
	
	//회원의 아이디와 주문 리스트를 넘겨서 계산한다.
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
		msg = "주문 완료했습니다." ;
		url = "mall_main.jsp" ;
		//계산이 끝났으니, 내 카트의 내용물을 비우도록 한다.
		session.removeAttribute("carts") ;
		
		// vector안의 데이터를 지운다.
		mycart.RemoveAllProduct(); 
%>
<script type="text/javascript">
	alert("<%=msg%>");
	var resp = confirm('계속하시겠습니까?') ;
	if(resp){ /* 계속 쇼핑하려면 쇼핑몰 메인 화면으로 이동 */ 
		location.href = "<%=mall_folder%>/mallMain.jsp" ;
	}else{
		location.href = "<%=me_folder%>/meLogout.jsp" ;
	}	
</script>
<%
	}else{
		msg = "주문 실패" ;
		url = mall_folder + "/mallMain.jsp" ;
		response.sendRedirect( url ) ;	
	}
%>
</body>
</html>
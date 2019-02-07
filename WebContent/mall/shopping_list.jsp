<%@page import="my.shop.OrderList"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="./../admin/adm_top.jsp"%>
<jsp:useBean id="odao" class="my.shop.OrderDao" />
<%
	request.setCharacterEncoding("EUC-KR") ;
	String mid = request.getParameter("memid") ;
	String startdate = request.getParameter("startdate") ; //검색 시작 일자
	String enddate = request.getParameter("enddate") ; //검색 종료 일자
	
	if( startdate == null || enddate == null){
		startdate = null ;
		enddate = null ;
	}
	
	//orderlists : 해당 사원이 검색 기간 내에 구매했던 내역
	Vector<OrderList> orderlists = null ;
	if(mid != null){
		orderlists = odao.getOrderList(mid, startdate, enddate) ;	
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript">
		function check(){
			var memid = document.myform.memid.value ;
			if(memid.length <= 0){
				alert('아이디를 입력해 주세요');
				document.myform.memid.focus();
				return false ;
			}
		}
	</script>
</head>
<body>
<tr>
<td colspan="1" valign="top">
	<% 
		if( loginfo.equals("admin")){
	%>
	<img src="./../images/pontSearch.png" width="160" height="60" > 
	<br> <br> <br>
	<a href="<%=me_folder%>/meList.jsp">- 회원 목록 조회</a>
	<% 
		}else{
	%>
	<img src="./../images/pontSearch.png" width="160" height="60" > 
	<br> <br> <br>
	<%=mem2%>
	<% 
		}
	%>
	<br> <br>
	<a href="<%=mall_folder%>/shopping_list.jsp">- 주문 내역 조회</a>
</td>

<td colspan="6" valign="top" align="center">
	<h3 align="center">주문 내역</h3>
	<table border=1>
	<tr>
		<td colspan="6">
			<form action="shopping_list.jsp" method="post" name="myform">
				회원 id :  
				<input type="text" name="memid" value="<%=loginfo%>">
				<input type="text" name="startdate" value="2014/01/01">
				&nbsp; ~ &nbsp;
				<input type="text" name="enddate" value="2016/01/01">
				<input type="submit" value="내역 조회" onclick="return check();">
			</form>
		</td>
	</tr>
	<tr bgcolor="<%=color_seashell%>">
		<td colspan="6" align="left">
			고객 아이디 : <%=mid%>
		</td>
	</tr>
	<tr>
		<td align="center">주문 번호</td>
		<td align="center">판매 일자</td>
		<td align="center">상품명</td>
		<td align="center">단가</td>
		<td align="center">수량</td>
		<td align="center">금액</td>
	</tr>
	<% 
		if( orderlists == null || orderlists.size() == 0 ){
	%>
	<tr bgcolor="<%=color_seashell%>">
		<td colspan="6">
			해당 사원에 대한 주문 내역이 존재하지 않습니다.
		</td>
	</tr>
	
	<%			
		}else{
			for(OrderList order : orderlists){
	%>
	<tr bgcolor="<%=color_seashell%>">
		<td><%=order.getOid()%></td>	
		<td><%=order.getOrderdate()%></td>
		<td><%=order.getPname()%></td>
		<td align="right"><%=df.format(order.getPrice())%></td>	
		<td align="right"><%=df.format(order.getQty())%></td>
		<td align="right"><%=df.format(order.getAmount())%></td>
	</tr>
	<%
			}	
		}
	%>
	</table>
</td>

</tr>
<%@include file="./../admin/adm_bottom.jsp"%>
</body>
</html>
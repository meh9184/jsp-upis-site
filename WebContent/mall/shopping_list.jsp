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
	String startdate = request.getParameter("startdate") ; //�˻� ���� ����
	String enddate = request.getParameter("enddate") ; //�˻� ���� ����
	
	if( startdate == null || enddate == null){
		startdate = null ;
		enddate = null ;
	}
	
	//orderlists : �ش� ����� �˻� �Ⱓ ���� �����ߴ� ����
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
				alert('���̵� �Է��� �ּ���');
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
	<a href="<%=me_folder%>/meList.jsp">- ȸ�� ��� ��ȸ</a>
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
	<a href="<%=mall_folder%>/shopping_list.jsp">- �ֹ� ���� ��ȸ</a>
</td>

<td colspan="6" valign="top" align="center">
	<h3 align="center">�ֹ� ����</h3>
	<table border=1>
	<tr>
		<td colspan="6">
			<form action="shopping_list.jsp" method="post" name="myform">
				ȸ�� id :  
				<input type="text" name="memid" value="<%=loginfo%>">
				<input type="text" name="startdate" value="2014/01/01">
				&nbsp; ~ &nbsp;
				<input type="text" name="enddate" value="2016/01/01">
				<input type="submit" value="���� ��ȸ" onclick="return check();">
			</form>
		</td>
	</tr>
	<tr bgcolor="<%=color_seashell%>">
		<td colspan="6" align="left">
			�� ���̵� : <%=mid%>
		</td>
	</tr>
	<tr>
		<td align="center">�ֹ� ��ȣ</td>
		<td align="center">�Ǹ� ����</td>
		<td align="center">��ǰ��</td>
		<td align="center">�ܰ�</td>
		<td align="center">����</td>
		<td align="center">�ݾ�</td>
	</tr>
	<% 
		if( orderlists == null || orderlists.size() == 0 ){
	%>
	<tr bgcolor="<%=color_seashell%>">
		<td colspan="6">
			�ش� ����� ���� �ֹ� ������ �������� �ʽ��ϴ�.
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
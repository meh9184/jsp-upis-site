<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="adm_top.jsp"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="pdao" class="my.shop.ProductDao"/>
<%
	ArrayList<ProductBean> lists = pdao.getAllProduct() ; 
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript">
		function prdUpdate( num ){
			var resp = confirm('수정하시겠습니까?') ;
			if( resp ){				
				location.href='prdUpdateForm.jsp?num=' + num ;
			}else{
				alert( '수정을 취소하셨습니다') ;
			}
		}
		function prdDelete( num, image ){
			var resp = confirm('삭제하시겠습니까?') ;
			if( resp ){
				location.href='prdDeleteProc.jsp?num=' + num + "&image=" + image ;
			}else{
				alert( '삭제를 취소하셨습니다') ;
			}
		}
	</script>
</head>
<body>

<tr>

<td colspan="1" valign="top">
	<img src="./../images/pontPrdList.png" width="160" height="60" > 
	<br> <br> <br>
	<a href="<%=adm_folder%>/catList.jsp">- 카테고리 목록</a>
	<br> <br>
	<a href="<%=adm_folder%>/catRegisterForm.jsp">- 카테고리 등록</a>
	<br> <br>
	<a href="<%=adm_folder%>/prdList.jsp">- 상품 목록</a>
	<br> <br>
	<a href="<%=adm_folder%>/prdRegisterForm.jsp">- 상품 등록</a>	
</td>

<td colspan="5">
	<h3 align="center">상품 목록</h3>	
	<table align="center">
		<%=sep_product_list%>
		<tr>
			<td>카테고리</td> 
			<td>상품명</td> 
			<td>제조회사</td> 
			<td>재고</td> 
			<td>단가</td> 
			<td>포인트</td>
			<td>입고 일자</td>
			<td>수정</td> 
			<td>삭제</td> 
		</tr>
		<%=sep_product_list%>
		<% 
			if( lists.size() == 0 ){
		%>
		<tr>
			<td colspan="10">
				상품 목록이 존재하지 않습니다.
			</td>
		</tr>
		<% 
			}else{
				for( ProductBean product : lists){
		%>
		<tr>
			<td><%=product.getCname()%></td>
			<td>
				<a href="prdDetailView.jsp?num=<%=product.getNum()%>">
					<%=product.getName()%>
				</a>
			</td>
			<td><%=product.getCompany()%></td>
			<td><%=product.getStock()%></td>
			<td><%=product.getPrice()%></td>
			<td><%=product.getPoint()%></td>
			<td><%=product.getInputdate()%></td>
			<td><input type="button" value="수정" onclick="prdUpdate('<%=product.getNum()%>')"></td>
			
			<!-- 삭제시 웹 서버상의 그림도 삭제가 되어야 한다. 그래서, 이미지도 넘겨 주도록 한다 -->
			<td><input type="button" value="삭제" 
				onclick="prdDelete('<%=product.getNum()%>', '<%=product.getImage()%>')"></td>
			<%=sep_product_list%>
		</tr>
		<% 
				}
			}
		%>	
	</table>
</td>
</tr>
<%@include file="adm_bottom.jsp"%>
</body>
</html>
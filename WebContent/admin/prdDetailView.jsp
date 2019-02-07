<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="pdao" class="my.shop.ProductDao" />
<%@page import="my.shop.ProductBean"%>
<%
	//상품 목록 보기에서 넘겨주는 상품 번호 파라미터 
	int num = Integer.parseInt( request.getParameter("num")) ;

	//상품 번호를 이용하여 상품 빈 객체를 리턴 받는다.
	ProductBean product = pdao.getProductByNum( num ) ;
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
</head>
<body>
<%@include file="adm_top.jsp"%>
<tr>
<td colspan="6">
	<h3 align="center">상품 상세 보기</h3>
	<table align="center" width="60%" border="2">
		<tr>
			<td align="center">카테고리</td>
			<td align="center">
				<%=product.getCname()%>
			</td>
		</tr>	
		<tr>
			<td align="center">상품명</td>
			<td align="center"><%=product.getName()%></td>
		</tr>
		<tr>
			<td align="center">제조회사</td>
			<td align="center"><%=product.getCompany()%></td>
		</tr>
		<tr>
			<td align="center">이미지</td>
			<td align="center">
				<%
					//만약에 이미지가 널이면 디폴트 이미지를 지정한다
					String image = product.getImage() ;
					String myimg = "";
					
					if( image == null ){ //웹서버에 존재하지 않을 경우에도 처리해줘야 한다.
						myimg = apppath + imgPath + "\\heart.png" ;
					}else{
						myimg = saveDirectory + "\\" + image  ;	
					}
				%>
				<img src="<%=myimg%>" width="300" height="200">				
			</td>
		</tr>
		<tr>
			<td align="center">재고</td>
			<td align="center"><%=product.getStock()%></td>
		</tr>
		<tr>
			<td align="center">단가</td>
			<td align="center"><%=product.getPrice()%></td>
		</tr>
		<tr>
			<td align="center">스펙</td>
			<td align="center">
				<%=product.getSpec()%>
			</td>
		</tr>
		<tr>
			<td align="center">상품 설명</td>
			<td align="center"><%=product.getContents()%></td>
		</tr>
		<tr>
			<td align="center">포인트</td>
			<td align="center">
				<%=product.getPoint()%>
			</td>
		</tr>
		<tr>
			<td align="center">입고 일자</td>
			<td align="center"><%=product.getInputdate()%></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="button" value="이전 화면" 
					onclick="javascript:history.back();">
			</td>
		</tr>		
	</table>	
</td>
</tr>
<%@include file="adm_bottom.jsp"%>
</body>
</html>
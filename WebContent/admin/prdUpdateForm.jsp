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
	<h3 align="center">상품 수정하기</h3>
	<form action="prdUpdateProc.jsp" method="post" enctype="multipart/form-data">
	<table align="center">
		<tr>
			<td>카테고리</td>
			<td>
				<!-- 카테고리는 읽기 전용으로 가는 게 좋을듯 하다.  -->
				<input type="hidden" name="num" value="<%=product.getNum()%>">
				<input type="hidden" name="cnum" value="<%=product.getCnum()%>">
				<input type="text" name="cname" value="<%=product.getCname()%>" readonly="readonly">
			</td>
		</tr>	
		<tr>
			<td>상품명</td>
			<td><input type="text" name="name" value="<%=product.getName()%>"></td>
		</tr>
		<tr>
			<td>제조회사</td>
			<td><input type="text" name="company" value="<%=product.getCompany()%>"></td>
		</tr>
		<tr>
			<td>이미지</td>
			<td>
				<%
					//이전 이미지를 변수 oldImage에 저장한다.
					//oldImage도 파라미터로 넘겨서, 새 이미지와 비교한 다음에 변경이 되었다면 웹서버에서 삭제하도록 한다.
					//myimg : 웹 서버 상의 이미지 이름
					String oldImage = product.getImage() ;
					String myimg = saveDirectory + "\\" + oldImage  ;
					//out.print( myimg ) ;
				%>
				<input type="hidden" name="oldImage" value="<%=oldImage%>">
				
				<img src="<%=myimg%>" width="120" height="120">
				<input type="file" name="image">
			</td>
		</tr>
		<tr>
			<td>재고</td>
			<td><input type="text" name="stock" value="<%=product.getStock()%>"></td>
		</tr>
		<tr>
			<td>단가</td>
			<td><input type="text" name="price" value="<%=product.getPrice()%>"></td>
		</tr>
		<tr>
			<td>스펙</td>
			<td>
				<input type="text" name="spec" value="<%=product.getSpec()%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>상품 설명</td>
			<td><input type="text" name="contents" value="<%=product.getContents()%>"></td>
		</tr>
		<tr>
			<td>포인트</td>
			<td>
				<input type="text" name="point" value="<%=product.getPoint()%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>입고 일자</td>
			<td><input type="text" name="inputdate" value="<%=product.getInputdate()%>"></td>
		</tr>
		<tr align="center">
			<td colspan="2">
				<input type="submit" value="수정">
				<input type="reset" value="취소">
			</td>
		</tr>		
	</table>
	</form>
</td>
</tr>
<%@include file="adm_bottom.jsp"%>
</body>
</html>
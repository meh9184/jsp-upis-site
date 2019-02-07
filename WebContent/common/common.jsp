<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 이 파일은 범용적으로 사용되는 공통 파일입니다. -->
<%
	//common.jsp 파일 : 여러 문서에서 공용적으로 참조하는 변수들은 여기서 정의	
	String apppath = request.getContextPath() ;	
	String adm_folder = apppath + "/admin" ; //관리자용 폴더
	String me_folder = apppath + "/member" ; //회원 폴더
	String bo_folder = apppath + "/board" ;
	String mall_folder = apppath + "/mall" ; //mall 폴더	
	
	//표에 넣는 얇은 선
	String separator = "<tr><td bgcolor='gray' height='1.5' colspan='20'></td></tr>";	
	String separator2 = "<tr><td bgcolor='lightblue' height='0.5' colspan='5'></td></tr>";
	String sep_category_list = "<tr><td bgcolor='lightblue' height='0.5' colspan='5'></td></tr>";
	String sep_product_list = "<tr><td bgcolor='lightblue' height='0.5' colspan='12'></td></tr>";	
	
	//imgPath 변수 : 이미지를 저장시킬 경로
	String imgPath = "/images/" ; //WebContent 하위의 images 폴더 만들어 주세요
	
	//saveDirectory 변수 : 웹 서버상의 이미지가 저장될 경로
	String saveDirectory = application.getRealPath(imgPath) ;
	//out.print( "이미지업로드경로 : " + saveDirectory ) ;
	
	String tb_bg_color = "#FEFEFE" ; // 테이블 배경색
	String color_seashell = "fff5ee" ;
	
	//금액에 대한 서식을 지정하기 위한 클래스
	DecimalFormat df=new DecimalFormat("###,###");		
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>U P I S</title>
	<style type="text/css">
		.setdiaabledme{
			background-color: #dcdcdc ;	
		}
	</style>
</head>
<body>
</body>
</html>
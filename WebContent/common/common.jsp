<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- �� ������ ���������� ���Ǵ� ���� �����Դϴ�. -->
<%
	//common.jsp ���� : ���� �������� ���������� �����ϴ� �������� ���⼭ ����	
	String apppath = request.getContextPath() ;	
	String adm_folder = apppath + "/admin" ; //�����ڿ� ����
	String me_folder = apppath + "/member" ; //ȸ�� ����
	String bo_folder = apppath + "/board" ;
	String mall_folder = apppath + "/mall" ; //mall ����	
	
	//ǥ�� �ִ� ���� ��
	String separator = "<tr><td bgcolor='gray' height='1.5' colspan='20'></td></tr>";	
	String separator2 = "<tr><td bgcolor='lightblue' height='0.5' colspan='5'></td></tr>";
	String sep_category_list = "<tr><td bgcolor='lightblue' height='0.5' colspan='5'></td></tr>";
	String sep_product_list = "<tr><td bgcolor='lightblue' height='0.5' colspan='12'></td></tr>";	
	
	//imgPath ���� : �̹����� �����ų ���
	String imgPath = "/images/" ; //WebContent ������ images ���� ����� �ּ���
	
	//saveDirectory ���� : �� �������� �̹����� ����� ���
	String saveDirectory = application.getRealPath(imgPath) ;
	//out.print( "�̹������ε��� : " + saveDirectory ) ;
	
	String tb_bg_color = "#FEFEFE" ; // ���̺� ����
	String color_seashell = "fff5ee" ;
	
	//�ݾ׿� ���� ������ �����ϱ� ���� Ŭ����
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
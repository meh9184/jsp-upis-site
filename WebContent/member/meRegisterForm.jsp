<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<!-- ��� �±� : â�����̳� �ڹٽ�ũ��Ʈ ���� �ۼ��ϴ� ���� -->
	<style type="text/css">
		body {
			background-image: url(./../images/bg_login.jpg);
			background-repeat: repeat-x;
			background-attachment: fixed;
			background-position: left bottom;
		}
	</style>
	
	<title>ȸ�� ���� </title>

</head>

	<script type="text/javascript">
		function check(){
			//alert('�޷�');
			//alert( document.myform.id.value );
			//document.myform.id.value = '�ٺ���' ;
			var id = document.myform.id.value ;
			
			if( id == 'admin' ){
				alert('��� �Ұ����� �����Դϴ�.');
				//document.myform.id.focus();
				document.myform.id.select();
				return false ;
			}
			
			if( id.length < 3 || id.length > 9 ){
				alert('���̵�� 3���� �̻� 8���� �����Դϴ�.');
				//document.myform.id.focus();
				document.myform.id.select();
				return false ;
			}
			
			/* 4 <= ��� <= 10 */
			var password = document.myform.password.value ;
			
			if( password.length < 3 || password.length > 9 ){
				alert('��� ��ȣ�� 4���� �̻� 10���� �����Դϴ�.');
				document.myform.password.focus();
				//document.myform.password.select();
				return false ;
			}
			
			var regex = /^\d{3}-?\d{3}$/ ;
			var zipcode = document.forms[0].zipcode.value ;
			
			if( zipcode.search(regex) == -1 ){
				alert('�߸��� ���� ��ȣ ����') ;
				document.myform.zipcode.focus();
				return false ;
			}else{
				//alert('�ùٸ� ���� ��ȣ ����') ;
			}
			
			regex = /^\d{4}\/\d{2}\/\d{2}$/;
			var hiredate = document.myform.hiredate.value ;
			if( hiredate.search(regex) == -1 ){
				alert('yyyy/mm/dd �������� �Է��� �ּ���') ;
				document.myform.hiredate.focus();
				return false ;
			}
		}		
	</script>
	<script type="text/javascript" src="script.js"></script>
</head>
<body>
<br><br>
	<table align="center" border="0">
		<tr>	
			<td align="center"> <a href="./meLoginForm.jsp"> <img src="./../images/logo.png" width="250" height="100"> </a></td>
		</tr>
	</table>


<table border="5" cellspacing="10" cellpadding="15" width="80%" align="center">	
	
<td colspan="5" align="center">
	
	
	<h3 align="center">ȸ�� ����</h3>
	<form action="meRegisterProc.jsp" method="post" name="myform">
	<input type="hidden" name="mpoint" value="30">
	<table border="1" align="center" width="70%">
		<tr>
			<td width="25%" align="center">���̵�</td>
			<td width="75%" align="left">
				<input type="text" name="id" value="">
				<input type="button" value="�ߺ� üũ" onclick="idCheck();">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">�̸�</td>
			<td width="75%" align="left">
				<input type="text" name="name" value="">
			</td>
		</tr>
		<tr>
			<td align="center">��� ��ȣ</td>
			<td width="75%" align="left">
				<input type="password" name="password" value="">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">�й�</td>
			<td width="75%" align="left">
				<input type="text" name="salary" value="">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">���� ����</td>
			<td width="75%" align="left">
				<input type="text" name="hiredate" value="">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">����</td>
			<td width="75%" align="left">
				<input type="radio" name="gender" value="��" checked="checked">����
				<input type="radio" name="gender" value="��">����
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">���</td>
			<td width="75%" align="left">
				<input type="checkbox" name="hobby" value="����">����
				<input type="checkbox" name="hobby" value="�">�
				<input type="checkbox" name="hobby" value="���ǰ���">���ǰ���
				<input type="checkbox" name="hobby" value="���α׷���">���α׷���
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">����</td>
			<td width="75%" align="left">
				<select name="job">
					<option value="-">---- �����ϼ��� ----
					<option value="����">����
					<option value="����">����
					<option value="�л�">�л�
					<option value="��Ÿ">��Ÿ
				</select>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">���� ��ȣ</td>
			<td width="75%" align="left">
				<input type="text" class="setdiaabledme" name="zipcode" value="" readonly="readonly">
				<input type="button" value="���� ��ȣ ã��" onclick="zipCheck();">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">�ּ�</td>
			<td width="75%" align="left">
				<input type="text" class="setdiaabledme" name="address1" size="40" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">���� �ּ�</td>
			<td width="75%" align="left">
				<input type="text" name="address2" size="40" value="">
			</td>
		</tr>		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="ȸ�� ����" onclick="return check()">
				<input type="reset" value="���">
			</td>
		</tr>	
	</table>	
	</form>
	<table border="0" >
		<td>
			<tr> <br> </tr>
			<tr> <br> </tr>
			<tr> <br> </tr>			
		</td>
	</table>
</table>
	
</body>
</html>
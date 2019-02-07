<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<!-- 헤더 태그 : 창제목이나 자바스크립트 등을 작성하는 영역 -->
	<style type="text/css">
		body {
			background-image: url(./../images/bg_login.jpg);
			background-repeat: repeat-x;
			background-attachment: fixed;
			background-position: left bottom;
		}
	</style>
	
	<title>회원 가입 </title>

</head>

	<script type="text/javascript">
		function check(){
			//alert('메롱');
			//alert( document.myform.id.value );
			//document.myform.id.value = '바보야' ;
			var id = document.myform.id.value ;
			
			if( id == 'admin' ){
				alert('사용 불가능한 문자입니다.');
				//document.myform.id.focus();
				document.myform.id.select();
				return false ;
			}
			
			if( id.length < 3 || id.length > 9 ){
				alert('아이디는 3글자 이상 8글자 이하입니다.');
				//document.myform.id.focus();
				document.myform.id.select();
				return false ;
			}
			
			/* 4 <= 비번 <= 10 */
			var password = document.myform.password.value ;
			
			if( password.length < 3 || password.length > 9 ){
				alert('비밀 번호는 4글자 이상 10글자 이하입니다.');
				document.myform.password.focus();
				//document.myform.password.select();
				return false ;
			}
			
			var regex = /^\d{3}-?\d{3}$/ ;
			var zipcode = document.forms[0].zipcode.value ;
			
			if( zipcode.search(regex) == -1 ){
				alert('잘못된 우편 번호 형식') ;
				document.myform.zipcode.focus();
				return false ;
			}else{
				//alert('올바른 우편 번호 형식') ;
			}
			
			regex = /^\d{4}\/\d{2}\/\d{2}$/;
			var hiredate = document.myform.hiredate.value ;
			if( hiredate.search(regex) == -1 ){
				alert('yyyy/mm/dd 형식으로 입력해 주세요') ;
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
	
	
	<h3 align="center">회원 가입</h3>
	<form action="meRegisterProc.jsp" method="post" name="myform">
	<input type="hidden" name="mpoint" value="30">
	<table border="1" align="center" width="70%">
		<tr>
			<td width="25%" align="center">아이디</td>
			<td width="75%" align="left">
				<input type="text" name="id" value="">
				<input type="button" value="중복 체크" onclick="idCheck();">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">이름</td>
			<td width="75%" align="left">
				<input type="text" name="name" value="">
			</td>
		</tr>
		<tr>
			<td align="center">비밀 번호</td>
			<td width="75%" align="left">
				<input type="password" name="password" value="">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">학번</td>
			<td width="75%" align="left">
				<input type="text" name="salary" value="">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">생년 월일</td>
			<td width="75%" align="left">
				<input type="text" name="hiredate" value="">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">성별</td>
			<td width="75%" align="left">
				<input type="radio" name="gender" value="남" checked="checked">남자
				<input type="radio" name="gender" value="여">여자
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">취미</td>
			<td width="75%" align="left">
				<input type="checkbox" name="hobby" value="독서">독서
				<input type="checkbox" name="hobby" value="운동">운동
				<input type="checkbox" name="hobby" value="음악감상">음악감상
				<input type="checkbox" name="hobby" value="프로그래밍">프로그래밍
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">직업</td>
			<td width="75%" align="left">
				<select name="job">
					<option value="-">---- 선택하세요 ----
					<option value="교수">교수
					<option value="조교">조교
					<option value="학생">학생
					<option value="기타">기타
				</select>
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">우편 번호</td>
			<td width="75%" align="left">
				<input type="text" class="setdiaabledme" name="zipcode" value="" readonly="readonly">
				<input type="button" value="우편 번호 찾기" onclick="zipCheck();">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">주소</td>
			<td width="75%" align="left">
				<input type="text" class="setdiaabledme" name="address1" size="40" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">세부 주소</td>
			<td width="75%" align="left">
				<input type="text" name="address2" size="40" value="">
			</td>
		</tr>		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="회원 가입" onclick="return check()">
				<input type="reset" value="취소">
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
function idCheck(){
	var id = document.myform.id.value ;
	var url='idCheck.jsp?id=' + id ;
	window.open(url, 'mywin', 'height=120,width=285') ;
}
function zipCheck(){
	var url='zipCheck.jsp';
	window.open(url, 'mywin', 'height=300,width=540,status=yes,scrollbars=yes,resizable=no') ;
}
function dongCheck(){
	if (document.zipForm.dong.value == ""){
		alert("동이름을 입력하세요") ;
		document.zipForm.dong.focus() ; 
		return false ;
	}
	//일반 버튼으로 전송 효과를 보려면 submit()을 이용하면 된다.
	document.zipForm.submit() ;
}

function sendAddress(zipcode, address){	
	//opener : 띄워진 창의 입장에서 봤을 때 부모 창을 지칭
	opener.document.myform.zipcode.value=zipcode;
	opener.document.myform.address1.value=address;
	opener.document.myform.address2.focus();
	self.close(); //self : 자신
}
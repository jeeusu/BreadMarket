function CheckAddBread() {	
	var bname=document.getElementById("bname");
	var price=document.getElementById("price");
	var info=document.getElementById("info");

	//상세 정보 체크
	if(info.value.length<10 || info.value.length>100) {
		alert("상세 정보는 최소 10자에서 최대 100자까지 입력하세요");
		info.select();
		return;
	}
	
	//빵 가격 체크
	if(price.value.length==0||isNaN(price.value)) { 
		alert("가격은 숫자만 입력 가능합니다");
		price.select();
		return;
	}
	
	//메뉴 이름 체크
	if(bname.value=="") {
		alert("메뉴 이름을 입력해주세요")
		bname.select();
		return;
	}
	
	document.breadinfo.submit();
}

function CheckUpdateBread() {	
	var bname=document.getElementById("bname");
	var price=document.getElementById("price");
	var info=document.getElementById("info");

	//상세 정보 체크
	if(info.value.length<10 || info.value.length>100) {
		alert("상세 정보는 최소 10자에서 최대 100자까지 입력하세요");
		info.select();
		return;
	}
	
	//빵 가격 체크
	if(price.value.length==0||isNaN(price.value)) { 
		alert("가격은 숫자만 입력 가능합니다");
		price.select();
		return;
	}
	
	//메뉴 이름 체크
	if(bname.value=="") {
		alert("메뉴 이름을 입력해주세요")
		bname.select();
		return;
	}
	
	document.breadinfo.submit();
}

function CheckAddMember() {
	var form=document.join;
	
	var id=form.id.value;
	var pwd=form.pwd.value;
	var birth=form.birth.value;
	var phone=form.phone.value;
	var email=form.email.value;
	
	//정규표현식
	var regExpId=/^[A-Za-z0-9]{4,10}$/;
	var regExpPwd=/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,20}$/;
	var regExpEmail =/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	var regExpNumber =/^\d+$/;
		
	//아이디 입력
	if(id.value=="") {
		alert("id를 입력하세요");
		form.id.select();
		return;
	}
		
	//아이디 유효성
	if(!regExpId.test(id)) {
		alert("아이디는 영문자,숫자 포함 4~10자 이내로 작성해주세요");
		form.id.select();
		return;
	}
		
	//비밀번호 입력
	if(pwd.value=="") {
		alert("비밀번호를 입력하세요");
		form.pwd.select();
		return;
	}
	
	//비밀번호 유효성
	if(!regExpPwd.test(pwd)) {
		alert("비밀번호는 영문자, 숫자, 특수문자를 포함하여 6~20자 이내로 작성해주세요");
		form.id.select();
		return;
	}
	
	//생년월일, 휴대폰번호 유효성
	if(!regExpNumber.test(birth)) {
		alert("생년월일은 숫자만 입력해주세요");
		form.birth.select();
		return;
	}
	if(!regExpNumber.test(phone)) {
		alert("전화번호는 숫자만 입력해주세요");
		form.phone.select();
		return;
	}
	
	//이메일 유효성
	if(!regExpEmail.test(email)) {
		alert("이메일 형식으로 입력해주세요	");
		form.email.select();
		return;
	}
	
	form.submit();
}

	
		
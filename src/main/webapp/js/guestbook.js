function checkGuestbookWriteForm(){
	document.getElementById("nosub").innerHTML = "";
	document.getElementById("nocontent").innerHTML = "";
	var name = document.getElementById("name").value;
	var subject = document.getElementById("subject").value;
	var content = document.getElementById("content").value;

	if (name == "")
		document.getElementById("noname").innerHTML = "작성자를 입력하세요";
	else if (subject == "")
		document.getElementById("nosub").innerHTML = "제목을 입력하세요";
	else if (content == "")
		document.getElementById("nocontent").innerHTML = "내용을 입력하세요";
	else {
		document.getElementById("guestbookWriteForm").submit();
	}
}
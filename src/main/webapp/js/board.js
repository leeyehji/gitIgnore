
function checkBoardWriteForm() {//유효성 검사
	document.getElementById("nosub").innerHTML = "";
	document.getElementById("nocontent").innerHTML = "";
	var subject = document.getElementById("subject").value;
	var content = document.getElementById("content").value;
	var id = "<%= id %>";
	if (id == null) {
		alert("게시판 작성은 로그인 한 유저만 가능합니다.");
		location.href = "../member/loginForm.jsp";
	}
	else if (subject == "")
		document.getElementById("nosub").innerHTML = "제목을 입력하세요";
	else if (content == "")
		document.getElementById("nocontent").innerHTML = "내용을 입력하세요";
	else {
		document.boardWriteForm.submit();
	}
}

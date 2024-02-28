<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<!-- url에 index.html을 작성하지 않아도 index 출력함. 메인화면으로 잡기 때문임. -->
<h2>*** 메인화면 ***</h2>
<%if(session.getAttribute("memId") == null){%>
	<h3><a href="./member/writeForm.jsp">회원가입</a></h3>
	<h3><a href="./member/loginForm.jsp">로그인</a></h3>
<%}else{%>
	<h3><a href="./member/logout.jsp">로그아웃</a></h3>
	<h3><a href="./member/updateForm.jsp">회원정보수정</a></h3>
	
	<h3><a href="./board/boardWriteForm.jsp">글쓰기</a></h3>
		<h3><a href="./guestbook/guestbookWriteForm.jsp">방명록 등록</a></h3>
	
<%}%>
<h3><a href="./board/boardList.jsp?pg=1">목록</a></h3><!-- 1페이지부터 보야줘 -->
<h3><a href="./guestbook/guestbookList.jsp?pg=1">방명록 목록</a></h3>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="guestbookWriteForm" id="guestbookWriteForm" action="guestbookWrite.jsp" method="post">
<table border="1" cellspacing=0 cellpadding="10">
	<tbody>
		<tr>
			<th>작성자</th>
			<td><input type="text" id="name" name="name" placeholder="작성자 입력"><div id="noname"></div></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" id="email" name="email" placeholder="이메일 입력"></td>
		</tr>
		<tr>
			<th>홈페이지</th>
			<td><input type="text" id="homepage" name="homepage" value="http://"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" size="50" id="subject" name="subject" placeholder="제목입력"><div id="nosub"></div></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea id="content" cols="50" rows="15" name="content" rows="10" cols="20"></textarea><div id="nocontent"></div></td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="button" value="글작성" onclick="checkGuestbookWriteForm()">
				<button type="reset">다시작성</button>
				<button type="button" onclick="location.href='guestbookList.jsp?pg=1'">글목록</button>
			</th>
		</tr>
	</tbody>
</table>
</form>
<script src="../js/guestbook.js"></script>
</body>
</html>
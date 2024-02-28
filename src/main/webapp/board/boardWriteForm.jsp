<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
   	import="member.dao.MemberDAO"
   	import="member.bean.MemberDTO"
   	import="board.dao.BoardDAO"%>
<%
String id=(String)session.getAttribute("memId");

//DB
//MemberDAO memberDAO=MemberDAO.getInstance();


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table,tr,th{
		border: 1px solid;	
	}
</style>


</head>
<body>
<form name="boardWriteForm" id="boardWriteForm" action="boardWrite.jsp?pg=1" method="post">
<table cellspacing=0 cellpadding="10">
	<tbody>
		<tr>
			<th>제목</th>
			<th><input type="text" id="subject" name="subject" placeholder="제목을 넣어주세요"><div id="nosub"></div></th>
		</tr>
		<tr>
			<th>내용</th>
			<th><textarea id="content" name="content" rows="10" cols="20"></textarea><div id="nocontent"></div></th>
		</tr>
		<tr>
			<th colspan="2">
				<input type="button" value="글쓰기" onclick="checkBoardWriteForm()">
				<button type="reset">다시작성</button>
			</th>
		</tr>
	</tbody>
</table>
</form>

<script src="../js/board.js"></script>
</body>
</html>
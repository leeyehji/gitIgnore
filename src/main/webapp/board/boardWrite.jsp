<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	import="member.dao.MemberDAO"
	import="member.bean.MemberDTO" 
	import="board.dao.BoardDAO"
	import="board.bean.BoardDTO"
	import="java.util.Map"
	import="java.util.HashMap"%>
<%
String subject = request.getParameter("subject");
String content = request.getParameter("content");

//DB 생성 - 싱글톤
//MemberDAO memberDAO = MemberDAO.getInstance();
BoardDAO boardDAO = BoardDAO.getInstance();

String id = (String) session.getAttribute("memId");
String name = (String) session.getAttribute("memName");
String email = (String) session.getAttribute("memEmail");

Map<String, String> map = new HashMap<>();
map.put("id",id);
map.put("name",name);
map.put("email",email);
map.put("subject",subject);
map.put("content",content);


String print = "작성하신 글을 등록하지못하였습니다.";
if (id != null) {
	//BoardDTO boardDTO = boardDAO.writeBoard(id, name, email, subject, content);
	boardDAO.writeBoard(map);
	//boardDAO.board2Table(boardDTO);
	print = "작성하신 글을 등록하였습니다.";
}

//세션해제
session.removeAttribute("boardCon");//원하는 세션값만 제거함.
session.removeAttribute("boarcSub");
session.removeAttribute("memEmail");

int pg=boardDAO.getTotalA();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>
	window.onload=function(){
		alert("<%=print%>");
		location.href="boardList.jsp?pg=1";
	}
</script>
</body>
</html>
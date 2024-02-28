<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="guestbook.dao.GuestbookDAO"
    import="guestbook.bean.GuestbookDTO"
    import="java.util.Map"
	import="java.util.HashMap"%>
<%
//DB 생성 - 싱글톤
//MemberDAO memberDAO = MemberDAO.getInstance();
GuestbookDAO guestbookDAO = GuestbookDAO.getInstance();

String id=(String)session.getAttribute("memId");
String name=(String)session.getAttribute("memName");
String email=(String)session.getAttribute("memEmail");
String homepage =request.getParameter("homepage");
String subject = request.getParameter("subject");
String content = request.getParameter("content");


Map<String, String> map = new HashMap<>();
map.put("id",id);
map.put("name",name);
map.put("email",email);
map.put("homepage",homepage);
map.put("subject",subject);
map.put("content",content);

guestbookDAO.writeGuestbook(map);

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
		alert("방명록 등록하였습니다.");
		location.href="guestbookList.jsp?pg=1";
	}
</script>
	
</body>
</html>
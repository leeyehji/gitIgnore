<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	import="member.dao.MemberDAO"%>
		
<%
String id = request.getParameter("id");

//DB 생성 - 싱글톤
MemberDAO memberDAO = MemberDAO.getInstance();
//DB에 id를 가져가 확인
boolean exist = memberDAO.isExistId(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%if(exist){ %>
	<form action="">
	<!--
	재귀로 쓰는 거라 비워도 되고 아니면 본인주소(checkRepetition.jsp) 넣기 
	유효성 검사도 넣으렴 -->
		<font color = "red"><strong>선택하신 아이디 <%=id%>은(는) 사용 불가능합니다.</strong></font> 
		<br><br>
		아이디 <input type="text" name="id"><input type="submit" value="중복체크">
	</form>
<%}else{ %>
	<font color = "blue"><strong>선택하신 아이디 <%=id%>은(는) 사용 가능합니다.</strong></font>
	<br><br>
	<input type="button" value="사용하기" onclick="checkIdClose('<%=id%>')"> 
<%} %>
<script>
function checkIdClose(id) {
	opener.document.getElementById("id").value=id;//opener=열려있는 모든 창 중에서. 사용하려면 모든 창의 중복되는 id가 없어야함.
	opener.document.getElementById("noid").innerHTML="사용 가능한 아이디입니다.";
	window.close();
	opener.document.getElementById("pwd").focus();
}
</script>
</body>
</html>
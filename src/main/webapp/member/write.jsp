<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.bean.MemberDTO"
    import="member.dao.MemberDAO"
%>

<%
request.setCharacterEncoding("UTF-8");
//낮은 버전의 Tomcat은 한글 인식 못해줘서 10은 상관없지만 9이하는 작성해야 한글이 깨지지 않는다. 
//요청으로 넘어오는 데이터들의 한글이 깨지지 않게 한다.

//data
String name = request.getParameter("name");
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
String gender = request.getParameter("gender");
String email1 = request.getParameter("email1");
String email2 = request.getParameter("email2");
String tel1 = request.getParameter("tel1");
String tel2 = request.getParameter("tel2");
String tel3 = request.getParameter("tel3");
String zipcode = request.getParameter("zipcode");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");

MemberDTO memberDTO = new MemberDTO();
memberDTO.setName(name);
memberDTO.setId(id);
memberDTO.setPwd(pwd);
memberDTO.setGender(gender);
memberDTO.setEmail1(email1);
memberDTO.setEmail2(email2);
memberDTO.setTel1(tel1);
memberDTO.setTel2(tel2);
memberDTO.setTel3(tel3);
memberDTO.setZipcode(zipcode);
memberDTO.setAddr1(addr1);
memberDTO.setAddr2(addr2);

//DB
MemberDAO memberDAO= MemberDAO.getInstance();
int su = memberDAO.write(memberDTO);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>
<img src="../image/qnsshdlraud2.jpg" alt="헤더익명" width="50" heigth="50" 
	onclick="location.href='../index.jsp'" style="cursor:pointer">
<%=name%>님 로그인 성공<br>
</h3>
<%if(su==1){ %>
	회원가입을 축하합니다.
<%}else{%>
	회원가입에 실패했습니다.<br>
	다시 작성하세요.
<%} %>
</body>
</html>
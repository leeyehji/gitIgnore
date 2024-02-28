<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.dao.MemberDAO"
    import="member.bean.MemberDTO"%>
    
<%
 String id= request.getParameter("id");
 String pwd=request.getParameter("pwd"); 

 //DB 생성 - 싱글톤
MemberDAO memberDAO = MemberDAO.getInstance();
//boolean exist = memberDAO.isExistId(id);
MemberDTO memberDTO = memberDAO.checkLogin(id,pwd);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
로그인 성공여부<br><br>

<%if(memberDTO != null){
	//페이지 이동
	//response.sendRedirect("loginOk.jsp?id="+id+"&name="+URLEncoder.encode(memberDTO.getName(),"UTF-8"));
	//한글 처리를 위한 UTF-8 사전정의.
	
	/*
	//쿠키. 
	//클라이언트 정보이므로 해킹 가능성 있음.
	Cookie cookie=new Cookie("memName",memberDTO.getName());//Cookie cookie=new Cookie("쿠키이름","값");
	cookie.setMaxAge(30*60);//30s*60=30m
	response.addCookie(cookie);//save at client
	Cookie cookie2=new Cookie("memId",memberDTO.getId());//Cookie cookie=new Cookie("쿠키이름","값");
	cookie.setMaxAge(30*60);//30s*60
	response.addCookie(cookie2);//save at client
	*/
	
	
	//세션
	//인터페이스 제공. 기본 30분 저장.
	//HttpSession session =request.getSession();//"jsp"의 내장 객체 9개 중 하나 session이므로 선언 불가
	session.setAttribute("memName", memberDTO.getName());//session.setAttribute("세션명", "값");
	session.setAttribute("memId", id);	
	String email=memberDTO.getEmail1()+"@"+memberDTO.getEmail2();
	session.setAttribute("memEmail",email);
	
	
	response.sendRedirect("loginOk.jsp");//page 이동
	
}else{
	response.sendRedirect("loginFail.jsp");
	
} %>

<script>
	function goUpdateForm() {
		location.href = 'updateForm.jsp?id=<%=id%>';
	}
	
</script>
</body>
</html>

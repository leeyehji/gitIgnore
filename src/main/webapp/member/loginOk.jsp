<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//data
	String name=request.getParameter("name");
	String id=request.getParameter("id");

/*
	//cookie.특정쿠키만 못가져오고 모든 쿠키 가져옴.
	Cookie[] arr=request.getCookies();
	if(arr !=null){
		for(int i=0; i<arr.length; i++){
			String cookieName =arr[i].getName();
			String cookieValue=arr[i].getValue();
			System.out.print("쿠키값="+cookieValue);
			
			if(cookieName.equals("memName"))
				name=cookieValue;
			if(cookieName.equals("memId"))
				id=cookieValue;	
		}
	}
*/


//세션
	name=(String)session.getAttribute("memName");
	id=(String)session.getAttribute("memId");

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

<input type="button" value="회원정보수정" onclick="location.href='updateForm.jsp'">
	<!-- <input type="button" value="회원정보수정" onclick="location.href='updateForm.jsp?id=<%=id%>'"> 세션미사용 시 id 필요 -->
	<!-- string은, 문자열은 넘길 수 있으나 객체는 넘길 수 없음. 따라서 memberDTO를 넘길 수 없음. id는 넘겨도 되지만 pwd는 넘기면 곤란함. -->
	<!-- requset.setAttribute()를 이용하면 request 객체에 객체를 담아 넘겨줄 수 있음. -->
	<!-- <input type="button" value="회원정보수정" onclick="goUpdateForm()"> -->
	<input type="button" value="로그아웃" onclick="location.href='logout.jsp'">
</h3>
</body>
</html>
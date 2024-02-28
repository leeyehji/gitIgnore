<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
   //cookie
   Cookie[] arr=request.getCookies();
   if(arr!=null){
   	for(int i=0; i<arr.length; i++){
   		if(arr[i].getName().equals("memName")){
   			arr[i].setMaxAge(0);// delete cookie
   			response.addCookie(arr[i]);// save at client
   		}
   		if(arr[i].getName().equals("memId")){
   			arr[i].setMaxAge(0);// delete cookie
   			response.addCookie(arr[i]);// save at client
		}
	}
}
*/

//session
session.removeAttribute("memName");//원하는 세션값만 제거함.
session.removeAttribute("memeId");

session.invalidate();//무효화. 실효성이 있는 모든 세션을 없앰.
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
	alert("로그아웃");
	location.href="../index.jsp";
}
</script>
</body>
</html>
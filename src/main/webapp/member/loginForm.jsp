<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	table{
        border: 1px solid ;
    }
    td,th{
        border: 1px solid;
        padding: 10px;
    }
    .center{
        text-align: center;
    }

</style>

</head>
<body>
<form name="loginForm" action="login.jsp" method="post">
<table cellspacing=0>
	<tr>
		<th>아이디</th>
		<td><input type="text" name ="id"><div id="noid"></div>
		</td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" name="pwd"><div id="nopwd"></div></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="button" name="login" value="로그인" onclick="checklogin()"><!-- login.jsp 이동 -->
			<input type="reset" name="join" value="회원가입" onclick="location.href = 'writeForm.jsp'"><!-- wirteForm.jsp 이동 -->
			<!--  http://localhost:8080/projectJSP/member/writeForm.jsp  -->
		</th>
	</tr>
</table>
</form>

<script type="text/javascript">
	function checklogin() {//유효성 검사
        document.getElementById("noid").innerHTML="";
        document.getElementById("nopwd").innerHTML="";

        if(document.loginForm.id.value=="")
            document.getElementById("noid").innerHTML="아이디를 작성하시오.";
        else if(document.loginForm.pwd.value=="")
            document.getElementById("nopwd").innerHTML="비밀번호를 작성하시오.";
        else{
        	document.loginForm.submit(); //loginForm = name 속성. id는 getElement~하지만 name은 그냥 쓴다. 
        }
	}
</script>
</body>
</html>
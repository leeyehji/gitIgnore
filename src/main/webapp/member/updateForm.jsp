<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.dao.MemberDAO"
    import="member.bean.MemberDTO"%>
    
<%
 //String id= request.getParameter("id");

String id=(String)session.getAttribute("memId");

 //DB 생성 - 싱글톤
MemberDAO memberDAO = MemberDAO.getInstance();
MemberDTO memberDTO = memberDAO.getMember(id);

%>
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
<form name="updateForm" method="post" action="update.jsp" >
<table cellspacing="0">
    <thead></thead>
	<tbody>
		<tr>
			<td class="center">이름</td>
			<td>
                <input type="text" name="name" id="name" value=<%=memberDTO.getName()%> >
            	<div id="noname"></div>       
            </td>
        </tr>
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="id" readonly="readonly" value="<%=id%>" size="30">
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input type="password" name="pwd" id="pwd" size="40" placeholder="비밀번호 입력">
				<div id="nopwd"></div>
			</td>
            
        </tr>
		<tr>
			<th>재확인</th>
			<td>
				<input type="password" name="repwd" id="repwd" size="40" placeholder="비밀번호 입력">
				<div id="incorrectPW"></div>
			</td>
		</tr>
		<tr>
			<td class="center">성별</td>
			<td>
				<input type="radio" name="gender" value="0" >
				<label for="남성">남성</label>
				<input type="radio" name="gender" value="1">
				<label for="여성">여성</label>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" name="email1" size="15" value=<%=memberDTO.getEmail1()%>>
                @
                <input type="email" readonly name="email2" id="email2" size="15" value=<%=memberDTO.getEmail2()%>>
                <select name="email3" onclick="javascript:emailInput(); return false;">
                    <option value="직접입력" id="self" selected>직접입력</option>
                    <option value="naver.com" id="naver">naver.com</option>
                    <option value="goole.com" id="goole">goole.com</option>
                    <option value="hanmail.com" id="hanmail">hanmail.com</option>
                </select>
			</td>
		</tr>
        <tr>
			<td class="center">휴대폰</td>
            <td>
                <select name="tel1" id="tel1">
                    <option value="010" id="010">010</option>
                    <option value="011" id="011">011</option>
                    <option value="019" id="019">019</option>
                </select>
                - <input type="text" name="tel2" size="2" maxlength="4" value=<%=memberDTO.getTel2()%>>
                - <input type="text" name="tel3" size="2" maxlength="4" value=<%=memberDTO.getTel3()%>>
            </td>
		</tr>
        <tr>
            <th>주소</th>
            <td>
                <input type="text" readonly id="zipcode" name="zipcode" value="<%=memberDTO.getZipcode()%>" > 
                
                <button type="button" onclick="javascript:searchAddress(); return false;">우편번호검색</button>
                <br>
                <input type="text" value="<%=memberDTO.getAddr1()%>" name="addr1" id="addr1"  size="70"  ><br>
                <input type="text" name="addr2" id="addr2"  size="70" value="<%=memberDTO.getAddr2()%>" >
            </td>
        </tr>
	</tbody>
    <tfoot>
        <tr>
            <th colspan="2">
            	<!-- <input type="button" onclick="javascript:checkWrite()" value="회원가입">-->
                <button type="button" id="join" onclick="javascript:checkUpdate();">회원정보수정</button>
                <input type="reset" value="다시입력" onclick="location.reload()">
            </th>
        </tr>
    </tfoot>
</table>
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
window.onload=function(){
	document.updateForm.gender['<%=memberDTO.getGender()%>'].checked=true;
	var tel1="<%=memberDTO.getTel1()%>";
	var telSelect = document.getElementById("tel1");
	
	 if(tel1=="010")
		 telSelect.selectedIndex = 0;
      else if(tel1=="011")
    	  telSelect.selectedIndex = 1;
      else if(tel1=="019")
    	  telSelect.selectedIndex = 2;
}
	
	function checkUpdate(){//유효성 검사
		//이름, 비밀번호, 비밀번호 재확인
		var pwd= document.getElementById("pwd").value;
		var repwd= document.getElementById("repwd").value;
		
		if(document.getElementById("name").value=="")
	    	document.getElementById("noname").innerHTML="이름을 작성하시오.";
		else if(pwd=="")
            document.getElementById("nopwd").innerHTML="비밀번호를 작성하시오.";
        else if(pwd !=repwd)
        	document.getElementById("incorrectPW").innerHTML="비번 틀림";
		else
			document.updateForm.submit();
	}
	
	   function tel1Check(tel1){
	      if(tel1=="010")
	         document.getElementById("010").selectedIndex=0;
	      else if(tel1=="011")
	         document.getElementById("010").selectedIndex=1;
	      else if(tel1=="019")
	         document.getElementById("019").selectedIndex=2;
	         
	   }

	   
	function emailInput(){
    	//emailInput
    	if(document.getElementById("self").selected){
    		document.getElementById("email2").value="";
    		document.getElementById("email2").readOnly=false;
    	}
    	else if(document.getElementById("naver").selected){
    		document.getElementById("email2").value="naver.com";
    		
    	}
    	else if(document.getElementById("goole").selected)
    		document.getElementById("email2").value=document.getElementById("goole").value;
    	else
    		document.getElementById("email2").value="hanmail.com";
    }
    
    function searchAddress(){
    	new daum.Postcode({
    		oncomplete: function(data) {
    			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

    			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
    			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
    			var addr = ''; // 주소 변수

    			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
    			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
    				addr = data.roadAddress;
    			} else { // 사용자가 지번 주소를 선택했을 경우(J)
    				addr = data.jibunAddress;
    			}

    			// 우편번호와 주소 정보를 해당 필드에 넣는다.
    			document.getElementById("zipcode").value = data.zonecode;
    			document.getElementById("addr1").value = addr;
    			// 커서를 상세주소 필드로 이동한다.
    			document.getElementById("addr2").focus();
    		}
    	}).open();
    }
</script>
</body>
</html>
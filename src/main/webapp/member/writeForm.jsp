<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>writeForm</title>

<style>
	#myTable{
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
<body onload="javascript:emailInput()">
<form name="memberForm" method="get" action="write.jsp" >
<table id="myTable" cellspacing="0">
    <thead></thead>
	<tbody>
		<tr>
			<td class="center">이름</td>
			<td>
                <input type="text" name="name" id="name" placeholder="이름 입력">
                <div id="noname"></div>
            </td>
        </tr>
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="id" id="id" placeholder="아이디 입력" size="30">
				<button type="button" onclick="javascript:checkRepetition()">중복체크</button>
				<input type="hidden" name="check" id="check" value="">
                <div id="noid"></div>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input type="password" name="pwd" id="pwd" size="40">
				<div id="nopwd"></div>
			</td>
            
        </tr>
		<tr>
			<th>재확인</th>
			<td>
				<input type="password" name="repwd" size="40">
				<div id="incorrectPW"></div>
			</td>
		</tr>
		<tr>
			<td class="center">성별</td>
			<td>
				<input type="radio" name="gender" value="0" checked>
				<label for="남성">남성</label>
				<input type="radio" name="gender" value="1">
				<label for="여성">여성</label>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" name="email1" size="15">
                @
                <input type="email" readonly name="email2" id="email2" size="15">
                <select name="email3" onclick="javascript:emailInput(); return false;">
                    <option value="직접입력" id="self" selected>직접입력</option>
                    <option value="naver.com" id="naver">naver.com</option>
                    <option value="goole.com" id="goole">goole.com</option>
                    <option value="hanmail.com" id="hanmail">hanmail.com</option>
                </select>
                <!-- 
                <data list id=email3>
                	<option value="직접입력" id="self" selected>직접입력</option>
                    <option value="naver.com" id="naver">naver.com</option>
                    <option value="goole.com" id="goole">goole.com</option>
                    <option value="hanmail.com" id="hanmail">hanmail.com</option>
                </data>
                 -->
			</td>
		</tr>
        <tr>
			<td class="center">휴대폰</td>
            <td>
                <select name="tel1">
                    <option value="010" id="010" selected>010</option>
                    <option value="011" id="011">011</option>
                    <option value="019" id="019">019</option>
                </select>
                - <input type="text" name="tel2" size="2" maxlength="4">
                - <input type="text" name="tel3" size="2" maxlength="4">
            </td>
		</tr>
        <tr>
            <th>주소</th>
            <td>
                <input type="text" readonly id="zipcode" name="zipcode"> 
                
                <button type="button" onclick="javascript:searchAddress(); return false;">우편번호검색</button>
                <br>
                <input type="text" name="addr1" id="addr1" placeholder="주소" size="70"><br>
                <input type="text" name="addr2" id="addr2"  placeholder="상세주소" size="70">
            </td>
        </tr>
	</tbody>
    <tfoot>
        <tr>
            <th colspan="2">
            	<!-- <input type="button" onclick="javascript:checkWrite()" value="회원가입">-->
                <button type="button" id="join" onclick="javascript:checkWrite();">회원가입</button>
                <input type="reset" value="다시작성">
            </th>
        </tr>
    </tfoot>
</table>
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- <script type="text/javascript" src="../js/member.js"> -->
<script type="text/javascript">

    function checkWrite(){//유효성검사
        document.getElementById("noname").innerHTML="";
        document.getElementById("noid").innerHTML="";
        document.getElementById("nopwd").innerHTML="";
        document.getElementById("incorrectPW").innerHTML="";
       
        
        if(document.getElementById("name").value=="")
            document.getElementById("noname").innerHTML="이름을 작성하시오.";
        else if(document.memberForm.id.value=="")
            document.getElementById("noid").innerHTML="아이디를 작성하시오.";
        else if(document.memberForm.pwd.value=="")
            document.getElementById("nopwd").innerHTML="비밀번호를 작성하시오.";
        else if(document.memberForm.pwd.value !=(document.memberForm.repwd.value))
        	document.getElementById("incorrectPW").innerHTML="비번 틀림";
        else if(document.getElementById("id").value != document.getElementById("check").value)
        	document.getElementById("noid").innerHTML="아이디중복 체크를하시오.";
        /*else if(memberDAO.isExistId(document.getElementById("id").value)){
        	document.getElementById("noid").innerHTML= "아이디 중복";
        }*/
        else{
        	document.memberForm.submit();
        }
            
    }

    function emailInput(){
    	
    	//emailInput
    	if(document.getElementById("self").selected){
    		document.getElementById("email2").value="";
    		document.getElementById("email2").readOnly=false;
    	}
    	else if(document.getElementById("naver").selected)
    		document.getElementById("email2").value="naver.com";
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
    function checkRepetition(){
    	var id=document.getElementById("id").value;
    	if(id=="")
    		document.getElementById("noid").innerHTML= "아이디를 입력하세요";
    	else{
    		window.open("http://localhost:8080/projectJSP/member/checkRepetition.jsp?id="+id
    					,"checkRepetition"
    					,"width=500 height=500");
    		
    		document.getElementById("check").value=id;
    		
    	}	
    }
</script>
</body>
</html>
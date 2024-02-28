<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="guestbook.dao.GuestbookDAO"
    import="guestbook.bean.GuestbookDTO"
    import="java.util.List"
    import="java.text.SimpleDateFormat"%>
<%
GuestbookDAO guestbookDAO=GuestbookDAO.getInstance();

//data
int pg=Integer.parseInt(request.getParameter("pg"));
int startNum=pg*3-2;
int endNum=pg*3;

int totalA=guestbookDAO.getTotalA();	//총 글 수
int totalP = (totalA+2)/3; //총 페이지 수


List<GuestbookDTO> list=guestbookDAO.guestbookList(startNum, endNum);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	div{
	margin:10px;
	}
	a{
		font-size: 10px;
		color: black;
		padding: 5px 10px 5px 10px;
		text-decoration:none;
	}
	#currentPaging{
		color: red;
		text-decoration:underline;
	}
	hr{
		height: 1pt;
		border: 0;
		background: red;
	}
</style>
</head>
<body>


<% if(list!=null){ %>
<% for(GuestbookDTO guestbookDTO:list) {%>
<table border="1" cellspacing=0 cellpadding="5" width="700px">
	<tr>
		<td>작성자</td>
		<td><%= guestbookDTO.getName() %></td>
		
		<td>작성일</td>
		<td><%=new SimpleDateFormat("YYYY.MM.dd").format(guestbookDTO.getLogtime()) %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td colspan="3"><%= guestbookDTO.getEmail() %></td>
	</tr>
	<tr>
		<td>홈페이지</td>
		<td colspan="3"><%= guestbookDTO.getHomepage() %></td>
	</tr>
	<tr>
		<td>제목</td>
		<td colspan="3"><%=guestbookDTO.getSubject() %></td>
	</tr>
	<tr height="100">
		<td colspan="4"><%=guestbookDTO.getContent() %></td>
	</tr>
</table>
<br><hr><br>
<%}%>
<%}%>

<div style="text-align:center; width:800px; color:black">
<%for(int i=1; i<=totalP; i++){ %>
	<%if(pg==i) {%>
		<a id="currentPaging" href="http://localhost:8080/projectJSP/board/boardList.jsp?pg=<%= i %>"><%= i %></a>&emsp;
	<%}else {%>
		<a id="paging" href="http://localhost:8080/projectJSP/board/boardList.jsp?pg=<%= i %>"><%= i %></a>&emsp;
	<%} %>
<%} %>
</div>
</body>
</html>
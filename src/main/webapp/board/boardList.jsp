<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="board.dao.BoardDAO"
    import="board.bean.BoardDTO"
    import="java.util.List"
    import="java.text.SimpleDateFormat"%>
    
<%
BoardDAO boardDAO=BoardDAO.getInstance();

//data
int pg=Integer.parseInt(request.getParameter("pg"));
int startNum=pg*5-4;//페이징 처리 1페이지에 글 5개
int endNum=pg*5;

int totalA=boardDAO.getTotalA();	//총 글 수
int totalP = (totalA+4)/5; //총 페이지 수
//DB-select

List<BoardDTO> list=boardDAO.boardList(startNum, endNum);
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
	a:hover{
		text-decoration:underline;
	}
	#currentPaging{
		color: red;
		background-color:lightgrey;
	}
</style>
</head>
<body>
<table border="1" frame="hsides" rules="rows" cellpadding="7" cellspacing=0 style="width:800px">
	<tr>
		<th width="100">글번호</th>
		<th width="300">제목</th>
		<th width="150">작성자</th>
		<th width="150">작성일</th>
		<th width="100">조회수</th>
	</tr>
<% if(list!=null){ %>
	<% for(BoardDTO boardDTO:list) {%>
		<tr>
			<td align="center"><%=boardDTO.getSeq() %></td>
			<td>
				<%for(int i=0; i<boardDTO.getLev(); i++){%>
					&emsp;
				<%} %>
				<%if(boardDTO.getPseq()!=0){ %>
					<img src="../image/reply.gif" alt="reply">
				<%} %>
				<%=boardDTO.getSubject() %></td>
			<td align="center"><%=boardDTO.getId() %></td>
			<td align="center"><%=new SimpleDateFormat("YYYY.MM.dd").format(boardDTO.getLogtime()) %></td>
			<td align="center"><%=boardDTO.getHit() %></td>
		</tr>
		
	<%}//for %>
<%}%><!--if. null이면 작성한 글이 없으므로 출력하지 않는다 = 출력할 필요가 없다 = 코드 안씀--> 
</table>

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
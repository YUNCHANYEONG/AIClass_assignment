<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="com.koreait.board.BoardDTO" id="boardDTO"/>
<jsp:useBean class="com.koreait.board.BoardDAO" id="boardDAO"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="userid" value="${sessionScope.userid}"/>
	<c:if test="${userid eq null}">
		<script>
			alert('로그인 후 이용하세요');
			location.href='../login.jsp';
		</script>
	</c:if>
	<c:if test="${userid ne null}">
<c:set var="pagenum" value="${param.pagenum}"/>
<c:set var="page_view" value="${boardDAO.page_view(pagenum)}"/>
<c:set var="boardList" value="${boardDAO.selectBoard(page_view)}"/>
<c:set var="count" value="${boardDAO.count()}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 리스트</title>
</head>
<body>
	<h2>커뮤니티 - 리스트</h2>
	<p>게시글 : ${count}개</p>
	<table border="1" width="800">
		<tr>
			<th width="50">번호</th>
			<th width="300">제목</th>
			<th width="100">글쓴이</th>
			<th width="75">조회수</th>
			<th width="200">날짜</th>
			<th width="75">좋아요</th>
		</tr>	
			
		<c:forEach var="item" items="${boardList}">
		${boardDTO.setIdx(item.idx)}
		<c:set var="list_reply" value="${boardDAO.list_reply(boardDTO.getIdx())}"/>
		<tr align="center">
			<th>${item.idx}</th>
			<th><a href='./view.jsp?b_idx=${item.idx}'>${item.title} [${list_reply}]</a></th>
			<th>${item.userid}</th>
			<th>${item.hit}</th>
			<th>${item.regdate}</th>
			<th>${item.like}</th>
		</tr>
		</c:forEach>		

		<tr>
			<td colspan="6"><center>
				<c:set var="page_num" value="${boardDAO.page_num()}"/>
					<c:forEach var="num" items="${page_num}">
							<a href='./list.jsp?pagenum=${num}'>${num} </a>
					</c:forEach>
			</center></td>
		</tr>
		
	</table>
	<p><input type="button" value="글쓰기" onclick="location.href='./write.jsp'"> 
		<input type="button" value="메인" onclick="location.href='../login.jsp'">
	</p>
</body>
</html>
</c:if>
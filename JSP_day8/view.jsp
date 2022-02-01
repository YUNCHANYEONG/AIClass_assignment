<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="com.koreait.board.BoardDTO" id="boardDTO"/>
<jsp:useBean class="com.koreait.board.BoardDAO" id="boardDAO"/>
<jsp:useBean class="com.koreait.reply.ReplyDTO" id="replyDTO"/>
<jsp:useBean class="com.koreait.reply.ReplyDAO" id="replyDAO"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="userid" value="${sessionScope.userid}"/>
<c:set var="b_idx" value="${param.b_idx}"/>
	<c:if test="${userid eq null}">
		<script>
			alert('로그인 후 이용하세요');
			location.href='../login.jsp';
		</script>
	</c:if>
	<c:if test="${userid ne null}">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 글보기</title>
<script>
	function like(){
		const xhr = new XMLHttpRequest();
		
		xhr.open('GET', './like_ok.jsp?b_idx='${b_idx}, true);
		xhr.send();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
				document.getElementById('like').innerHTML = xhr.responseText;
			}
		}
	}
/* 	function replyDelete(r_idx){
		const yn = confirm('삭제하시겠습니까?');
		
		if(yn){
			location.href="./reply_del_ok.jsp?r_idx="+r_idx+"&b_idx=${b_idx};
		}
	} */
</script>

${replyDAO.delete_reply(r_idx)}
</head>
<body>
<c:set var="view" value="${boardDAO.view(b_idx)}"/>
	<h2>커뮤니티 - 리스트</h2>
	<table border="1" width="800">
	<c:forEach var="item" items="${view}">
		<tr>
			<td>제목</td><td>${item.title}</td>
		</tr>
		<tr>
			<td>날짜</td><td>${item.regdate}</td>
		</tr>
		<tr>
			<td>작성자</td><td>${item.userid}</td>
		</tr>
		<tr>
			<td>조회수</td><td>${item.hit}</td>
		</tr>
		<tr>
			<td>좋아요</td><td><span id="like">${item.like}</span></td>
		</tr>
		<tr>
			<td>내용</td><td>${item.content}</td>
		</tr>
		<tr>
			<td>파일</td>
			<td>
			<c:if test="${item.file ne null}">
				<img src='../upload/" + ${item.file} +"' arl='첨부파일' width='150'>
			</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<c:if test="${item.userid eq userid}">		
				<input type="button" value="수정" onclick="location.href='./edit.jsp?b_idx=${b_idx}'"> 
				<input type="button" value="삭제" onclick="location.href='./delete.jsp?b_idx=${b_idx}'"> 
			</c:if>
				<input type="button" value="좋아요" onclick="like()"> 
				<input type="button" value="리스트" onclick="location.href='./list.jsp'">
			</td>
		</tr>
		</c:forEach>
	</table>
	<hr>
	<form method="post" action="reply_ok.jsp">
		<input type="hidden" name="b_idx" value="${b_idx}">
		<p>${userid} : <input type="text" size="40" name="r_content"> <input type="submit" value="확인"></p>
	</form>
	<hr>
	<c:set var="view_reply" value="${replyDAO.view_reply(b_idx)}"/>
	<c:forEach var="item" items="${view_reply}">

	<p>${item.userid} : ${item.content} (${item.regdate})
	<c:if test="${item.userid eq userid}">
		<input type="button" value="삭제" onclick="replyDelete(${item.idx})">
	</c:if>
	</p>
	</c:forEach>
</body>
</html>
</c:if>
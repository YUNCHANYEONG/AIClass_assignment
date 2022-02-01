<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<jsp:useBean class="com.koreait.board.BoardDTO" id="boardDTO"/>
<jsp:useBean class="com.koreait.board.BoardDAO" id="boardDAO"/>
<jsp:useBean class="com.koreait.reply.ReplyDTO" id="replyDTO"/>
<jsp:useBean class="com.koreait.reply.ReplyDAO" id="replyDAO"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="userid" value="${sessionScope.userid}"/>
<c:set var="r_idx" value="${param.r_idx}"/>
<c:set var="b_idx" value="${param.b_idx}"/>
	<c:if test="${userid eq null}">
		<script>
			alert('로그인 후 이용하세요');
			location.href='../login.jsp';
		</script>
	</c:if>
	<c:if test="${userid ne null}">
		
	<c:set var=delete_reply" value="${replyDAO.delete_reply(r_idx)}"/>
	<script>
		alert('댓글이 삭제되었습니다.');
		location.href='./view.jsp?b_idx=${b_idx}';
	</script>
</c:if>
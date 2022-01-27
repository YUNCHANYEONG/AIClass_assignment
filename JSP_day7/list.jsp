<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="com.koreait.member.MemberDTO" id="member"/>
<jsp:useBean class="com.koreait.member.MemberDAO" id="memberDAO"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="userid" value="${sessionScope.userid}"/>
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
<title>커뮤니티 - 리스트</title>
</head>
<body>
	<h2>커뮤니티 - 리스트</h2>
	<c:set var="count" value="<%=memberDAO.count()%>"/>
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
	<c:set var="list" value="<%=memberDAO.list()%>"/>
		<c:forEach var="student" items="${list}">
			<tr>
				<td>${student[0]}</td>
				${member.setIdx(student[0])}
				<c:set var="list_reply" value="<%=memberDAO.list_reply(member)%>"/>
				<td>${student[1]}[${list_reply}]</td>
				<td>${student[2]}</td>
				<td>${student[3]}</td>
				<td>${student[4]}</td>
				<td>${student[5]}</td>
			</tr>
		</c:forEach>	
			<tr>
				<td colspan="6"><center>
					<c:set var="page_num" value="<%=memberDAO.page_num()%>"/>
						<c:forEach var="num" items="${page_num}">
								<a href='./list.jsp?pagenum=${num}'>${num}${request.setParameter("pagenum", num)} </a>
						</c:forEach>
				</center></td>
			</tr>	
	</table>
	<p>
		<input type="button" value="글쓰기" onclick="location.href='./write.jsp'"> 
		<input type="button" value="메인" onclick="location.href='../login.jsp'">
	</p>
</body>
</html>
	</c:if>	
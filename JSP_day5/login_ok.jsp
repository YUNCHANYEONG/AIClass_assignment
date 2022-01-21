<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<jsp:useBean class="com.koreait.member.MemberDTO" id="member"/>
<jsp:setProperty property="userid" name="member"/>
<jsp:setProperty property="userpw" name="member"/>
<jsp:setProperty property="username" name="member"/>

<jsp:useBean class="com.koreait.member.MemberDAO" id="memberDAO"/>
<%
	if(memberDAO.login(member) != null){
		session.setAttribute("userid", member.getUserid());
		session.setAttribute("name", member.getUsername());
		session.setAttribute("idx", member.getIdx());
%>
	<script>
		alert('로그인되었습니다.');
		location.href="login.jsp";
	</script>
<%
	}else{ // 로그인 실패
%>	
	<script>
		alert('아이디 또는 비밀번호를 확인하세요');
		history.back();	
	</script>
<%
}
%>	
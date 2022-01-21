<%@page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="com.koreait.member.MemberDTO" id="member"/>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = (String)session.getAttribute("userid");
%>
<jsp:setProperty property="*" name="member"/>
<jsp:setProperty property="userid" name="member" value="<%=userid%>"/>
<jsp:setProperty property="username" param="name" name="member"/>
<%
	if(userid == null){
%>
	<script>
		alert('로그인 후 이용하세요');
		location.href='./login.jsp';
	</script>
<%	
	}else{
%>
<jsp:useBean class="com.koreait.member.MemberDAO" id="memberDAO"/>		
<%
		if(memberDAO.edit(member) > 0){
%>
	<script>
		alert('정보정보가 수정되었습니다.');
		location.href='./info.jsp';
	</script>
<%
		}else{
%>
	<script>
		alert('정보정보 수정이 실패했습니다.');
		history.back();
	</script>
<%
		}
}
%>
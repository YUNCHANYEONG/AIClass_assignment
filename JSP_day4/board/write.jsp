<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = (String)session.getAttribute("userid");
	if(userid == null){
%>
<script>
	alert('로그인 후 이용하세요');
	location.href='../login.jsp';
</script> 
<%		
	}else{
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 글쓰기</title>
</head>
<body>
	<h2>커뮤니티 - 글쓰기</h2>
	 <form method="post" action="./write_ok.jsp">
	 	<p>작성자 : <%=userid%></p>
	 	<p>제목<input type="text" name="b_title"></p>
	 	<p>내용</p>
	 	<p><textarea name="b_content" rows="5" column="40"></textarea></p>
	 	<p><input type="submit" value="등록"> <input type="reset" value="다시작성"> <input type="button" value="리스트" onclick="location.href='list.jsp'"></p>
	 </form>
</body>
</html>
<%	
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="java.sql.*"%>
<%
	if(session.getAttribute("userid") == null){
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
<title>커뮤니티 - 리스트</title>
</head>
<body>
	<h2>커뮤니티 - 리스트</h2>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";	
	
	int totalCount = 0;
	
	try {
		conn = Dbconn.getConnection();
		sql = "select count(b_idx) as total from tb_board;";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			totalCount = rs.getInt("total");
		}
		
		sql = "select b_idx, b_title, b_userid, b_hit, b_regdate, b_like from tb_board order by b_idx DESC;";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
				
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
	<p>게시글 : <%=totalCount%>개</p>
	<table border="1" width="800">
		<tr>
			<th width="50">번호</th>
			<th width="300">제목</th>
			<th width="100">글쓴이</th>
			<th width="75">조회수</th>
			<th width="200">날짜</th>
			<th width="75">좋아요</th>
		</tr>		
<% 
	while(rs.next()){
	String b_idx = rs.getString("b_idx");
	String b_title = rs.getString("b_title");
	String b_userid = rs.getString("b_userid");
	int b_hit = rs.getInt("b_hit");
	String b_regdate = rs.getString("b_regdate").substring(0, 10);
	int b_like = rs.getInt("b_like");
	
	
	
	ResultSet rs1 = null;
	int re_total = 0;
	
	try {
	sql = "select count(r_boardidx) as re_total from tb_reply where r_boardidx=?;";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, b_idx);
	rs1 = pstmt.executeQuery();

	} catch (Exception e) {
		e.printStackTrace();
	}
	if(rs1.next()){
		re_total = rs1.getInt("re_total");
	}
	if(re_total == 0){
%>
		<tr align="center">
			<th><%=b_idx%></th>
			<th><a href="./view.jsp?b_idx=<%=b_idx%>"><%=b_title%></a></th>
			<th><%=b_userid%></th>
			<th><%=b_hit%></th>
			<th><%=b_regdate%></th>
			<th><%=b_like%></th>
		</tr>		
<% 
		}else{
%>
		<tr align="center">
			<th><%=b_idx%></th>
			<th><a href="./view.jsp?b_idx=<%=b_idx%>"><%=b_title%> [<%=re_total%>]</a></th>
			<th><%=b_userid%></th>
			<th><%=b_hit%></th>
			<th><%=b_regdate%></th>
			<th><%=b_like%></th>
		</tr>		
<% 
	}
}
%>
	</table>
	<p><input type="button" value="글쓰기" onclick="location.href='./write.jsp'"> 
		<input type="button" value="메인" onclick="location.href='../login.jsp'">
	</p>
</body>
</html>
<%	
}
%>
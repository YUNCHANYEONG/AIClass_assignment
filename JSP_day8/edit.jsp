<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userid = (String)session.getAttribute("userid");
	if(userid == null){
%>
<script>
	alert('로그인 후 이용하세요');
	location.href='../login.jsp';
</script> 
<%		
	}else{
		
		String b_idx = request.getParameter("b_idx");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String b_title = "";
		String b_content = "";
		String b_file = "";
		
		
		String sql = "";
		
		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				sql = "select b_title, b_content, b_file from tb_board where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					b_title = rs.getString("b_title");
					b_content = rs.getString("b_content");
					b_file = rs.getString("b_file"); // DB에서 받을땐 String
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 글수정</title>
</head>
<body>
	<h2>커뮤니티 - 글수정</h2>
	 <form method="post" action="./edit_ok.jsp" enctype="multipart/form-data">
		<input type="hidden" name="b_idx" value="<%=b_idx%>">
	 	<p>작성자 : <%=userid%></p>
	 	<p>제목<input type="text" name="b_title" value="<%=b_title%>"></p>
	 	<p>내용</p>
	 	<p><textarea name="b_content" rows="5" column="40"><%=b_content%></textarea></p>
	 	<p>
			<%
				if(b_file != null && !b_file.equals("")){
					out.println("<img src='../upload/" + b_file +"' arl='첨부파일' width='150'>");
				}
			%>
	 	</p>
	 	<p><input type="file" name="b_file"></p>
	 	<p><input type="submit" value="수정"> <input type="reset" value="다시작성"> <input type="button" value="리스트" onclick="location.href='list.jsp'"></p>
	 </form>
</body>
</html>
<%	
	}
%>
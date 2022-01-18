<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("userid"); // apple
	String userpw = request.getParameter("userpw"); // 1111
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String sql = "";
	String url = "jdbc:mysql://localhost:3306/aiclass";
	String uid = "root";
	String upw = "1234";

	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, uid, upw);
		if (conn != null) {
			sql = "select mem_idx, mem_name from tb_member where mem_userid=? and mem_userpw=?";
			pstmt = conn.prepareStatement(sql); // 컴파일
			pstmt.setString(1, userid);
			pstmt.setString(2, userpw);
			rs = pstmt.executeQuery();
			if(rs.next()){ // 로그인 성공
				session.setAttribute("userid", userid);
				session.setAttribute("idx", rs.getString("mem_idx"));
				session.setAttribute("name", rs.getString("mem_name"));
%>
			<script>
				alert('로그인되었습니다.');
				location.href="login.jsp"; // 새로 패이지를 여는 방법
			</script>
<%
			}else{ // 로그인 실패
%>	
			<script>
				alert('아이디 또는 비밀번호를 확인하세요');
				history.back();				// 그 전 패이지를 기억하고 전 패이지로 이동
			</script>
<%
			}
		}	
	} catch (Exception e) {
		e.printStackTrace();
}
%>	
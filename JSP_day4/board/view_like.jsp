<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%
	int b_like = Integer.parseInt(request.getParameter("b_like"));
	String b_idx = request.getParameter("b_idx");
	
	b_like++;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "";
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			sql = "update tb_board set b_like = ? where b_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_like);
			pstmt.setString(2, b_idx);
			pstmt.executeUpdate();
		}
	}catch (Exception e) {
		e.printStackTrace();
	}
	out.println(b_like);
%>
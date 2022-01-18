<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// localhost:8080/Day3/1_Ajax_ok.jsp?userid=apple
	String userid = request.getParameter("userid");	// apple

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
			sql = "select mem_userid from tb_member where mem_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				out.println("no"); // 중복 아이디가 있는 경우
			}else{
				out.println("ok"); // 중복 아이디가 없는 경우
			}
		}
		} catch (Exception e) {
		e.printStackTrace();
	}
%>

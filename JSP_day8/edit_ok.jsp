<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
		String uploadPath = request.getRealPath("upload");
		int size = 1024*1024*10;
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		
		String b_idx = "";
		
		try{
			MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
			b_idx = multi.getParameter("b_idx");
			String b_title = multi.getParameter("b_title");
			String b_content = multi.getParameter("b_content"); 
			String b_file = multi.getFilesystemName("b_file");
			
			conn = Dbconn.getConnection();
			if(conn != null){
                if(b_file != null && !b_file.equals("")){ /* b_file 가 null이 아니고 ""가 아니면*/
                    sql = "update tb_board set b_title = ?, b_content = ?, b_file = ? where b_idx = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, b_title);
                    pstmt.setString(2, b_content);
                    pstmt.setString(3, b_file);
                    pstmt.setString(4, b_idx);
                    pstmt.executeUpdate();
                }else{	/* b_file 가 null이거나 ""이면*/
                      sql = "update tb_board set b_title = ?, b_content = ? where b_idx = ?";
                      pstmt = conn.prepareStatement(sql);
                      pstmt.setString(1, b_title);
                      pstmt.setString(2, b_content);
                      pstmt.setString(3, b_idx);
                      pstmt.executeUpdate();
                }
            }
		}catch (Exception e) {
			e.printStackTrace();
		}	
%>
<script>
	alert('게시글이 수정되었습니다.');
	location.href='./view.jsp?b_idx=<%=b_idx%>';
</script>
<%
	}
%>
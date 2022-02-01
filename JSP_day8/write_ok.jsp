<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.db.Dbconn" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- 파일 업로드간 필요 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 파일 업로드간 필요 -->
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
		String uploadPath = request.getRealPath("upload"); // 저장위치 설정
		// System.out.println(uploadPath); // 저장위치를 확인 : 확인한 장소에 같은 폴더 하나더 생성하기위해
		int size = 1024*1024*10; // 파일크기 설정 : 10MB
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "";

		try {
			/* MultipartRequest의 객체를 생성하고 생성된 참조변수로 getParameter(일반변수), getFilesystemName(파일) 불러옴*/
			/* MultipartRequest(request, 저장위치, 파일크기, 인코딩타입, 파일정책) */
			MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
			String b_title = multi.getParameter("b_title");
			String b_content = multi.getParameter("b_content"); 
			String b_file = multi.getFilesystemName("b_file"); /* DB내부에는 파일의 이름이 저장됨 */
			
			conn = Dbconn.getConnection();
			if (conn != null) {
				sql = "insert into tb_board (b_userid, b_title, b_content, b_file) values (?, ?, ?, ?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, b_title);
				pstmt.setString(3, b_content);
				pstmt.setString(4, b_file);
				pstmt.executeUpdate();
			}
		
		} catch (Exception e) {
		e.printStackTrace();
	}
%>
<script>
	alert('게시글이 등록되었습니다.');
	location.href='./list.jsp';
</script>
<%
	}
%>
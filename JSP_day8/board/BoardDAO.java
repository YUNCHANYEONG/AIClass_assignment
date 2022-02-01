package com.koreait.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.koreait.db.Dbconn;
import com.koreait.member.MemberDTO;
import com.koreait.reply.ReplyDTO;

public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	List<BoardDTO> boardList = new ArrayList<BoardDTO>();
	String sql = "";
	
	public List<BoardDTO> selectBoard(int num){
		try {
			conn = Dbconn.getConnection();
			sql = "select b_idx, b_title, b_userid, b_hit, b_regdate, b_like, b_file from tb_board order by b_idx DESC limit ?, 10;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setIdx(rs.getLong("b_idx"));
				board.setUserid(rs.getString("b_userid"));
				board.setTitle(rs.getString("b_title"));
				board.setHit(rs.getInt("b_hit"));
				board.setLike(rs.getInt("b_like"));
				board.setRegdate(rs.getString("b_regdate"));
				board.setFile(rs.getString("b_file"));
				boardList.add(board);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return boardList;
	}
	
	public String count(){
		try {
			conn = Dbconn.getConnection();
			sql = "select count(b_idx) as total from tb_board;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				return rs.getString("total");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return null;
	}
	
	public long list_reply(long idx){
		try {
			ResultSet rs1 = null;
			
			conn = Dbconn.getConnection();
			sql = "select count(r_idx) as replycount from tb_reply where r_boardidx=?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, idx);
			rs1 = pstmt.executeQuery();
			
			while(rs1.next()) {
				return rs1.getInt("replycount");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return 0;
	}
	
	public String[] page_num() {
		try {
			ResultSet rs1 = null;
			
			conn = Dbconn.getConnection();
			sql = "select count(b_idx) as total from tb_board;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getInt("total")%10 == 0) {
					String str = "";
					for(int i = 1 ; i <= rs.getInt("total")/10 ; i++) {
						str = str + i + " ";
					}
					return str.split(" ");
				}else {
					String str = "";
					for(int i = 1 ; i <= (rs.getInt("total")/10)+1 ; i++) {
						str = str + i + " ";
					}
					return str.split(" ");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return null;
	}
	
	public int page_view(int num) {
		int pagePerCount = 10;
	    int start = 0;
	    int pagenum = (num == 0 ? 0 : num);

	    if(pagenum != 0){
	        start = (pagenum-1) * pagePerCount;
	    }	
	    return start;
	}
	
	public List<BoardDTO> view(int b_idx) {
		List list = new ArrayList();
		try{			
			conn = Dbconn.getConnection();
			if(conn != null){
				
				sql = "update tb_board set b_hit = b_hit + 1 where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b_idx);
				pstmt.executeUpdate();
				
				sql = "select b_idx, b_userid, b_title, b_content, b_regdate, b_like, b_hit, b_file from tb_board where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b_idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					BoardDTO boardDTO = new BoardDTO();
					boardDTO.setUserid(rs.getString("b_userid"));
					boardDTO.setTitle(rs.getString("b_title"));
					boardDTO.setContent(rs.getString("b_content"));
					boardDTO.setRegdate(rs.getString("b_regdate"));
					boardDTO.setLike(rs.getInt("b_like"));
					boardDTO.setHit(rs.getInt("b_hit"));
					boardDTO.setFile(rs.getString("b_file"));
					list.add(boardDTO);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	

}

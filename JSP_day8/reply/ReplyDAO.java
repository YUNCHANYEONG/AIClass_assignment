package com.koreait.reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.koreait.db.Dbconn;

public class ReplyDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	String sql = "";
	
	public List<ReplyDTO> view_reply(int b_idx) {
		List list = new ArrayList();
		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				
				sql = "select r_idx, r_userid, r_content, r_regdate from tb_reply where r_boardidx=? order by r_idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b_idx);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ReplyDTO replyDTO = new ReplyDTO();
					replyDTO.setIdx(rs.getInt("r_idx"));
					replyDTO.setUserid(rs.getString("r_userid"));
					replyDTO.setContent(rs.getString("r_content"));
					replyDTO.setRegdate(rs.getString("r_regdate"));
					list.add(replyDTO);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}	
		return list;
	}
	
	public void delete_reply(int r_idx) {
		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				sql = "delete from tb_reply where r_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, r_idx);
				pstmt.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}

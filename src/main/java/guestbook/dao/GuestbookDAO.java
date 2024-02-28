package guestbook.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import board.bean.BoardDTO;
import guestbook.bean.GuestbookDTO;

public class GuestbookDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String username = "c##java";
	private String password = "1234";

	private static GuestbookDAO guestbookDAO = new GuestbookDAO();// 프로그램이 끝날 때까지 메모리 차지.

	public static GuestbookDAO getInstance() {// 그래서 한번 만들어지면 계속 씀 = 메모리 부담
		return guestbookDAO;
	}

	public GuestbookDAO() {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}// constructor

	public void getConnection() {
		try {
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}// getConnection

	public int getTotalA() {
		String sql = "select count(*) as total from guestbook";
		getConnection();
		int total = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			total = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {// 안닫아두면 몇번 검사하다가 터짐
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return total;

	}

	public void writeGuestbook(Map<String, String> map) {
		GuestbookDTO guestbookDTO = null;
		String sql = "INSERT INTO GUESTBOOK(SEQ, NAME, EMAIL, HOMEPAGE, SUBJECT, CONTENT, LOGTIME) "
				+ "VALUES(seq_guestbook.NEXTVAL,?,?,?,?,?,SYSDATE)";
		getConnection();
		
		
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, map.get("name"));
				pstmt.setString(2, map.get("email"));				
				pstmt.setString(3, map.get("homepage"));
				pstmt.setString(4, map.get("subject"));
				pstmt.setString(5, map.get("content"));

				rs = pstmt.executeQuery();// RsultSet 실행 리턴
				if (rs.next()) {
					guestbookDTO = new GuestbookDTO();
					guestbookDTO.setSeq(rs.getInt("seq"));
					guestbookDTO.setName(rs.getString("name"));
					guestbookDTO.setEmail(rs.getString("email"));
					guestbookDTO.setHomepage(rs.getString("homepage"));
					guestbookDTO.setSubject(rs.getString("subject"));
					guestbookDTO.setContent(rs.getString("content"));
					guestbookDTO.setLogtime(rs.getDate("LOGTIME"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {// 안닫아두면 몇번 검사하다가 터짐
				try {
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			
	}


	public List<GuestbookDTO> guestbookList(int startNum, int endNum) {
		List<GuestbookDTO> list = new ArrayList<GuestbookDTO>();
		String sql ="""
					select * from guestbook order by seq desc
					""";
		getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				GuestbookDTO guestbookDTO = new GuestbookDTO();
				guestbookDTO.setSeq(rs.getInt("seq"));
				guestbookDTO.setName(rs.getString("name"));
				guestbookDTO.setEmail(rs.getString("email"));
				guestbookDTO.setHomepage(rs.getString("homepage"));
				guestbookDTO.setSubject(rs.getString("subject"));
				guestbookDTO.setContent(rs.getString("content"));
				guestbookDTO.setLogtime(rs.getDate("logtime"));
				list.add(guestbookDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
}

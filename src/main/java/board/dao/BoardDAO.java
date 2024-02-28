package board.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import board.bean.BoardDTO;
import member.bean.MemberDTO;

public class BoardDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String username = "c##java";
	private String password = "1234";

	private static BoardDAO boardDAO = new BoardDAO();// 프로그램이 끝날 때까지 메모리 차지.

	public static BoardDAO getInstance() {// 그래서 한번 만들어지면 계속 씀 = 메모리 부담
		return boardDAO;
	}

	public BoardDAO() {
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

	/*
	 * public BoardDTO writeBoard(String id, String name, String email, String
	 * subject,String content) { BoardDTO boardDTO=null; String
	 * sql="INSERT INTO BOARD(SEQ, ID, NAME, EMAIL, SUBJECT, CONTENT, REF) " +
	 * "VALUES(seq_board.NEXTVAL,?,?,?,?,?,seq_board.NEXTVAL)"; getConnection(); try
	 * { pstmt=conn.prepareStatement(sql);
	 * 
	 * pstmt.setString(1, id); pstmt.setString(2, name); pstmt.setString(3, email);
	 * pstmt.setString(4, subject); pstmt.setString(5, content);
	 * 
	 * 
	 * //만약에 id와 pwd가 일치하는 컬럼이 있다면 match를 true로 바꾸기
	 * rs=pstmt.executeQuery();//RsultSet 실행 리턴 if(rs.next()) { boardDTO= new
	 * BoardDTO(); boardDTO.setSeq(rs.getInt("seq"));
	 * boardDTO.setName(rs.getString("name")); boardDTO.setId(rs.getString("id"));
	 * boardDTO.setEmail(rs.getString("email"));
	 * boardDTO.setSubject(rs.getString("subject"));
	 * boardDTO.setContent(rs.getString("content"));
	 * boardDTO.setRef(rs.getInt("ref")); }
	 * 
	 * return boardDTO; } catch (SQLException e) { // TODO Auto-generated catch
	 * block e.printStackTrace(); }finally{//안닫아두면 몇번 검사하다가 터짐 try { if(pstmt
	 * !=null) pstmt.close(); if(conn != null)conn.close(); } catch (SQLException e)
	 * { e.printStackTrace(); }
	 * 
	 * } return boardDTO; }
	 */
	public void writeBoard(Map<String, String> map) {
		BoardDTO boardDTO = null;
		String sql = "INSERT INTO BOARD(SEQ, ID, NAME, EMAIL, SUBJECT, CONTENT, REF) "
				+ "VALUES(seq_board.NEXTVAL,?,?,?,?,?,seq_board.NEXTVAL)";
		// 한줄을 동시에 처리하므로 뒤쪽 seq_board.NEXTVAL 대신 currentval도 가능하다.
		getConnection();
		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, map.get("id"));
			pstmt.setString(2, map.get("name"));
			pstmt.setString(3, map.get("email"));
			pstmt.setString(4, map.get("subject"));
			pstmt.setString(5, map.get("content"));

			// 만약에 id와 pwd가 일치하는 컬럼이 있다면 match를 true로 바꾸기
			rs = pstmt.executeQuery();// RsultSet 실행 리턴
			if (rs.next()) {
				boardDTO = new BoardDTO();
				boardDTO.setSeq(rs.getInt("seq"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setId(rs.getString("id"));
				boardDTO.setEmail(rs.getString("email"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setRef(rs.getInt("ref"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {// 안닫아두면 몇번 검사하다가 터짐
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

	public void board2Table(BoardDTO boardDTO) {
		String sql = "INSERT INTO board(SEQ, ID, NAME, EMAIL, SUBJECT, CONTENT, REF) values(?,?,?,?,?,?,?)";
		getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardDTO.getSeq());
			pstmt.setString(2, boardDTO.getId());
			pstmt.setString(3, boardDTO.getName());
			pstmt.setString(4, boardDTO.getEmail());
			pstmt.setString(5, boardDTO.getSubject());
			pstmt.setString(6, boardDTO.getContent());
			pstmt.setInt(7, boardDTO.getRef());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<BoardDTO> boardList(int startNum, int endNum) {
		//String sql = "select * from board order by seq desc";
		String sql ="""
					select * from  
						(select rownum rn, tt.* from 
						(select * from board order by ref desc, step asc)tt
				     	) where rn>=? and rn<=?
						""";
		List<BoardDTO> list = new ArrayList<BoardDTO>();

		getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startNum);
			pstmt.setInt(2, endNum);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO boardDTO = new BoardDTO();
				boardDTO.setSeq(rs.getInt("seq"));
				boardDTO.setId(rs.getString("id"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setEmail(rs.getString("email"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setSeq(rs.getInt("seq"));
				boardDTO.setRef(rs.getInt("ref"));
				boardDTO.setLev(rs.getInt("lev"));
				boardDTO.setStep(rs.getInt("step"));
				boardDTO.setPseq(rs.getInt("pseq"));
				boardDTO.setReply(rs.getInt("reply"));
				boardDTO.setHit(rs.getInt("hit"));
				boardDTO.setLogtime(rs.getDate("logtime"));//rs.getTimestamp("logtime")

				list.add(boardDTO);
			} // while
		} catch (SQLException e) {
			e.printStackTrace();
			list = null;
		} finally {// 안닫아두면 몇번 검사하다가 터짐
			try {
				if (rs != null)	rs.close();
				if (pstmt != null)	pstmt.close();
				if (conn != null)	conn.close();
			} catch (SQLException e) {
				e.printStackTrace();

			}
		}
		return list;
	}

	public int getTotalA() {
		String sql = "select count(*) as total from board";
		getConnection();
		int total = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			total=rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {// 안닫아두면 몇번 검사하다가 터짐
			try {
				if (rs != null)	rs.close();
				if (pstmt != null)	pstmt.close();
				if (conn != null)	conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
		return total;

	}
}

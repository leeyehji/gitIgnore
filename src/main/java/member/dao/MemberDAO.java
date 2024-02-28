package member.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import member.bean.MemberDTO;
//ojabc11.jar 위치 = "D:\Oracle\sqldeveloper-23.1.1.345.2114-x64\sqldeveloper\jdbc\lib\ojdbc11.jar"
public class MemberDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private String driver="oracle.jdbc.driver.OracleDriver";
	private String url="jdbc:oracle:thin:@localhost:1521:xe";
	private String username="c##java"; 
	private String password="1234";
	
	private static MemberDAO memberDAO= new MemberDAO();//프로그램이 끝날 때까지 메모리 차지.
	public static MemberDAO getInstance(){//그래서 한번 만들어지면 계속 씀 = 메모리 부담
		return memberDAO;
	}
	
	public MemberDAO() {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}//constructor
	
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(url,username,password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//getConnection
	
	public boolean isExistId(String id) {
		boolean exist =false;
		String sql= "SELECT * FROM MEMBER WHERE ID =?";
		getConnection();
		try {
			pstmt= conn.prepareStatement(sql);//생성
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();//ResultSet 실행 리턴
			
			if(rs.next()) exist=true;//레코드 존재
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally{//안닫아두면 몇번 검사하다가 터짐
			try {
				if(rs!=null)rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn != null)conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		return exist;
	}
	public MemberDTO getMember(String id) {
		MemberDTO memberDTO = null;
		String sql= "SELECT * FROM MEMBER WHERE ID =?";
		getConnection();
		try {
			pstmt= conn.prepareStatement(sql);//생성
			pstmt.setString(1, id);
			
			
			//만약에 id와 pwd가 일치하는 컬럼이 있다면 match를 true로 바꾸기
			rs=pstmt.executeQuery();//RsultSet 실행 리턴
			if(rs.next()) {
				memberDTO= new MemberDTO();
				memberDTO.setName(rs.getString("name"));
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPwd(rs.getString("pwd"));
				memberDTO.setGender(rs.getString("gender"));
				memberDTO.setEmail1(rs.getString("email1"));
				memberDTO.setEmail2(rs.getString("email2"));
				memberDTO.setTel1(rs.getString("tel1"));
				memberDTO.setTel2(rs.getString("tel2"));
				memberDTO.setTel3(rs.getString("tel3"));
				memberDTO.setZipcode(rs.getString("zipcode"));
				memberDTO.setAddr1(rs.getString("addr1"));
				memberDTO.setAddr2(rs.getString("addr2"));
			}
			} catch (SQLException e) {
				e.printStackTrace();
		}finally{//안닫아두면 몇번 검사하다가 터짐
			try {
					if(rs!=null)rs.close();
					if(pstmt !=null) pstmt.close();
					if(conn != null)conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
			}
		}
		return memberDTO;
	}
	public int write(MemberDTO memberDTO) {//student 참고
		int su=0;
		try {//테이블에 값을 넣기
			//db 명령어 넣을 거임
			String sql= "INSERT INTO member(name, id, pwd, gender, email1, email2, tel1, tel2, tel3, zipcode, addr1, addr2) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			//db 연결
			getConnection();
			
			pstmt = conn.prepareStatement(sql);
			String name= memberDTO.getName();
			pstmt.setString(1, name);
			pstmt.setString(2, memberDTO.getId());
			pstmt.setString(3, memberDTO.getPwd());
			pstmt.setString(4, memberDTO.getGender());
			pstmt.setString(5, memberDTO.getEmail1());
			pstmt.setString(6, memberDTO.getEmail2());
			pstmt.setString(7, memberDTO.getTel1());
			pstmt.setString(8, memberDTO.getTel2());
			pstmt.setString(9, memberDTO.getTel3());
			pstmt.setString(10, memberDTO.getZipcode());
			pstmt.setString(11, memberDTO.getAddr1());
			pstmt.setString(12, memberDTO.getAddr2());
			
			//제발 1이여야 해
			su = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {//연결 미 해제 시 메모리 터짐. 사용했으면 정리해주자.
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return su;
	}
	
	//id와 pw가 일치하는 지 확인
	public MemberDTO checkLogin(String id, String pwd) {
		MemberDTO memberDTO=null;
		String sql= "SELECT * FROM MEMBER WHERE ID =? and PWD=?";
		getConnection();
		try {
			pstmt= conn.prepareStatement(sql);//생성
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			
			//만약에 id와 pwd가 일치하는 컬럼이 있다면 match를 true로 바꾸기
			rs=pstmt.executeQuery();//RsultSet 실행 리턴
			if(rs.next()) {
				memberDTO= new MemberDTO();
				memberDTO.setName(rs.getString("name"));
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPwd(rs.getString("pwd"));
				memberDTO.setGender(rs.getString("gender"));
				memberDTO.setEmail1(rs.getString("email1"));
				memberDTO.setEmail2(rs.getString("email2"));
				memberDTO.setTel1(rs.getString("tel1"));
				memberDTO.setTel2(rs.getString("tel2"));
				memberDTO.setTel3(rs.getString("tel3"));
				memberDTO.setZipcode(rs.getString("zipcode"));
				memberDTO.setAddr1(rs.getString("addr1"));
				memberDTO.setAddr2(rs.getString("addr2"));
			}
			} catch (SQLException e) {
				e.printStackTrace();
		}finally{//안닫아두면 몇번 검사하다가 터짐
			try {
					if(rs!=null)rs.close();
					if(pstmt !=null) pstmt.close();
					if(conn != null)conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
			}
		}

		return memberDTO;
	}
	
	public void update(MemberDTO memberDTO) {
		try {//테이블에 값을 넣기
			//db 명령어 넣을 거임
			String sql= """
					UPDATE member SET name=?
									, pwd=?
									, gender=?
									, email1=?
									, email2=?
									, tel1=?
									, tel2=?
									, tel3=?
									, zipcode=?
									, addr1=?
									, addr2=?
					WHERE ID=?
					""";
			//db 연결
			getConnection();
			
			pstmt = conn.prepareStatement(sql);
			String name= memberDTO.getName();
			pstmt.setString(1,  memberDTO.getName());
			pstmt.setString(2, memberDTO.getPwd());
			pstmt.setString(3, memberDTO.getGender());
			pstmt.setString(4, memberDTO.getEmail1());
			pstmt.setString(5, memberDTO.getEmail2());
			pstmt.setString(6, memberDTO.getTel1());
			pstmt.setString(7, memberDTO.getTel2());
			pstmt.setString(8, memberDTO.getTel3());
			pstmt.setString(9, memberDTO.getZipcode());
			pstmt.setString(10, memberDTO.getAddr1());
			pstmt.setString(11, memberDTO.getAddr2());
			pstmt.setString(12, memberDTO.getId());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {//연결 미 해제 시 메모리 터짐. 사용했으면 정리해주자.
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
}

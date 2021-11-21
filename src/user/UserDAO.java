package user;

import java.sql.*;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimeZone=UTC";
			String id = "root";
			String pw = "1234";  
			
			Class.forName("com.mysql.jdbc.Driver");


			Connection conn = DriverManager.getConnection(dbURL, id, pw);
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//로그인 영역
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(sql); //sql쿼리문을 대기 시킨다
			pstmt.setString(1, userID); //첫번째 '?'에 매개변수로 받아온 'userID'를 대입
			rs = pstmt.executeQuery(); //쿼리를 실행한 결과를 rs에 저장
			
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				
				else
					return 0; //비밀번호 틀림
			}
			
			return -1; //아이디 없음
			
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return -2; //오류
	}
	
	public int join(User user) {
		  String sql = "insert into user values(?, ?, ?, ?, ?)";
		  try {
		    pstmt = conn.prepareStatement(sql);
		    pstmt.setString(1, user.getUserID());
		    pstmt.setString(2, user.getUserPassword());
		    pstmt.setString(3, user.getUserName());
		    pstmt.setString(4, user.getUserGender());
		    pstmt.setString(5, user.getUserEmail());
		    return pstmt.executeUpdate();
		  }
		  
		  catch (Exception e) {
		 	e.printStackTrace();
		  }
		  
		  return -1;
	}
}

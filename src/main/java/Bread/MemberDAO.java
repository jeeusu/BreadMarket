package Bread;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private Connection conn;
	
	public MemberDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn=DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/bread",
				"root",
				"1234" );	
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean overlappedId(String id) {
		boolean result=false;
		try {
			System.out.print(id);
			String query="select if(count(*)=1,'true','false') from member where id=?";
			
			PreparedStatement pstmt = conn.prepareStatement(query);
			System.out.print("prepareStatement: "+ query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,id);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			result=Boolean.parseBoolean(rs.getString(1));
			System.out.print(result);
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}




package Board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBManager {
	
	public static Connection getConnection() {
		
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn=DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/bread",
				"root",
				"1234" );	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}

	
}


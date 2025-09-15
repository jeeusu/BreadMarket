package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class BoardDAO {
	
	public static BoardDAO instance;

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	private BoardDAO() {}
	
	public static BoardDAO getInstance() {
		if(instance==null)
			instance=new BoardDAO();
		return instance;
	}
	
	public int getListCount() {
		int count=0;
		
		try {	
			conn=DBManager.getConnection();
			
			String sql = ""+"SELECT count(*) FROM board ";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next())
				count = rs.getInt("count(*)");
			
			if(rs!=null)
				rs.close();
			if(ps!=null)
				ps.close();
			if(conn!=null)
				conn.close();
			
			System.out.println("게시글 수 :"+count);
		} catch (Exception e){ e.printStackTrace();	}
		
		return count;
	}
	
	public ArrayList<Board> getBoardList(int pageNum) {
		ArrayList<Board> board = new ArrayList<>();
		
		int limit = 10;
		int start = (pageNum-1)*limit;
		
		int hit=0;
		int num=0;
		try {
			conn=DBManager.getConnection();
			
			String sql = ""+"SELECT num, id, hit, title, regist FROM board ORDER BY num DESC LIMIT ?, 10 ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,start);
			
			rs = ps.executeQuery();
			
			while (rs.next()) {
				Board bd = new Board();
				
				num = rs.getInt("num");
				bd.setNum(num);
				
				String id = rs.getString("id");
				bd.setId(id);
				
				String title = rs.getString("title");
				bd.setTitle(title);
				
				String regist = rs.getString("regist");
				bd.setRegist(regist);
				
				hit = rs.getInt("hit");
				bd.setHit(hit);
				
				board.add(bd);
			}
			
			if(rs!=null)
				rs.close();
			if(ps!=null)
				ps.close();
			if(conn!=null)
				conn.close();
			
		}catch (Exception e) { e.printStackTrace(); }
		
		return board;
	}
	
	public boolean getWriteBoard(String id, String title, String bcontent) {	
		SimpleDateFormat simpledate = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String date = simpledate.format(now);
		boolean result = false;
		
		try {
			conn=DBManager.getConnection();
			
			String sql = ""+"INSERT INTO board VALUES (null, ?, ?, ?, ?, 0) ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,id);
			ps.setString(2,title);
			ps.setString(3,bcontent);
			ps.setString(4,date);
			
			int rows = ps.executeUpdate();
			
			if(rows>0)
				result=true;
			else
				result=false;
			
			if(ps!=null)
				ps.close();
			if(conn!=null)
				conn.close();
			
		}catch(Exception e) { e.printStackTrace(); }
		
		return result;
	}
	
	public Board getBoard(String num) {
		Board bd = new Board();
		int hit=0;
		
		try {
			conn=DBManager.getConnection();
						
			String sql = ""+"SELECT id, title, bcontent, regist, hit FROM board WHERE num=? "; 
			ps = conn.prepareStatement(sql);
			ps.setString(1,num);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				String id = rs.getString("id");
				bd.setId(id);
				
				String title = rs.getString("title");
				bd.setTitle(title);
				
				String bcontent = rs.getString("bcontent");
				bd.setBcontent(bcontent);
				
				String regist = rs.getString("regist");
				bd.setRegist(regist);
				
				hit =(rs.getInt("hit")+1);
				bd.setHit(hit);
				
				bd.setNum(Integer.parseInt(num));
			}
			
			sql=""+"UPDATE board SET hit=? WHERE num=? ";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, hit);
			ps.setString(2,num);
			int rows = ps.executeUpdate();
			
			if(rows>0)
				System.out.println("조회수 증가 성공"); 
			else
				System.out.println("조회수 증가 실패");
			
			if(rs!=null)
				rs.close();
			if(ps!=null)
				ps.close();
			if(conn!=null)
				conn.close();
			
		} catch (Exception e) { e.printStackTrace(); }
		
		return bd;
	}
	
	public boolean getUpdateBoard(String num,String title,String bcontent) {
		boolean result = false;
		
		try {
			conn=DBManager.getConnection();
			
			String sql = ""+"UPDATE board SET title=?, bcontent=? WHERE num=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, title);
			ps.setString(2, bcontent);
			ps.setString(3, num);
			
			int rows = ps.executeUpdate();
			
			if(rows>0)
				result=true;
			else
				result=false;
			
			if(ps!=null)
				ps.close();
			if(conn!=null)
				conn.close();
			
		}catch(Exception e) { e.printStackTrace(); }
		
		return result;
	}

	public boolean getDeleteBoard(String num) {
		boolean result = false;
		
		try {
			conn=DBManager.getConnection();
			
			String sql = ""+"DELETE FROM board WHERE num=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			
			int rows = ps.executeUpdate();
			
			if(rows>0)
				result = true;
			else
				result = false;
			
			if(ps!=null)
				ps.close();
			if(conn!=null)
				conn.close();
			
		} catch (Exception e) { e.printStackTrace(); }
		
		return result;
	}
	
	public ArrayList<Board> getSearchBoard(String items, String search) {
		ArrayList<Board> searchboard = new ArrayList<>();
		String word = "%"+search+"%";
		String value="";
		
		try {
			conn=DBManager.getConnection();
			
			if(items.equals("subject")) {
				value="title";
				
				String sql = "" + "SELECT num, title, id, regist FROM board WHERE title LIKE ? ";
				ps=conn.prepareStatement(sql);
				ps.setString(1, word);
				
				rs=ps.executeQuery();
				while(rs.next()) {
					Board bd = new Board();
					
					int num = rs.getInt("num");
					bd.setNum(num);
					
					String title = rs.getString("title");
					bd.setTitle(title);
					
					String id = rs.getString("id");
					bd.setId(id);
					
					String regist = rs.getString("regist");
					bd.setRegist(regist);
					
					searchboard.add(bd);
				}
				
			} else if(items.equals("content")) {
				value="bcontent";
				
				String sql = "" + "SELECT num, title, id, regist FROM board WHERE bcontent LIKE ? ";
				ps=conn.prepareStatement(sql);
				ps.setString(1, word);
				
				rs=ps.executeQuery();
				while(rs.next()) {
					Board bd = new Board();
					
					int num = rs.getInt("num");
					bd.setNum(num);
					
					String title = rs.getString("title");
					bd.setTitle(title);
					
					String id = rs.getString("id");
					bd.setId(id);
					
					String regist = rs.getString("regist");
					bd.setRegist(regist);
					
					searchboard.add(bd);
				}
			} else if(items.equals("name")) {
				value="id";
				
				String sql = "" + "SELECT num, title, id, regist FROM board WHERE id LIKE ? ";
				ps=conn.prepareStatement(sql);
				ps.setString(1, word);
				
				rs=ps.executeQuery();
				while(rs.next()) {
					Board bd = new Board();
					
					int num = rs.getInt("num");
					bd.setNum(num);
					
					String title = rs.getString("title");
					bd.setTitle(title);
					
					String id = rs.getString("id");
					bd.setId(id);
					
					String regist = rs.getString("regist");
					bd.setRegist(regist);
					
					searchboard.add(bd);
				}
			}

			if(rs!=null)
				rs.close();
			if(ps!=null)
				ps.close();
			if(conn!=null)
				conn.close();
			
		}catch (Exception e) { e.printStackTrace(); }
		
		return searchboard;
	}
	
	public ArrayList<Board> getDeleteBoardList(String num) {
		ArrayList <Board> deleteboard = new ArrayList<>();
		
		try {
			conn=DBManager.getConnection();
			
			String sql = ""+"DELETE FROM board WHERE num=? ";
			ps=conn.prepareStatement(sql);
			ps.setString(1,num);
			
			int rows = ps.executeUpdate();
			
			if(rows>0) {
				sql = ""+"SELECT num, title, id, hit, regist FROM board ";
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				
				while (rs.next()) {
					Board bd = new Board();
					
					int bnum = rs.getInt("num");
					bd.setNum(bnum);
					
					String title = rs.getString("title");
					bd.setTitle(title);
					
					String id = rs.getString("id");
					bd.setId(id);
					
					int hit = rs.getInt("hit");
					bd.setHit(hit);
					
					String regist = rs.getString("regist");
					bd.setRegist(regist);
					
					deleteboard.add(bd);
				}
			}
			
			if(rs!=null)
				rs.close();
			if(ps!=null)
				ps.close();
			if(conn!=null)
				conn.close();
			
		} catch (Exception e) { e.printStackTrace(); }
		
		return deleteboard;
	}
	
	public int getSearchCount(String search, String items)  {
		conn=DBManager.getConnection();
		
		String word = "%"+search+"%";
		String value="";
		
		int count=0;
		try {
		
			if(items.equals("subject")) {
				value="title";
				
				String sql = "" +"SELECT count(*) FROM board WHERE title LIKE ? ";
				ps=conn.prepareStatement(sql);
				ps.setString(1, word);
					
				rs=ps.executeQuery();
					
				if(rs.next())
					count=rs.getInt("count(*)");
					
			} else if(items.equals("content")) {
				value="bcontent";
				
				String sql = "" +"SELECT count(*) FROM board WHERE bcontent LIKE ? ";
				ps=conn.prepareStatement(sql);
				ps.setString(1, word);
					
				rs=ps.executeQuery();
					
				if(rs.next())
					count=rs.getInt("count(*)");
				
			} else if(items.equals("name")) {
				value="id";
	
				String sql = "" +"SELECT count(*) FROM board WHERE id LIKE ? ";
				ps=conn.prepareStatement(sql);
				ps.setString(1, word);
					
				rs=ps.executeQuery();
					
				if(rs.next())
					count=rs.getInt("count(*)");
				
			}
		}catch (Exception e) { e.printStackTrace(); }
		
		return count;
	}
}

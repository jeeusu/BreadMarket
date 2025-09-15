package Board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	
	DBManager DB = new DBManager();
	BoardDAO dao = BoardDAO.getInstance();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String RequestURI = request.getRequestURI();
		String contentPath = request.getContextPath();
		String command = RequestURI.substring(contentPath.length());
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		if(command.equals("/BoardList.do")) {
			requestBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./BoardList.jsp");
			rd.forward(request,response);
		}
		
		if(command.equals("/WriteBoardProcess.do")) {
			requestWriteBoard(request);
			RequestDispatcher rd = request.getRequestDispatcher("./WriteBoardProcess.jsp");
			rd.forward(request,response);
		}
		
		if(command.equals("/ShowBoard.do")) {
			requestShowBoard(request);
			RequestDispatcher rd = request.getRequestDispatcher("./ShowBoard.jsp");
			rd.forward(request,response);
		}
		
		if(command.equals("/UpdateBoardProcess.do")) {
			requestUpdateBoard(request);
			RequestDispatcher rd = request.getRequestDispatcher("./UpdateBoardProcess.jsp");
			rd.forward(request,response);
		}
		
		if(command.equals("/DeleteBoard.do")) {
			requestDeleteBoard(request);
			RequestDispatcher rd = request.getRequestDispatcher("./DeleteBoardProcess.jsp");
			rd.forward(request,response);
		}
		
		if(command.equals("/SearchBoard.do")) {
			requestSearchBoard(request);
			RequestDispatcher rd = request.getRequestDispatcher("./BoardList.jsp");
			rd.forward(request,response);
		}
		
		
		if(command.equals("/AdminBoardList.do")) { //관리자 게시판 목록 보기
			requestBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./AdminBoardList.jsp");
			rd.forward(request,response);
		}
	
		if(command.equals("/AdminBoard.do")) { //관리자 게시글 보기
			requestShowBoard(request);
			RequestDispatcher rd = request.getRequestDispatcher("./AdminBoard.jsp");
			rd.forward(request,response);
		}
		
		if(command.equals("/AdminDeleteBoard.do")) { //관리자 게시글 삭제
			requestAdminDeleteBoard(request);
			RequestDispatcher rd = request.getRequestDispatcher("./AdminBoardList.jsp");
			rd.forward(request,response);
		}
	}
	
	public void requestBoardList(HttpServletRequest request) {
		int pageNum;
		int total_record=dao.getListCount();
		int total_page;
		
		
		if(total_record>10)
			total_page= (total_record/10)+1;
		else
			total_page=1;
		
		if(request.getParameter("pageNum")!=null)
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		else 
			pageNum=1;
		
		System.out.print(total_record+","+total_page);
		ArrayList<Board> board = dao.getBoardList(pageNum);
		request.setAttribute("board", board);
		request.setAttribute("total_record", total_record);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_page", total_page);
	}	
	
	public void requestWriteBoard(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id=(String)session.getAttribute("userID");
		String title=request.getParameter("title");
		String bcontent=request.getParameter("bcontent");
		
		boolean result = dao.getWriteBoard(id, title, bcontent);
		request.setAttribute("result", result);
	}

	public void requestShowBoard(HttpServletRequest request) {
		String num = request.getParameter("num");
		Board board = dao.getBoard(num);
		request.setAttribute("board", board);	
	}
	
	public void requestUpdateBoard(HttpServletRequest request) {
		String num = request.getParameter("num");
		String title=request.getParameter("title");
		String bcontent=request.getParameter("bcontent");
		
		boolean result = dao.getUpdateBoard(num, title, bcontent);
		request.setAttribute("result", result);
	}
	
	public void requestDeleteBoard(HttpServletRequest request) {
		String num = request.getParameter("num");
		
		boolean result = dao.getDeleteBoard(num);
		request.setAttribute("result", result);
	}
	
	public void requestSearchBoard(HttpServletRequest request) {
		String search = request.getParameter("search");
		String items = request.getParameter("items");
		
		int pageNum=0;
		int total_record=dao.getSearchCount(search, items);
		int total_page=0;
		
		if(request.getParameter("pageNum")!=null)
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		else 
			pageNum=1;
		
		if(total_record>10)
			total_page= (total_record/10)+1;
		else
			total_page=1;
		
		if(request.getParameter("pageNum")!=null)
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		else 
			pageNum=1;
		
		ArrayList<Board> searchboard = dao.getSearchBoard(items, search);
		request.setAttribute("searchboard", searchboard);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_record", total_record);
		request.setAttribute("total_page", total_page);
	}
	
	public void requestAdminDeleteBoard(HttpServletRequest request) {
		String num = request.getParameter("num");
		ArrayList<Board> board = dao.getDeleteBoardList(num);
		request.setAttribute("board", board);
	}
}

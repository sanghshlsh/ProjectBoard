package kr.co.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.command.Command;
import kr.co.command.IDCheckCommand;

/**
 * Servlet implementation class IDChecker
 */
public class IDChecker extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IDChecker() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Command com = new IDCheckCommand();
		com.execute(request, response);
		String id =request.getParameter("id");
		if (id == "") {
			response.getWriter().print("사용 불가능한 아이디입니다.");
		} else {
			
		boolean idCheck = (boolean) request.getAttribute("idCheck");
		
		if (!idCheck) {
			response.getWriter().print("사용 가능한 아이디입니다.");
		} else {
			response.getWriter().print("사용 불가능한 아이디입니다.");
		}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

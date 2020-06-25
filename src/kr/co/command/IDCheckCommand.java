package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;

public class IDCheckCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		boolean idCheck = false;
		
			BoardDAO dao = new BoardDAO();
			idCheck = dao.idCheck(id);
			
		
		
		request.setAttribute("idCheck", idCheck);
		
		return new CommandAction(false, "idcheck");
	}

}

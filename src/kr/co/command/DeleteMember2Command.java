package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.LoginDTO;

public class DeleteMember2Command implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		HttpSession session = request.getSession(false);
	
		if (session != null) {
			LoginDTO loginDTO = (LoginDTO) session.getAttribute("login");
	
			if (loginDTO != null) {
				String id = request.getParameter("id");
				if (loginDTO.getId().equals(id)) {
				
					new BoardDAO().deleteMember(id);
					session.invalidate();
					return new CommandAction(true, "mainPage.do");
				}
			}
		}
		
		return new CommandAction(true, "loginui.do");
	}

	
}
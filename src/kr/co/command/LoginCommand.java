package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.LoginDTO;

public class LoginCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id1");
		String pw = request.getParameter("pw1");
		
		boolean isLogin = new BoardDAO().login(new LoginDTO(id, pw));
		
		if(isLogin) {
			HttpSession session = request.getSession();
			session.setAttribute("login", new LoginDTO(id, null));
//			session.setMaxInactiveInterval(60*15);
			return new CommandAction(true, "mainPage.do");
		} else {
			return new CommandAction(true, "loginui.do?isID=0");			
		}
		
		
	}

}

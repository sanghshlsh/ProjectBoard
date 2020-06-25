package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.LoginDTO;

public class DeleteMemberCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		BoardDAO dao = new BoardDAO();
		boolean isIDPW = dao.login(new LoginDTO(id, pw));
		if (isIDPW) {
			
		request.setAttribute("id", id);
		request.setAttribute("pw", pw);
		return new CommandAction(false, "deleteMemberui.do?delete=0");
		} else {
			
			return new CommandAction(false, "deleteMemberui.do?nopw=1");
		}
	}

}

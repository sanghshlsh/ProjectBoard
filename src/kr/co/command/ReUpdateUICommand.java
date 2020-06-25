package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.command.Command;
import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.ReplyDTO;

public class ReUpdateUICommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String Srepnum = request.getParameter("repNum");
		int repnum = -1;
		if (Srepnum != null) {
			repnum = Integer.parseInt(Srepnum);
		}

		String content = request.getParameter("contnet");
		BoardDAO dao = new BoardDAO();


		ReplyDTO redto = dao.reupdateui(repnum);
		
		request.setAttribute("redto", redto);

		return new CommandAction(false, "reupdate.jsp");
	}

}

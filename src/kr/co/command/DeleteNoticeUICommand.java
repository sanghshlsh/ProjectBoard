package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.LoginDTO;

public class DeleteNoticeUICommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String sNum = request.getParameter("num");
		int num = 0;
		if (sNum != null) {
			num = Integer.valueOf(sNum);
		}
		request.setAttribute("num", num);
		
		return new CommandAction(false, "deleteNoticeUI.jsp");
	}

	
}
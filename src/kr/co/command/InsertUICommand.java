package kr.co.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.SelectDTO;

public class InsertUICommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		List<SelectDTO> lolist =  dao.location();
		List<SelectDTO> calist =  dao.category();

		request.setAttribute("lolist", lolist);
		request.setAttribute("calist", calist);
		
		return new CommandAction(false, "insert.jsp");
	}

}





package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.command.Command;
import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.PageDTO;

public class SearchCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String scurPage = request.getParameter("curPage");

		int curPage = 1;
		if (scurPage != null) {
			curPage = Integer.parseInt(scurPage);

		}
		String sVisible = request.getParameter("visible");
		int visible = 1;
		if (sVisible != null) {
			visible = Integer.parseInt(sVisible);
		}
		String keyField = request.getParameter("keyField");
		String keyword = request.getParameter("keyWord");
		BoardDAO dao = new BoardDAO();

		PageDTO to = dao.searchpage(curPage, visible,keyword,keyField);
		
		request.setAttribute("to", to);
		request.setAttribute("list", to.getList());
		return new CommandAction(false, "search.jsp");
	}

}


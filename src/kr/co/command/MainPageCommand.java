package kr.co.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;
import kr.co.domain.PageDTO;

public class MainPageCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		BoardDAO dao= new BoardDAO();
		PageDTO to= dao.page(1,1,12,null,null);
		List<BoardDTO> nolist =dao.noticeList();
		request.setAttribute("to", to);
		request.setAttribute("list",to.getList());
		request.setAttribute("nolist",nolist);
		
		
		
		
		
		List<BoardDTO> hList = dao.MainPageHotsalelist();
		

		request.setAttribute("hList", hList);
		
	
		
		return new CommandAction(false, "mainPage.jsp");
	}

}

package kr.co.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.dao.BoardDAO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;
import kr.co.domain.LoginDTO;
import kr.co.domain.MemberDTO;

public class MyPageCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		LoginDTO dto = (LoginDTO) session.getAttribute("login");
		String id = dto.getId();
		BoardDAO dao = new BoardDAO();
		List<BoardDTO> list = dao.likeList(id);
		List<BoardDTO> list2 = dao.selectList(id);
		request.setAttribute("list", list);
		request.setAttribute("list2", list2);
		
		
		
		return new CommandAction(false, "myPage.jsp");
	}

}

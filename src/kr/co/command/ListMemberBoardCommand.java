package kr.co.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;

public class ListMemberBoardCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String id = request.getParameter("id");
		BoardDAO dao = new BoardDAO();
		String nickname = dao.selectMember(id).getNickname();
		List<BoardDTO> list = dao.selectList(id);
		request.setAttribute("list", list);
		request.setAttribute("nickname", nickname);
		return new CommandAction(false, "listmemberboard.jsp");
	}

}

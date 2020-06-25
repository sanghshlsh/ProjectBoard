package kr.co.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.command.Command;
import kr.co.dao.BoardDAO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;
import kr.co.domain.LoginDTO;
import kr.co.domain.ReplyDTO;

public class ReadNoticeCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
		String Snum =request.getParameter("num");
		int num= -1;
		if (Snum != null) {
			num = Integer.parseInt(Snum);
		}
	
		BoardDAO dao =new BoardDAO();
		BoardDTO dto = dao.readNotice(num);
	

		request.setAttribute("dto", dto);
		request.setAttribute("alist",dto.getAttList() );

		return new CommandAction(false, "readNotice.jsp");
	}

}

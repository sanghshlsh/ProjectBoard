package kr.co.command;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.AttDTO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;
import kr.co.domain.SelectDTO;

public class UpdateNoticeUICommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String sNum = request.getParameter("num");
		int num = 0;
		if (sNum != null) {
			num = Integer.parseInt(sNum);
		}
		BoardDAO dao = new BoardDAO();
		BoardDTO dto =  dao.readNotice(num);
		List<AttDTO> alist =dto.getAttList();
		
		request.setAttribute("dto", dto);
		request.setAttribute("alist", alist);
		

		return new CommandAction(false, "updateNotice.jsp");
	}

}

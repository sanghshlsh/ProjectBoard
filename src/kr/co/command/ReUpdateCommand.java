package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.command.Command;
import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.ReplyDTO;

public class ReUpdateCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String Srepnum = request.getParameter("repNum");
		int repnum = 1;
		if (Srepnum != null) {
			repnum = Integer.valueOf(Srepnum);
		}
		

		
	
		String content = request.getParameter("content");
           BoardDAO dao =new BoardDAO();
//		ReplyDTO rdto = new ReplyDTO();
           dao.reupdate(new ReplyDTO(repnum, 0, content, null, null, 0, 0, 0));
        int num = dao.reupdateui(repnum).getNum();   
		
		return new CommandAction(true, "read.do?num="+num);
	}

}

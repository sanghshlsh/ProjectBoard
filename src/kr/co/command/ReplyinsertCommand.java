package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.command.Command;
import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.ReplyDTO;

public class ReplyinsertCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		
		String snum= request.getParameter("num");
		int num = 1;
		if (snum != null) {
			 num =Integer.parseInt(snum);
			
		}
		String srepnum= request.getParameter("repnum");
		int repnum = 1;
		if (srepnum != null) {
			 repnum =Integer.parseInt(srepnum);
			
		}
	
		String id =request.getParameter("id");
		String content =request.getParameter("content");
		
		
		BoardDAO dao =new BoardDAO();
		
		
		//dao.Replyinsert(new ReplyDTO(0, num, content, id, null, 0,0, 0));
		dao.Replyinsert(new ReplyDTO(repnum, num, content, id, null, 0, 0, 0));
		
		
		return new CommandAction(true, "read.do?num="+num);
	}

}

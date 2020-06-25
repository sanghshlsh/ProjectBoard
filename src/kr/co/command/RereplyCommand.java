package kr.co.command;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.command.Command;
import kr.co.dao.BoardDAO;

import kr.co.domain.CommandAction;
import kr.co.domain.ReplyDTO;

public class RereplyCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String rerenum =request.getParameter("repNum");
		int orgnum =-1;
		if (rerenum != null) {
			orgnum =Integer.parseInt(rerenum);
			
		}
		
		String snum =request.getParameter("num");
		
		int num =1;
		if (snum != null) {
			num =Integer.parseInt(snum);
		}
		
		String content =request.getParameter("content");
		String id = request.getParameter("id");
		
		
		BoardDAO dao =new BoardDAO();
	
		
		dao.rereply(new ReplyDTO(0, num, content, id, null, -1, -1, 1),orgnum);
//  new ReplyDTO(repNum, num, content, id, writeday, repRoot, repStep, repIndent);
		
		
		
		
		return new CommandAction(false, "read.do?num="+num);
	}

}

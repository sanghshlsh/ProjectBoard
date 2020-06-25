package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.command.Command;
import kr.co.dao.BoardDAO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;
import kr.co.domain.ReplyDTO;

public class ReDeleteCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String srepnum =request.getParameter("repNum");
		int repnum =-1;
		if (srepnum != null) {
			repnum =Integer.parseInt(srepnum);
		}
		String rnum =request.getParameter("num");
		int num =-1;
		if (rnum != null) {
			num =Integer.parseInt(rnum);
		}
		
		
		BoardDAO dao =new BoardDAO();
		
		
	     dao.redelete(repnum);
	   

		return new CommandAction(true, "read.do?num="+num);
		
	}

}

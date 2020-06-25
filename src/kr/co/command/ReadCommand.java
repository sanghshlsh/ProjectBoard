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

public class ReadCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		//리플 리스트 읽기
		
		String Snum =request.getParameter("num");
		int num= -1;
		if (Snum != null) {
			num = Integer.parseInt(Snum);
		}
		String srepnum =request.getParameter("repNum");
		int repnum =-1;
		if (srepnum != null) {
		repnum =Integer.parseInt(srepnum);
		}
		HttpSession session = request.getSession(false);
		LoginDTO logindto =	(LoginDTO) session.getAttribute("login");
		BoardDAO dao =new BoardDAO();
		BoardDTO dto = dao.read(num);
		int check = 0;// 0 로그인x 1 로그인 좋아요x 2로그인 좋아요 o
		if (logindto!=null) {
		check =	dao.checklike(num,logindto.getId());	
		} 
		List<ReplyDTO> rlist = dao.replyRead(num);
		request.setAttribute("dto", dto);
		request.setAttribute("rlist", rlist);
		request.setAttribute("alist",dto.getAttList() );
		request.setAttribute("check", check);
		return new CommandAction(false, "read.jsp");
	}

}

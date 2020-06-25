package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.LikeDTO;
import kr.co.domain.LoginDTO;

public class deleteLikeCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String sNum =  request.getParameter("num");
		int num = 0;
		if(sNum != null) num = Integer.parseInt(sNum);
		
		HttpSession session = request.getSession(false);
		if(session!=null) {
			LoginDTO logindDTO = (LoginDTO) session.getAttribute("login");
			if(logindDTO != null) {
				String id = logindDTO.getId();
				BoardDAO dao = new BoardDAO();
				LikeDTO likeDTO = new LikeDTO(0,num,id);  
				dao.deleteLikes(likeDTO);
				
			}
		}
		
		return new CommandAction(true, "read.do?num="+num);
		
	}

}

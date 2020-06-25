package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.LoginDTO;
import kr.co.domain.MemberDTO;

public class UpdateMember2Command implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String contact = request.getParameter("contact");
		String location = request.getParameter("location");
		String sBirthdate = request.getParameter("birthdate");
		int birthdate = 0;
		if (sBirthdate != null) {
			birthdate = Integer.parseInt(sBirthdate);
		}
		String gender = request.getParameter("gender");
		
		BoardDAO dao = new BoardDAO();
		dao.updateMember(new MemberDTO(id, pw, name, nickname, contact, location, birthdate, gender));
		
		return new CommandAction(true, "myPage.do");
	}

}

package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;
import kr.co.domain.MemberDTO;

public class InsertMemberCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id2");
		String pw = request.getParameter("pw2");
		String pw2 = request.getParameter("pw3");
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
		MemberDTO dto = new MemberDTO(id, pw, name, nickname, contact, location, birthdate, gender);
			boolean isID = dao.idCheck(id);
			if (isID) {	
				return new CommandAction(true, "insertMemberui.do?noid=0");
		
			} else {
				if (pw.equals(pw2)) {					
					dao.insertMember(dto);
					return new CommandAction(true, "mainPage.do?success=1");
				} else {
					return new CommandAction(true, "insertMemberui.do?noid=1");
				}
				
			}
		}

	
	}
	
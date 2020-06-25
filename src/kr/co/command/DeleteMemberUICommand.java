package kr.co.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.domain.CommandAction;

public class DeleteMemberUICommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response) {
		
	String id = request.getParameter("id");
	request.setAttribute("id", id);
	return new CommandAction(false, "deleteMember.jsp");
	}

}

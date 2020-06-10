package kr.co.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.domain.CommandAction;

public interface Command {
	CommandAction execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}

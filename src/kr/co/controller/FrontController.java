package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.command.Command;
import kr.co.command.DeleteCommand;
import kr.co.command.InsertCommand;
import kr.co.command.InsertUICommand;
import kr.co.command.ReDeleteCommand;
import kr.co.command.ReUpdateCommand;
import kr.co.command.ReUpdateUICommand;
import kr.co.command.ReadCommand;
import kr.co.command.ReadNoticeCommand;
import kr.co.command.ReplyUICommand;
import kr.co.command.ReplyinsertCommand;
import kr.co.command.RereplyCommand;
import kr.co.command.DeleteListCommand;
import kr.co.command.DeleteMember2Command;
import kr.co.command.DeleteMemberCommand;
import kr.co.command.DeleteMemberUICommand;
import kr.co.command.DeleteNoticeCommand;
import kr.co.command.DeleteNoticeUICommand;
import kr.co.command.DeleteUICommand;
import kr.co.command.HotsaleListPageCommand;
import kr.co.command.InVisibleCommand;

import kr.co.command.InsertMemberCommand;
import kr.co.command.InsertMemberUICommand;

import kr.co.command.InsertNoticeCommand;
import kr.co.command.InsertNoticeUICommand;
import kr.co.command.InsertUICommand;
import kr.co.command.ListCommand;
import kr.co.command.ListMemberBoardCommand;
import kr.co.command.ListNoticeCommand;
import kr.co.command.LoginCommand;
import kr.co.command.LoginUICommand;
import kr.co.command.LogoutCommand;
import kr.co.command.MainPageCommand;
import kr.co.command.MyPageCommand;
import kr.co.command.SearchCommand;
import kr.co.command.UpdateCommand;
import kr.co.command.UpdateMember2Command;
import kr.co.command.UpdateMemberCommand;
import kr.co.command.UpdateMemberUICommand;
import kr.co.command.UpdateNoticeCommand;
import kr.co.command.UpdateNoticeUICommand;
import kr.co.command.UpdateUICommand;
import kr.co.command.VisibleCommand;
import kr.co.command.deleteLikeCommand;
import kr.co.command.likeCommand;
import kr.co.domain.CommandAction;

/**
 * Servlet implementation class FrontController
 */

public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	public FrontController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String ctxp = request.getContextPath();
		String uri = request.getRequestURI();
		String sp = uri.substring(ctxp.length());

		Command com = null;

		if (sp.equalsIgnoreCase("/list.do")) {
			com = new ListCommand();
		} else if (sp.equalsIgnoreCase("/insertui.do")) {
			com = new InsertUICommand();
		} else if (sp.equalsIgnoreCase("/insert.do")) {
			com = new InsertCommand();
		} else if (sp.equalsIgnoreCase("/read.do")) {
			com = new ReadCommand();
		} else if (sp.equalsIgnoreCase("/replyui.do")) {
			com = new ReplyUICommand();
		} else if (sp.equalsIgnoreCase("/replyinsert.do")) {
			com = new ReplyinsertCommand();
		} else if (sp.equalsIgnoreCase("/reupdateui.do")) {
			com = new ReUpdateUICommand();
		} else if (sp.equalsIgnoreCase("/reupdate.do")) {
			com = new ReUpdateCommand();
		} else if (sp.equalsIgnoreCase("/redelete.do")) {
			com = new ReDeleteCommand();
		} else if (sp.equalsIgnoreCase("/rereply.do")) {
			com = new RereplyCommand();
		} else if (sp.equalsIgnoreCase("/search.do")) {
			com = new SearchCommand();
		} else if (sp.equalsIgnoreCase("/invisible.do")) {
			com = new InVisibleCommand();
		} else if (sp.equalsIgnoreCase("/deletelist.do")) {
			com = new DeleteListCommand();
		} else if (sp.equalsIgnoreCase("/visible.do")) {
			com = new VisibleCommand();
		} else if (sp.equalsIgnoreCase("/loginui.do")) {
			com = new LoginUICommand();
		} else if (sp.equalsIgnoreCase("/login.do")) {
			com = new LoginCommand();
		} else if (sp.equalsIgnoreCase("/mainPage.do")) {
			com = new MainPageCommand();
		}		else if(sp.equalsIgnoreCase("/hotsalelist.do")) {
			 com=new HotsaleListPageCommand();
		} else if (sp.equalsIgnoreCase("/logout.do")) {
			com = new LogoutCommand();
		} else if (sp.equalsIgnoreCase("/insertMemberui.do")) {
			com = new InsertMemberUICommand();
		} else if (sp.equalsIgnoreCase("/insertMember.do")) {
			com = new InsertMemberCommand();
		} else if (sp.equalsIgnoreCase("/myPage.do")) {
			com = new MyPageCommand();
		} else if (sp.equalsIgnoreCase("/updateMemberui.do")) {
			com = new UpdateMemberUICommand();
		} else if (sp.equalsIgnoreCase("/updateMember.do")) {
			com = new UpdateMemberCommand();
		} else if (sp.equalsIgnoreCase("/updateMember2.do")) {
			com = new UpdateMember2Command();
		} else if (sp.equalsIgnoreCase("/deleteMemberui.do")) {
			com = new DeleteMemberUICommand();
		} else if (sp.equalsIgnoreCase("/deleteMember.do")) {
			com = new DeleteMemberCommand();
		} else if (sp.equalsIgnoreCase("/deleteMember2.do")) {
			com = new DeleteMember2Command();
		} else if (sp.equalsIgnoreCase("/listNotice.do")) {
			com = new ListNoticeCommand();
		} else if (sp.equalsIgnoreCase("/insertNoticeUi.do")) {
			com = new InsertNoticeUICommand();
		} else if (sp.equalsIgnoreCase("/insertNotice.do")) {
			com = new InsertNoticeCommand();
		} else if(sp.equalsIgnoreCase("/listMemberBoard.do")) {
			com = new ListMemberBoardCommand();
		} else if(sp.equalsIgnoreCase("/like.do")) {
			com = new likeCommand();
		} else if(sp.equalsIgnoreCase("/deletelike.do")) {
			com = new deleteLikeCommand();
		} else if (sp.equalsIgnoreCase("/updateui.do")) {
			com = new UpdateUICommand();
		} else if (sp.equalsIgnoreCase("/update.do")) {
			com = new UpdateCommand();
		} else if (sp.equalsIgnoreCase("/deleteui.do")) {
			com = new DeleteUICommand();
		} else if (sp.equalsIgnoreCase("/delete.do")) {
			com = new DeleteCommand();
		} else if (sp.equalsIgnoreCase("/readNotice.do")) {
			com = new ReadNoticeCommand();
		} else if (sp.equalsIgnoreCase("/DeleteNoticeUI.do")) {
			com = new DeleteNoticeUICommand();
		} else if (sp.equalsIgnoreCase("/deleteNotice.do")) {
			com = new DeleteNoticeCommand();
		} else if (sp.equalsIgnoreCase("/updateNoticeUI.do")) {
			com = new UpdateNoticeUICommand();
		} else if (sp.equalsIgnoreCase("/updateNotice.do")) {
			com = new UpdateNoticeCommand();
		}
		
		
		if (com != null) {
			CommandAction action = com.execute(request, response);
			if (action.isRedirect()) {
				response.sendRedirect(action.getWhere());
			} else {
				request.getRequestDispatcher(action.getWhere()).forward(request, response);
			}
		} else {
			System.out.println("현재 없는 기능");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

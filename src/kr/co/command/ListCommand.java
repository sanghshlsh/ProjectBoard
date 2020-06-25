package kr.co.command;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;
import kr.co.domain.PageDTO;
import kr.co.domain.SelectDTO;

public class ListCommand implements Command {


		@Override
		public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
	
			String scurPage=request.getParameter("curPage");
			
			int curPage=1;
			if(scurPage!=null) {
				curPage= Integer.parseInt(scurPage);
			}
			String location = request.getParameter("location");
			
			String category = request.getParameter("category");
			
			
			BoardDAO dao= new BoardDAO();
			PageDTO to= dao.page(curPage,1,0,location,category);
			List<BoardDTO> nolist =dao.noticeList();
			List<SelectDTO> lolist =  dao.location();
			List<SelectDTO> calist =  dao.category();
			request.setAttribute("to", to);
			request.setAttribute("list",to.getList());
			request.setAttribute("nolist",nolist);
			request.setAttribute("lolist", lolist);
			request.setAttribute("calist", calist);
			return new CommandAction(false, "list.jsp");
		
		}

}

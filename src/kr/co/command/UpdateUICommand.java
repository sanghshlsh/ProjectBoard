package kr.co.command;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.AttDTO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;
import kr.co.domain.SelectDTO;

public class UpdateUICommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String sNum = request.getParameter("num");
		int num = 0;
		if (sNum != null) {
			num = Integer.parseInt(sNum);
		}
		BoardDAO dao = new BoardDAO();
		BoardDTO dto =  dao.read(num);
		List<SelectDTO> lolist =  dao.location();
		List<SelectDTO> calist =  dao.category();
		List<AttDTO> alist =dto.getAttList();
		List<File> flist = new ArrayList<File>();

		for (int i = 0 ; i < alist.size(); i++) {
			
				flist.add(new File(alist.get(i).getAttPath()));
				
		}		
		request.setAttribute("dto", dto);
		request.setAttribute("lolist", lolist);
		request.setAttribute("calist", calist);
		request.setAttribute("flist", flist);
		request.setAttribute("alist", alist);
		

		return new CommandAction(false, "update.jsp");
	}

}

package kr.co.command;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.dao.BoardDAO;
import kr.co.domain.AttDTO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;

public class InsertNoticeCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Calendar cal = Calendar.getInstance();

		String path = request.getSession().getServletContext().getRealPath("/upload");
		
		String today =  String.format("%04d-%02d-%02d", cal.get(Calendar.YEAR),cal.get(Calendar.MONTH)+1,cal.get(Calendar.DAY_OF_MONTH));
		
		String uploadPath = path+File.separator+today;
		

		File uploadFolder = new File(uploadPath);
		if (!uploadFolder.exists()) {
			uploadFolder.mkdir();
		}
		MultipartRequest multi = new MultipartRequest(request, uploadPath, 
				10*1024*1024, "utf-8",
				new DefaultFileRenamePolicy());
		String fileName = multi.getFilesystemName("file");;
		String fileName2 = multi.getFilesystemName("file2");;
		String fileName3 = multi.getFilesystemName("file3");;
		
		String realUploadPath = "http:"+File.separator+File.separator+"localhost:8089" +File.separator+"ProjectBoard"+File.separator+"upload"+File.separator+today;
		
		
		String content = multi.getParameter("content");
		String id = multi.getParameter("id");
		String title = multi.getParameter("title");
		List<AttDTO> attList = new ArrayList<AttDTO>();
		if (fileName != null) {
			attList.add(new AttDTO(0, 0, realUploadPath+File.separator+fileName));			
		}
		if (fileName2 != null) {
			attList.add(new AttDTO(0, 0, realUploadPath+File.separator+fileName2));			
		}
		if (fileName3 != null) {
			attList.add(new AttDTO(0, 0, realUploadPath+File.separator+fileName3));			
		}
		BoardDAO dao =new BoardDAO();
		dao.insertNotice(new BoardDTO(0, id, title, content, 0, null, 0, null, null, 0, attList, null,0));
		
		
		
		return new CommandAction(true, "listNotice.do");
	}

}

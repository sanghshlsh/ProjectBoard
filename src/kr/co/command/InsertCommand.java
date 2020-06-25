package kr.co.command;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.dao.BoardDAO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;

public class InsertCommand implements Command {

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
		
		//업로드 폴더 경로
		//workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Project_Board/upload
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, 
				10*1024*1024, "utf-8",
				new DefaultFileRenamePolicy());
		String fileName = multi.getFilesystemName("file");;
		String fileName2 = multi.getFilesystemName("file2");;
		String fileName3 = multi.getFilesystemName("file3");;
		String category = multi.getParameter("category");
		String location = multi.getParameter("location");
		String realUploadPath = "http:"+File.separator+File.separator+"localhost:8089" +File.separator+"ProjectBoard"+File.separator+"upload"+File.separator+today;
		
		String sMoney = multi.getParameter("money");
		int money = 0;
		if (sMoney != null) {
			money = Integer.valueOf(sMoney);
		}		
		String content = multi.getParameter("content");
		String id = multi.getParameter("id");
		String title = multi.getParameter("title");
		
		BoardDAO dao =new BoardDAO();
		dao.insert(new BoardDTO(0, id, title, content, 0, null, money, category, location, 0),fileName,fileName2,fileName3,realUploadPath);
		
		return new CommandAction(true, "list.do");
	}

}

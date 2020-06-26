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
import com.sun.org.apache.xml.internal.utils.AttList;

import kr.co.dao.BoardDAO;
import kr.co.domain.AttDTO;
import kr.co.domain.BoardDTO;
import kr.co.domain.CommandAction;

public class UpdateCommand implements Command {

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
		String category = multi.getParameter("category");
		String location = multi.getParameter("location");
		String realUploadPath = "http:"+File.separator+File.separator+"localhost:8089" +File.separator+"ProjectBoard"+File.separator+"upload"+File.separator+today;
		String sOrgFile1 = multi.getParameter("orgFile1");
		String sOrgFile2 = multi.getParameter("orgFile2");
		String sOrgFile3 = multi.getParameter("orgFile3");
		List<Integer> delList = new ArrayList<Integer>();
		String sMoney = multi.getParameter("money");
		int money = 0;
		if (sMoney != null) {
			money = Integer.valueOf(sMoney);
		}		
		String content = multi.getParameter("content");
		String id = multi.getParameter("id");
		String title = multi.getParameter("title");
		String sNum = multi.getParameter("num");
		int num = 0;
		if (sNum != null) {
			num = Integer.valueOf(sNum);
		}
		List<AttDTO> attList = new ArrayList<AttDTO>();
		if (fileName != null) {
			attList.add(new AttDTO(0, num, realUploadPath+File.separator+fileName));
			if (sOrgFile1 != null) 
				delList.add(Integer.valueOf(sOrgFile1));
		}
		if (fileName2 != null) {
			attList.add(new AttDTO(0, num, realUploadPath+File.separator+fileName2));
			if (sOrgFile2 != null) {
				delList.add(Integer.valueOf(sOrgFile2));
			}
		}
		if (fileName3 != null) {
			attList.add(new AttDTO(0, num, realUploadPath+File.separator+fileName3));
			if (sOrgFile3 != null) {
				delList.add(Integer.valueOf(sOrgFile3));
			}
		}
		
		BoardDAO dao =new BoardDAO();
		BoardDTO dto = new BoardDTO(num, id, title, content, 0, null, money, category, location, 0, attList, null,0);
		dao.update(dto,delList);
		request.setAttribute("dto", dto);
		return new CommandAction(true, "read.do?num="+num);
	}

}

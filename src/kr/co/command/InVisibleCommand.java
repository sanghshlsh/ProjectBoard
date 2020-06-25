
package kr.co.command;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.CommandAction;

public class InVisibleCommand implements Command {
	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String[] sNums = request.getParameterValues("num");
		List<Integer> nums = new ArrayList<Integer>();

		if (sNums != null) {
			for (String sNum : sNums) {

				nums.add(Integer.parseInt(sNum));
			}
		}

		for (Integer num : nums) {
			new BoardDAO().visible(0, num);

		}

		return new CommandAction(true, "list.do");
	}
}
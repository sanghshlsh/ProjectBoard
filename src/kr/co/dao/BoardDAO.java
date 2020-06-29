package kr.co.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import kr.co.domain.AttDTO;
import kr.co.domain.BoardDTO;
import kr.co.domain.LikeDTO;
import kr.co.domain.LoginDTO;
import kr.co.domain.MemberDTO;
import kr.co.domain.PageDTO;
import kr.co.domain.ReplyDTO;
import kr.co.domain.SelectDTO;

public class BoardDAO {

	private DataSource dataFactory;

	public BoardDAO() {
		try {
			Context ctx = new InitialContext();
			dataFactory = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle11g");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void closeAll(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {

			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//// 리플 쓰는거
	public void Replyinsert(ReplyDTO replyDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into reply(renum, num, content, id, repRoot, repStep, repIndent) values(?,?,?,?,?,?,?)";
		try {

			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			int renum = createRepNum(conn);
			pstmt.setInt(1, renum);
			pstmt.setInt(2, replyDTO.getNum());
			pstmt.setString(3, replyDTO.getContent());
			pstmt.setString(4, replyDTO.getId());

			pstmt.setInt(5, renum);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 0);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeAll(conn, pstmt, null);

		}

	}

	/// 리플관련 ㄱ거
	private int createRepNum(Connection conn) {
		Integer num = null;
		PreparedStatement pstmt = null;
		String sql = "select max(renum) from reply";
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1);
				num += 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}

		return num;
	}

///리플수정

	private ReplyDTO updateui(int orgnum) {

		ReplyDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from reply where renum=?";

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orgnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int num = rs.getInt("num");
				String id = rs.getString("id");
				String content = rs.getString("content");
				int repRoot = rs.getInt("repRoot");
				int repStep = rs.getInt("repStep");
				int repIndent = rs.getInt("repIndent");

				dto = new ReplyDTO(orgnum, num, content, id, null, repRoot, repStep, repIndent);

			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {

			closeAll(conn, pstmt, rs);
		}
		return dto;
	}

	// step plus1
	private void stepPlus1(Connection conn, ReplyDTO orgDTO, int repstep) {
		PreparedStatement pstmt = null;
		String sql = "update reply set repStep= repStep+1 where repRoot = ? and repStep >= ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orgDTO.getRepRoot());
			pstmt.setInt(2, repstep);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			closeAll(null, pstmt, null);

		}
	}

//	//혹시몰라 남김
//	private int increaseReadCnt(Connection conn, int num) {
//		PreparedStatement pstmt = null;
//		String sql = "update board set readcnt =readcnt+1 where num=?";
//
//		try {
//			conn = dataFactory.getConnection();
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, num);
//			pstmt.executeUpdate();
//
//		} catch (Exception e) {
//			e.printStackTrace();
//
//		} finally {
//			closeAll(null, pstmt, null);
//		}
//
//		return 0;
//
//	}

	// 이거 리플읽기
	public List<ReplyDTO> replyRead(int num) {

		List<ReplyDTO> list = new ArrayList<ReplyDTO>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from (select rownum rnum, renum, num, content, id, writeday, repIndent, reproot, repstep,orgnum from (select * from REPLY where num = ? order by  repRoot asc, repStep asc))";

		try {

			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int repNum = rs.getInt("reNum");
				String content = rs.getString("content");
				String id = rs.getString("id");
				Date writeday = rs.getDate("writeday");
				int repIndent = rs.getInt("repIndent");
				String nickname = getnickname(id, conn);
				ReplyDTO rdto = new ReplyDTO(repNum, num, content, id, writeday, 0, 0, repIndent, nickname);

				list.add(rdto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			closeAll(conn, pstmt, rs);
		}
		return list;
	}

	//// 댓글 수정

	public void reupdate(ReplyDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update reply set content=? where renum=?";
		try {

			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getContent());

			pstmt.setInt(2, dto.getRepNum());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		}

	}

	// 댓글수정 ui
	public ReplyDTO reupdateui(int repnum) {
		ReplyDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from reply where renum=?";
		ResultSet rs = null;
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, repnum);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				String content = rs.getString("content");
				int num = rs.getInt("num");

				dto = new ReplyDTO(repnum, num, content, null, null, 0, 0, 0);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}
		return dto;
	}

	/// 댓글 삭제
	public void redelete(int repnum) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from reply where renum=? ";
		try {

			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, repnum);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		}

	}

//글쓰기
	public void insert(BoardDTO boardDTO, String fileName, String fileName2, String fileName3, String uploadPath) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into board (num, id, title, content, money,  readcnt, category, location) values (?,?,?,?,?,?,?,?)";
		boolean isCommit = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			int num = createNum(conn);

			pstmt.setInt(1, num);
			pstmt.setString(2, boardDTO.getId());
			pstmt.setString(3, boardDTO.getTitle());
			pstmt.setString(4, boardDTO.getContent());
			pstmt.setInt(5, boardDTO.getMoney());
			pstmt.setString(7, boardDTO.getCategory());
			pstmt.setString(8, boardDTO.getLocation());
			pstmt.setInt(6, 0);
			pstmt.executeUpdate();
			if (fileName != null) {
				attach(conn, num, uploadPath, fileName);
			}
			if (fileName2 != null) {
				attach(conn, num, uploadPath, fileName2);
			}
			if (fileName3 != null) {
				attach(conn, num, uploadPath, fileName3);
			}
			isCommit = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isCommit) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}
	}

//첨부파일db등록
	private void attach(Connection conn, int num, String uploadPath, String fileName) {
		PreparedStatement pstmt = null;
		String sql = "insert into attfile (attNum, num, attPath) values (?, ?, ?)";
		int attNum = createANum(conn);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attNum);
			pstmt.setInt(2, num);
			pstmt.setString(3, uploadPath + File.separator + fileName);
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			closeAll(null, pstmt, null);
		}

	}

	// 대댓글
	public void rereply(ReplyDTO replyDTO, int orgnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into reply (renum, num, id, content, writeday, repRoot, repStep, repIndent, orgnum) values (?,?,?,?,?,?,?,?,?)";
		boolean isOk = false;
		try {

			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);

			int repnum = createRepNum(conn);

			ReplyDTO orgDTO = updateui(orgnum);

			pstmt.setInt(1, repnum);
			pstmt.setInt(2, replyDTO.getNum());
			pstmt.setString(3, replyDTO.getId());
			pstmt.setString(4, replyDTO.getContent());
			pstmt.setDate(5, replyDTO.getWriteday());
			pstmt.setInt(6, orgDTO.getRepRoot());
			int repstep = repstep2(conn, orgDTO) + 1;
			stepPlus1(conn, orgDTO, repstep);
			pstmt.setInt(7, repstep);

			pstmt.setInt(8, orgDTO.getRepIndent() + 1);
			pstmt.setInt(9, orgnum);
			pstmt.executeUpdate();

			isOk = true;
		} catch (Exception e) {

			e.printStackTrace();

		} finally {
			try {
				if (isOk) {

					conn.commit();
				} else {

					conn.rollback();
				}
			} catch (SQLException e1) {

				e1.printStackTrace();

				closeAll(null, pstmt, null);
			}

		}
	}

//첨부파일 넘버링
	private int createANum(Connection conn) {
		Integer num = null;
		PreparedStatement pstmt = null;
		String sql = "select max(attnum) from attfile";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1);
				num += 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}
		return num;
	}

//게시판 넘버링
	private int createNum(Connection conn) {
		Integer num = null;
		PreparedStatement pstmt = null;
		String sql = "select max(num) from board";
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1);
				num += 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}
		return num;
	}

	// 중고매물게시판 리스트 페이지
	public PageDTO page(int curPage, int vNum, int perPage, String location, String category) {
		if (location == null || location.length() < 1) {
			location = "1";
		}
		if (category == null || category.length() < 1) {
			category = "1";
		}
		String sql = "";
		if (location.equals("1") && category.equals("1")) {
			sql = "select * from (select rownum rnum, num, title,id, writeday, money,category,location, readcnt,likes from (select * from board where visible=? order by num desc))\r\n"
					+ "where rnum>=? and rnum <=?";
		} else if (!category.equals("1") && !location.equals("1")) {
			sql = "select * from ( select rownum rnum, num, title,id, writeday, money,category,location, readcnt,likes from ( select * from board where visible=? and location = ? and category = ? order by num desc)) where rnum>=? and rnum <=?";
		} else if (!location.equals("1")) {
			sql = "select * from ( select rownum rnum, num, title,id, writeday, money,category,location, readcnt,likes from ( select * from board where visible=? and location = ? order by num desc)) where rnum>=? and rnum <=?";
		} else {
			sql = "select * from ( select rownum rnum, num, title,id, writeday, money,category,location, readcnt,likes from ( select * from board where visible=? and category = ? order by num desc)) where rnum>=? and rnum <=?";
		}

		PageDTO to = new PageDTO(curPage);
		if (perPage != 0) {
			to.setPerPage(perPage);
		}

		List<BoardDTO> list = new ArrayList<BoardDTO>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = dataFactory.getConnection();

			int amount = getAmount(conn, location, category);
			to.setAmount(amount);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vNum);
			if (location.equals("1") && category.equals("1")) {
				pstmt.setInt(2, to.getStartNum());
				pstmt.setInt(3, to.getEndNum());
			} else if (!category.equals("1") && !location.equals("1")) {
				pstmt.setString(2, location);
				pstmt.setString(3, category);
				pstmt.setInt(4, to.getStartNum());
				pstmt.setInt(5, to.getEndNum());
			} else if (!location.equals("1")) {
				pstmt.setString(2, location);
				pstmt.setInt(3, to.getStartNum());
				pstmt.setInt(4, to.getEndNum());
			} else {
				pstmt.setString(2, category);
				pstmt.setInt(3, to.getStartNum());
				pstmt.setInt(4, to.getEndNum());
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int num = rs.getInt("num");
				String id = rs.getString("id");
				String title = rs.getString("title");
				Date writeday = rs.getDate("writeday");
				int readcnt = rs.getInt("readcnt");
				int likes = rs.getInt("likes");

				int money = rs.getInt("money");
				category = rs.getString("category");
				location = rs.getString("location");
				List<AttDTO> attList = attList(num, conn);
				String nickname = getnickname(id, conn);
				int replycnt = countReply(num, conn);
				list.add(new BoardDTO(num, id, title, null, readcnt, writeday, money, category, location, likes,
						attList, nickname, replycnt));
			}

			to.setList(list);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);

		}
		return to;

	}

	private String getnickname(String id, Connection conn) {
		String nickname = "";
		PreparedStatement pstmt = null;
		String sql = "select nickname from member where id = ?";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				nickname = rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);

		}

		return nickname;
	}

	private List<AttDTO> attList(int num, Connection conn) {
		List<AttDTO> list = new ArrayList<AttDTO>();

		PreparedStatement pstmt = null;
		String sql = "select * from attfile where num = ? order by attnum";
		ResultSet rs = null;
		try {

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int attNum = rs.getInt("attNum");
				String attPath = rs.getString("attPath");
				list.add(new AttDTO(attNum, num, attPath));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}
		return list;
	}

//중고매물게시판 리스트 페이지 getamount
	private int getAmount(Connection conn, String location, String category) {
		int amount = 0;

		PreparedStatement pstmt = null;
		String sql = "";
		if (location.equals("1") && category.equals("1")) {
			sql = "select count(num) from board";
		} else if (!category.equals("1") && !location.equals("1")) {
			sql = "select count(num) from board where location = ? and category = ?";
		} else if (!location.equals("1")) {
			sql = "select count(num) from board where location = ?";
		} else {
			sql = "select count(num) from board where category = ?";
		}
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			if (location.equals("1") && category.equals("1")) {
			} else if (!category.equals("1") && !location.equals("1")) {
				pstmt.setString(1, location);
				pstmt.setString(2, category);
			} else if (!location.equals("1")) {
				pstmt.setString(1, location);
			} else {
				pstmt.setString(1, category);
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				amount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

		return amount;
	}

//공지사항
	public List<BoardDTO> noticeList() {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select*\n"
				+ "from(select rownum rnum,num,id,title,content,readcnt,writeday,money,category,location\n"
				+ "from(select * from NoticeBoard order by num desc))\n" + "where rnum<6";
		ResultSet rs = null;
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int num = rs.getInt("num");
				String id = rs.getString("id");
				String title = rs.getString("title");
				Date writeday = rs.getDate("writeday");
				int readcnt = rs.getInt("readcnt");
				int money = rs.getInt("money");
				String category = rs.getString("category");
				String location = rs.getString("location");
				String nickname = getnickname(id, conn);
				List<AttDTO> attList = attnoticelist(num, conn);
				list.add(new BoardDTO(num, id, title, null, readcnt, writeday, money, category, location, 0, attList,
						nickname,0));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}

		return list;
	}

	public PageDTO pageNotice(int curPage, int perPage) {
		String sql = "select * from (select rownum rnum, num, title,id, writeday, money,category,location, readcnt from (select * from noticeboard order by num desc))\r\n"
				+ "where rnum>=? and rnum <=?";

		PageDTO to = new PageDTO(curPage);
		if (perPage != 0) {
			to.setPerPage(perPage);
		}

		List<BoardDTO> list = new ArrayList<BoardDTO>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = dataFactory.getConnection();

			int amount = getNoticeAmount(conn);

			to.setAmount(amount);

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, to.getStartNum());
			pstmt.setInt(2, to.getEndNum());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int num = rs.getInt("num");
				String id = rs.getString("id");
				String title = rs.getString("title");
				Date writeday = rs.getDate("writeday");
				int readcnt = rs.getInt("readcnt");
				String nickname = getnickname(id, conn);
				List<AttDTO> attList = attnoticelist(num, conn);
				list.add(new BoardDTO(num, id, title, null, readcnt, writeday, 0, null, null, 0, attList, nickname,0));
			}
			to.setList(list);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}

		return to;
	}

	private int getNoticeAmount(Connection conn) {
		int amount = 0;

		PreparedStatement pstmt = null;
		String sql = "select count(num) from noticeboard";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				amount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

		return amount;
	}

//관리자 글 삭제/복원
	public void visible(int tfnum, Integer num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update board set visible = ? where num = ?";

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tfnum);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, null);
		}
	}

//검색+페이징
	public PageDTO searchpage(int curPage, int visible, String keyword, String keyField) {
		String sql = "";
		if (keyField.equals("title_content")) {

			sql = "select * from (select rownum rnum, num, title,id, content, visible, writeday, money,category,location, readcnt, likes from (select * from (select * from board where visible=? order by num desc) where title like ? or content like ? )) where rnum >= ? and rnum <= ? ";
		} else if (keyField.equals("title_location")) {
			sql = "select * from (select rownum rnum, num, title,id, content, visible, writeday, money,category,location, readcnt, likes from (select * from (select * from board where visible=? order by num desc) where title like ? or location like ?)) where rnum >= ? and rnum <= ?";
		} else {
			sql = "select * from (select rownum rnum, num, title,id, content, visible, writeday, money,category,location, readcnt, likes from (select * from (select * from board where visible=? order by num desc) where "

					+ keyField + " like ? )) where rnum >= ? and rnum <= ?";
		}

		PageDTO to = new PageDTO(curPage);
		List<BoardDTO> list = new ArrayList<BoardDTO>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = dataFactory.getConnection();

			int amount = getSearchAmount(conn, visible, keyField, keyword);
			to.setAmount(amount);

			pstmt = conn.prepareStatement(sql);
			if (keyField.equals("title_content") || keyField.equals("title_location")) {
				pstmt.setInt(1, visible);
				pstmt.setString(2, "%" + keyword + "%");
				pstmt.setString(3, "%" + keyword + "%");
				pstmt.setInt(4, to.getStartNum());
				pstmt.setInt(5, to.getEndNum());
			} else {
				pstmt.setInt(1, visible);
				pstmt.setString(2, "%" + keyword + "%");
				pstmt.setInt(3, to.getStartNum());
				pstmt.setInt(4, to.getEndNum());
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int num = rs.getInt("num");
				String id = rs.getString("id");
				String title = rs.getString("title");
				Date writeday = rs.getDate("writeday");
				int readcnt = rs.getInt("readcnt");
				int likes = rs.getInt("likes");
				int money = rs.getInt("money");
				String category = rs.getString("category");
				String location = rs.getString("location");
				List<AttDTO> attList = attList(num, conn);
				String nickname = getnickname(id, conn);
				int replycnt = countReply(num, conn);

				list.add(new BoardDTO(num, id, title, null, readcnt, writeday, money, category, location, likes,
						attList, nickname,replycnt));
			}

			to.setList(list);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}
		return to;
	}

//검색 페이지 getAmount
	private int getSearchAmount(Connection conn, int visible, String keyField, String keyword) {
		int amount = 0;

		PreparedStatement pstmt = null;
		String sql = "";

		if (keyField.equals("title_content")) {

			sql = "select count(num) from (select * from board where visible=? order by num desc) where title like ? or content like ?";
		} else if (keyField.equals("title_location")) {

			sql = "select count(num) from (select * from board where visible=? order by num desc) where title like ? or location like ?";
		} else {

			sql = "select count(num) from (select * from board where visible=? order by num desc) where " + keyField
					+ " like ?";
		}
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			if (keyField.equals("title_content") || keyField.equals("title_location")) {

				pstmt.setInt(1, visible);
				pstmt.setString(2, "%" + keyword + "%");
				pstmt.setString(3, "%" + keyword + "%");

			} else {

				pstmt.setInt(1, visible);
				pstmt.setString(2, "%" + keyword + "%");

			}
			rs = pstmt.executeQuery();
			if (rs.next()) {

				amount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

		return amount;
	}

	// Member테이블 id와 pw있는지 확인
	public boolean login(LoginDTO loginDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from member where id = ? and pw = ?";
		ResultSet rs = null;
		boolean isLogin = false;

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginDTO.getId());
			pstmt.setString(2, loginDTO.getPw());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				isLogin = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}
		return isLogin;
	}

	// Member테이블 insert
	public void insertMember(MemberDTO memberDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into member (id, pw, name, nickname, contact, location, birthdate, gender) values (?, ?, ?, ?, ?, ?, ?, ?)";
		boolean isCommit = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			insertMemberCopy(conn, memberDTO);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getId());
			pstmt.setString(2, memberDTO.getPw());
			pstmt.setString(3, memberDTO.getName());
			pstmt.setString(4, memberDTO.getNickname());
			pstmt.setString(5, memberDTO.getContact());
			pstmt.setString(6, memberDTO.getLocation());
			pstmt.setInt(7, memberDTO.getBirthdate());
			pstmt.setString(8, memberDTO.getGender());
			pstmt.executeUpdate();
			isCommit = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isCommit) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();

			}
			closeAll(conn, pstmt, null);
		}

	}

//중요repstep2
	private int repstep2(Connection conn, ReplyDTO orgDTO) {
		int repstep = 0;
		PreparedStatement pstmt = null;

		String sql = "select repstep from reply where orgnum = ?";
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orgDTO.getRepNum());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int step = rs.getInt(1);
				repstep = step;
			}
			if (repstep == 0) {
				repstep = orgDTO.getRepStep();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}

		return repstep;
	}

	private void insertMemberCopy(Connection conn, MemberDTO memberDTO) {
		PreparedStatement pstmt = null;
		String sql = "insert into memberCopy (id, pw, name, nickname, contact, location, birthdate, gender) values (?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getId());
			pstmt.setString(2, memberDTO.getPw());
			pstmt.setString(3, memberDTO.getName());
			pstmt.setString(4, memberDTO.getNickname());
			pstmt.setString(5, memberDTO.getContact());
			pstmt.setString(6, memberDTO.getLocation());
			pstmt.setInt(7, memberDTO.getBirthdate());
			pstmt.setString(8, memberDTO.getGender());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
	}

	// 아이디 중복 확인
	public boolean idCheck(String id) {
		boolean idcheck = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from member where id = ?";
		ResultSet rs = null;

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				idcheck = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}
		return idcheck;
	}

	// Member테이블 업데이트
	public void updateMember(MemberDTO memberDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update member set pw = ?, name = ?, nickname = ?, contact = ?, location = ?, birthdate = ?, gender = ? where id = ?";
		boolean isCommit = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			updateMemberCopy(conn, memberDTO);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getPw());
			pstmt.setString(2, memberDTO.getName());
			pstmt.setString(3, memberDTO.getNickname());
			pstmt.setString(4, memberDTO.getContact());
			pstmt.setString(5, memberDTO.getLocation());
			pstmt.setInt(6, memberDTO.getBirthdate());
			pstmt.setString(7, memberDTO.getGender());
			pstmt.setString(8, memberDTO.getId());
			pstmt.executeUpdate();
			isCommit = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isCommit) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}

	}

	private void updateMemberCopy(Connection conn, MemberDTO memberDTO) {
		PreparedStatement pstmt = null;
		String sql = "update memberCopy set pw = ?, name = ?, nickname = ?, contact = ?, location = ?, birthdate = ?, gender = ? where id = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getPw());
			pstmt.setString(2, memberDTO.getName());
			pstmt.setString(3, memberDTO.getNickname());
			pstmt.setString(4, memberDTO.getContact());
			pstmt.setString(5, memberDTO.getLocation());
			pstmt.setInt(6, memberDTO.getBirthdate());
			pstmt.setString(7, memberDTO.getGender());
			pstmt.setString(8, memberDTO.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
	}

	// Member테이블 delete
	public void deleteMember(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from member where id = ?";
		boolean isCommit = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			likeListDelete(conn, id);
			trashMemberReply(conn, id);
			trashMemberBoard(conn, id);
			deleteMemberCopy(conn, id);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			isCommit = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isCommit) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}

	}

	private void trashMemberBoard(Connection conn, String id) {
		PreparedStatement pstmt = null;
		String sql = "update board set id = ? where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "trash");
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

	}
	
	private void likeListDelete(Connection conn, String id) {
		PreparedStatement pstmt = null;
		String sql = "delete from likelist where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

	}
	
	private void trashMemberReply(Connection conn, String id) {
		PreparedStatement pstmt = null;
		String sql = "update reply set id = ? where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "trash");
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

	}

	private void deleteMemberCopy(Connection conn, String id) {
		PreparedStatement pstmt = null;
		String sql = "delete from memberCopy where id = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
	}

	// num을 가지고 있는 likeList 출력
	public List<BoardDTO> likeList(String id) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from board where num = ?";
		ResultSet rs = null;
		boolean isCommit = false;

		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			List<LikeDTO> numList = likeListNum(conn, id);
			for (LikeDTO nl : numList) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, nl.getNum());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					int num = rs.getInt("num");
					String title = rs.getString("title");
					String content = rs.getString("content");
					int readcnt = rs.getInt("readcnt");
					Date writeday = rs.getDate("writeday");
					int money = rs.getInt("money");
					String category = rs.getString("category");
					String location = rs.getString("location");
					int likes = rs.getInt("likes");
					List<AttDTO> attList = attList(num, conn);
					list.add(new BoardDTO(num, id, title, content, readcnt, writeday, money, category, location, likes, attList, null, 0));
					if (pstmt != null) {
						pstmt.close();
					}
				}
			}
			isCommit = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isCommit) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, null, rs);
		}
		return list;
	}

	// id를 가지고있는 likeList 출력
	private List<LikeDTO> likeListNum(Connection conn, String id) {
		List<LikeDTO> numList = new ArrayList<LikeDTO>();
		PreparedStatement pstmt = null;
		String sql = "select * from likeList where id = ? order by likeNum desc";
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int likeNum = rs.getInt("likeNum");
				int num = rs.getInt("num");
				LikeDTO dto = new LikeDTO(likeNum, num, id);
				numList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		closeAll(null, pstmt, rs);

		return numList;
	}

	// read(중고 매물 게시글 자세히 보기 클릭하면 나오는것)(트랜젝션 구현)
	public BoardDTO read(int num) {
		BoardDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from Board where num = ?";
		ResultSet rs = null;
		boolean isOk = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			// readcnt 조회수 증가시키는 메소드
			createReadcnt(conn, num);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();


			if (rs.next()) {
				String id = rs.getString("id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				int readcnt = rs.getInt("readcnt");
				Date writeday = rs.getDate("writeday");
				int money = rs.getInt("money");
				String category = rs.getString("category");
				String location = rs.getString("location");
				int likes = rs.getInt("likes");
				List<AttDTO> attList = attList(num, conn);
				String nickname = getnickname(id, conn);
				int replycnt = countReply(num, conn);
				dto = new BoardDTO(num, id, title, content, readcnt, writeday, money, category, location, likes,
						attList, nickname,replycnt);
			}
			isOk = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk)
					conn.commit();
				else
					conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, rs);
		}
		return dto;
	}

	// readcnt 조회수 증가시키는 메서드 (read 메서드 안으로 들어감)
	public void createReadcnt(Connection conn, int num) {
		PreparedStatement pstmt = null;
		String sql = "update board set readcnt = readcnt + 1 where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
	}

	// ---------------------------------------------------------------
	// likes 증가시키는 메서드 createLikes(num)
	public void createLikes(LikeDTO likeDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql1 = "insert into likeList (likeNum,num,id) values (?,?,?)";
		boolean isOk = false;
		int likeNum = 0;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql1);
			likeNum = createLikeNum(conn);
			pstmt.setInt(1, likeNum);
			pstmt.setInt(2, likeDTO.getNum());
			pstmt.setString(3, likeDTO.getId());
			pstmt.executeUpdate();
			likesPlus(conn, likeDTO.getNum()); // board에 like 컬럼 update(plus) 시켜주는 메서드

			isOk = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk)
					conn.commit();
				else
					conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}

	}

	// likelist 테이블에 주키를 자동으로 증가시켜주는 메서드
	private int createLikeNum(Connection conn) {
		int likeNum = 0;
		PreparedStatement pstmt = null;
		String sql = "select max(likeNum) from likeList";
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				likeNum = rs.getInt(1);
				likeNum += 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}
		return likeNum;
	}

	/// board에 like 컬럼 update(plus) 시켜주는 메서드
	private void likesPlus(Connection conn, int num) {
		PreparedStatement pstmt = null;
		String sql = "update board set likes = likes + 1 where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
	}

	// like를 체크 했냐 안했냐 메서드
	public int checklike(int num, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from likelist where num = ? and id = ?";
		ResultSet rs = null;
		int likeit = 1;
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				likeit = 2;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}

		return likeit;
	}

	// like를 취소하는 메서드
	public void deleteLikes(LikeDTO likeDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql1 = "delete from likelist where id = ? and num = ?";
		boolean isOk = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, likeDTO.getId());
			pstmt.setInt(2, likeDTO.getNum());
			pstmt.executeUpdate();
			likeMinus(conn, likeDTO.getNum()); // board에 like 컬럼 update(minus) 시켜주는 메서드

			isOk = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk)
					conn.commit();
				else
					conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}

	}

	// board에 like 컬럼 update(minus) 시켜주는 메서드
	private void likeMinus(Connection conn, int num) {
		PreparedStatement pstmt = null;
		String sql = "update board set likes = likes -1 where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

	}

	// 공지사항 글쓰기
	public void insertNotice(BoardDTO boardDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into noticeboard (num, id, title, content,  readcnt, category, location) values (?,?,?,?,?,?,?)";
		boolean isCommit = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			int num = createNoticeNum(conn);

			pstmt.setInt(1, num);
			pstmt.setString(2, boardDTO.getId());
			pstmt.setString(3, boardDTO.getTitle());
			pstmt.setString(4, boardDTO.getContent());
			pstmt.setInt(5, 0);
			pstmt.setString(6, null);
			pstmt.setString(7, null);

			pstmt.executeUpdate();
			List<AttDTO> attList = boardDTO.getAttList();
			for (AttDTO attDTO : attList) {
				attachfilenotice(conn, attDTO.getAttPath(), num);
			}

			isCommit = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isCommit) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}

	}


	

	private void attachfilenotice(Connection conn, String attPath, int num) {
		PreparedStatement pstmt = null;
		String sql = "insert into attfilenotice (attNum, num, attPath) values (?, ?, ?)";
		int attNum = createAttNoticeNum(conn);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attNum);
			pstmt.setInt(2, num);
			pstmt.setString(3, attPath);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			closeAll(null, pstmt, null);
		}

		
	}

	private int createAttNoticeNum(Connection conn) {
		Integer num = null;
		PreparedStatement pstmt = null;
		String sql = "select max(attnum) from attfilenotice";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1);
				num += 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}
		return num;
	}

	// 공지사항게시판 넘버링
	private int createNoticeNum(Connection conn) {

		Integer num = null;
		PreparedStatement pstmt = null;
		String sql = "select max(num) from noticeboard";
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1);
				num += 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}
		return num;

	}

	public MemberDTO selectMember(String id) {
		MemberDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from member where id = ? ";
		ResultSet rs = null;
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String nickname = getnickname(id, conn);
				String name = rs.getString("name");
				String contact = rs.getString("contact");
				String location = rs.getString("location");
				int birthdate = rs.getInt("birthdate");
				String gender = rs.getString("gender");

				dto = new MemberDTO(id, null, name, nickname, contact, location, birthdate, gender);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}

		return dto;
	}

	public List<BoardDTO> selectList(String id) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from board where id = ?";
		ResultSet rs = null;

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String content = rs.getString("content");
				int readcnt = rs.getInt("readcnt");
				Date writeday = rs.getDate("writeday");
				int money = rs.getInt("money");
				String category = rs.getString("category");
				String location = rs.getString("location");
				int likes = rs.getInt("likes");
				List<AttDTO> attList = attList(num, conn);
				String nickname = getnickname(id, conn);
				int replycnt = countReply(num, conn);
				list.add(new BoardDTO(num, id, title, content, readcnt, writeday, money, category, location, likes,
						attList, nickname,replycnt));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}

		return list;
	}


	//  hotsalelist page  페이징처리
	public PageDTO page(int curPage) {
		PageDTO to = new PageDTO(curPage);
			List<BoardDTO> list = new ArrayList<BoardDTO>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = "select*from (select * from (select rownum rnum,num,id,title,writeday,money,category,location,readcnt,likes from (select*from board where writeday>sysdate-3 and visible = 1 order by likes Desc, readcnt desc)) where rnum<18)where rnum>=? and rnum<=? ";
			ResultSet rs = null;

			try {
				conn = dataFactory.getConnection();

				int amount = gethotsaleAmount(conn);
				to.setAmount(amount);

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, to.getStartNum());
				pstmt.setInt(2, to.getEndNum());

				rs = pstmt.executeQuery();

				while (rs.next()) {
					int num = rs.getInt("num");
					String id = rs.getString("id");
					String title = rs.getString("title");

					Date writeday = rs.getDate("writeday");
					int money = rs.getInt("money");
					String category = rs.getString("category");
					String location = rs.getString("location");
					int readcnt = rs.getInt("readcnt");
					int likes = rs.getInt("likes");
					String nickname = getnickname(id, conn);
					List<AttDTO> attList = attList(num, conn);
					int replycnt = countReply(num, conn);
					BoardDTO dto = new BoardDTO(num, id, title, null, readcnt, writeday, money, category, location, likes, attList, nickname, replycnt);

					list.add(dto);
				}
				to.setList(list);

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeAll(conn, pstmt, rs);
			}

			return to;
		}
		
	private int countReply(int num, Connection conn) {
		int replycnt = 0;
		PreparedStatement pstmt = null;
		String sql = "select count(renum) from reply where num = ?";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				replycnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}
		return replycnt;
	}

	public List<SelectDTO> location() {
		List<SelectDTO> list = new ArrayList<SelectDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from location";
		ResultSet rs = null;
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String option = rs.getString("location");
				String val = rs.getString("loVal");
				list.add(new SelectDTO(option, val));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}

		return list;
	}

	public List<SelectDTO> category() {
		List<SelectDTO> list = new ArrayList<SelectDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from category";
		ResultSet rs = null;
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String option = rs.getString("category");
				String val = rs.getString("caVal");
				list.add(new SelectDTO(option, val));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}
		return list;
	}

//글수정
	public void update(BoardDTO boardDTO, List<Integer> delList) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update board set location = ?, category = ?, money = ?, title = ?, content = ? where num = ?";
		boolean isOk = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getLocation());
			pstmt.setString(2, boardDTO.getCategory());
			pstmt.setInt(3, boardDTO.getMoney());
			pstmt.setString(4, boardDTO.getTitle());
			pstmt.setString(5, boardDTO.getContent());
			pstmt.setInt(6, boardDTO.getNum());
			pstmt.executeUpdate();

			for (AttDTO attDTO : boardDTO.getAttList()) {
				attachfile(conn, attDTO.getAttPath(), attDTO.getNum());
			}
			for (Integer attNum : delList) {
				deletefile(conn, attNum);
			}
			isOk = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}
	}

//글수정 첨부파일 추가
	private void attachfile(Connection conn, String attPath, int num) {
		PreparedStatement pstmt = null;
		String sql = "insert into attfile (attNum, num, attPath) values (?, ?, ?)";
		int attNum = createANum(conn);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attNum);
			pstmt.setInt(2, num);
			pstmt.setString(3, attPath);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			closeAll(null, pstmt, null);
		}

	}

//글수정 첨부파일 삭제
	private void deletefile(Connection conn, Integer attNum) {
		PreparedStatement pstmt = null;
		String sql = "delete from attfile where attnum = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attNum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
	}

//글삭제
	public void delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from board where num = ?";
		boolean isOk = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			deleteReply(conn,num);
			deleteLike(conn, num);
			deleteFile(conn, num);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			isOk = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}

	}
//글삭제 선행조건 댓글삭제
	private void deleteReply(Connection conn, int num) {
		PreparedStatement pstmt = null;
		String sql = "delete from reply where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
}

	// 글삭제 선행조건-첨부파일삭제
	private void deleteFile(Connection conn, int num) {
		PreparedStatement pstmt = null;
		String sql = "delete from attfile where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

	}

	// 글삭제 선행조건-좋아요삭제
	private void deleteLike(Connection conn, int num) {
		PreparedStatement pstmt = null;
		String sql = "delete from likelist where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

	}



	// hotsalelist page amount

	private int gethotsaleAmount(Connection conn) {
		int amount = 1;

		PreparedStatement pstmt = null;
		String sql = "select count(num) from (select * from (select rownum rnum,num,id,title,writeday,money,category,location,readcnt,likes from (select*from board where writeday>sysdate-3 and visible = 1 order by likes Desc)) where rnum<18)";
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				amount = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}

		return amount;
	}

	// main page hotsalelist
	public List<BoardDTO> MainPageHotsalelist() {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = " select * from (select rownum rnum,num,id,title,writeday,money,category,location,readcnt,likes from (select*from board where writeday>sysdate-2 and visible = 1 order by likes Desc, readcnt desc)) where rownum<13";
		ResultSet rs = null;

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int num = rs.getInt("num");
				String id = rs.getString("id");
				String title = rs.getString("title");

				Date writeday = rs.getDate("writeday");
				int money = rs.getInt("money");
				String category = rs.getString("category");
				String location = rs.getString("location");
				int readcnt = rs.getInt("readcnt");
				int likes = rs.getInt("likes");
				String nickname = getnickname(id, conn);
				List<AttDTO> attList = attList(num, conn);
				int replycnt = countReply(num, conn);
				BoardDTO dto = new BoardDTO(num, id, title, null, readcnt, writeday, money, category, location, likes, attList, nickname,replycnt);
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, pstmt, rs);
		}

		return list;
	}

	public BoardDTO readNotice(int num) {
		BoardDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select * from noticeBoard where num = ?";
		ResultSet rs = null;
		boolean isOk = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			createNoticeReadcnt(conn, num);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

		

			if (rs.next()) {
				String id = rs.getString("id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				int readcnt = rs.getInt("readcnt");
				Date writeday = rs.getDate("writeday");
				String nickname = getnickname(id, conn);
				List<AttDTO> attList = attnoticelist(num,conn);
				dto = new BoardDTO(num, id, title, content, readcnt, writeday, 0, null, null, 0,
						attList, nickname,0);
			}
			isOk = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk)
					conn.commit();
				else
					conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, rs);
		}
		return dto;
	}
	
	private List<AttDTO> attnoticelist(int num, Connection conn) {
		List<AttDTO> list = new ArrayList<AttDTO>();

		PreparedStatement pstmt = null;
		String sql = "select * from attfilenotice where num = ? order by attnum";
		ResultSet rs = null;
		try {

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int attNum = rs.getInt("attNum");
				String attPath = rs.getString("attPath");
				list.add(new AttDTO(attNum, num, attPath));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, rs);
		}
		return list;
	}

	private void createNoticeReadcnt(Connection conn, int num) {
		PreparedStatement pstmt = null;
		String sql = "update Noticeboard set readcnt = readcnt + 1 where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
	}

	public void deleteNotice(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from noticeboard where num = ?";
		boolean isOk = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			deleteNoticeFile(conn, num);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			isOk = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}
		
	}
//공지삭제 선행작업-첨부파일삭제
	private void deleteNoticeFile(Connection conn, int num) {
		PreparedStatement pstmt = null;
		String sql = "delete from attfilenotice where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}

		
	}
//공지수정
	public void updateNotice(BoardDTO boardDTO, List<Integer> delList) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update Noticeboard set title = ?, content = ? where num = ?";
		boolean isOk = false;
		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getTitle());
			pstmt.setString(2, boardDTO.getContent());
			pstmt.setInt(3, boardDTO.getNum());
			pstmt.executeUpdate();

			for (AttDTO attDTO : boardDTO.getAttList()) {
				attachfilenotice(conn, attDTO.getAttPath(), attDTO.getNum());
			}
			for (Integer attNum : delList) {
				deletefilenotice(conn, attNum);
			}
			isOk = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll(conn, pstmt, null);
		}
		
	}

	private void deletefilenotice(Connection conn, Integer attNum) {
		PreparedStatement pstmt = null;
		String sql = "delete from attfilenotice where attnum = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attNum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
		
	}

}

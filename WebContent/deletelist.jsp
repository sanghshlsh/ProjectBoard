<%@page import="kr.co.domain.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	session = request.getSession(false);

	if (session.getAttribute("login") == null) {

		out.println(
				"<script>alert('관리자만 접근 가능한 페이지 입니다. 메인 페이지로 이동합니다.'); location.href='/ProjectBoard/mainpage.do'; </script>");

		return; // 중요함!!
	
	} else {
		
		LoginDTO dto = (LoginDTO) session.getAttribute("login");
		if (dto.getId()=="admin") {
			out.println(
					"<script>alert('관리자만 접근 가능한 페이지 입니다. 메인 페이지로 이동합니다.'); location.href='/ProjectBoard/mainpage.do'; </script>");

			return; // 중요함!!
		}
	}
%>
</head>
<body>
	<form action="visible.do">
		<table border="1">
			<thead>
				<tr>
					<th>선택</th>
					<th>글번호</th>
					<th>id</th>
					<th>제목</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>찜한 인원</th>

				</tr>
			</thead>

			<tbody>

				<c:forEach items="${list}" var="dto">
					<tr>
						<td><input type="checkbox" name="num" value="${dto.num }"></td>
						<td width="20px">${dto.num}</td>
						<td width="100px">${dto.id}</td>

						<td width="200px"><a href="read.do?num=${dto.num }">${dto.title}</a></td>
						<td width="100px">${dto.writeday}</td>
						<td width="20px">${dto.readcnt}</td>
						<td width="20px">${dto.likes}</td>

					</tr>
				</c:forEach>


			</tbody>

		</table>
		<input type="submit" value="복원">
	</form>

	<form action="search.do" name="search" method="get">
		<select name="keyField">
			<option value="">--------</option>
			<option value="id">아이디</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="location">지역</option>
			<option value="title_content">제목+내용</option>
			<option value="title_location">제목+지역</option>

		</select> <input type="text" name="keyWord" /> <input type="submit" value="검색">
		<input type="reset" value="리셋">


	</form>

	<table>
		<tbody>
			<tr>
				<td colspan="7"><p align="center">
						<a href="list.do">[전체목록]</a></td>
			</tr>
		</tbody>
	</table>

	<a href="list.do?curPage=${(to.curPage-1) > 0 ? (to.curPage-1) : 1 }">&laquo;</a>
	&nbsp;&nbsp;
	<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}" var="idx">

		<c:if test="${to.curPage == idx}">
			<!-- 현재페이지 글자 크게 -->
			<a style="font-size: 30px;" href="list.do?curPage=${idx}">${idx}</a>&nbsp;&nbsp;
		</c:if>

		<c:if test="${to.curPage != idx }">
			<a href="list.do?curPage=${idx}">${idx}</a>&nbsp;&nbsp;
		</c:if>

	</c:forEach>
	&nbsp;&nbsp;
	<a
		href="list.do?curPage=${(to.curPage+1)< to.totalPage ? (to.curPage+1): to.totalPage }">&raquo;</a>

</body>

</html>
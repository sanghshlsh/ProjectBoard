<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고게시판</title>

</head>

<body>
	<h1>${param.keyWord } 검색 목록</h1>
	
	<button
		<c:if test="${not empty login }">
		onclick="location.href='insertui.do'" 
		</c:if>
		<c:if test="${empty login }">
		onclick="clickbutton();"
		</c:if>
	>
		글쓰기</button>
		



	<script type="text/javascript">
		function clickbutton() {
			alert("로그인이 필요한 서비스입니다.");
			location.href = '/ProjectBoard/loginui.do';
		};
		
	</script>

	
		<table border="1">
			<thead>
				<tr>
				
					<th>지역</th>
					<th>카테고리</th>
					<th>글번호</th>
					<th>닉네임</th>
					<th>제목</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>찜한 인원</th>

				</tr>
			</thead>

			<tbody>
				<c:forEach items="${nolist }" var="dto">
					<tr>
					
						<td></td>
						<td></td>
						<td>공지</td>
						<td>${dto.nickname}</td>
						<td><a href="readNotice.do?num=${dto.num }">${dto.title}</a></td>
						<td>${dto.writeday}</td>
						<td>${dto.readcnt}</td>
						<td></td>
					</tr>
				</c:forEach>

				<c:forEach items="${list}" var="dto">
					<tr>
						<td>${dto.location }</td>
						<td>${dto.category }</td>
						<td width="20px">${dto.num}</td>
						<td width="100px">${dto.nickname}</td>

						<td width="200px"><a href="read.do?num=${dto.num }"><c:if
									test="${not empty dto.attList }">
									<img width="50px" height="50px" src="${dto.attList[0].attPath}">
								</c:if> ${dto.title}</a></td>
						<td width="100px">${dto.writeday}</td>
						<td width="20px">${dto.readcnt}</td>
						<td width="20px">${dto.likes}</td>

					</tr>
				</c:forEach>


			</tbody>

		</table>




	<form action="search.do" name="search" method="get">
		<select name="keyField">
			<option value="">--------</option>
			<option value="id">아이디</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="location">지역</option>
			<option value="title_content">제목+내용</option>
			<option value="title_location">제목+지역</option>

		</select> <input type="text" name="keyWord" /> <input type="submit" value="검색"><input
			type="hidden" value="1" name="visible"> <input type="reset"
			value="리셋">


	</form>


	<table>
		<tbody>
			<tr>
				<td colspan="7"><p align="center">
						<a href="list.do">[전체목록]</a></td>
				<td colspan="7"><p align="center">
						<a href="listNotice.do">[공지게시판]</a></td>
			</tr>
		</tbody>
	</table>

	<a href="search.do?keyField=${param.keyField }&keyWord=${param.keyWord }&curPage=${(to.curPage-1) > 0 ? (to.curPage-1) : 1 }"> &laquo;</a>
	&nbsp;&nbsp;
	<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}" var="idx">

		<c:if test="${to.curPage == idx}">
			<!-- 현재페이지 글자 크게 -->
			<a style="font-size: 30px;" href="search.do?keyField=${param.keyField }&keyWord=${param.keyWord }&curPage=${idx}">${idx}</a>&nbsp;&nbsp;
		</c:if>

		<c:if test="${to.curPage != idx }">
			<a href="search.do?keyField=${param.keyField }&keyWord=${param.keyWord }&curPage=${idx}">${idx}</a>&nbsp;&nbsp;
		</c:if>

	</c:forEach>
	&nbsp;&nbsp;
	<a
		href="search.do?keyField=${param.keyField }&keyWord=${param.keyWord }&curPage=${(to.curPage+1)< to.totalPage ? (to.curPage+1): to.totalPage }">&raquo;</a>


</body>
</html>
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
</head>
<body>
<h1>${nickname }님의 판매 물품리스트</h1>
<br>
<br>
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


			<c:forEach items="${list}" var="dto">
				<tr>
					<td>${dto.location }</td>
					<td>${dto.category }</td>
					<td>${dto.num}</td>
					<td>${dto.nickname}</td>

					<td><a href="read.do?num=${dto.num }"><c:if
								test="${not empty dto.attList }">
								<img width="50px" height="50px" src="${dto.attList[0].attPath}">
							</c:if> ${dto.title}</a></td>
					<td>${dto.writeday}</td>
					<td>${dto.readcnt}</td>
					<td>${dto.likes}</td>

				</tr>
			</c:forEach>


		</tbody>

	</table>

</body>
</html>
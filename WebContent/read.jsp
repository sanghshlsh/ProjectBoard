<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고거래 물품</title>
</head>
<body>

	<h1>중고거래 목록</h1>


	글번호:${dto.num }
	<br> 조회:${dto.readcnt }
	<br> 카테고리:${dto.category}
	<br> 
	<c:if test="${check eq 0 or dto.id eq login.id}">좋아요 </c:if> 
	<c:if test="${check eq 1 and dto.id ne login.id}"><a href="like.do?num=${dto.num }">좋아요</a> </c:if>
	<c:if test="${check eq 2}"><a href="deletelike.do?num=${dto.num }">좋아요 취소</a> </c:if>
	:${dto.likes}
	<br> 닉네임 :<a href="listmemberboard.do?id=${dto.id }">${dto.nickname }</a>
	<br> 아이디:<a href="listmemberboard.do?id=${dto.id }">${dto.id}</a>
	<br> 제목:${dto.title }
	<br> 금액:${dto.money }
	<br> 지역:${dto.location}
	<br> 내용:${dto.content}
	<br> 
	<c:forEach items="${alist }" var="adto">
	<img width="250px" height="250px" src="${adto.attPath}"><br>
	</c:forEach>





	<c:if test="${dto.id eq login.id }">
	<a href="updateui.do?num=${dto.num}">수정</a>
	<a href="deleteui.do?num=${dto.num}">삭제</a>
	</c:if>
	<a href="list.do">목록</a>



	<table>
		<thead>
			<tr>
				<th colspan="5">-----------------------------------------------------------------</th>
				


			</tr>
		</thead>

		<tbody>
			<c:forEach items="${rlist}" var="rdto">
				<tr>
					<td><a href="listmemberboard.do?id=${rdto.id}">${rdto.nickname}</a></td>
					<td width="250px"><c:forEach begin="1" end="${rdto.repIndent}">
   &nbsp;&nbsp;→
   
   </c:forEach> ${rdto.content}</td>
					<td><c:if test="${not empty login }"><a href="replyui.do?repNum=${rdto.repNum}&num=${rdto.num}">댓글</a></c:if></td>
					<td><c:if test="${login.id eq rdto.id }"><a href="reupdateui.do?repNum=${ rdto.repNum}">수정</a></c:if></td>
					<td><c:if test="${login.id eq rdto.id }"><a href="redelete.do?repNum=${rdto.repNum}&num=${rdto.num}">삭제</a></c:if></td> 
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
<c:if test="${not empty login }">
	<form action="replyinsert.do" method="post">
		<input type="hidden" name="num" readonly value="${dto.num }"><br>
		<input type="hidden" name="id" value="${login.id }">
		<textarea rows="5" cols="70" name="content"></textarea>
		<br> <br> <input type="submit" value="댓글달기">

	</form>
</c:if>





</body>
</html>
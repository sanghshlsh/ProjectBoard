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

	<h1>공지사항</h1>


	글번호:${dto.num }
	<br> 
	${dto.nickname }
	<br> 제목:${dto.title }
	<br> 조회수:${dto.readcnt }
	<br> 작성일:${dto.writeday }
	<br> 내용:${dto.content}
	<br> 
	<c:forEach items="${alist }" var="adto">
	<img width="250px" height="250px" src="${adto.attPath}"><br>
	</c:forEach>

	<c:if test="${dto.id eq login.id }">
	<a href="updatenoticeui.do?num=${dto.num}">수정</a>
	<a href="deletenoticeui.do?num=${dto.num}">삭제</a>
	</c:if>
	<a href="listNotice.do">목록</a>

</body>
</html>
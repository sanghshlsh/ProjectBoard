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



	<form action="rereply.do" method="post">
<input type="hidden" name="id" value="${login.id }">
<input type="hidden" name ="num" value="${param.num}"><br>
<input type="hidden" name ="repNum" value="${param.repNum}"><br>
		댓글<br>
		
		<textarea rows="5" cols="70" name="content"></textarea>
		<br> <input type="submit" value="댓글">

	</form>





</body>
</html>
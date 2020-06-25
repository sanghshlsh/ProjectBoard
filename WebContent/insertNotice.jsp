<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>공지사항 작성</h1>

<form action="insertNotice.do"method="post" enctype="multipart/form-data">

글제목 : <input name="title"><br>
<input type="file" name="file">
<br>
<input type="file" name="file2">
<br>
<input type="file" name="file3">
<br>
<textarea rows="10" cols="35" name="content">

</textarea><br>
<input type="submit" value="완료">
<input type="hidden" name="id" value="${login.id }">

</form>
<button onclick="location.href='listNotice.do'">목록으로</button>
</body>
</html>
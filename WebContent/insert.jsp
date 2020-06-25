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
<h1>글 작성</h1>

<form action="insert.do" method="post"  enctype="multipart/form-data">
지역:<select name="location" >
<c:forEach items="${lolist }" var="lodto">
<option value="${lodto.option }">${lodto.option }</option>
</c:forEach>
</select><br>
카테고리:<select name="category">
<c:forEach items="${calist }" var="cadto">
<option value="${cadto.val }">${cadto.option }</option>
</c:forEach>
</select><br>
금액 : <input name="money" type="number"><br>
글제목 : <input name="title"><br>
<input type="file" value="업로드" name="file">
<br>
<input type="file" value="업로드" name="file2">
<br>
<input type="file" value="업로드" name="file3">
<br>
<textarea rows="10" cols="35" name="content">

</textarea><br>
<input type="submit" value="완료">
<input type="hidden" name="id" value="${login.id }">

</form>
<button onclick="location.href='list.do'">목록으로</button>
</body>
</html>
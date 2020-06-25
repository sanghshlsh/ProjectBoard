<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<h1>댓글은 수정이</h1>


<form action="reupdate.do" method="post">
<input type ="hidden" name ="repNum" readonly value="${param.repNum}"><br>

<textarea rows="5" cols="70"  name="content">${param.content}</textarea><br>
<input type="submit" value="댓수정">



</form>

</body>
</html>
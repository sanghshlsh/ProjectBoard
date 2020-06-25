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
공지사항을 삭제하시겠습니까.
<button	onclick="location.href='deletenotice.do?num=${num}'"> 예</button>
<button	onclick="location.href='readnotice.do?num=${num}'"> 아니오</button>		
		
		
</body>
</html>
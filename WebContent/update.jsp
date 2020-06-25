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
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
	$(function() {

		$("#btn").click(function(e) {
			e.preventDefault();
			$("#file").click();
		});
	
		$("#btn2").click(function(e) {
			e.preventDefault();
			$("#file2").click();
		});
		
		$("#btn3").click(function(e) {
			e.preventDefault();
			$("#file3").click();
		});
		
	});

	function changeValue(obj) {
		//alert(obj.value);
	}
</script>
<style type="text/css">
.file {
	display: none;
}
</style>

</head>
<body>
	<h1>글 수정</h1>

	<form action="update.do" method="post" enctype="multipart/form-data">
		<input type="hidden" value="${dto.num }" name = "num">
		지역:<select name="location">
			<c:forEach items="${lolist }" var="lodto">
				<option value="${lodto.val }"
					<c:if test="${lodto.val eq dto.location }">selected</c:if>>${lodto.option }</option>
			</c:forEach>
		</select><br> 카테고리:<select name="category">
			<c:forEach items="${calist }" var="cadto">
				<option value="${cadto.val }"
					<c:if test="${cadto.val eq dto.category }">selected</c:if>>${cadto.option }</option>
			</c:forEach>
		</select><br> 금액 : <input name="money" type="number" value="${dto.money }"><br>
		글제목 : <input name="title" value="${dto.title }"><br> 
			
			
			
			<c:if test="${empty alist[0]}">
				<input type="file" name="file">
			</c:if>
			<c:if test="${not empty alist[0]}">
				<input type="file" class="file" id="file" name="file"
					onchange="changeValue(this)" />
				<button type="button" id="btn">
					<img src="${alist[0].attPath }" width="50px" height="50px">
				</button>
				<input type="hidden"  value="${alist[0].attNum }" name = "orgFile1">
			</c:if>
<br>



		<c:if test="${empty alist[1]}">
				<input type="file" name="file2">
			</c:if>
			<c:if test="${not empty alist[1]}">
				<input type="file" class="file" id="file2" name="file2"
					onchange="changeValue(this)" />
				<button type="button" id="btn2">
					<img src="${alist[1].attPath }" width="50px" height="50px">
				</button>
					<input type="hidden"  value="${alist[1].attNum }" name = "orgFile2">
			</c:if>
	<br>	
		
			<c:if test="${empty alist[2]}">
				<input type="file" name="file3">
			</c:if>
			<c:if test="${not empty alist[2]}">
				<input type="file" class="file" id="file3" name="file3"
					onchange="changeValue(this)" />
				<button type="button" id="btn3">
					<img src="${alist[2].attPath }" width="50px" height="50px">
				</button>
				<input type="hidden"  value="${alist[2].attNum }" name = "orgFile3">
			</c:if>
	

		<br>
		<textarea rows="10" cols="35" name="content">
${dto.content }
</textarea>
		<br> <input type="submit" value="완료"> <input
			type="hidden" name="id" value="${login.id }">

	</form>
	<button onclick="location.href='list.do'">목록으로</button>
</body>
</html>
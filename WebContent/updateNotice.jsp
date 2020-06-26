<%@page import="kr.co.domain.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/codingBooster.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>당근마켓</title>
<%
	session = request.getSession(false);

	if (session.getAttribute("login") == null) {

		out.println(
				"<script>alert('관리자만 접근 가능한 페이지 입니다. 메인 페이지로 이동합니다.'); location.href='/ProjectBoard/mainpage.do'; </script>");

		return; // 중요함!!
	
	} else {
		
		LoginDTO dto = (LoginDTO) session.getAttribute("login");
		if (dto.getId()=="admin") {
			out.println(
					"<script>alert('관리자만 접근 가능한 페이지 입니다. 메인 페이지로 이동합니다.'); location.href='/ProjectBoard/mainpage.do'; </script>");

			return; // 중요함!!
		}
	}
%>
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

<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
					<span class="sr-only"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="mainPage.do">당근 마켓</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li class="active"><a href="mainPage.do">소개<span class="sr-only"></span></a></li>
					<li><a href="####">운영진</a></li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
							aria-haspopup="true" aria-expanded="false">게시판<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="listNotice.do">공지사항</a></li>
							<li><a href="list.do">일반 매물 게시판</a></li>
							<li><a href="hotsalelist.do">인기 매물 게시판</a></li>
						</ul>
					</li>
				</ul>
				<c:if test="${empty login}">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
							aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="loginui.do">로그인</a></li>
							<li><a href="insertMemberui.do">회원가입</a></li>
						</ul>
					</li>
				</ul>
				</c:if>
				<c:if test="${not empty login}">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="myPage.do">마이페이지</a></li>
					<li><a href="logout.do">로그아웃</a></li>
				</ul>
				</c:if>
			</div>
		</div>
	</nav>


	<div class="container">
		<div class="row">
		<form action="updateNotice.do"method="post" enctype="multipart/form-data">
			<input type="hidden" value="${dto.num }" name = "num">
			<table class="table table-striped table-bordered">
				<thead  style="background-color: #337ab7; color: white;">
					<tr>
						<th colspan="5" style="text-align: center;"><h3>공지사항 수정</h3></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="20%;">제목</td>
						<td><input name="title" style="width: 100%" value="${dto.title}"></td>
					</tr>
					<tr>
						<td>첨부파일</td>
						<td>
							<c:if test="${empty alist[0]}">
								<input type="file" name="file">
							</c:if>
							<c:if test="${not empty alist[0]}">
								<input type="file" class="file" id="file" name="file" onchange="changeValue(this)" />
								<button type="button" id="btn">
									<img src="${alist[0].attPath }" width="50px" height="50px">
								</button>
								<input type="hidden"  value="${alist[0].attNum }" name = "orgFile1">
							</c:if>
							<c:if test="${empty alist[1]}">
								<input type="file" name="file2">
							</c:if>
							<c:if test="${not empty alist[1]}">
								<input type="file" class="file" id="file2" name="file2" onchange="changeValue(this)" />
								<button type="button" id="btn2">
									<img src="${alist[1].attPath }" width="50px" height="50px">
								</button>
								<input type="hidden"  value="${alist[1].attNum }" name = "orgFile2">
							</c:if>
							<c:if test="${empty alist[2]}">
								<input type="file" name="file3">
							</c:if>
							<c:if test="${not empty alist[2]}">
								<input type="file" class="file" id="file3" name="file3" onchange="changeValue(this)" />
								<button type="button" id="btn3">
									<img src="${alist[2].attPath }" width="50px" height="50px">
								</button>
								<input type="hidden"  value="${alist[2].attNum }" name = "orgFile3">
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="5">내용</td>
					</tr>
					<tr>
						<td colspan="5"><textarea style="width: 100%" rows="30" name="content">${dto.content}</textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="id" value="${login.id }">
			<button class="btn btn-primary btn-lg" onclick="location.href='listNotice.do'">목록</button>
			<span style="float:right"><button type="submit" class="btn btn-primary btn-lg">완료</button></span>
		</form>
		</div>
	</div>

	<br>
	
	<footer style="background-color: #000000; color: #ffffff">
		<div class="container-fluid">
			<br>
			<div class="row">
				<div class="col-sm-2" style="text-align: center;"><h5>Copyright &copy; 2020</h5><h5>박성혁 이상협</h5><h5>최형단 신혜원</h5><h5>박민철 윤소휘</h5></div>
				<div class="col-sm-4"><h4>홈페이지 소개</h4><p>당근 마켓은 팀 프로젝트 떄문에 만든 중고 거래 게시판입니다.</p></div>
				<div class="col-sm-2"><h4 style="text-align: center;">내비게이션</h4>
					<div class="list-group">
						<a href="mainpage.do" class="list-group-item">소개</a>
						<a href="####" class="list-group-item">운영진</a>
						<a href="list.do" class="list-group-item">게시판</a>
					</div>
				</div>
				<div class="col-sm-2"><h4 style="text-align: center;">바로가기</h4>
					<div class="list-group">
						<a href="https://www.naver.com" class="list-group-item">네이버</a>
						<a href="https://www.google.com" class="list-group-item">구글</a>
						<a href="https://www.daum.net" class="list-group-item">다음</a>
					</div>
				</div>
				<div class="col-sm-2"><h4 style="text-align: center;"><span class="glyphicon glyphicon-ok"></span>&nbsp;by 팀 프로젝트</h4></div>
			</div>
		</div>
	</footer>
	
</body>
</html>
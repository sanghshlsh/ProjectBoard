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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/codingBooster.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>일반 매물 게시판 당근마켓</title>
</head>

<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="mainPage.do">당근 마켓</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li class="active"><a href="mainPage.do">소개<span
							class="sr-only"></span></a></li>
					<li><a href="####">운영진</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">게시판<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="listNotice.do">공지사항</a></li>
							<li><a href="list.do">일반 매물 게시판</a></li>
							<li><a href="hotsalelist.do">인기 매물 게시판</a></li>
						</ul></li>
				</ul>
				<c:if test="${empty login}">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="loginui.do">로그인</a></li>
								<li><a href="insertMemberui.do">회원가입</a></li>
							</ul></li>
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

	<%-- 글쓰기 버튼 --%>
	<button type="button" class="btn btn-primary"
		<c:if test="${not empty login }">
		onclick="location.href='insertui.do'" 
		</c:if>
		<c:if test="${empty login }">
		onclick="clickbutton();"
		</c:if>>
		글쓰기</button>

	<script type="text/javascript">
		function clickbutton() {
			alert("로그인이 필요한 서비스입니다.");
			location.href = '/ProjectBoard/loginui.do';
		};
	</script>


	<%-- 지역--%>
	<select name="location" onchange="window.open(value,'_self');">
		<option value="/ProjectBoard/list.do?category=${param.category}">지역</option>
		<c:forEach items="${lolist }" var="lodto">
			<option
				value="/ProjectBoard/list.do?location=${lodto.val }&category=${param.category}"
				<c:if test="${lodto.val eq param.location }" >selected </c:if>>${lodto.option }</option>
		</c:forEach>
	</select>




	<!-- 카테고리 -->
	<select name="category" onchange="window.open(value,'_self');">
		<option value="/ProjectBoard/list.do?location=${param.location}">카테고리</option>
		<c:forEach items="${calist }" var="cadto">
			<option
				value="/ProjectBoard/list.do?category=${cadto.val }&location=${param.location}"
				<c:if test="${cadto.val eq param.category }" >selected </c:if>>${cadto.option }</option>
		</c:forEach>
	</select>

	<form action="invisible.do">

	<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-heading">
					<span class="glyphicon glyphicon-option-vertical"></span>&nbsp;일반
					매물 게시판
				</h1>
			</div>
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<c:if test="${login.id eq 'admin' }">
								<th>선택</th>
							</c:if>
							<th>지역</th>
							<th>카테고리</th>
							<th>글번호</th>
							<th>닉네임</th>
							<th>제목</th>
							<th>작성일</th>
							<th>조회수</th>
							<th>찜한인원</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${nolist}" var="dto">
							<tr>
								<c:if test="${login.id eq 'admin' }">
									<td></td>
								</c:if>
								<td></td>
								<td></td>
								<td>공지</td>
								<td>${dto.nickname}</td>
								<td><a href="readNotice.do?num=${dto.num }">${dto.title}</a></td>
								<td>${dto.writeday}</td>
								<td>${dto.readcnt}</td>
								<td></td>
							</tr>
						</c:forEach>
						<c:forEach items="${list}" var="dto">
							<tr>
								<c:if test="${login.id eq 'admin' }">
									<td><input type="checkbox" name="num" value="${dto.num }"></td>
								</c:if>
								<td>${dto.location }</td>
								<td>${dto.category }</td>
								<td width="20px">${dto.num}</td>
								<td width="100px"><a href="listmemberboard.do?id=${dto.id}">${dto.nickname}</a></td>

								<td width="200px"><a href="read.do?num=${dto.num }"><c:if
											test="${not empty dto.attList }">
											<img width="50px" height="50px"
												src="${dto.attList[0].attPath}">
										</c:if> ${dto.title}</a>[${dto.replycnt }]</td>
								<td width="100px">${dto.writeday}</td>
								<td width="20px">${dto.readcnt}</td>
								<td width="20px">${dto.likes}</td>

							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>


	<!--admin 이면 삭제가능하게 좌측에~~  -->
	<c:if test="${login.id eq 'admin' }">
		<a href="deletelist.do">삭제된 글 모음</a>
	</c:if>
	<%--
	공지사항 하단 게시판에 통합
	<table border="1">
		<thead>

			<tr>
				<th>num</th>
				<th>id</th>
				<th>title</th>
				<th>writeday</th>
				<th>redcnt</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach items="${nolist}" var="dto">
				<tr>
					<td width="20px">${dto.num}</td>
					<td width="100px">${dto.id}</td>

					<td width="200px">${dto.title}</td>
					<td width="100px">${dto.writeday}</td>
					<td width="20px">${dto.readcnt}</td>


				</tr>
			</c:forEach>
		</tbody>
	</table>
 --%>
	<br>





		<%-- 이미지경로
<img src="http://localhost:8089/ProjectBoard/upload/2020-06-16/copy_test5.jpg">
 --%>

		<c:if test="${login.id eq 'admin' }">
			<input type="submit" value="삭제">
		</c:if>
	</form>



	<form action="search.do" name="search" method="get">
		<select name="keyField">
			<option value="id">아이디</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="location">지역</option>
			<option value="title_content">제목+내용</option>
			<option value="title_location">제목+지역</option>

		</select> <input type="text" name="keyWord" /> <input type="submit" value="검색"><input
			type="hidden" value="1" name="visible"> <input type="reset"
			value="리셋">


	</form>


	<table>
		<tbody>
			<tr>
				<td colspan="7"><p align="center">
						<a href="list.do">[전체목록]</a></td>
				<td colspan="7"><p align="center">
						<a href="listNotice.do">[공지게시판]</a></td>
			</tr>
		</tbody>
	</table>

	<a
		href="list.do?location=${param.location }&category=${param.category }&curPage=${(to.curPage-1) > 0 ? (to.curPage-1) : 1 }">
		&laquo;</a> &nbsp;&nbsp;
	<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}" var="idx">

		<c:if test="${to.curPage == idx}">
			<!-- 현재페이지 글자 크게 -->
			<a style="font-size: 30px;"
				href="list.do?location=${param.location }&category=${param.category }&curPage=${idx}">${idx}</a>&nbsp;&nbsp;
		</c:if>

		<c:if test="${to.curPage != idx }">
			<a
				href="list.do?location=${param.location }&category=${param.category }&curPage=${idx}">${idx}</a>&nbsp;&nbsp;
		</c:if>

	</c:forEach>
	&nbsp;&nbsp;
	<a
		href="list.do?location=${param.location }&category=${param.category }&curPage=${(to.curPage+1)< to.totalPage ? (to.curPage+1): to.totalPage }">&raquo;</a>





	<footer style="background-color: #000000; color: #ffffff">
		<div class="container-fluid">
			<br>
			<div class="row">
				<div class="col-sm-2" style="text-align: center;">
					<h5>Copyright &copy; 2020</h5>
					<h5>박성혁 이상협</h5>
					<h5>최형단 신혜원</h5>
					<h5>박민철 윤소희</h5>
				</div>
				<div class="col-sm-4">
					<h4>홈페이지 소개</h4>
					<p>당근 마켓은 팀 프로젝트 떄문에 만든 중고 거래 게시판입니다.</p>
				</div>
				<div class="col-sm-2">
					<h4 style="text-align: center;">내비게이션</h4>
					<div class="list-group">
						<a href="mainpage.do" class="list-group-item">소개</a> <a
							href="####" class="list-group-item">운영진</a> <a href="list.do"
							class="list-group-item">게시판</a>
					</div>
				</div>
				<div class="col-sm-2">
					<h4 style="text-align: center;">바로가기</h4>
					<div class="list-group">
						<a href="https://www.naver.com" class="list-group-item">네이버</a> <a
							href="https://www.google.com" class="list-group-item">구글</a> <a
							href="https://www.daum.net" class="list-group-item">다음</a>
					</div>
				</div>
				<div class="col-sm-2">
					<h4 style="text-align: center;">
						<span class="glyphicon glyphicon-ok"></span>&nbsp;by 팀 프로젝트
					</h4>
				</div>
			</div>
		</div>
	</footer>

</body>
</html>
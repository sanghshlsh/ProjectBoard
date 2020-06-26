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
<style>
.row {
	height: 400px;
}
</style>

<title>당근마켓</title>
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





	<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-heading listColor">
					<span class="glyphicon glyphicon-option-vertical"></span> &nbsp;인기
					매물 게시판
				</h1>
			</div>
			<div class="panel-body">
				<div class="row">
					<c:forEach items="${list}" var="dto">
						<div class="col-md-3 col-xs-6">
							<div class="thumbnail">
								<h5>닉네임  : ${dto.nickname}</h5>
								<a href="read.do?num=${dto.num}"> <c:if
										test="${not empty dto.attList }">
										<img style="width: 100%; height: 200px;"
											src="${dto.attList[0].attPath}">
										<hr>
									</c:if>
									<h4 align="center">${dto.title}</h4> <br>
								</a>

								

								<svg class="bi bi-blockquote-left" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M2 3.5a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm5 3a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 3a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zm-5 3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5z"/>
  <path d="M3.734 6.352a6.586 6.586 0 0 0-.445.275 1.94 1.94 0 0 0-.346.299 1.38 1.38 0 0 0-.252.369c-.058.129-.1.295-.123.498h.282c.242 0 .431.06.568.182.14.117.21.29.21.521a.697.697 0 0 1-.187.463c-.12.14-.289.21-.503.21-.336 0-.577-.108-.721-.327C2.072 8.619 2 8.328 2 7.969c0-.254.055-.485.164-.692.11-.21.242-.398.398-.562.16-.168.33-.31.51-.428.18-.117.33-.213.451-.287l.211.352zm2.168 0a6.588 6.588 0 0 0-.445.275 1.94 1.94 0 0 0-.346.299c-.113.12-.199.246-.257.375a1.75 1.75 0 0 0-.118.492h.282c.242 0 .431.06.568.182.14.117.21.29.21.521a.697.697 0 0 1-.187.463c-.12.14-.289.21-.504.21-.335 0-.576-.108-.72-.327-.145-.223-.217-.514-.217-.873 0-.254.055-.485.164-.692.11-.21.242-.398.398-.562.16-.168.33-.31.51-.428.18-.117.33-.213.451-.287l.211.352z"/>
</svg> 댓글 :  ${dto.replycnt } <p>작성일 : ${dto.writeday}</p> <svg class="bi bi-hand-thumbs-up" width="1em" height="1em"
									viewBox="0 0 16 16" fill="currentColor"
									xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd"
										d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16v-1c.563 0 .901-.272 1.066-.56a.865.865 0 0 0 .121-.416c0-.12-.035-.165-.04-.17l-.354-.354.353-.354c.202-.201.407-.511.505-.804.104-.312.043-.441-.005-.488l-.353-.354.353-.354c.043-.042.105-.14.154-.315.048-.167.075-.37.075-.581 0-.211-.027-.414-.075-.581-.05-.174-.111-.273-.154-.315L12.793 9l.353-.354c.353-.352.373-.713.267-1.02-.122-.35-.396-.593-.571-.652-.653-.217-1.447-.224-2.11-.164a8.907 8.907 0 0 0-1.094.171l-.014.003-.003.001a.5.5 0 0 1-.595-.643 8.34 8.34 0 0 0 .145-4.726c-.03-.111-.128-.215-.288-.255l-.262-.065c-.306-.077-.642.156-.667.518-.075 1.082-.239 2.15-.482 2.85-.174.502-.603 1.268-1.238 1.977-.637.712-1.519 1.41-2.614 1.708-.394.108-.62.396-.62.65v4.002c0 .26.22.515.553.55 1.293.137 1.936.53 2.491.868l.04.025c.27.164.495.296.776.393.277.095.63.163 1.14.163h3.5v1H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z" />
</svg> 좋아요 : ${dto.likes}

							</div>
						</div>
					</c:forEach>



				</div>
			</div>

			<div class="panel-body">
				<nav aria-label="Page navigation" class="text-center">
					<ul class="pagination">
						<li><a
							href="hotsalelist.do?curPage=${(to.curPage-1)>0?(to.curPage-1):1}"
							aria-label="Previous"> <span aria-hidden="true"
								class="glyphicon glyphicon-chevron-left"></span>
						</a></li>
						<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}"
							var="idx">
							<c:if test="${to.curPage==idx}">
								<li class="active"><a href="hotsalelist.do?curPage=${idx}">${idx}</a>
								</li>
							</c:if>
							<c:if test="${to.curPage!=idx}">
								<li><a href="hotsalelist.do?curPage=${idx}">${idx}</a></li>
							</c:if>
						</c:forEach>
						<li><a
							href="hotsalelist.do?curPage=${(to.curPage+1)<to.totalPage ?(to.curPage+1):to.totalPage}"
							aria-label="Next"> <span aria-hidden="true"
								class="glyphicon glyphicon-chevron-right"></span>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>


	<%--
	형단님이 작성하신거

	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<li class="page-item "><a class="page-link"
				href="hotsalelist.do?curPage=${(to.curPage-1)>0?(to.curPage-1):1}"
				tabindex="-1" aria-disabled="true">이전페이지</a></li>
			<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}" var="idx">
				<c:if test="${to.curPage==idx}">
					<li class="page-item"><a class="page-link"
						href="hotsalelist.do?curPage=${idx}" style="color:#00008B; background-color:lightblue;">${idx}</a></li>
				</c:if>
				<c:if test="${to.curPage!=idx}">
					<li class="page-item"><a class="page-link"
						href="hotsalelist.do?curPage=${idx}">${idx}</a></li>
				</c:if>
			</c:forEach>
			
					
			
			<li class="page-item"><a class="page-link"
				href="hotsalelist.do?curPage=${(to.curPage+1)<to.totalPage ?(to.curPage+1):to.totalPage}">다음페이지</a>
			</li>
		</ul>
	</nav>

 --%>

	<footer style="background-color: #000000; color: #ffffff">
		<div class="container-fluid">
			<br>
			<div class="row">
				<div class="col-sm-2" style="text-align: center;">
					<h5>Copyright &copy; 2020</h5>
					<h5>박성혁 이상협</h5>
					<h5>최형단 신혜원</h5>
					<h5>박민철 윤소휘</h5>
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
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
<style type="text/css">

.listColor {
	color: #ffffff; /* 흰색 */
	text-decoration: none;
}

.page1 { /* 페이징 고정 */
   width: 1108px;
   position: absolute;
   bottom: 0;
   height: 350px;
}
.footer {
   width:100%;
   position:absolute;
   bottom:0;
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
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-heading listColor"><span class="glyphicon glyphicon-pushpin"></span>
					&nbsp;공지사항
					<span class="pull-right">
						<c:if test="${login.id eq 'admin' }">
							<button onclick="location.href='insertNoticeui.do'" class="btn btn-success btn-lg">글쓰기</button>		
						</c:if>
						<c:if test="${login.id ne 'admin' }">
							<button onclick="clickbutton();" class="btn btn-success btn-lg">글쓰기</button>
							</c:if>
					</span>
				</h1>
			</div>
			<div class="panel-body" style="height: 550px;">
				<table class="table">
					<thead>
						<tr>
							<th>글번호</th>
							<th>닉네임</th>
							<th>제목</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="dto">
							<tr>	
								<td>${dto.num}</td>
								<td>${dto.nickname}</td>
								<td><a href="readNotice.do?num=${dto.num }">${dto.title}</a></td>
								<td>${dto.writeday}</td>
								<td>${dto.readcnt}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<nav aria-label="Page navigation" class="text-center page1">
  					<ul class="pagination">
  						<li>
      						<a href="listNotice.do?curPage=${(to.curPage-1)>0?(to.curPage-1):1}" aria-label="Previous">
        						<span aria-hidden="true" class="glyphicon glyphicon-chevron-left"></span>
     						 </a>
    					</li>
						<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}" var="idx">
							<c:if test="${to.curPage==idx}">
								<li class="active">
									<a href="listNotice.do?curPage=${idx}">${idx}</a>
								</li>
							</c:if>
							<c:if test="${to.curPage!=idx}">
								<li>
									<a href="listNotice.do?curPage=${idx}">${idx}</a>
								</li>
							</c:if>
						</c:forEach>
    					<li>
      						<a href="listNotice.do?curPage=${(to.curPage+1)<to.totalPage ?(to.curPage+1):to.totalPage}" aria-label="Next">
        						<span aria-hidden="true" class="glyphicon glyphicon-chevron-right"></span>
      						</a>
    					</li>
					</ul>
				</nav>
			</div>
		</div>
	</div>



<%-- 
	<a href="listNotice.do?curPage=${(to.curPage-1) > 0 ? (to.curPage-1) : 1 }">&laquo;</a>
	&nbsp;&nbsp;
	<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}" var="idx">

		<c:if test="${to.curPage == idx}">
			<!-- 현재페이지 글자 크게 -->
			<a style="font-size: 30px;" href="listNotice.do?curPage=${idx}">${idx}</a>&nbsp;&nbsp;
		</c:if>

		<c:if test="${to.curPage != idx }">
			<a href="listNotice.do?curPage=${idx}">${idx}</a>&nbsp;&nbsp;
		</c:if>

	</c:forEach>
	&nbsp;&nbsp;
	<a
		href="list.doNotice?curPage=${(to.curPage+1)< to.totalPage ? (to.curPage+1): to.totalPage }">&raquo;</a>
--%>









	<footer style="background-color: #000000; color: #ffffff" class="footer">
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

	<script type="text/javascript">
		function clickbutton() {
			alert("관리자만 작성할 수 있습니다.");
		};
	</script>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
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
footer {
	margin-top: 425px;
}
.form-control {
	width: 400px;
	display: inline-block;
}
.btn-size1 {
	width: 400px;
}
</style>
<c:if test="${empty login }">
<script>alert('로그인이 필요한 화면입니다. 로그인 페이지로 이동합니다.'); location.href='/ProjectBoard/loginui.do'; </script>
</c:if>

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





	<c:if test="${param.update == null}">
	<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading text-center">
				<h1 class="panel-heading">회원 정보 수정</h1>
			</div>
			<div class="panel-body">
				<form action="updateMember.do" method="post" class="text-center">
					<input type="hidden" name="id" value="${login.id}" readonly>
					<h3>패스워드를 입력하세요.</h3>
					<input name="pw" type="password"><br>
					<input type="submit" value="확인" class="btn btn-primary" style="margin: 10px">
				</form>
			</div>
		</div>
	</div>
	
	</c:if>
	<c:if test="${param.nopw == 1}">
		<script>
		alert("비밀번호가 틀립니다.");
		</script>
	</c:if>
	
	<c:if test="${param.update == 0}">
	<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading text-center">
				<h1 class="panel-heading">회원 정보 수정</h1>
			</div>
			<div class="panel-body text-center">
				<form action="updateMember2.do" method="post">
					<input type="hidden" name="id" value="${login.id}">
					<div class="form-group">
						<input name="pw" type="password" type="text" placeholder="변경할 비밀번호" class="form-control" required>
					</div>
					<div class="form-group">
						<input name="name" type="text" placeholder="이름" class="form-control" required>				
					</div>
					<div class="form-group">
						<input name="nickname" type="text" placeholder="닉네임" class="form-control" required>
					</div>
					<div class="form-group">
						<input name="contact" type="text" placeholder="전화번호 ex)01012341234" class="form-control" required>					
					</div>
					<div class="form-group">
						  <select name="location" class="form-control" id="location" style="height: 3.5em;">
									<option value="서울">서울
									<option value="인천">인천
									<option value="경기도">경기도
									<option value="충청도">충청도
									<option value="강원도">강원도
									<option value="경상도">경상도
									<option value="전라도">전라도
									<option value="제주도">제주도
							</select>
					</div>
					<div class="form-group">
						<input name="birthdate" type="text"  placeholder="생년월일 ex>19960523" class="form-control" required><br>					
					</div>
					<div class="form-group">
                  		<select name="gender" class="form-control" id="gender" style="height: 3.5em;">
							<option value="남자">남자
							<option value="여자">여자
						</select>
					</div>
					<input type="submit" value="수정" class="btn btn-primary btn-lg btn-size1" style="margin: 10px">
				</form>
			</div>
		</div>
	</div>
	</c:if>
	
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


	<script>
    function numberMaxLength(e){
        if(e.value.length > e.maxLength){
            e.value = e.value.slice(0, e.maxLength);
        }
    }
</script>
</body>
</html>
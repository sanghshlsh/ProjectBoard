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
<title>회원가입 페이지 당근마켓</title>
<style>
footer {
  margin-top: 300px;
}
  .panel-login {
	border-color: #ccc;
	-webkit-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	-moz-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	margin-top: 100px;
}
.panel-login>.panel-heading {
	color: #00415d;
	background-color: #fff;
	border-color: #fff;
	text-align:center;
}
.panel-login>.panel-heading a{
	text-decoration: none;
	color: #666;
	font-weight: bold;
	font-size: 15px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login>.panel-heading a.active{
	color: #029f5b;
	font-size: 18px;
}
.panel-login>.panel-heading hr{
	margin-top: 10px;
	margin-bottom: 0px;
	clear: both;
	border: 0;
	height: 1px;
	background-image: -webkit-linear-gradient(left,rgba(0, 0, 0, 0),rgba(0, 0, 0, 0.15),rgba(0, 0, 0, 0));
	background-image: -moz-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -ms-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -o-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
}
.panel-login input[type="text"],.panel-login input[type="email"],.panel-login input[type="password"] {
	height: 45px;
	border: 1px solid #ddd;
	font-size: 16px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login input:hover,
.panel-login input:focus {
	outline:none;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
	border-color: #ccc;
}
.btn-login {
	background-color: #59B2E0;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #59B2E6;
}
.btn-login:hover,
.btn-login:focus {
	color: #fff;
	background-color: #53A3CD;
	border-color: #53A3CD;
}
.forgot-password {
	text-decoration: underline;
	color: #888;
}
.forgot-password:hover,
.forgot-password:focus {
	text-decoration: underline;
	color: #666;
}

.btn-register {
	background-color: #1CB94E;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #1CB94A;
}
.btn-register:hover,
.btn-register:focus {
	color: #fff;
	background-color: #1CA347;
	border-color: #1CA347;
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
							<li><a href="####">인기 매물 게시판</a></li>
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
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-6">
								<a href="#" id="login-form-link">로그인</a>
							</div>
							<div class="col-xs-6">
								<a href="#" class="active" id="register-form-link">회원가입</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="login-form" action="login.do" method="post" role="form" style="display: none;">
									<div class="form-group">
										<input type="text" name="id1" id="id1" tabindex="1" class="form-control" placeholder="아이디" value="" required>
									</div>
									<div class="form-group">
										<input type="password" name="pw1" id="pw1" tabindex="2" class="form-control" placeholder="비밀번호" required>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="로그인">
											</div>
										</div>
									</div>
					
								</form>
								<form id="register-form" action="insertMember.do" method="post" role="form" style="display: block;">
									<div class="form-group">
										<input type="text" name="id2" id="id2" tabindex="1" class="form-control" placeholder="아이디" value="" required>
									</div>
									<div class="form-group">
										<button  class="form-control btn btn-register idbutton">아이디 중복 체크</button>
									</div>
									<div class="form-group">
										<input type="password" name="pw2" id="pw2" tabindex="2" class="form-control" placeholder="비밀번호" required>
									</div>
									<div class="form-group">
										<input type="password" name="pw3" id="pw3" tabindex="2" class="form-control" placeholder="비밀번호 확인" required>
									</div>
									<div class="form-group">
										<input type="text" name="name" id="name" tabindex="2" class="form-control" placeholder="이름" required>
									</div>
									<div class="form-group">
										<input type="text" name="nickname" id="nickname" tabindex="2" class="form-control" placeholder="닉네임" required>
									</div>
									<div class="form-group">
										<input type="text" name="contact" id="contact" tabindex="2" class="form-control" placeholder="전화번호" required>
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
										<input type="text" name="birthdate" id="birthdate" tabindex="2" class="form-control" placeholder="생년월일" required>
									</div>
									<div class="form-group">
                  					<select name="gender" class="form-control" id="gender" style="height: 3.5em;">
									<option value="남자">남자
									<option value="여자">여자
									</select>
								</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="가입하기">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	
	
	
	
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

		<c:if test="${param.isID == 0}">
		<script>
		alert("아이디 또는 비밀번호를 확인해주세요.");
		</script>
	</c:if>
	
		<c:if test="${param.noid == 0}">
		<script>
		alert("아이디 중복 체크를 해주세요.");
		</script>
	</c:if>
		<c:if test="${param.noid == 1}">
		<script>
		alert("비밀번호가 일치하지 않습니다.");
		</script>
	</c:if>
	
	
	<script type="text/javascript">
	$(function() {

	    $('#login-form-link').click(function(e) {
			$("#login-form").delay(100).fadeIn(100);
	 		$("#register-form").fadeOut(100);
			$('#register-form-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault();
		});
		$('#register-form-link').click(function(e) {
			$("#register-form").delay(100).fadeIn(100);
	 		$("#login-form").fadeOut(100);
			$('#login-form-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault();
		});

	});
	
	
	</script>
	
		<script type="text/javascript">
		$(document).ready(function() {
			$(".idbutton").click(function(event) {
				event.preventDefault();
				
				var id = $("#id2").val();
				
				$.ajax({
					type : "get",
					url : "idcheck",
					data : {
						id : id
					},
					dataType : "text",
					success : function(result) {
						alert(result);
				
					}
				});
			});
		});
	</script>
</body>
</html>
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
<!-- insert,update link 순서중요  -->
<link  rel="stylesheet" href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"  >


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/codingBooster.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

	


<title>당근마켓</title>
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
				<h3 class="panel-heading">
					<span class="glyphicon glyphicon-option-vertical"></span> &nbsp;글수정
				</h3>
			</div>
		</div>
	</div>



	<<div class="container contact">
		<div class="row">
			<div class="col-md-3">
				<div class="contact-info">

					<img
						src="https://cdn.shopify.com/s/files/1/0089/7895/6347/t/9/assets/img_index_cover_logo.png?v=1399351759041780807"
						alt="image" />
					

				</div>
			</div>
			<form action="update.do" method="post" enctype="multipart/form-data" >
				<input type="hidden" value="${dto.num }" name="num">
				<div class="col-md-9">
					<div class="contact-form">
						<div class="form-group">
							<label class="control-label col-sm-2" for="title">글제목</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="title"
									placeholder="Enter title" name="title" value="${dto.title }">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" for="Money">금액</label>
							<div class="col-sm-10">
								<input type="number" class="form-control" id="Money"
									placeholder="Enter Money" name="Money" value="${dto.money }">
							</div>
						</div>
					
						<div class="form-group">
							<label class="control-label col-sm-2" for="category">카테고리</label>
							<div class="col-sm-10">
								<select name="category" >
									<c:forEach items="${calist }" var="cadto">
										<option value="${cadto.val }"
											<c:if test="${cadto.val eq dto.category }">selected</c:if>>${cadto.option }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group" >
							<label class="control-label col-sm-2" for="location" >지역</label>
							<div class="col-sm-10">
								<select name="location"  >
									<c:forEach items="${lolist }" var="lodto">
										<option value="${lodto.val }"
											<c:if test="${lodto.val eq dto.location }">selected</c:if>>${lodto.option }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" for="comment">Content:</label>
							<div class="col-sm-10">
								<textarea class="form-control" rows="5"name="content">${dto.content }</textarea>
							</div>
						</div>
						<br>
						
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

						<c:if test="${empty alist[1]}">
							<input type="file" name="file2">
						</c:if>
						<c:if test="${not empty alist[1]}">
							<input type="file" class="file" id="file2" name="file2"
								onchange="changeValue(this)" />
							<button type="button" id="btn2">
								<img src="${alist[1].attPath }" width="50px" height="50px">
							</button>
							<input type="hidden" value="${alist[1].attNum }" name="orgFile2">
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
							<input type="hidden" value="${alist[2].attNum }" name="orgFile3">
						</c:if><br>
						<input type="hidden" name="id" class="btn btn-primary pull-right"
							value="${login.id }">
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<input type="submit" value="send" class="btn btn-danger"> <input type="hidden"
									name="id" value="${login.id }" class="btn btn-danger">

								<button onclick="location.href='list.do'" class="btn btn-danger">List</button>

							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>



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

	<c:if test="${param.success == 1}">
		<script>
			alert("회원 가입 성공!");
		</script>
	</c:if>

</body>
</html>

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
<title>중고거래 물품</title>
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
							<li><a href="####">인기 매물 게시판</a></li>
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
					<span class="glyphicon glyphicon-sunglasses"></span> &nbsp;글자세히보기
				</h3>
			</div>
		</div>
	</div>




	<!-- insert -->
	<div class="container " align="center">
		<div class="row">
			<div class="col-md-12"></div>
		</div>
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="panel panel-warning">
					<div class="panel-heading">
						<h3 class="panel-title">
							Not All Systems Operational <small class="pull-right">Refreshed
								39 minutes ago</small>
						</h3>
					</div>
				</div>


				<div class="row clearfix center">
					<div class="col-md-12 column">
						<div class="list-group">

							<div class="list-group-item">
								<h4 class="list-group-item-heading">글번호:${dto.num}</h4>

							</div>

							<div class="list-group-item">
								<h4 class="list-group-item-heading">카테고리:${dto.category}</h4>

							</div>

							<div class="list-group-item">
								<h4 class="list-group-item-heading">조회:${dto.readcnt}</h4>

							</div>
							<div class="list-group-item">
								<h4 class="list-group-item-heading">
									닉네임 :<a href="listmemberboard.do?id=${dto.id }">${dto.nickname }</a>

								</h4>

							</div>
							<div class="list-group-item">
								<h4 class="list-group-item-heading">
									아이디:<a href="listmemberboard.do?id=${dto.id }">${dto.id}</a>

								</h4>

							</div>
							<div class="list-group-item">
								<h4 class="list-group-item-heading">제목:${dto.title }</h4>

							</div>
							<div class="list-group-item">
								<h4 class="list-group-item-heading">금액:${dto.money }</h4>

							</div>
							<div class="list-group-item">
								<h4 class="list-group-item-heading">지역:${dto.location}</h4>

							</div>
							<div class="list-group-item">
								<h4 class="list-group-item-heading">
									<c:if test="${check eq 0}">
										<span class="glyphicon glyphicon-heart-empty"></span>
									</c:if>
									<c:if test="${check eq 1}">
										<a href="like.do?num=${dto.num }"><span
											class="glyphicon glyphicon-heart-empty"></span></a>
									</c:if>
									<c:if test="${check eq 2}">
										<a href="deletelike.do?num=${dto.num }"><span
											class="glyphicon glyphicon-heart"></span></a>
									</c:if>
									${dto.likes}

								</h4>

							</div>
							<div class="list-group-item">
								<h4 class="list-group-item-heading">
									내용:${dto.content} <br>
									<c:forEach items="${alist}" var="adto">
										<img width="250px" height="250px" src="${adto.attPath}">
										<br>
									</c:forEach>

								</h4>

								<!-- reply -->

								<div align="right">
									<c:if test="${dto.id eq login.id }">
										<div class="btn btn-primary">
											<a href="updateui.do?num=${dto.num}">수정</a>
										</div>
										<div class="btn btn-danger">
											<a href="deleteui.do?num=${dto.num}&id=${dto.id}">삭제</a>
										</div>
									</c:if>
									<div class="btn btn-warning">
										<a href="list.do">목록</a>
									</div>
								</div>
							</div>


							<table>
								<thead>
									<tr>
										<th colspan="10">-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</th>

									</tr>
								</thead>

								<tbody>
									<c:forEach items="${rlist}" var="rdto">
										<tr>
											<td><a href="listmemberboard.do?id=${rdto.id}">${rdto.nickname}
											</a></td>
											<td width="250px"><c:forEach begin="1"
													end="${rdto.repIndent}">
   &nbsp;&nbsp; <span class="glyphicon glyphicon-share-alt"></span>



												</c:forEach> ${rdto.content}</td>
											<td><c:if test="${not empty login }">
													<button onclick="reply${rdto.repNum}()">댓글</button>
													<script>
			function reply${rdto.repNum}() {
			  document.getElementById("reply").innerHTML = 
				  "<div class='row'>"+
				  "<div class='ui-group-buttons'>"+
				  "<div class='panel panel-default widget'>"+
				  "<div class='panel-heading'>"
					+"<span class='glyphicon glyphicon-comment'></span>"
					+"<h3 class='panel-title'>대댓글</h3>"+
				  "<form action='rereply.do' method='post'>"+
				  "<textarea name='content' class='form-control' rows='3' placeholder='Write in your wall'></textarea>"+
				"<input type='submit' value='댓글입력'>"+
				  "<input type='hidden' value='${login.id}' name='id'>"+
				  "<input type='hidden' value='${rdto.repNum}' name='repNum'>"+
				  "<input type='hidden' name='num' value='${rdto.num}'></form></div></div></div></div>";
			}
</script>
												</c:if></td>
											<td><c:if test="${login.id eq rdto.id }">
													<button onclick="reUpdate${rdto.repNum}()">수정</button>
													<script>
			function reUpdate${rdto.repNum}() {
  				document.getElementById("reply").innerHTML = 
  				  "<div class='row'>"+
				  "<div class='ui-group-buttons'>"+
				  "<div class='panel panel-default widget'>"+
				  "<div class='panel-heading'>"
					+"<span class='glyphicon glyphicon-comment'></span>"
					+"<h3 class='panel-title'>수정</h3>"+
				  "<form action='reupdate.do' method='post'>"
  				+"<textarea name='content' class='form-control' rows='3'>${rdto.content}</textarea>"
  				+"<input type='submit' value='수정'><input type='hidden' value='${rdto.repNum}' name='repNum'>"
  				+"<input type='hidden' name='num' value='${rdto.num}'></form></div></div></div></div>";
			}
</script>
												</c:if></td>
											<td><c:if test="${login.id eq rdto.id }">
													<button
														onclick="location.href='redelete.do?repNum=${rdto.repNum}&num=${rdto.num}'">삭제</button>
												</c:if></td>

										</tr>
									</c:forEach>

								</tbody>
							</table>

							<div class="container" id="reply"></div>

							<div class="container">
								<div class="row">
									<div class="ui-group-buttons">
										<div class="panel panel-default widget">
											<div class="panel-heading">
												<span class="glyphicon glyphicon-comment"></span>
												<h3 class="panel-title">Reply</h3>

												<form action="replyinsert.do" method="post">
													<input type="hidden" name="num" readonly
														value="${dto.num }"><br>
													<div class="panel-body"></div>
													<input type="hidden" name="id" value="${login.id }">

													<c:if test="${not empty login }">
														<fieldset>
															<div class="form-group">
																<textarea class="form-control" rows="3"
																	placeholder="Write in your wall" name="content"></textarea>

																<br> <br> <input type="submit" value="댓글달기"
																	class="btn btn-danger" role="button"
																	data-loading-text="Loading...">
															</div>

														</fieldset>

													</c:if>
												</form>
											</div>
										</div>

									</div>

								</div>
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
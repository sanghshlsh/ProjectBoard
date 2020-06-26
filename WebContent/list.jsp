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
				<a class="navbar-brand" href="mainPage.do">당근마켓</a>
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
			<div class="panel-heading" style="color: black;">
				<h3 class="panel-heading" style="color: white;">
					<span class="glyphicon glyphicon-th-list"></span> &nbsp;중고거래 리스트
				</h3>
<table>
					<tbody>
						<tr>
							<td colspan="7"><p align="center">
									<a href="list.do"><button class="btn btn-success"><span class="glyphicon glyphicon-align-justify"></span>전체목록</button></a></td>
							<td colspan="7"><p align="center">
									<a href="listNotice.do"><button class="btn btn-success"><span class="glyphicon glyphicon-ok"></span>공지게시판</button></a></td>
						</tr>
					</tbody>
				</table>




				<c:if test="${login.id eq 'admin' }">
					<a href="deletelist.do">삭제된 글 모음</a>
				</c:if>

				<%-- <게시판>--%>




				<script type="text/javascript">
					function clickbutton() {
						alert("로그인이 필요한 서비스입니다.");
						location.href = '/ProjectBoard/loginui.do';
					};
				</script>
				<select name="location" onchange="window.open(value,'_self');">
					<option value="/ProjectBoard/list.do?category=${param.category}">지역</option>
					<c:forEach items="${lolist }" var="lodto">
						<option
							value="/ProjectBoard/list.do?location=${lodto.val }&category=${param.category}"
							<c:if test="${lodto.val eq param.location }" >selected </c:if>>${lodto.option }</option>
					</c:forEach>
				</select> <select name="category" onchange="window.open(value,'_self');">
					<option value="/ProjectBoard/list.do?location=${param.location}">카테고리</option>
					<c:forEach items="${calist }" var="cadto">
						<option
							value="/ProjectBoard/list.do?category=${cadto.val }&location=${param.location}"
							<c:if test="${cadto.val eq param.category }" >selected </c:if>>${cadto.option }</option>
					</c:forEach>
				</select> <br>

				<form action="search.do" name="search" method="get">
					<select name="keyField">
						<option value="id">닉네임</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="location">지역</option>
						<option value="title_content">제목+내용</option>
						<option value="title_location">제목+지역</option>
					</select> 
					
			<input type="text" name="keyWord" class="col-sm-3"placeholder="Search"/> 
					<input type="submit" value="Search" class="btn btn-danger">
					<input type="hidden" value="1"name="visible"> 
					<input type="reset" value="clear" class="btn btn-danger">


				</form>


				
				<div align="right">
					<button class="btn btn-success"
						<c:if test="${not empty login }">
		onclick="location.href='insertui.do'" 
		</c:if>
						<c:if test="${empty login }">
		onclick="clickbutton();"
		</c:if>>
						<span class="glyphicon glyphicon-pencil"></span>글쓰기</button>
				</div>



			</div>

		</div>
	</div>

	<div class="container">
		<form action="invisible.do">
			<table class="table">
				<thead>
					<tr>
						<c:if test="${login.id eq 'admin' }">
							<th>선택</th>
						</c:if>
						<th class="col-xs-1">글번호</th>
						<th class="col-xs-1">지역</th>
						<th class="col-xs-1">카테고리</th>
						<th class="col-xs-1">닉네임</th>
						<th class="col-xs-4 ">제목</th>
						<th class="col-xs-1">작성일</th>
						<th class="col-xs-1">조회수</th>
						<th class="col-xs-1">찜한 인원</th>

					</tr>
				</thead>

				<tbody>
					<c:forEach items="${nolist }" var="dto">
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
                      
                      
                      
					<c:forEach items="${list}" var="dto" >
						<tr>
							<c:if test="${login.id eq 'admin' }">
								<td><input type="checkbox" name="num" value="${dto.num }"></td>
							</c:if>
							<td width="20px">${dto.num}</td>
							<td>${dto.location }</td>
							<td>${dto.category }</td>
							<td width="100px"><a href="listmemberboard.do?id=${dto.id}">${dto.nickname}</a></td>

							<td width="200px"><a href="read.do?num=${dto.num }"><c:if
										test="${not empty dto.attList }">
										<img width="50px" height="50px"
											src="${dto.attList[0].attPath}">
									</c:if> ${dto.title}</a></td>
							<td width="100px">${dto.writeday}</td>
							<td width="20px">${dto.readcnt}</td>
							<td width="20px">${dto.likes}</td>

						</tr>
					</c:forEach>


				</tbody>

			</table>
			<%-- 이미지경로
<img src="http://localhost:8089/ProjectBoard/upload/2020-06-16/copy_test5.jpg">
 --%>

			<c:if test="${login.id eq 'admin' }">
				<input type="submit" value="삭제">
			</c:if>
		</form>




	</div>

<div class="panel-body">
				<nav aria-label="Page navigation" class="text-center">
  					<ul class="pagination">
  						<li>
      						<a href="list.do?curPage=${(to.curPage-1)>0?(to.curPage-1):1}" aria-label="Previous">
        						<span aria-hidden="true" class="glyphicon glyphicon-chevron-left"></span>
     						 </a>
    					</li>
						<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}" var="idx">
							<c:if test="${to.curPage==idx}">
								<li class="active">
									<a href="list.do?location=${param.location }&category=${param.category }&curPage=${idx}">${idx}</a>
								</li>
							</c:if>
							<c:if test="${to.curPage!=idx}">
								<li>
									<a href="list.do?location=${param.location }&category=${param.category }&curPage=${idx}">${idx}</a>
								</li>
							</c:if>
						</c:forEach>
    					<li>
      						<a href="list.do?curPage=${(to.curPage+1)<to.totalPage ?(to.curPage+1):to.totalPage}" aria-label="Next">
        						<span aria-hidden="true" class="glyphicon glyphicon-chevron-right"></span>
      						</a>
    					</li>
					</ul>
				</nav>
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
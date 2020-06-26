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
</head>
<body>





	<div class="container">
		<div class="row">
			<div class="ui-group-buttons">
				<div class="panel panel-default widget">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-comment"></span>
						<h3 class="panel-title">Reply</h3>

						<form action="rereply.do" method="post">
							<input type="hidden" name="num" value="${param.num}"><br>
							<input type="hidden" name="repNum" value="${param.repNum}"><br>
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









</body>
</html>
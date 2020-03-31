<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
</jsp:include>
<!-- 게시판 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/board.css">
<style>
.clickable:hover {color:red;}
.clickable, .rclick {cursor:pointer;}
.thumbs {display: inline-block; height:30px; margin: 2px; padding: 0px; padding-top: 6px; border-radius: 10px; text-align: center;}
#reply .inline{display: inline-block; padding:0 10px;}
.recom {color:green; border:1px solid green;}
.decom {color:blue; border:1px solid blue;}
</style>

<!-- body begin-->
<div class="site-section" style="padding:0px;">
	<div class="container" style="margin-top:0px; max-width: 1440px;">
		<div class="row">
			<div class="col-lg-2" style="padding-left:0px;">
				<!--커뮤니티 서브메뉴-->
				<ul class="menu" style="margin-top : 150px;">
					<c:forEach items="${boardList}" var="board">
						<li class="list"><a href="${pageContext.request.contextPath}/board/postList?boardCode=${board.boardCode}">${board.boardName}</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="col-lg-10">
				<!-- contents begin-->
				<div class="site-section" style="padding-top: 10px;">
					<div class="container" style="padding: 0px;">
						<div class="row">
							<div class="col-md-6">
								<span style="font-size: x-large">${post.title }</span>
								<form action="" id="postForm" method="POST">
									<input type="hidden" name="boardCode" value="${post.boardCode}"/>
									<input type="hidden" name="postNo" value="${post.postNo}" />
									<input type="hidden" name="writer" value="${memberLoggedIn.memberId}" />
									<input type="hidden" id="delRpl" name="replyNo"/>
								</form>
							</div>
						</div>
						<table id="content" style="width: 100%;">
							<tr>
								<td style="width: 85%; text-align: left;">글 작성자 : ${post.writer }</td>
								<td style="width:60px;"><i title="댓글수" class="far fa-comment-dots"></i> ${replyCount}</td>
								<td style="width:60px;"><i title="선호수" class="fas fa-heart"></i> ${prefCount}</td>
								<td style="width:60px;"><i title="조회수" class="far fa-eye"></i> ${post.readCount}</td>
							</tr>
							<tr>
								<td colspan="4" style="text-align: left; height: 300px;">${post.content }</td>
							</tr>
							<tr>
								<td colspan="4">
									<div class="col-md-1 thumbs clickable recom" onclick="recom('0');"><i class="far fa-thumbs-up"></i>추천 ${post.recommenCount }</div>
									<div class="col-md-1 thumbs clickable decom" onclick="decom('0');"><i class="far fa-thumbs-down"></i>비추천 ${post.decommenCount }</div>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: left;">
									<i title="목록으로" class="fas fa-clipboard-list clickable" onclick="location.href='${pageContext.request.contextPath}/board/postList?boardCode=${post.boardCode }'"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<i title="신고하기" class="fas fa-exclamation-triangle clickable"></i>
								</td>
								<c:if test="${memberLoggedIn.memberId == post.writer}">
								<td><i title="수정하기" class="far fa-edit clickable"></i></td>
								<td><i title="삭제하기" class="fas fa-eraser clickable" onclick="deletePost();"></i></td>
								</c:if>
								<c:if test="${memberLoggedIn.memberId != post.writer }"><td/><td/></c:if>
							</tr>
						</table>
						<br />
						<br />
						<table id="reply" style="width: 100%; text-align: left;">
						<c:if test="${empty replyList}">
							<tr><td>작성된 댓글이 없습니다. 첫 댓글을 작성해주세요!</td></tr>
						</c:if>
						<c:if test="${not empty replyList}">
							<c:forEach items="${replyList}" var="reply">
							<tr>
								<td>
									<div class="inline" style="font-size:12px;">${reply.replyWriter} / ${reply.replyWriteTime}</div>
									<div class="inline">
									<c:if test="${memberLoggedIn.memberId == reply.replyWriter}">
										<i class="far fa-thumbs-up"> ${reply.recommenCount}</i>&nbsp;&nbsp;
										<i class="far fa-thumbs-down"> ${reply.decommenCount}</i>&nbsp;&nbsp;
										<i title="신고" class="fas fa-exclamation-triangle"></i>
									</c:if>
									<c:if test="${memberLoggedIn.memberId != reply.replyWriter }">
										<i class="far fa-thumbs-up rclick" onclick="recom('${reply.replyNo}');"> ${reply.recommenCount}</i>&nbsp;&nbsp;
										<i class="far fa-thumbs-down rclick" onclick="decom('${reply.replyNo}');"> ${reply.decommenCount}</i>&nbsp;&nbsp;
										<i title="신고" class="fas fa-exclamation-triangle rclick"></i>
									</c:if>
									</div>
									<c:if test="${memberLoggedIn.memberId == reply.replyWriter}">
										<div class="inline"><i title="수정" class="far fa-edit rclick"></i> <i title="삭제" class="fas fa-eraser rclick" onclick="deleteReply(${reply.replyNo})"></i></div>
									</c:if>
									<br />
									<div style="font-size:18px;"><strong>${reply.replyContent}</strong></div>
								</td>
							</tr>
							</c:forEach>
						</c:if>
							<tr>
								<td>
									<input type="text" id="ReplyWrite" placeholder="댓글을 입력하세요." style="width: 90%;" />&nbsp;
									<button onclick="writeReply();">댓글 작성</button>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- contents end-->
			</div>
		</div>
	</div>
</div>
<!-- body end-->
<c:if test="${empty memberLoggedIn }">
<script>
function writeReply() {
	alert("로그인 이후에 사용 가능한 기능입니다.");
}
</script>
</c:if>

<c:if test="${not empty memberLoggedIn}">
<script>
function writeReply() {
	
	if(!confirm("댓글을 작성하시겠습니까?")) {
		return;
	}
	
	let reply = {
			boardCode : "${post.boardCode}",
			postNo : "${post.postNo}",
			replyWriter : "${memberLoggedIn.memberId}",
			replyContent : $("#ReplyWrite").val()
	}
	$.ajax({
			url: "${pageContext.request.contextPath}/board/replyWrite.ajax",
			data: reply,
			type: "POST",
			success: function(data) {
				if(data>0)
					location.reload();
				else alert("댓글 작성에 실패했습니다.");
			},
			error : function(x,s,e) {
				alert("댓글 작성에 실패했습니다.");
				console.log(x,s,e);
			}
	});
}
function recom(replyNo) {
	if(!confirm("추천하시겠습니까?")) {
		return;
	}
	let recom = {
			memberId : "${memberLoggedIn.memberId}",
			boardCode : "${post.boardCode}",
			postNo : "${post.postNo}",
			replyNo : replyNo
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/board/recom.ajax",
		data: recom,
		type: "POST",
		success: function(data) {
			if(data>0)
				location.reload();
			else alert("이미 추천/비추천한 상태입니다.");
		},
		error: function(x,s,e) {
			console.log(x,s,e);
		}
	});
}
function decom(replyNo) {
	if(!confirm("비추천하시겠습니까?")) {
		return;
	}
	let decom = {
			memberId : "${memberLoggedIn.memberId}",
			boardCode : "${post.boardCode}",
			postNo : "${post.postNo}",
			replyNo : replyNo
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/board/decom.ajax",
		data: decom,
		type: "POST",
		success: function(data) {
			if(data>0)
				location.reload();
			else alert("이미 추천/비추천한 상태입니다.");
		},
		error: function(x,s,e) {
			console.log(x,s,e);
		}
	});
}
</script>
</c:if>

<script>
function deletePost() {
	if(!confirm("게시글을 삭제하시겠습니까?"))
		return;
	$("#postForm").attr("action", "${pageContext.request.contextPath}/board/deletePost.do")
				  .submit();
}
function deleteReply(replyNo) {
	if(!confirm("댓글을 삭제하시겠습니까?"))
		return;
	$("#delRpl").val(replyNo);
	$("#postForm").attr("action","${pageContext.request.contextPath}/board/deleteReply.do")
				.submit();
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
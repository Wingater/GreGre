<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/shop/common/header.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/shop/wishList.css"
	type="text/css">
<!-- wishlist -->
<!-- Breadcrumb Section Begin -->
<div class="breacrumb-section">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb-text product-more">
					<a href="${pageContext.request.contextPath }/"><svg style="margin-bottom: 2.5px;"
							xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="16px"
							height="16px" viewBox="0 0 172 172" style=" fill:#000000;">
							<g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1"
								stroke-linecap="butt" stroke-linejoin="miter"
								stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0"
								font-family="none" font-weight="none" font-size="none"
								text-anchor="none" style="mix-blend-mode: normal">
							<path d="M0,172v-172h172v172z" fill="none"></path>
							<g fill="#b2b2b2">
							<path
								d="M86,15.0472l-78.83333,70.9528h21.5v64.5h43v-50.16667h28.66667v50.16667h43v-64.5h21.5z"></path></g></g></svg>Home</a> <a href="./shop.html">MY쇼핑</a> <span>이벤트 참여내역</span>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Breadcrumb Section Begin -->
<!-- contents begin-->
<div class="site-section">
	<div class="container">
		<div class="row">
			<div class="col-md-12 mt-4 pt-4">
				<h1 class="mb-3 font-weight-bold text-teal ">MY쇼핑</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div class="sidebar">
					<div class="sidebar__header">
						<div class="profile sidebar__profile">
							<img class="profile__avatar"
								src="${pageContext.request.contextPath }/resources/images/myPage/user.png" />
							<div class="profile__name">${memberLoggedIn.memberId }</div>
						</div>
					</div>
					<div class="sidebar__middle">
						<div class="profile side__profile _3fftNQzxHO">
							<ul>
								<li>보유 쿠폰<a
									href="${pageContext.request.contextPath }/shop/myShopping/coupon/list.do"
									class="_2XiEZGqw1K"><em>${myCouponCount }</em>장</a>
								</li>
								<li>포인트<a href="#" class="_2XiEZGqw1K "><em>
								<fmt:formatNumber type="number" maxFractionDigits="3"
									value="${point }" /></em>p</a>
								</li>
							</ul>
						</div>

					</div>
					<div class="sidebar__body">
						<div class="menu sidebar__menu">
							<a class="menu__item"
								href="${pageContext.request.contextPath }/shop/myShopping/order/list.do">
								<div class="menu__title">주문확인/배송조회</div>
							</a> <a class="menu__item"
								href="${pageContext.request.contextPath }/shop/myShopping/wish/list.do">
								<div class="menu__title">관심상품</div>
							</a> 
							<a class="menu__item"
								href="${pageContext.request.contextPath }/shop/myShopping/event/list.do">
								<div class="menu__title">이벤트참여내역</div>
							</a> 
							<a class="menu__item"
								href="${pageContext.request.contextPath }/shop/myShopping/review/list.do">
								<div class="menu__title">상품리뷰</div>
							</a> 
							<a class="menu__item" href="${pageContext.request.contextPath }/shop/myShopping/QnA/list.do">
								<div class="menu__title">상품문의 내역</div>
							</a>
						</div>
					</div>
				</div>
			</div>
			<!--이벤트 참여내역 시작-->
			<div class="col-md-9">
				<div class="row">
					<h4 style="margin-bottom: 20px;">
						<strong>이벤트참여내역</strong>
					</h4>
				</div>
				<!--contents begein-->
				<div class="row">
					<div class="col-lg-12">
						<table class="tbl-col">
							<thead>
								<tr>
									<th scope="col">이벤트명</th>
									<th scope="col">참여일시</th>
									<th scope="col">당첨여부</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${wlist }" var="w">	
								<tr>
									<td class="aleft"><a href="${pageContext.request.contextPath }/shop/event/noticeDetail.do?eventNo=${w.eventNo}"
										class="title">${w.eventTitle }</a></td>
									<td>${w.replyWriteTime }</td>
									<td><a href=""><span class="fc-gray">당첨</span></a></td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!--contents end-->

			</div>
			<!--이벤트 참여내역 끝-->
		</div>
	</div>
</div>

	<jsp:include page="/WEB-INF/views/shop/common/footer.jsp" />
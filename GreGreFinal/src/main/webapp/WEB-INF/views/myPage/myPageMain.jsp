<%@page import="kh.mclass.Igre.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!-- 마이페이지 서브메뉴 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
<!--서브메뉴 js-->
<script
	src="${pageContext.request.contextPath}/resources/js/subMenu/subMenu.js"></script>

<div class="ftco-blocks-cover-1">
	<div class="site-section-cover overlay"
		data-stellar-background-ratio="0.5">
		<div class="container">
			<div class="row align-items-center ">
				<div class="col-md-5 mt-5 pt-5">
					<h1 class="mb-3 font-weight-bold text-teal">마이페이지</h1>
					<p>
						<a href="${pageContext.request.contextPath}/" class="text-white">Home</a>
						<span class="mx-3">/</span> <strong>MyPage</strong>
					</p>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- contents begin-->


<div class="site-section">
	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<div class="sidebar">
					<div class="sidebar__header">
						<div class="profile sidebar__profile">
							<img class="profile__avatar"
								src="${pageContext.request.contextPath}/resources/images/myPage/user.png" />
							<div class="profile__name">${m.memberId }</div>
						</div>
					</div>
					<div class="sidebar__body">
						<div class="menu sidebar__menu">
							<a class="menu__item"
								href="${pageContext.request.contextPath}/myPage/memberUpdate.do">
								<div class="menu__title">개인정보</div>
							</a> <a class="menu__item"
								href="${pageContext.request.contextPath}/myPage/memberChildUpdate.do">
								<div class="menu__title">자녀정보</div>
							</a> <a class="menu__item"
								href="${pageContext.request.contextPath}/myPage/myPeriod.do">
								<div class="menu__title">월경캘린더</div>
							</a> <a class="menu__item"
								href="${pageContext.request.contextPath}/myPage/counsellingInfo.do">
								<div class="menu__title">상담정보/리뷰</div>
							</a> <a class="menu__item"
								href="${pageContext.request.contextPath}/myPage/deleteMember.do">
								<div class="menu__title">회원탈퇴</div>
							</a>

						</div>
					</div>
				</div>
			</div>

			<div class="col-md-9">
				<div class="row mb-4">
					<div class="col-md-12">
						<h4 style="text-align: center;">
							<strong>자녀정보</strong>
						</h4>
					</div>
				</div>

				<c:if test="${m.childNumber !=0 }">
					<c:forEach items="${list }" var="c" varStatus="vs">

						<div class="row mb-3">
							<div class="col-md-12">
								<div class="card">
									<div class="card-body">
										<div class="row">
											<!--                                     <div class="col-md-3">
                                       <img src="../images/myPage/pic2.PNG" class="imgmini">
                                    </div> -->
											<div class="col-md-4">
												<p>자녀이름 : ${c.childName }</p>
												<p>자녀생일 : ${c.birthday }</p>
												<p>성별 : ${c.gender eq 'M'? '남':'여'}</p>
											</div>
											<div class="col-md-5">
												<p style="font-weight: bold">최근에 맞은 백신</p>
												<c:forEach items="${list2}" var="v" varStatus="status">
													<c:if test="${c.childId == v.childId}">
														<c:if test="${status.last == true }">
															<p>백신:${v.vaccinCode }</p>
															<p>차수:${v.nth }</p>
															<p>접종일:${v.vaccinDate }</p>
														</c:if>
													</c:if>
												</c:forEach>
											</div>


										</div>

									</div>
								</div>
							</div>
						</div>


					</c:forEach>
				</c:if>


				<div class="row mb-4">
					<div class="col-md-12">
						<h4 style="text-align: center;">
							<strong>상담정보</strong>
						</h4>
					</div>
				</div>


				<c:forEach items="${list3 }" var="a">
					<c:if test="${a.appointNo != null }">
						<div class="row mb-3">
							<div class="col-md-12">
								<div class="card">
									<div class="card-body">
										<div class="row">
											<div class="col-md-3">
												<img src="${pageContext.request.contextPath}/resources/images/counselling/${a.advisImg }"
													class="imgmini">
											</div>
											<div class="col-md-7">
												<p>예약한 상담사명 : ${a.advisName}</p>
												<p>결제정보 : ${a.payInfo }</p>
												<p>결제일 : ${a.startDay}</p>
												<p>남은횟수 : ${a.coin }</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>




				<div class="row mb-4">
					<div class="col-md-12">
						<h4 style="text-align: center;">
							<strong>월경정보</strong>
						</h4>
					</div>
				</div>





				<c:forEach items="${list4 }" var="p" varStatus="vs">
					<c:if test="${p.mensesNo != null }">
						<c:if test="${vs.last == true }">
							<div class="row mb-3">
								<div class="col-md-12">
									<div class="card">
										<div class="card-body">
											<div class="row">

												<div class="col-md-6">
													<p style="font-weight: bold">마지막 생리 정보</p>
													<p>생리 시작일 : ${p.mensesStart }</p>
													<p>종료 예정일 : ${p.mensesEnd}</p>
													<p>생리주기 : ${p.mensesCycle } 일</p>
												</div>



											</div>
										</div>
									</div>
								</div>


							</div>
						</c:if>
					</c:if>
				</c:forEach>






			</div>



		</div>
	</div>
</div>

<!-- contents end-->


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
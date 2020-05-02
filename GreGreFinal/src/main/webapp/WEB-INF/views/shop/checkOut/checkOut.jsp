<%@page import="kh.mclass.IgreMall.shopMember.model.vo.ShopMember"%>
<%@page import="java.util.List"%>
<%@page import="kh.mclass.IgreMall.product.model.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/shop/common/header.jsp" />

<%
	List<Product> prodList = (List<Product>) request.getAttribute("prodList");
	List<Integer> totalPriceList = (List<Integer>) request.getAttribute("totalPriceList");
	List<Integer> totalAmountList = (List<Integer>) request.getAttribute("totalAmountList");
	ShopMember sMem = (ShopMember) request.getAttribute("sMem");

	//보유 쿠폰 개수
	int totalCoupon = 0;
	for (int i = 0; i < sMem.getCouponList().size(); i++) {
		if (sMem.getCouponList().get(i).getCouponState().equals("Y")) {
			totalCoupon++;
		}
	}
	pageContext.setAttribute("totalCoupon", totalCoupon);
	//총수량
	int totalAmount = 0;
	for (int i = 0; i < totalAmountList.size(); i++) {
		totalAmount += totalAmountList.get(i);
	}
	//총 수량
	pageContext.setAttribute("totalAmount", totalAmount);

	int totalPoint = 0;
	String allProdName = "";
	for (int i = 0; i < prodList.size(); i++) {
		totalPoint += prodList.get(i).getPointRate() * 0.01 * totalPriceList.get(i);
		allProdName += prodList.get(i).getProductName() + (i == prodList.size() - 1 ? "" : ",");
	}

	pageContext.setAttribute("allProdName", allProdName);
	//총 적림 예상금액
	pageContext.setAttribute("totalPoint", totalPoint);
%>

<!--checkOut css-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/shop/check-out.css">

<!-- 아임포트 호출 하는 스크립트 -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!--bootpay api-->
<script src="https://cdn.bootpay.co.kr/js/bootpay-3.2.1.min.js"
	type="application/javascript"></script>
<!-- 네이버페이 -->
<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>
<style>
.member-info-form {
	background: #f5f5f5;
	height: 150px;
	padding-right: 20px;
	padding-left: 20px;
}

.table td, .table th {
	border-top: 0;
}

img.kakao-img {
	padding-top: 29px;
	padding-bottom: 6px;
}

input.site-btn.place-btn {
	width: 170px;
	height: auto;
}

td.first-row {
	border-right: 0 !important;
}

td.qua-col.first-row {
	text-align: center;
}

.torder-info-t tr {
	border-bottom: 1px solid #ebebeb;
}

img.delivery-icon {
	width: 26px;
	margin-right: 2px;
	margin-bottom: 4px;
}
</style>
<script>
	$(function() {
		//총상품금액
		var totalOriginPrice = 0;
		$('.origin-price').each(function(index, item) {
			totalOriginPrice += Number(uncomma($(item).text()));
		});
		$('#total-prod').text(comma(totalOriginPrice));

		//총 배송비
		var totalDeliFee = 0;
		<c:forEach var="p" items="${prodList}" >
		totalDeliFee += Number('${p.deliveryFee}');
		</c:forEach>
		$('#total-del').text(comma(totalDeliFee));

		//총 할인 금액
		var totalDis = 0;
		$('._discountAmountText').each(function(index, item) {
			totalDis += Number(uncomma($(item).text()));
		});
		$('#total-dis').text(comma(totalDis));
	});
</script>

<!-- 최종 금액 -->
<script>
	$(function() {
		var totalProd = Number(uncomma($('#total-prod').text()));
		var totalDel = Number(uncomma($('#total-del')));
		var totalDis = Number(uncomma($('#total-dis').text()));
		var totalPay = totalProd + totalDel - totalDis;

		$("#total-pay").text(comma(totalPay));
	});
</script>
<!-- 포인트 사용 -->
<script>
	$(function() {
		$("input[name=payAmounts]")
				.on(
						"propertychange change keyup paste ",
						function() {
							var totalProd = Number(uncomma($('#total-prod')
									.text()));
							var totalDel = Number(uncomma($('#total-del')));
							var totalDis = Number(uncomma($('#total-dis')
									.text()));
							var usedCoupon = Number(uncomma($('#used-coupon')
									.text()));
							var totalPay = totalProd + totalDel - totalDis
									- usedCoupon;

							var usingPoint = $(this).val();
							var hasPoint = Number(uncomma($("#has-point")
									.text()));

							if (Number(usingPoint) > hasPoint) {
								alert("보유하신 포인트보다 많습니다. ");
								$(this).val(hasPoint);
								return;
							}
							if (hasPoint > 0) {
								$('#used-point').text(usingPoint);
								console.log("using=" + usingPoint);
								totalPay -= Number(usingPoint);
								console.log("totalPay=" + totalPay);
								$("#total-pay").text(comma(totalPay));
							}

							return;
						});

	});
</script>
<!--회원 정보 사용 -->
<script>
function goMember() {

	if (confirm("회원 정보를 수정하시겠습니까?")) {

		var objParams = {
				"memberId" : $('#memberId').val(),
				"memberName" : $('#m-name').val(),
				"phone" : $('#m-phone').val(),
				"email" : $('#m-email').val()
		}

		$.ajax({
			url: "${pageContext.request.contextPath}/shop/myShopping/shopMemberUpdate.do",
			type: "POST",
			dataType : "json",
			data: objParams,
			success: function (data) {
				console.log(data);
				$('#s-mem-email').text(data.email);
				$('#s-mem-name').text(data.memberName);
				$('#s-mem-phone').text(data.phone);
				
				alert('회원 정보가 수정되었습니다');
				$('#memberUpdateModal').modal('hide');
					
			},
			error:(x,s,e)=>{
				console.log(x,s,e);
			}
		}); 
	  
	} 

}
</script>
<!--쿠폰 사용 -->
<script>
	function goCoupon() {
		var couponValue = $("input[name=coupon-radio]:checked").next().next().val();
		var couponListId = $("input[name=coupon-radio]:checked").next().next().next().val();
		var discountType = $("input[name=coupon-radio]:checked").next().next().next().next().val();
		var totalProd = Number(uncomma($('#total-prod').text()));
		var totalDel = Number(uncomma($('#total-del')));
		var totalDis = Number(uncomma($('#total-dis').text()));
		var usedPoint = Number(uncomma($('#used-point').text()));
		var usedCoupon = Number(uncomma($('#used-coupon').text()));
		var totalPay = totalProd + totalDel - totalDis - usedPoint - usedCoupon;

		var discountedPrice = totalProd - totalDis;
		
		console.log("discountType ")
		//쿠폰사용
		if (couponValue != null) {
			console.log("여기=");
			if (discountType == 'P') { // 할인율
				var usingCoupon = Number(couponValue) * discountedPrice;
				totalPay -= usingCoupon;
				
				console.log("여기="+totalPay);
				$("#total-pay").text(comma(totalPay));

				$("#pro_coupon").val(comma(usingCoupon));
				$('#used-coupon').text(comma(usingCoupon));
				$('[name=couponListId]').val(couponListId);

			}
			// 할인금액
			else if (discountType == 'C') {
				totalPay -= Number(uncomma(couponValue));
				console.log("여기="+totalPay);
				$("#total-pay").text(comma(totalPay));
				$("#pro_coupon").val(comma(couponValue));
				$('#used-coupon').text(comma(couponValue));
				$('[name=couponListId]').val(couponListId);

			}

		}
		//쿠폰적용 취소
		else {
			console.log("toPay" + couponVal)
			console.log("toPay" + totalPay)
			var couponVal = Number(uncomma($("#pro_coupon").val()));
			totalPay += couponVal;
			$("#total-pay").text(comma(totalPay));

			$('#used-coupon').text(0);
			$('#pro_coupon').val(0);
			$('[name=couponListId]').val("");
		}

		$('#couponModal').modal('hide');
		alert("쿠폰할인이 적용되었습니다.");
	}
</script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						//라디오 요소처럼 동작시킬 체크박스 그룹 셀렉터
						$('input[type="checkbox"][name="coupon-radio"]')
								.click(
										function() {
											//클릭 이벤트 발생한 요소가 체크 상태인 경우
											if ($(this).prop('checked')) {
												//체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
												$(
														'input[type="checkbox"][name="coupon-radio"]')
														.prop('checked', false);
												$(this).prop('checked', true);
											}
										});
					});
</script>
<script>
	function noCoupon() {
		alert("사용가능한 쿠폰이 없습니다.");
	}
</script>
<!-- Breadcrumb Section Begin -->
<div class="breacrumb-section">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcru${pageContext.request.contextPath}/">
					<i class="fa fa-home"></i> Home</a> <a href="./shop.html">Shop</a> <span>Check
						Out</span>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Breadcrumb Section Begin -->

<!-- Shopping Cart Section Begin -->
<section class="checkout-section spad">
	<form class="checkout-form" name="checkOutFrm" method='POST'
		enctype="multipart/form-data">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="cart-table">
						<table class="order-info-t">
							<colgroup>
								<col style="width: 15%;">
								<col style="width: 32%;">
								<col style="width: 15%;">
								<col style="width: 7%;">
								<col style="width: 15%;">
								<col style="width: 15%;">
							</colgroup>
							<thead>
								<tr>
									<th class="title-col" colspan='2'>상품정보</th>
									<th class="title-col">배송비</th>
									<th class="title-col">수량</th>
									<th class="title-col">할인</th>
									<th class="title-col">주문금액</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="prod" items="${prodList}" varStatus="vs">
									<tr>
										<td class="cart-pic first-row"><c:forEach var="attach"
												items="${prod.attachList}">
												<c:if
													test="${fn:contains(prod.attachList.get(0).originalImg, 'http://')}">
													<img class="prod-main-img"
														src="${prod.attachList.get(0).originalImg}" alt="">
												</c:if> 
												<c:if test="${fn:contains(prod.productId, 'p')}">
												<c:if test='${ "R" eq attach.imgType}'>
													<img
														src="${pageContext.request.contextPath}/resources/upload/shop/productMainImg/${attach.renamedImg}"
														alt="">
												</c:if>
												</c:if>
											</c:forEach></td>
										<td class="cart-title first-row">
											<h5>
												[<span>${prod.brandName} </span>]
											</h5>
											<h3 class="product-name">${prod.productName}</h3>
											<div class="option">
												<c:if test="${ prod.optionList.get(0).optionId !=null }">
													<span class="ico_option"><span class="">옵션</span></span>
													<ul class="option_list">
														<c:forEach items="${prod.optionList}" var="optList">
															<c:if test="${ optList.optionId !=null }">
																<c:set var="optName"
																	value="${fn:split(optList.optionName,',') }" />
																<c:set var="optValue"
																	value="${fn:split(optList.optionValue,',') }" />
																<c:if test="${ not empty optName[1] }">
																	<li>${optName[0]}:${optValue[0]}/${optName[1]}:
																		${optValue[1]} / ${optList.optionStock}개</li>
																</c:if>
																<c:if test="${  empty optName[1] }">
																	<li>${optName[0]}:${optValue[0]}/
																		${optList.optionStock}개</li>
																</c:if>
															</c:if>
														</c:forEach>

													</ul>
												</c:if>
											</div>
										</td>

										<td class="first-row"><c:if
												test="${ prod.deliveryFee eq 0}">
												<span class="deli-fee"> <img class="delivery-icon"
													src="${pageContext.request.contextPath }/resources/images/shop/icon/delivery-icon.png" />
													무료
												</span>
											</c:if> <c:if test="${prod.deliveryFee> 0}">
												<span class="deli-fee"> <img class="delivery-icon"
													src="${pageContext.request.contextPath }/resources/images/shop/icon/delivery-icon.png">
													<fmt:formatNumber type="number" maxFractionDigits="3"
														value="${prod.deliveryFee}" />원
												</span>
											</c:if></td>
										<td class="qua-col first-row">${totalAmountList.get(vs.index)}</td>
										<td class="qua-col first-row"><span class="discount">
												<c:set var="totalDiscount"
													value="${totalAmountList.get(vs.index)*prod.discountPrice }" />
												<span class="_discountAmount">(-) </span> <span><em
													class="_discountAmountText"> <fmt:formatNumber
															type="number" maxFractionDigits="3"
															value="${totalDiscount}" /></em>원 </span>
										</span></td>
										<td class="total-price first-row">
										<c:if test="${prod.discountPrice > 0}">
											<span class="orgn_price ">
												<em class="origin-price"> 
												<fmt:formatNumber
															type="number" maxFractionDigits="3"
															value="${totalPriceList.get(vs.index)+totalDiscount}" /></em>원
											</span> 
										</c:if>
										<strong> <em><fmt:formatNumber type="number"
														maxFractionDigits="3"
														value="${totalPriceList.get(vs.index)}" /></em>원
										</strong></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>


			<fmt:formatNumber var="licsNo" value="${memberLoggedIn.phone }"
				pattern="###,####,####" />
			<c:set var="phone" value="0${fn:replace(licsNo, ',', '-')}" />
			<div class="row" style="margin-top: 30px; margin-bottom: 50px;">
				<div class="col-lg-8">
					<h4>배송정보</h4>
					<div class="chkout-row">
						<div class="row">
							<div class="col-lg-3">
								<label for="fir">수령인<span>*</span></label> <input type="text"
									name="recptName" value="${memberLoggedIn.memberName }">
							</div>
						</div>
						<div class="row">
							<div class="col-lg-5">
								<label for="phone">연락처<span>*</span></label> <input type="text"
									name="recptPhone" id="phone" value="${phone }">
							</div>
						</div>
						<div class="row">
							<div class="col-lg-5">
								<label for="street">배송지 주소<span>*</span></label>
							</div>

						</div>
						<div class="row">
							<div class="col-lg-3" style="float: left;">
								<input type="text" name="recptZipcode" id="zipcode"
									class="zipcode" value="" readonly>
							</div>
							<div class="col-lg-3">
								<input type="button" style="background: #ebebeb;" class="btn"
									onclick="execPostCode();" value="우편번호 찾기">
							</div>
						</div>

						<div class="row">
							<div class="col-lg-7" style="float: left;">
								<input type="text" name="recptAddr" id="address1" readonly>
							</div>
							<div class="col-lg-5">
								<input type="text" name="recptDetailAddr" id="address2">
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div class="dropdown_wrap">
									<label for="delivery-memo">배송메모</label> <input type="text"
										placeholder="요청사항을 직접 입력합니다" title="배송 메세지"
										name="deliveryText" class="deli_msg placeholder">

								</div>

							</div>

						</div>

					</div>
				</div>
				<div class="col-lg-4 member-info-form">
					<h5 style="font-weight: 700; padding-top: 15px;">주문자 정보</h5>
					<input type="button" class="btn btn-dark"
						style="float: right; width: 80px" data-toggle="modal"
						data-target="#memberUpdateModal" value="수정" />
					<ul class="user_info">
						<li id="s-mem-name">${memberLoggedIn.memberName }</li>
						<li class="_telNoHighlight "><span class="_memberTelNumber"
							id="s-mem-phone">${phone } </span></li>
						<li><span class="_memberEmailAddress" id="s-mem-email">${memberLoggedIn.email }</span>
							<input type="hidden" name="recptEmail"
							value="${memberLoggedIn.email }"></li>
					</ul>
				</div>


			</div>
			<hr>
			<div class="row" style="margin-top: 50px; margin-bottom: 50px;">
				<div class="col-lg-7">
					<div class="discount_info discountPriceInfo">
						<h4>
							<span class="blind">할인 및 포인트</span>
						</h4>
						<table cellspacing="0" class="tb_discount">
							<colgroup>
								<col width="121">
								<col width="126">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th rowspan="2">
										<div class="deliver_option_wrap">
											<strong class="req short">쿠폰 할인</strong>
										</div>
									</th>
									<th>상품/주문쿠폰</th>
									<td>
										<div class="input_area">
											<input type="text" name="productCouponPrice" id="pro_coupon"
												value="" class="value" title="상품/주문쿠폰금액" readOnly> <span
												class="measure">원</span>
										</div> <c:if test="${totalCoupon == 0}">
											<button type="button" class="coupon-btn"
												onclick="noCoupon();">쿠폰사용</button>
										</c:if> <c:if test="${totalCoupon != 0}">
											<button type="button" class="coupon-btn" data-toggle="modal"
												data-target="#couponModal">쿠폰사용</button>
										</c:if>
										<ul class="use_list">
											<li>(보유 쿠폰 : <em>${totalCoupon}</em>장)
											</li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
						<table cellspacing="0" class="tb_discount">
							<colgroup>
								<col width="121">
								<col width="126">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th rowspan="2">
										<div class="deliver_option_wrap">
											<strong class="req long">포인트</strong>
										</div> <a href="#" title="?" class="sp_order "></a>
									</th>
									<th>보유 포인트</th>
									<td>
										<div class="input_area no_underline">
											<span class="value" id="has-point"> <fmt:formatNumber
													type="number" maxFractionDigits="3" value="${sMem.point }" />
											</span> <span class="measure"
												style="position: relative; top: -24px;">원</span>
										</div>
									</td>
								</tr>
								<tr>
									<th>사용 포인트</th>
									<td>
										<div class="input_area">
											<c:if test="${sMem.point == 0 }">
												<input type="text" id="mileage" title="포인트"
													name="payAmounts" value="0" class="value" readonly />
												<span class="measure"
													style="position: relative; top: -24px;">원</span>
											</c:if>
											<c:if test="${sMem.point!= 0 }">
												<input type="text" id="mileage" title="포인트"
													name="payAmounts" value="0" class="value">
												<span class="measure"
													style="position: relative; top: -24px;">원</span>
											</c:if>

										</div>

									</td>
								</tr>

							</tbody>
						</table>
					</div>
					<h4>예상 적립 포인트</h4>
					<div class="expect_mileage">

						<fmt:formatNumber type="number" maxFractionDigits="3" var="tPoint"
							value="${totalPoint }" />
						<div class="mileage" id="expect_mileage" data-benefit="1"
							data-hj-suppress="">${tPoint}P</div>
						<div>적립예정</div>
					</div>
				</div>

				<div class="col-lg-5">
					<div class="place-order">
						<div class="order-total">
							<h5 style="margin-bottom: 0 !important; font-weight: 700;">최종
								결제 금액</h5>
							<ul class="order-table">
								<li class="total-price" style="border: 0; margin-bottom: 20px;"><span
									style="font-size: 30px; padding-top: 5px; float: left;"><em
										id="total-pay"></em>원</span></li>
								<li class="fw-normal">총 상품금액 <span><em
										id="total-prod"></em>원</span></li>
								<li class="fw-normal">배송비 <span>(+)<em
										id="total-del"></em>원
								</span></li>
								<li class="fw-normal">할인금액<span>(-)<em
										id="total-dis"></em>원
								</span></li>
								<li class="fw-normal">쿠폰 사용금액<span>(-)<em
										id="used-coupon"></em>원
								</span></li>
								<li class="fw-normal">포인트 사용금액<span>(-)<em
										id="used-point"></em>원
								</span></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<hr>
			<div class="row" style="margin-top: 50px;">
				<div class="col-lg-12">
					<h4>결제수단</h4>
					<div class="pay_method">
						<div class="payment_panel">
							<!-- 결제선택  시작-->
							<!-- 신용카드 결제 -->
							<input type="radio" value="cr" name="payMethod"
								id="order_payment_method_kcp_credit_card"> <label
								class="first top" for="order_payment_method_kcp_credit_card">
								<img class="img" width="64"
								src="https://bucketplace-v2-development.s3.amazonaws.com/pg/card.png"
								alt="Card">
								<div class="title">카드</div>
							</label>
							<!-- 실시간 계좌이체 -->
							<input type="radio" value="ra" name="payMethod"
								id="order_payment_method_smilepay"> <label class=" top"
								for="order_payment_method_smilepay">
								<img class="img"
								width="64"
								src="${pageContext.request.contextPath }/resources/images/shop/icon/ra-icon.png"
								alt="실시간계좌이체">
								<div class="title">실시간계좌이체</div>
							</label>
							<!-- 휴대폰 결제 -->
							<input type="radio" value="ph" name="payMethod"
								id="order_payment_method_phone"> <label class=" top"
								for="order_payment_method_phone"> <img class="img"
								width="64"
								src="https://bucketplace-v2-development.s3.amazonaws.com/pg/phone.png"
								alt="Phone">
								<div class="title">핸드폰</div>

							</label>
							<!-- 가상계좌입금 -->
							<input type="radio" value="ac" name="payMethod"
								id="order_payment_method_without_bankbook"> <label
								class=" top" for="order_payment_method_without_bankbook">
								<img class="img" width="64"
								src="https://bucketplace-v2-development.s3.amazonaws.com/pg/vbank.png"
								alt="Vbank">
								<div class="title">가상계좌입금</div>
							</label>
							<!-- 네이버페이 -->
							<input type="radio" value="na" name="payMethod"
								id="order_payment_method_naverpay"> <label class=" top"
								for="order_payment_method_naverpay"> <img class="img"
								width="64"
								src="https://bucketplace-v2-development.s3.amazonaws.com/pg/naver.png"
								alt="Naver">
								<div class="title">네이버페이</div>

							</label>
							<!-- 카카오페이 -->
							<input type="radio" value="ka" name="payMethod"
								id="order_payment_method_kakao"> <label class=" top"
								for="order_payment_method_kakao"> <img width="64"
								class="kakao-img"
								src="${pageContext.request.contextPath }/resources/images/shop/pay/kakaoPay.png"
								alt="kakaoPay">
								<div class="title">카카오페이</div>
							</label>
							<!-- 토스결제 -->
							<input type="radio" value="to" name="payMethod"
								id="order_payment_method_tosspay"> <label class="top"
								for="order_payment_method_tosspay"> <img class="img"
								width="64"
								src="https://bucketplace-v2-development.s3.amazonaws.com/pg/toss.png"
								alt="Toss">
								<div class="title">토스</div>
							</label>
							<!-- 결제선택 끝 -->
						</div>
					</div>
					<div id="confirm_checkbox">
						<div class="form-check check_agree_policy">
							<label class="form-check-label" for="check_agree_policy">
								<input type="checkbox" id="check_agree_policy"
								class="form-check"> <span class="check-img"></span> 결제
								진행 필수사항 동의
							</label>
						</div>

						<div class="all_policy">
							<div class="title">개인정보 제 3자 제공 및 결제대행 서비스 표준 이용약관</div>
						</div>

						<div class="policies">
							<div class="policy">
								<div class="title_panel">
									<div class="title">개인정보 제 3자 제공</div>
								</div>
								<div class="content">
									<table>
										<thead>
											<tr>
												<th class="to">제공 받는자</th>
												<th class="goal">제공목적</th>
												<th class="information">항목</th>
												<th class="due_date">보유 및 이용 기간</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="to">다온에스아이</td>
												<td class="goal">상품 및 경품(서비스) 배송(전송), 제품 설치, 반품, 환불,
													고객상담 등 정보통신서비스제공계약 및 전자상거래(통신판매)계약의 이행을 위해 필요한 업무의 처리</td>
												<td class="information">1) 구매자정보(닉네임, 성명, 휴대폰번호, 이메일주소)<br>
													2) 수령인정보(성명, 휴대폰번호, 주소)<br> 3) 상품 구매, 취소, 반품, 교환정보<br>
													4) 송장정보
												</td>
												<td class="due_date">상품 제공 완료 후 3개월</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>


							<div class="policy">
								<div class="title_panel">
									<div class="title">개인정보 수집 및 이용</div>
								</div>
								<div class="content">
									<table>
										<thead>
											<tr>
												<th class="to">수집방법</th>
												<th class="goal">수집항목</th>
												<th class="information">목적</th>
												<th class="due_date">보유 및 이용 기간</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="to">상품구매</td>
												<td class="goal">1) 구매자 정보(성명, 휴대전화 번호)<br>2) 수령인
													정보(성명, 휴대전화 번호, 주소)
												</td>
												<td class="information">상품 배송 및 서비스 제공을 위한 사용자 정보 확인</td>
												<td class="due_date" rowspan="4">5년 (계약 및 철회, 결제 및 공급)</td>
											</tr>
											<tr>
												<td class="to">결제</td>
												<td class="goal">신용카드 정보</td>
												<td class="information">간편 결제 서비스 제공</td>
											</tr>
											<tr>
												<td class="to">취소·환불</td>
												<td class="goal">환불 계좌번호, 은행명, 예금주명</td>
												<td class="information">결제 서비스 환불</td>
											</tr>
											<tr>
												<td class="to">휴대전화 인증</td>
												<td class="goal">휴대전화 번호</td>
												<td class="information">상품 구매 및 포인트(적립금) 지급 시 본인 인증</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

						</div>
					</div>
					<div class="order-btn">
						<input type="button" class="site-btn place-btn" onclick="goPay();"
							value="결제하기" />
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" name="couponListId" value=""> <input
			type="hidden" name="bankName" value=""> <input type="hidden"
			name="accountHolder" value=""> <input type="hidden"
			name="accountNo" value=""> <input type="hidden"
			name="expireDate" value=""> <input type="hidden"
			name="prodPrice" value=""> <input type="hidden"
			name="totalDeliveryFee" value=""> <input type="hidden"
			name="totalDiscount" value=""> <input type="hidden"
			name="usedPoint" value=""> <input type="hidden"
			name="usedCoupon" value=""> <input type="hidden"
			name="totalPrice" value=""> <input type="hidden"
			name="addPoint" value="${totalPoint }">
	</form>

</section>

<!-- 	<button type="button" class="site-btn place-btn impPay">결제하기test</button> -->
<!-- 쿠폰사용 modal -->
<div class="modal fade" id="couponModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">쿠폰 할인적용</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
							<label for="coupon-title" class="col-form-label">할인 쿠폰 선택</label>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<span style="float: right;">* 모든 쿠폰은 중복사용이 불가능합니다.</span>
							<table class="fold-table table table-sm"
								style="border-top: 2px solid #dee2e6; text-align: center;">
								<colgroup>
									<col style="width: 3%;">
									<col style="width: 10%;">
									<col style="width: 25%;">
									<col style="width: 15%;">
									<col style="width: 22%;">
									<col style="width: 25%;">
								</colgroup>
								<thead>
									<tr>
										<th></th>
										<th>쿠폰번호</th>
										<th>쿠폰명</th>
										<th>할인액(율)</th>
										<th>사용제한 조건</th>
										<th>유효기간</th>
									</tr>
								</thead>
								<tbody style="border-bottom: 2px solid #dee2e6;">
									<c:forEach items="${sMem.couponList}" var="cList">
										<c:if test="${cList.couponState eq 'Y'}">
											<tr>
												<td>
													<div class="form-check">
														<input name="coupon-radio" class="form-check-input"
															type="checkbox" id="inlineCheckbox1" value="option1">
														<input type="hidden" name="couponListId"
															value="${cList.couponListId }" />
														<c:if test="${cList.discountType eq 'P'}">
															<fmt:parseNumber var="discountVal"
																value="${cList.discountValue*0.01} " />
															<input type="hidden" name="discountValue"
																value="<fmt:formatNumber type="number" maxFractionDigits="3" value="${discountVal}" />" />
														</c:if>
														<c:if test="${cList.discountType eq 'C'}">
															<input type="hidden" name="discountValue"
																value="${cList.discountValue }" />
														</c:if>
														<input type="hidden" id="couponListId"
															value="${cList.couponListId}"> 
														<input
															type="hidden" id="discountType"
															value="${cList.discountType}">

													</div>

												</td>
												<td>${cList.couponListId}</td>
												<td>${cList.couponName}</td>
												<td><c:if test="${cList.discountType eq 'P'}">
												${cList.discountValue}%
												</c:if> <c:if test="${cList.discountType eq 'C'}">
 													${cList.discountValue}원
												</c:if></td>
												<td><c:if test="${not empty cList.maxValue }">
														<fmt:formatNumber type="number" maxFractionDigits="3"
															value="${cList.maxValue }" />원 이상 구매
											</c:if></td>
												<td>${cList.expireDate }일까지</td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>

						</div>


					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="goCoupon();">쿠폰적용</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 모달 끝 -->
<!-- 회원 정보 수정 modal -->
<div class="modal fade" id="memberUpdateModal" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<div class="row">
					<div class="col-lg-12">
						<h5 class="modal-title" id="exampleModalLabel">주문자 정보 수정</h5>
					</div>
				</div>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
							<span>*수정시 회원 정보에 반영됩니다.</span>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<form class="card-body mx-auto" id="memberFrm" method="post">
								<div class="form-group input-group">
									<div class="input-group-prepend">
										<span class="input-group-text">아이디</span>
									</div>
									<input type="text" name="memberId" id="memberId"
										class="form-control" value="${memberLoggedIn.memberId }"
										readonly><br>
								</div>
								<div class="form-group input-group">
									<div class="input-group-prepend">
										<span class="input-group-text">이름</span>
									</div>
									<input type="text" name="memberName" id="m-name"
										class="form-control" value="${memberLoggedIn.memberName }"><br>
								</div>
								<div class="form-group input-group">
									<div class="input-group-prepend">
										<span class="input-group-text">연락처 </span>
									</div>
									<input name="phone" class="form-control" id="m-phone"
										placeholder="(-)없이 입력" value="${memberLoggedIn.phone }"
										type="text">
								</div>

								<div class="form-group input-group">
									<div class="input-group-prepend">
										<span class="input-group-text">이메일 </span>
									</div>
									<input name="email" class="form-control" id="m-email"
										placeholder="abc@xyz.com" type="email"
										value="${memberLoggedIn.email }">
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="goMember();">정보수정</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 모달 끝 -->


<!-- 네이버패이 -->



<!-- 결제하기 -->
<script>
	function goPay() {
		var payMethod = $("input[name=payMethod]:checked").val();

		var name = "아이그레페이";
		var qty = "${totalAmount}"; // 총수량
		var payPrice = uncomma($('#total-pay').text()); //결제금액
		var buyerEmail = '${sMem.email}';
		var buyerName = '${sMem.memberName}';
		var buyerTel = '${sMem.phone}';
		var buyerAddr = $('#address1').val() + " " + $('#address2').val();
		var buyerPostCode = $('#zipcode').val();
		var allProdName = '${allProdName}';

		var nowDate = new Date();
		var accExprieDate = nowDate.getFullYear() + "-"
				+ (nowDate.getMonth() + 1) + "-" + (nowDate.getDate() + 5);

		var prodPrice = Number(uncomma($('#total-prod').text()));
		//배송비
		var totalDeliveryFee = Number(uncomma($('#total-del').text()));
		//할인가격
		var totalDiscount = Number(uncomma($('#total-dis').text()));
		//포인트
		var usedPoint = Number(uncomma($('#used-point').text()));
		//쿠폰
		var usedCoupon = Number(uncomma($('#used-coupon').text()));
		//결제금액
		var totalPrice = Number(uncomma($('#total-pay').text()));

		$('[name=prodPrice]').val(prodPrice);
		$('[name=totalDeliveryFee]').val(totalDeliveryFee);
		$('[name=totalDiscount]').val(totalDiscount);
		$('[name=usedPoint]').val(usedPoint);
		$('[name=usedCoupon]').val(usedCoupon);
		$('[name=totalPrice]').val(totalPrice);
		
		//토스
		if(payMethod == 'to'){
			console.log("요기");
			var request = new XMLHttpRequest();

			request.open('POST', 'https://private-anon-8e0b89fbc2-tossbutton.apiary-mock.com/transfer-web/linkgen-api/link');

			request.setRequestHeader('Content-Type', 'application/json');

			request.onreadystatechange = function () {
			  if (this.readyState === 4) {
			    console.log('Status:', this.status);
			    console.log('Headers:', this.getAllResponseHeaders());
			    console.log('Body:', this.responseText);
			  }
			};


			var body = {
	/* 		  'apiKey': 'sk_test_w5lNQylNqa5lNQe013Nq', */
			  'bankName': '기업',
			  'bankAccountNo': '21604828802016',
			  'amount': 15000,
			  'message': '토스입금버튼'
			};

			request.send(JSON.stringify(body));
		}
		//카카오페이
		if (payMethod == 'ka') {
			BootPay
					.request({
						price : payPrice, //실제 결제되는 가격
						application_id : "5e8580d902f57e0036d63afd",
						name : name, //결제창에서 보여질 이름
						pg : 'kakao',
						method : 'easy', //결제수단, 입력하지 않으면 결제수단 선택부터 화면이 시작합니다.
						show_agree_window : 0, // 부트페이 정보 동의 창 보이기 여부
						items : [ {
							item_name : allProdName, //상품명
							qty : qty, //수량
							unique : '123', //해당 상품을 구분짓는 primary key
							price : payPrice
						//상품 단가
						/* 				cat1: 'TOP', // 대표 상품의 카테고리 상, 50글자 이내
										cat2: '티셔츠', // 대표 상품의 카테고리 중, 50글자 이내
										cat3: '라운드 티', // 대표상품의 카테고리 하, 50글자 이내 */
						} ],
						user_info : {
							username : buyerName,
							email : buyerEmail,
							addr : buyerPostCode + " " + buyerAddr,
							phone : buyerTel
						},
						order_id : 'igrePay_' + new Date().getTime(), //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
						params : {
							callback1 : '그대로 콜백받을 변수 1',
							callback2 : '그대로 콜백받을 변수 2',
							customvar1234 : '변수명도 마음대로'
						},
						account_expire_at : '2018-05-25' // 가상계좌 입금기간 제한 ( yyyy-mm-dd 포멧으로 입력해주세요. 가상계좌만 적용됩니다. )
					})
					.error(function(data) {
						//결제 진행시 에러가 발생하면 수행됩니다.
						console.log(data);
					})
					.cancel(function(data) {
						//결제가 취소되면 수행됩니다.
						console.log(data);
					})
					.ready(function(data) {
						// 가상계좌 입금 계좌번호가 발급되면 호출되는 함수입니다.
						console.log(data);
					})
					.confirm(function(data) {
						//결제가 실행되기 전에 수행되며, 주로 재고를 확인하는 로직이 들어갑니다.
						//주의 - 카드 수기결제일 경우 이 부분이 실행되지 않습니다.
						console.log(data);
						var enable = true; // 재고 수량 관리 로직 혹은 다른 처리
						if (enable) {
							BootPay.transactionConfirm(data); // 조건이 맞으면 승인 처리를 한다.
						} else {
							BootPay.removePaymentWindow(); // 조건이 맞지 않으면 결제 창을 닫고 결제를 승인하지 않는다.
						}
					})
					.close(function(data) {
						// 결제창이 닫힐때 수행됩니다. (성공,실패,취소에 상관없이 모두 수행됨)
						console.log(data);
					})
					.done(
							function(data) {
								//결제가 정상적으로 완료되면 수행됩니다
								//비즈니스 로직을 수행하기 전에 결제 유효성 검증을 하시길 추천합니다.
								console.log(data);

								var finishPayment = "${pageContext.request.contextPath}/shop/order/finishPayment.do";
								document.checkOutFrm.action = finishPayment;
								document.checkOutFrm.submit();
							});
		}
		//무통장입금
		if (payMethod == 'ac') {
			BootPay
					.request({
						price : payPrice, //실제 결제되는 가격
						application_id : "5e8580d902f57e0036d63afd",
						name : name, //결제창에서 보여질 이름
						pg : 'nicepay',
						method : 'vbank', //결제수단, 입력하지 않으면 결제수단 선택부터 화면이 시작합니다.
						show_agree_window : 0, // 부트페이 정보 동의 창 보이기 여부
						items : [ {
							item_name : allProdName, //상품명
							qty : qty, //수량
							unique : '123', //해당 상품을 구분짓는 primary key
							price : payPrice
						//상품 단가
						/* 				cat1: 'TOP', // 대표 상품의 카테고리 상, 50글자 이내
										cat2: '티셔츠', // 대표 상품의 카테고리 중, 50글자 이내
										cat3: '라운드 티', // 대표상품의 카테고리 하, 50글자 이내 */
						} ],
						user_info : {
							username : buyerName,
							email : buyerEmail,
							addr : buyerPostCode + " " + buyerAddr,
							phone : buyerTel
						},
						order_id : '고유order_id_1234', //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
						params : {
							callback1 : '그대로 콜백받을 변수 1',
							callback2 : '그대로 콜백받을 변수 2',
							customvar1234 : '변수명도 마음대로'
						},
						account_expire_at : accExprieDate, // 가상계좌 입금기간 제한 ( yyyy-mm-dd 포멧으로 입력해주세요. 가상계좌만 적용됩니다. )
						extra : {
							vbank_result : 0
						// 가상계좌 사용시 사용, 가상계좌 결과창을 볼지(1), 말지(0), 미설정시 봄(1)

						}
					})
					.error(function(data) {
						//결제 진행시 에러가 발생하면 수행됩니다.
						console.log(data);
					})
					.cancel(function(data) {
						//결제가 취소되면 수행됩니다.
						console.log(data);
					})
					.ready(
							function(data) {
								// 가상계좌 입금 계좌번호가 발급되면 호출되는 함수입니다.

								console.log(data);

								$('[name=bankName]').val(data.bankname);
								$('[name=accountNo]').val(data.account);
								$('[name=accountHolder]').val(data.accounthodler);
								$('[name=expireDate]').val(data.expiredate);
								console.log("accountNo="+data.account);
								var finishPayment = "${pageContext.request.contextPath}/shop/order/finishPayment.do";
								 document.checkOutFrm.action = finishPayment;
								document.checkOutFrm.submit();

							}).confirm(function(data) {

						//결제가 실행되기 전에 수행되며, 주로 재고를 확인하는 로직이 들어갑니다.
						//주의 - 카드 수기결제일 경우 이 부분이 실행되지 않습니다.
						console.log(data);
						var enable = true; // 재고 수량 관리 로직 혹은 다른 처리
						if (enable) {

							BootPay.transactionConfirm(data); // 조건이 맞으면 승인 처리를 한다.

						} else {
							BootPay.removePaymentWindow(); // 조건이 맞지 않으면 결제 창을 닫고 결제를 승인하지 않는다.
						}
					}).close(function(data) {
						// 결제창이 닫힐때 수행됩니다. (성공,실패,취소에 상관없이 모두 수행됨)
						console.log(data);
						console.log("여기오나2");

					}).done(function(data) {

						//결제가 정상적으로 완료되면 수행됩니다
						//비즈니스 로직을 수행하기 전에 결제 유효성 검증을 하시길 추천합니다.
						console.log(data);

					});
		}
		//실시간계좌이체
		if (payMethod == 'ra') {
			BootPay
					.request({
						price : payPrice, //실제 결제되는 가격
						application_id : "5e8580d902f57e0036d63afd",
						name : name, //결제창에서 보여질 이름
						pg : 'nicepay',
						method : 'bank', //결제수단, 입력하지 않으면 결제수단 선택부터 화면이 시작합니다.
						show_agree_window : 0, // 부트페이 정보 동의 창 보이기 여부
						items : [ {
							item_name : allProdName, //상품명
							qty : qty, //수량
							unique : '123', //해당 상품을 구분짓는 primary key
							price : payPrice
						//상품 단가
						/* 				cat1: 'TOP', // 대표 상품의 카테고리 상, 50글자 이내
										cat2: '티셔츠', // 대표 상품의 카테고리 중, 50글자 이내
										cat3: '라운드 티', // 대표상품의 카테고리 하, 50글자 이내 */
						} ],
						user_info : {
							username : buyerName,
							email : buyerEmail,
							addr : buyerPostCode + " " + buyerAddr,
							phone : buyerTel
						},
						order_id : '고유order_id_1234', //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
						params : {
							callback1 : '그대로 콜백받을 변수 1',
							callback2 : '그대로 콜백받을 변수 2',
							customvar1234 : '변수명도 마음대로'
						},
						account_expire_at : '2018-05-25'// 가상계좌 입금기간 제한 ( yyyy-mm-dd 포멧으로 입력해주세요. 가상계좌만 적용됩니다. )
					})
					.error(function(data) {
						//결제 진행시 에러가 발생하면 수행됩니다.
						console.log(data);
					})
					.cancel(function(data) {
						//결제가 취소되면 수행됩니다.
						console.log(data);
					})
					.ready(function(data) {
						// 가상계좌 입금 계좌번호가 발급되면 호출되는 함수입니다.
						console.log(data);
					})
					.confirm(function(data) {
						//결제가 실행되기 전에 수행되며, 주로 재고를 확인하는 로직이 들어갑니다.
						//주의 - 카드 수기결제일 경우 이 부분이 실행되지 않습니다.
						console.log(data);
						var enable = true; // 재고 수량 관리 로직 혹은 다른 처리
						if (enable) {
							BootPay.transactionConfirm(data); // 조건이 맞으면 승인 처리를 한다.
						} else {
							BootPay.removePaymentWindow(); // 조건이 맞지 않으면 결제 창을 닫고 결제를 승인하지 않는다.
						}
					})
					.close(function(data) {
						// 결제창이 닫힐때 수행됩니다. (성공,실패,취소에 상관없이 모두 수행됨)
						console.log(data);
					})
					.done(
							function(data) {
								//결제가 정상적으로 완료되면 수행됩니다
								//비즈니스 로직을 수행하기 전에 결제 유효성 검증을 하시길 추천합니다.
								console.log(data);
								var finishPayment = "${pageContext.request.contextPath}/shop/order/finishPayment.do";
								document.checkOutFrm.action = finishPayment;
								document.checkOutFrm.submit();
							});
		}
		//핸드폰결제
		if (payMethod == 'ph') {
			BootPay
					.request({
						price : payPrice, //실제 결제되는 가격
						application_id : "5e8580d902f57e0036d63afd",
						name : name, //결제창에서 보여질 이름
						pg : 'mobilians',
						method : 'phone', //결제수단, 입력하지 않으면 결제수단 선택부터 화면이 시작합니다.
						show_agree_window : 0, // 부트페이 정보 동의 창 보이기 여부
						items : [ {
							item_name : allProdName, //상품명
							qty : qty, //수량
							unique : '123', //해당 상품을 구분짓는 primary key
							price : payPrice
						//상품 단가
						} ],
						user_info : {
							username : buyerName,
							email : buyerEmail,
							addr : buyerPostCode + " " + buyerAddr,
							phone : buyerTel
						},
						order_id : '고유order_id_1234', //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
						params : {
							callback1 : '그대로 콜백받을 변수 1',
							callback2 : '그대로 콜백받을 변수 2',
							customvar1234 : '변수명도 마음대로'
						},
						account_expire_at : '2018-05-25', // 가상계좌 입금기간 제한 ( yyyy-mm-dd 포멧으로 입력해주세요. 가상계좌만 적용됩니다. )
					})
					.error(function(data) {
						//결제 진행시 에러가 발생하면 수행됩니다.
						console.log(data);
					})
					.cancel(function(data) {
						//결제가 취소되면 수행됩니다.
						console.log(data);
					})
					.ready(function(data) {
						// 가상계좌 입금 계좌번호가 발급되면 호출되는 함수입니다.
						console.log(data);
					})
					.confirm(function(data) {
						//결제가 실행되기 전에 수행되며, 주로 재고를 확인하는 로직이 들어갑니다.
						//주의 - 카드 수기결제일 경우 이 부분이 실행되지 않습니다.
						console.log(data);
						var enable = true; // 재고 수량 관리 로직 혹은 다른 처리
						if (enable) {
							BootPay.transactionConfirm(data); // 조건이 맞으면 승인 처리를 한다.
						} else {
							BootPay.removePaymentWindow(); // 조건이 맞지 않으면 결제 창을 닫고 결제를 승인하지 않는다.
						}
					})
					.close(function(data) {
						// 결제창이 닫힐때 수행됩니다. (성공,실패,취소에 상관없이 모두 수행됨)
						console.log(data);
					})
					.done(
							function(data) {
								//결제가 정상적으로 완료되면 수행됩니다
								//비즈니스 로직을 수행하기 전에 결제 유효성 검증을 하시길 추천합니다.
								console.log(data);

								var finishPayment = "${pageContext.request.contextPath}/shop/order/finishPayment.do";
								document.checkOutFrm.action = finishPayment;
								document.checkOutFrm.submit();
							});
		}
		//네이버페이
		if (payMethod == 'na') {
			var oPay = Naver.Pay
					.create({
						"mode" : "production", // development or production
						"clientId" : "u86j4ripEt8LRfPGzQ8", // clientId
						"onAuthorize" : function(oData) {

							if (oData.resultCode === "Success") {
								// 네이버페이 결제 승인 요청 처리

								var finishPayment = "${pageContext.request.contextPath}/shop/order/finishPayment.do";
								document.checkOutFrm.action = finishPayment;
								document.checkOutFrm.submit();
							} else {
								// 필요 시 oData.resultMessage 에 따라 적절한 사용자 안내 처리
							}
						}
					});
			//총 상품 금액
			var prodPrice = Number(uncomma($('#total-prod').text()));
			//배송비
			var totalDeliveryFee = Number(uncomma($('#total-del').text()));
			//할인가격
			var totalDiscount = Number(uncomma($('#total-dis').text()));
			//포인트
			var usedPoint = Number(uncomma($('#used-point').text()));
			//쿠폰
			var usedCoupon = Number(uncomma($('#used-coupon').text()));
			//결제금액
			var totalPrice = Number(uncomma($('#total-pay').text()));
			var finishPayment = "${pageContext.request.contextPath}/shop/order/finishPayment.do?totalPrice="
					+ totalPrice
					+ "&prodPrice="
					+ prodPrice
					+ "&totalDiscount="
					+ totalDiscount
					+ "&usedPoint="
					+ usedPoint
					+ "&usedCoupon="
					+ usedCoupon
					+ "&totalDeliveryFee=" + totalDeliveryFee;

			oPay.open({
				"merchantUserKey" : "bbbbb",
				"merchantPayKey" : "aaaa",
				"productName" : name,
				"totalPayAmount" : payPrice,
				"taxScopeAmount" : payPrice,
				"taxExScopeAmount" : "0",
				"returnUrl" : finishPayment
			});

		}
		//신용카드결제

		if (payMethod == 'cr') {
			var IMP = window.IMP; // 생략가능
			IMP.init('iamport');

			IMP.request_pay(
							{
								pg : 'inicis', // version 1.1.0부터 지원.
								pay_method : 'card',
								merchant_uid : 'igrePay_'
										+ new Date().getTime(),
								name : name,
								amount : payPrice,
								buyer_email : buyerEmail,
								buyer_name : buyerName,
								buyer_tel : buyerTel,
								buyer_addr : buyerAddr,
								buyer_postcode : buyerPostCode,
								m_redirect_url : 'https://www.yourdomain.com/payments/complete'
							},
							function(rsp) {
								if (rsp.success) {
									var msg = '결제가 완료되었습니다.';
									/* 	                msg += '고유ID : ' + rsp.imp_uid;
									 msg += '상점 거래ID : ' + rsp.merchant_uid;
									 msg += '결제 금액 : ' + rsp.paid_amount;
									 msg += '카드 승인번호 : ' + rsp.apply_num; */
									var finishPayment = "${pageContext.request.contextPath}/shop/order/finishPayment.do";
									document.checkOutFrm.action = finishPayment;
									document.checkOutFrm.submit();

								} else {
									var msg = '결제에 실패하였습니다.';
									msg += '에러내용 : ' + rsp.error_msg;
								}
								alert(msg);
							});
		}

	}
</script>





<!-- bootpay 테스트  -->
<!--  <input type="button" id="phoneBtn" value="핸드폰 결제 버튼">  -->

<!-- Shopping Cart Section End -->


<jsp:include page="/WEB-INF/views/shop/common/footer.jsp" />

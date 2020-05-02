<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/shop/common/header.jsp" />

<!--product view js -->
<script
	src="${pageContext.request.contextPath }/resources/js/shop/productView.js"></script>
<!--product view css-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/shop/productView.css"
	type="text/css"></link>
<style>
img.review-modal__form__product__image {
	border: 2px solid #cbc4c4;
	padding: 5px;
}

.dropdown-wrap.select .btn-sel-option {
	width: 100%;
	height: 38px;
	padding: 10px 15px 10px 15px;
	vertical-align: top;
	color: #000;
	background: #fff
		url(${pageContext.request.contextPath }/resources/images/ui/ui_select_arr.png)
		right center no-repeat;
	cursor: pointer;
	line-height: 16px;
	border: solid 1px #ddd;
	text-align: left;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.fa-star:before {
	content: "";
	background-image:
		url('${pageContext.request.contextPath }/resources/images/star/star.png');
	background-size: 20px 20px;
	width: 20px;
	height: 20px;
	display: inline-block;
}

.fa-star-o:before {
	content: "";
	background-image:
		url('${pageContext.request.contextPath }/resources/images/star/star-o.png');
	background-size: 18px 18px;
	width: 18px;
	height: 18px;
	display: inline-block;
	margin-bottom: 1px;
}

span.optVal1 {
	color: #FF5722;
	font-weight: 500;
}

span.opt-price {
	float: right;
}

span.optNm2 {
	color: #FF5722;
	font-weight: 500;
}

.modal-header {
	border: 0;
}

.modal-footer {
	border: 0;
}

#cart-modal h5 {
	padding-bottom: 34px;
}

.avatar-text.col-lg-8 {
	padding-top: 20px;
	padding-bottom: 20px;
}

.sold-out-btn {
	color: red !important;
}
button.heart-icon {
    border: 0;
    background-color: transparent;
}
</style>
<script>
function addOpt2(optVal1) {
	console.log("optVal1="+optVal1)
	 var dataOpt1 = new Array();
	<c:forEach items="${optionValue1}" var ="item">
		dataOpt1.push("${item}");
	</c:forEach>
	var dataOpt2 = new Array();
	<c:forEach items="${optionValue2}" var ="item">
		dataOpt2.push("${item}");
	</c:forEach>
	var dataOptList = new Array();
	<c:forEach items="${optionList}" var ="item">
		var optItem = new Object();
		optItem.optionId = "${item.optionId}";
		optItem.optionName = "${item.optionName}";
		optItem.optionValue = "${item.optionValue}";
		optItem.optionStock = "${item.optionStock}";
		optItem.optionPrice = "${item.optionPrice}";
		dataOptList.push(optItem);
	</c:forEach>
	var dataResultOption = new Array();

	
	var idx=0;
	var t=0;
	var optPriceArr = new Array();
	var optValueArr = new Array();
	var optStockArr = new Array();
	var optIdArr = new Array();
	
	var discountPrice = Number("${p.discountPrice}");
	for( idx ; idx<dataOpt1.length;idx++){
		for( t ; t<dataOpt2.length;t++){
			var resultOption = optVal1+','+dataOpt2[t];
			 for (var a=0; a<dataOptList.length;a++) {
				if(resultOption == dataOptList[a].optionValue){
					optPriceArr.push(Number(dataOptList[a].optionPrice)-discountPrice);
					optValueArr.push(dataOpt2[t]);
					optStockArr.push(dataOptList[a].optionStock);
					optIdArr.push(dataOptList[a].optionId);
				}
				
			} 
		}
	}

	$('span.optVal1').remove();
	$('#btn-sel-option1').toggleClass("open").next(".dropdown-cont").toggleClass("open");
	var optValHtml = '<span class="optVal1">' + optVal1 + '</span>';
	$('#btn-sel-option1').append(optValHtml);
	
	var data = [ { 
		"optVal1" :   optVal1,
		"optPriceArr" :  optPriceArr[0],
		"optValueArr" :   optValueArr[0],
		"optStockArr" :   optStockArr[0],
		"optIdArr" :   optIdArr[0]
		
	    },
	    { 
			"optVal1" :   optVal1,
			"optPriceArr" :  optPriceArr[1],
			"optValueArr" :   optValueArr[1],
			"optStockArr" :   optStockArr[1],
			"optIdArr" :   optIdArr[1]
			
		  },
		  { 
				"optVal1" :   optVal1,
				"optPriceArr" :  optPriceArr[2],
				"optValueArr" :   optValueArr[2],
				"optStockArr" :   optStockArr[2],
				"optIdArr" :   optIdArr[2]
				
			  },
			  { 
					"optVal1" :   optVal1,
					"optPriceArr" :  optPriceArr[3],
					"optValueArr" :   optValueArr[3],
					"optStockArr" :   optStockArr[3],
					"optIdArr" :   optIdArr[3]
					
				  }
		    
	    
	    ];
	var template = $.templates("#itemTmplOption2");
	var htmlOutput = template.render(data);
	$('#opt2-list .item').remove();
	$("#opt2-list").append(htmlOutput);
	
	//optionValue가 없을 때
	if(dataOpt2 == ""){
	

		var optId="";
		var optPrice=0;
		var optNm1="";
		var optStock=0;
		for(var vIdx =0; vIdx <dataOptList.length ; vIdx++){
			if(dataOptList[vIdx].optionValue == optVal1){
		
				optId = dataOptList[vIdx].optionId;
				optPrice = dataOptList[vIdx].optionPrice;
				optNm1 = dataOptList[vIdx].optionValue;
				optStock = dataOptList[vIdx].optionStock;
			}
		}
		var price = "${p.price-p.discountPrice}";
		var optPriceC = Number(optPrice) -Number('${p.discountPrice}');
		var data = [ {
			"optId" : optId,
			"optPrice" : optPriceC,
			"optPriceC" : comma(optPriceC),
			"optNm" : optNm1,
			"optStock" : Number(optStock)
		} ];
		
		$('span.optNm2').remove();


		
		var template = $.templates("#itemTmplOption");
		var htmlOutput = template.render(data);
		$("#selected-option").append(htmlOutput);
		var prevPrice = Number(uncomma($('#totalPrice').text()))+Number(uncomma(optPriceC));
	   
		$('#totalPrice').text(comma(prevPrice));	
		
		
		
	}

}
</script>

<script>
	function addOption(optId, optPrice, optNm1, optNm2, optStock) {
		var price = "${p.price-p.discountPrice}";

		var data = [ {
			"optId" : optId,
			"optPrice" : Number(optPrice),
			"optPriceC" : comma(optPrice),
			"optNm" : optNm1+"/"+optNm2,
			"optStock" : Number(optStock)
		} ];
		
		$('span.optNm2').remove();
		$('#btn-sel-option2').toggleClass("open").next(".dropdown-cont").toggleClass("open");
		var optValHtml = '<span class="optNm2">' + optNm2 + '</span>';
		$('#btn-sel-option2').append(optValHtml);
		
		var template = $.templates("#itemTmplOption");
		var htmlOutput = template.render(data);
		$("#selected-option").append(htmlOutput);
		
		var prevPrice = Number(uncomma($('#totalPrice').text()))+Number(uncomma(optPrice));
	
		$('#totalPrice').text(comma(prevPrice));			
		
	
	}
</script>
<script>
	function optDelete(t) {
		var rePrice = Number(uncomma($('#totalPrice').text()))-Number(uncomma($(t).parent().parent().find('.optPrice').text()));
		$('#totalPrice').text(comma(rePrice));
		$(t).parent().parent().remove();
	}
</script>
<script>
//수량체크
	function dec(t, optPrice) {
		
		var num = Number($(t).parent('div').find('[name=count]').val());
		if (num == 1) {
			alert('더이상 줄일수 없습니다.');
			num = 1;
		} else if (num > 1) {
			num--;
			$(t).parent('div').find('[name=count]').val(num);
			var resultOptPrice = Number(uncomma(optPrice)) * num;
			var prevPrice = Number(uncomma($('#totalPrice').text()))-Number(uncomma(optPrice));
		     $(t).parent().parent().parent().parent().parent().find('.optPrice').text(comma(resultOptPrice));
		    $('#totalPrice').text(comma(prevPrice));	
		}
		

	}
	function inc(t, optPrice) {

		var num = Number($(t).parent('div').find('[name=count]').val());
	
		if (num >= $(t).parent('div').find('[name=count]').attr('max')) {

			alert('더이상 늘릴수 없습니다.');

		} else if (num < $(t).parent('div').find('[name=count]').attr('max')) {
			num++;
			
			
			var resultOptPrice = Number(uncomma(optPrice)) * num;
			var prevPrice = Number(uncomma($('#totalPrice').text()))+Number(uncomma(optPrice));	
			$(t).parent().parent().parent().parent().parent().find('.optPrice').text(comma(resultOptPrice));	
			$('#totalPrice').text(comma(prevPrice));
		}
		$(t).parent('div').find('[name=count]').val(num);
	

	}
</script>

<script>
function detailSubmit(index){
	//장바구니 버튼클릭시 장바구니 등록
	if(index == 1){
		 <c:if test="${p.productStock eq 0 }">
			alert("품절 상품입니다.");
			return;
		 </c:if>
		<c:if test="${empty memberLoggedIn}">
			alert("로그인 후 이용가능합니다.");
			return;
		</c:if>
		var totalPrice = Number(uncomma($('#totalPrice').text()));
		if(totalPrice==0){
			alert("상품을 선택해 주세요.");
			return;
		}
		 var optionIdArr = [];
		 if($('.opt-id-val').val()!=null){
	         $('.opt-id-val').each(function(i){//체크된 리스트 저장
	    		optionIdArr.push($(this).val()); 
	         	console.log("이거는="+$(this).val());
	          });		 
		 }        
		 var countArr = [];
         $('[name=count]').each(function(i){//체크된 리스트 저장
        	 countArr.push($(this).val());
         	console.log("이거는="+$(this).val());
          }); 
		
		var objParams = {
			"memberId" : $("[name=memberId]").val(),
			"optionIdList" : optionIdArr,
			"countList" : countArr
		} 
		$.ajax({
		    type : 'POST',
		    dataType : "json",
			url:"${pageContext.request.contextPath}/shop/myShopping/cartInsert.do",
			 data : objParams,
			success: function(retVal){
                    console.log(retVal.message);
                    $('#cart-modal').modal('show');
                 
            },
			error:(x,s,e)=>{
				console.log(x,s,e);
			}
		}); 
	
	
	}
	//바로구매하기
	if(index==2){
		 <c:if test="${p.productStock eq 0 }">
			alert("품절 상품입니다.");
			return;
		 </c:if>
		
		<c:if test="${empty memberLoggedIn}">
		alert("로그인 후 이용가능합니다.");
		return;
		</c:if>
		var totalPrice = Number(uncomma($('#totalPrice').text()));
		if(totalPrice==0){
			alert("상품을 선택해 주세요.");
			return;
		}
		document.detailFrm.action='${pageContext.request.contextPath }/shop/order/checkOut.do';
		document.detailFrm.submit();
		
	}
}

</script>
<script>
//장바구니보러가기
function goCart(){	
	location.href="${pageContext.request.contextPath }/shop/myShopping/cart.do";
}
</script>
<script>
//상품문의하기
function goQnA(){
	
	document.qaFrm.action='${pageContext.request.contextPath }/shop/QnA/writeQnA.do';
	document.qaFrm.submit();
	alert("문의가 접수되었습니다. 빠른시일내에 답변드리겠습니다^^");
	 
}
//문의하기 모달 창 띄우기
function goQmodal(){
	<c:if test="${empty memberLoggedIn}">
	alert("로그인 후 이용가능합니다.");
	return;
	</c:if>
	
	$('#qNaModal').modal();
}
</script>
<script>
$(function(){
    $("label.rating-input__star").on("click",function(){
        $(this).parent().children("label").removeClass("selected").children('i').addClass("fa-star-o"); 
        $(this).addClass("selected").prevAll("label").addClass("selected").children('i').removeClass("fa-star-o").addClass("fa-star");
        $(this).children("i").removeClass("fa-star-o").addClass("fa-star"); 
        $(this).children("input:radio[name='starPoint']").prop('checked', true); 
        return false;
    })
})
</script>
<script>
//찜하기 등록 및 업데이트
function goWish(productId, t){
	<c:if test="${empty memberLoggedIn}">
	alert("로그인 후 이용가능합니다.");
	return;
	</c:if>
	

	var objParams = {
			"productId" : productId
	} 
	$.ajax({
		url: "${pageContext.request.contextPath}/shop/wish/wishUpdate.do",
		type: "POST",
		dataType : "json",
		data: objParams,
		success: function (data) {
			
			if( data.wishCheck == 'Y'){
				console.log("레드");
				$(t).find('.heart-img').remove();
				var redHeart = '<img class="heart-img" src="${pageContext.request.contextPath }/resources/images/shop/icon/heart-icon-p.png" style="width: 30px;">';
				$(t).append(redHeart);
			}else if( data.wishCheck == 'N'){
				console.log("화이트");
				$(t).find('.heart-img').remove();
				var whiteHeart = '<img  class="heart-img" src="${pageContext.request.contextPath }/resources/images/shop/icon/heart-icon.png" style="width: 30px;">';
				$(t).append(whiteHeart); 
			}
		
				
		},
		error:(x,s,e)=>{
			console.log(x,s,e);
		}
	}); 
}
</script>
<script>
//도움이 돼요 버튼
function reviewReco(reviewId, t){
	
	<c:if test="${empty memberLoggedIn}">
	alert("로그인 후 이용가능합니다.");
	return;
	</c:if>
	//리뷰 도움돼요  업뎅이트
	var objParams = {
			"reviewId" : reviewId
	} 
	$.ajax({
		url: "${pageContext.request.contextPath}/shop/review/reivewRecoUpdate.do",
		type: "POST",
		dataType : "json",
		data: objParams,
		success: function (data) {
			
			if( data.recoCheck == 'Y'){
				$(t).css('background-color','green');
				$(t).css('color','white');
			}else if( data.recoCheck == 'N'){
				$(t).css('background-color','white');
				$(t).css('color','green');			
			}
			$(t).next().find('.recoCount').text(comma(data.reviewRecommen));
				
		},
		error:(x,s,e)=>{
			console.log(x,s,e);
		}
	}); 
}
</script>
<script>
$(function(){
	$("#dec-button").prev().hide();
	$("#inc-button").next().hide();
});
</script>
<!-- Breadcrumb Section Begin -->
<div class="breacrumb-section">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb-text product-more">
					<a href="./home.html"><i class="fa fa-home"></i> Home</a> <a
						href="./shop.html">Shop</a> <span>Detail</span>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Breadcrumb Section Begin -->
<!-- contents begin-->
<div class="container">
	<!-- Product Shop Section Begin -->
	<section class="product-shop spad page-details">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="row">
						<div class="col-lg-6">
							<div class="product-pic-zoom">
								<c:if
									test="${fn:contains(attachList.get(0).originalImg, 'http://')}">
									<img class="product-big-img"
										src="${attachList.get(0).originalImg}" alt="">
								</c:if>
								<c:if test="${fn:contains(p.productId, 'p')}">
									<c:forEach var="attach" items="${attachList}" varStatus="vs">
										<c:if test='${ "R" eq attach.imgType}'>
											<img class="product-big-img"
												src="${pageContext.request.contextPath}/resources/upload/shop/productMainImg/${attach.renamedImg}"
												alt="">

										</c:if>
									</c:forEach>
								</c:if>
								<div class="zoom-icon">
									<i class="fa fa-search-plus"></i>
								</div>
							</div>
							<div class="product-thumbs">
								<div class="product-thumbs-track ps-slider owl-carousel">
									<c:forEach var="attach" items="${attachList}" varStatus="vs">
										<c:if test='${ "R" eq attach.imgType}'>
											<div class="pt active"
												data-imgbigurl="${pageContext.request.contextPath}/resources/upload/shop/productMainImg/${attach.renamedImg}">
												<img
													src="${pageContext.request.contextPath}/resources/upload/shop/productMainImg/${attach.renamedImg}"
													alt="">
											</div>
										</c:if>
									</c:forEach>
									<c:forEach var="attach" items="${attachList}" varStatus="vs">
										<c:if test='${ "D" eq attach.imgType}'>
											<div class="pt"
												data-imgbigurl="${pageContext.request.contextPath}/resources/upload/shop/productSubImg/${attach.renamedImg}">
												<img
													src="${pageContext.request.contextPath}/resources/upload/shop/productSubImg/${attach.renamedImg}"
													alt="">
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="product-details">
								<div class="pd-title">
									<span>${p.brandName }</span>
									<h3>${p.productName }</h3>
									<!-- wish가 없는경우 -->
									<c:if test="${empty wish }">
									<button class="heart-icon" onclick="goWish('${p.productId}',this);">
									<img class="heart-img" src="${pageContext.request.contextPath }/resources/images/shop/icon/heart-icon.png" style="width: 30px;">
									</button>
									</c:if>
									<!-- wish가 있는 경우 -->
									<c:if test="${not empty wish }">
										<c:if test="${ wish.wishCheck eq 'Y'}">								
										<button class="heart-icon" onclick="goWish('${p.productId}',this);">
										<img class="heart-img" src="${pageContext.request.contextPath }/resources/images/shop/icon/heart-icon-p.png" style="width: 30px;">
										</button>
										</c:if>
										<c:if test="${ wish.wishCheck eq 'N'}">								
										<button class="heart-icon" onclick="goWish('${p.productId}',this);">
										<img class="heart-img" src="${pageContext.request.contextPath }/resources/images/shop/icon/heart-icon.png" style="width: 30px;">
										</button>
										</c:if>
									</c:if>
								</div>
								<div class="pd-rating">
									<c:if test="${tStar == 0}">
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
									</c:if>
									<c:if test="${tStar == 1}">
										<i class="fa fa-star"></i>
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
									</c:if>
									<c:if test="${tStar == 2}">
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
									</c:if>
									<c:if test="${tStar == 3}">
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star-o"></i>
										<i class="fa fa-star-o"></i>
									</c:if>
									<c:if test="${tStar == 4}">
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star-o"></i>
									</c:if>
									<c:if test="${tStar == 5}">
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
										<i class="fa fa-star"></i>
									</c:if>
									<span>(${avgStar })</span>
								</div>
								<div class="pd-desc">
									<h4>
										<c:set var="discountedPrice"
											value="${p.price-p.discountPrice}" />
										<fmt:formatNumber type="number" maxFractionDigits="3"
											value="${p.price-p.discountPrice}" />
										원 <span> <fmt:formatNumber type="number"
												maxFractionDigits="3" value="${p.price}" />원
										</span>
									</h4>
								</div>
								<hr>
								<ul class="pd-tags">
									<li><span>배송비</span> <fmt:formatNumber type="number"
											maxFractionDigits="3" value="${p.deliveryFee}" />원</li>
									<li><span>포인트</span> 최대 ${p.pointRate }% 적립</li>
								</ul>
								<hr>
								<div class="prd-option">
									<c:if test="${not empty optionName}">
										<c:forEach items="${optionName}" var="optNm" varStatus="vs1">
											<c:if test="${ vs1.index eq 0}">
												<div class="dropdown-wrap select fn-select"
													data-role="dropdown" data-effect="slide"
													style="z-index: 1;">
													<button type="button" id="btn-sel-option1"
														class="btn-sel-option fn-btn">
														${optNm}<span class="down-up-icon"></span>
													</button>
													<div class="dropdown-cont fn-cont right share-cont"
														data-width="550" style="width: 550px;"
														id="dropdown-menu-3" aria-hidden="true"
														aria-owns="dropdown-btn-3">
														<c:if test="${not empty optionValue1}">
															<c:forEach items="${optionValue1}" var="opt1"
																varStatus="vs">
																<ul class="option-list">
																	<li class="item"><c:forEach items="${optionList}"
																			var="item">
																			<c:if test="${item.optionValue ==opt1 }">
																				<c:set var="optionStock" value="${item.optionStock}" />
																			</c:if>
																		</c:forEach> <c:if test="${optionStock eq 0 }">
																			<!-- 가격 넘겨주기 addOption()  -->
																			<button class="btn-option sold-out-btn">${opt1}
																				<span class="sold-out-txt">[품절]</span>
																			</button>
																		</c:if> <c:if test="${optionStock  != 0 }">
																			<!-- 가격 넘겨주기 addOption()  -->
																			<button class="btn-option"
																				onclick="addOpt2('${opt1}');">${opt1}</button>
																			<c:set var="selectedOpt1" value="${opt1 }"
																				scope="page" />
																		</c:if></li>
																</ul>
															</c:forEach>
														</c:if>
													</div>
												</div>
											</c:if>

											<c:if test="${  vs1.index eq 1 }">
												<div class="dropdown-wrap select fn-select"
													data-role="dropdown" data-effect="slide"
													style="z-index: 1;">
													<button type="button" class="btn-sel-option fn-btn"
														id="btn-sel-option2">
														${optNm}<span class="down-up-icon"></span>
													</button>
													<div class="dropdown-cont fn-cont right share-cont"
														data-width="550" style="width: 550px;"
														id="dropdown-menu-opt2" aria-hidden="true"
														aria-owns="dropdown-btn-3">
														<ul class="option-list" id="opt2-list">
														</ul>
													</div>
												</div>
											</c:if>
										</c:forEach>
									</c:if>
									<script id="itemTmplOption2" type="text/x-jsrender"
										data-jsv-tmpl="jsvTmpl">
															
															{{if optValueArr}}
																{{if optStockArr ==0 }}
																	<li class="item">
																	<!-- 가격 넘겨주기 addOption()  --> 
																	<button class="btn-option" style="color:red;">{{:optValueArr}} [품절]<span class="opt-price">{{:optPriceArr}}</span></button>
																
																</li>
																{{/if}}
																{{if optStockArr >0 }}		
																<li class="item">
																	<!-- 가격 넘겨주기 addOption()  --> 
																	<button class="btn-option"
																	onclick="addOption({{:optIdArr}}, {{:optPriceArr}}, '{{:optVal1}}','{{:optValueArr}}','{{:optStockArr}}');">{{:optValueArr}}<span class="opt-price">{{:optPriceArr}}</span></button>
																
																</li>
																{{/if}}

															{{/if}}

												
									</script>
									<script id="itemTmplOption" type="text/x-jsrender"
										data-jsv-tmpl="jsvTmpl">
									
                                        <div class="option-box">
                                            <input type="hidden" name="optionId" class="opt-id-val" value="{{:optId}}"> 
                                            <input type="hidden" name="optionPrice"  value="{{:optPrice}}">
                                            <div class="sel-title">
                                                                                                        선택 : {{:optNm}}
                                                <button type="button" class="btn-option-delete" onclick="optDelete(this);"><span class="" style="color:#979696; margin: 0 auto;"><strong>X</strong></span></button>
                                            </div>
                                            
                                            <div class="option-info">
                                                <div class="fleft">
	
													<!--재고가 있는 경우-->
                                                    <!--수량체크-->
                                                    <div class="number-count fn-count">
                                                            <div class="quantity">
                                                                <div class="pro-qty">
																	<span class="dec qtybtn" onclick="dec(this,{{:optPrice}});">-</span>
                                                                    <input type="text" name="count"  value="1"  min="1" max="{{:optStock}}">
                                                               		<span class="inc qtybtn" onclick="inc(this,{{:optPrice}});">+</span>
																</div>
                                                            </div>
                                                        </div>
                                                </div>
                                                <div class="fright">
                                                    <div class="price-select">
                                                        <span class="number optPrice">{{:optPriceC}}</span><span class="unit">원</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
									
                                    </script>
									<form name="detailFrm" method='POST'
										enctype="multipart/form-data">
										<input type="hidden" name="memberId"
											value="${memberLoggedIn.memberId }">
										<!-- 선택정보영역 -->
										<div id="selected-option">

											<!-- 옵션이 없을 경우 -->
											<c:if test="${ empty optionList }">

												<div class="option-box">
													<div class="sel-title">선택 : ${p.productName}</div>

													<div class="option-info">
														<div class="fleft">
															<!--수량체크-->
															<c:if test="${p.productStock eq 0 }">
																<div class="number-count fn-count">품절 상품입니다.</div>
															</c:if>
															<c:if test="${p.productStock != 0 }">
																<div class="number-count fn-count">
																	<div class="quantity">
																		<div class="pro-qty">
																			<span class="dec qtybtn" id="dec-button"
																				onclick="dec(this,${discountedPrice});">-</span> <input
																				type="text" name="count" value="1" min="1"
																				max="${p.productStock }"> <span
																				class="inc qtybtn" id="inc-button"
																				onclick="inc(this,${discountedPrice});">+</span>
																		</div>
																	</div>
																</div>
															</c:if>
														</div>
														<div class="fright">
															<div class="price-select">
																<c:if test="${p.productStock != 0 }">
																	<span class="number optPrice"> <fmt:formatNumber
																			type="number" maxFractionDigits="3"
																			value="${discountedPrice}" /></span>
																	<span class="unit">원</span>
																</c:if>
																<c:if test="${p.productStock eq 0 }">
																	<span class="number optPrice"> <fmt:formatNumber
																			type="number" maxFractionDigits="3" value="0" /></span>
																	<span class="unit">원</span>
																</c:if>
															</div>
														</div>
													</div>
												</div>
											</c:if>

											<!--  옵션이 없을 경우 끝 -->
										</div>
									</form>
								</div>
								<div class="row">
									<div class="col">
										<div class="prd-price-total">
											<div class="fleft">
												<div class="tt-title">총 결제 예상 금액</div>
											</div>
											<div class="fright">
												<c:if test="${p.productStock eq 0 }">
													<div class="price-total" style="overflow: inherit;">
														<span class="number" id="totalPrice">0</span> <span
															class="unit">원</span>
													</div>
												</c:if>
												<c:if test="${p.productStock != 0 }">
													<div class="price-total" style="overflow: inherit;">
														<c:if test="${ empty optionList }">

															<span class="number" id="totalPrice"> <fmt:formatNumber
																	type="number" maxFractionDigits="3"
																	value="${discountedPrice}" />
															</span>
														</c:if>
														<c:if test="${ not empty optionList }">
															<span class="number" id="totalPrice">0</span>
														</c:if>
														<span class="unit">원</span>
													</div>
												</c:if>
											</div>
										</div>

									</div>
								</div>
								<div class="row">
									<div class="col-lg-6" style="padding: 0 5px 0 10px !important;">
										<input type="button" onclick="detailSubmit(1);"
											class="btn btn-outline-dark product-btn pd-cart" value="장바구니">
									</div>
									<div class="col-lg-6" style="padding: 0 5px 0 10px !important;">
										<input type="button" onclick="detailSubmit(2);"
											class="btn btn-outline-dark product-btn check-out"
											value="바로구매">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="product-tab">
						<div class="row">
							<div class="tab-item">
								<ul class="nav" role="tablist">
									<li><a class="active" data-toggle="tab" href="#tab-1"
										role="tab">상품상세정보</a></li>
									<li><a data-toggle="tab" href="#tab-3" role="tab">상품리뷰(${fn:length(reviewList)})</a>
									</li>
									<li><a data-toggle="tab" href="#tab-4" role="tab">상품Q&A(${fn:length(prodQnAList)})</a>
									</li>
								</ul>
							</div>

						</div>
						<div class="tab-item-content">
							<div class="tab-content">
								<div class="tab-pane fade-in active" id="tab-1" role="tabpanel">
									<div class="product-content">
										<div class="row">
											<div class="col-lg-12">${p.productDetail }</div>
										</div>
									</div>
								</div>
								<div class="tab-pane fade" id="tab-3" role="tabpanel">
									<div class="customer-review-option">
										<div class="row">
											<div class="mr-auto">
												<h4>상품리뷰(${fn:length(reviewList)})</h4>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-12">
												<div class="at-rating production-review-feed__header__stars">
													<div>
														<h5 style="text-align: center; margin-bottom: 20px;">사용자
															총 평점</h5>
													</div>
													<div>
														<c:if test="${tStar == 0}">
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
														</c:if>
														<c:if test="${tStar == 1}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
														</c:if>
														<c:if test="${tStar == 2}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
														</c:if>
														<c:if test="${tStar == 3}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
														</c:if>
														<c:if test="${tStar == 4}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o"></i>
														</c:if>
														<c:if test="${tStar == 5}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
														</c:if>
														<i class="total_stars"><strong>${avgStar}</strong>/5</i>
													</div>
												</div>

											</div>

										</div>
										<div class="row">

											<div class="production-review-feed__filter">
												<div class="production-review-feed__filter__order-list">
													<div>
														<button class="btn btn-outline-dark" type="button">베스트순</button>
														<button class="btn btn-outline-dark" type="button">최신순</button>
														<button class="btn btn-outline-dark " type="button">
															<svg class="icon" width="18" height="18"
																viewBox="0 0 18 18" preserveAspectRatio="xMidYMid meet">
                                                                <path
																	fill="currentColor"
																	d="M15.821 3a.67.67 0 0 1 .679.672v10.656a.67.67 0 0 1-.679.672H2.18a.67.67 0 0 
                                                                1-.679-.672V3.672c0-.375.3-.672.679-.672H15.82zm-.679 1.344H2.858v8.14L7.01 7.781c.094-.125.284-.125.394 
                                                                0l2.321 2.657c.048.046.063.109.048.156l-.3 1.375c-.016.11.11.172.173.094l2.369-2.579a.202.202 0 0 1 
                                                                .284 0l2.842 3.094V4.344zm-2.526 3.61a1.1 1.1 0 0 1-1.105-1.095
                                                                 1.1 1.1 0 0 1 1.105-1.093 1.1 1.1 0 0 1 1.105 1.093 1.1 1.1 0 0 1-1.105 1.094z">
                                                                </path>
                                                            </svg>
															사진리뷰
														</button>
														<!-- 	<div class="btn production-selling-section__right">
															<button type="button" data-toggle="modal"
																data-target="#writeReviewModal">리뷰쓰기</button>
														</div> -->
													</div>
												</div>
											</div>
										</div>
										<div class="comment-option">
											<c:if test="${ empty reviewList }">
												<div class="co-item row">
													<div class="col-lg-12 comment-user-info"
														style="text-align: center;">
														<h5>등록된 글이 없습니다.</h5>
													</div>
												</div>
											</c:if>
											<c:forEach var="review" items="${reviewList}"
												varStatus="reVs">
												<div class="co-item row">

													<div class="col-lg-3 comment-user-info">
														<h5 style="margin-bottom: 15px;">${review.reviewerId }</h5>
														<div class="at-rating">
															<c:if test="${review.starPoint == 1}">
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
															</c:if>
															<c:if test="${review.starPoint == 2}">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
															</c:if>
															<c:if test="${review.starPoint == 3}">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o"></i>
																<i class="fa fa-star-o"></i>
															</c:if>
															<c:if test="${review.starPoint == 4}">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o"></i>
															</c:if>
															<c:if test="${review.starPoint == 5}">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
															</c:if>
														</div>

														<c:forEach var="optName" items="${review.optionName}"
															varStatus="opN">
															<div>
																<span>${optName}</span>
															</div>
														</c:forEach>
														<span>${review.reviewDate }</span>
													</div>
													<div class="avatar-text col-lg-7">
														<p class="at-reply">${review.reviewContent }</p>
														<div class="production-review-item__help">
															<c:if test="${not empty recoList }">
																<c:forEach var="reco" items="${recoList}">
																	<c:if test="${reco.reviewId eq review.reviewId }">
																		<c:if test="${reco.recoCheck eq 'Y' }">
																			<button type="button"
																				style="background: green; color: white;"
																				class="production-review-item__help__btn btn btn-outline-success my-2 my-sm-0"
																				onclick="reviewReco('${review.reviewId}', this);">
																				도움이 돼요</button>
																		</c:if>
																		<c:if test="${reco.recoCheck eq 'N' }">
																			<button type="button"
																				class="production-review-item__help__btn btn btn-outline-success my-2 my-sm-0"
																				onclick="reviewReco('${review.reviewId}', this);">
																				도움이 돼요</button>
																		</c:if>
																		<c:if test="${empty reco.recoCheck }">
																			<button type="button"
																			class="production-review-item__help__btn btn btn-outline-success my-2 my-sm-0"
																			onclick="reviewReco('${review.reviewId}', this);">
																			도움이 돼요</button>
												
																		</c:if>
																	</c:if>
																</c:forEach>
															</c:if>
														
															<div class="production-review-item__help__text">
																<span
																	class="production-review-item__help__text__number recoCount">
																	<fmt:formatNumber type="number" maxFractionDigits="3"
																		value="${review.reviewRecommen}" />
																</span>명에게 도움이 되었습니다.
															</div>
														</div>
													</div>
													<div class="review-img col-lg-2 mb-2">
														<img
															src="${pageContext.request.contextPath}/resources/upload/shop/memberProdReview/${review.renamedImg}"
															alt="">
													</div>
												</div>
											</c:forEach>
										</div>
										<div class="modal fade" id="exampleModal" tabindex="-1"
											role="dialog" aria-labelledby="exampleModalLabel"
											aria-hidden="true">
											<div class="modal-dialog" role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="exampleModalLabel">New
															message</h5>
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														<form>
															<div class="form-group">
																<label for="recipient-name" class="col-form-label">Recipient:</label>
																<input type="text" class="form-control"
																	id="recipient-name">
															</div>
															<div class="form-group">
																<label for="message-text" class="col-form-label">Message:</label>
																<textarea class="form-control" id="message-text"></textarea>
															</div>
														</form>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-secondary"
															data-dismiss="modal">Close</button>
														<button type="button" class="btn btn-primary">Send
															message</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane fade" id="tab-4" role="tabpanel">
									<div class="customer-review-option">
										<div class="row" style="margin-bottom: 40px;">
											<div class="col-lg-12">
												<h4>상품Q&A(${fn:length(prodQnAList)})</h4>
											</div>
										</div>
										<div class="row" style="margin-bottom: 20px;">
											<div class=" col-lg-12 production-selling-section__right">
												<button type="button" data-toggle="modal"
													onclick="goQmodal();">상품문의하기</button>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-12">
												<table class="fold-table table table-sm">
													<thead>
														<tr>
															<th>번호</th>
															<th>답변상태</th>
															<th>제목</th>
															<th>문의자</th>
															<th>등록일</th>
															<th></th>
														</tr>
													</thead>
													<tbody>
														<c:if test="${ empty prodQnAList }">
															<tr class="">
																<td colspan="6"
																	style="text-align: center; padding: 40px 0;">
																	<h5>등록된 글이 없습니다.</h5>
																</td>
															</tr>
														</c:if>
														<!-- 문의 리스트 시작 -->
														<c:forEach var="QnA" items="${prodQnAList}"
															varStatus="qVs">

															<tr class="view">
																<td>${qVs.index+1 }</td>
																<c:if test="${QnA.qaState eq'N'}">
																	<td>검토중</td>
																</c:if>
																<c:if test="${QnA.qaState eq'Y'}">
																	<td>답변완료</td>
																</c:if>
																<c:if test="${QnA.setSecret eq'Y'}">
																	<c:if test="${QnA.qtnerId eq memberLoggedIn.memberId }">
																		<td><span class="secret-icon"> <img
																				src="${pageContext.request.contextPath }/resources/images/shop/icon/secret.png"
																				alt="">
																		</span> ${QnA.qtnTitle}</td>
																	</c:if>
																	<c:if test="${QnA.qtnerId != memberLoggedIn.memberId }">
																		<td><span class="secret-icon"> <img
																				src="${pageContext.request.contextPath }/resources/images/shop/icon/secret.png"
																				alt="">
																		</span> 비밀글입니다</td>
																	</c:if>
																</c:if>
																<c:if test="${QnA.setSecret eq 'N'}">
																	<td>${QnA.qtnTitle}</td>
																</c:if>
																<td>${QnA.qtnerId }</td>
																<td>${QnA.qtnDate }</td>
																<td></td>
															</tr>
															<c:if
																test="${QnA.setSecret == 'N' || (QnA.setSecret=='Y' && QnA.qtnerId eq memberLoggedIn.memberId)}">
																<tr class="fold">
																	<td colspan="6">
																		<div class="fold-content">
																			<div class="qt">
																				<span class="ic_qt"><img
																					src="${pageContext.request.contextPath }/resources/img/QnA/q-icon.png"
																					alt=""></span> ${QnA.qtnContent }
																			</div>
																			<c:if test="${QnA.qaState eq'Y'}">
																				<div class="as">
																					<span class="ic_as"><img
																						src="${pageContext.request.contextPath }/resources/img/QnA/a-icon.png"
																						alt=""></span>${QnA.adminAnswer.ansContent }
																				</div>
																				<p class="reginfo">
																					<span class="wh">판매자의 답변</span> <span class="date">등록일
																						: <em>${QnA.adminAnswer.ansDate }</em>
																					</span>
																				</p>
																			</c:if>
																		</div>
																	</td>
																</tr>
															</c:if>
														</c:forEach>
														<!-- 문의 리스트 끝-->
													</tbody>
												</table>

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
	</section>
	<!-- Product Shop Section End -->
	<!-- 장바구니 Modal  -->
	<div class="modal fade cart-modal" id="cart-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="text-align: center;">
					<h5 class="modal-title" id="exampleModalLabel">장바구니에 상품을 담았습니다</h5>
					<div style="padding-bottom: 15px;">
						<button type="button" class="btn btn-primary" onclick="goCart();">장바구니
							보기</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>


<!--  dkdkdkdkdkdk -->
	<!-- 문의하기 modal -->

	<div class="modal fade" id="qNaModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">상품 문의</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form name="qaFrm" method="post">
						<div class="form-group">
							<label for="QnA-title" class="col-form-label">제목</label> <input
								type="text" class="form-control" name="qtnTitle" id="QnA-title">
						</div>
						<div class="bc-item">
							<label for="bc-calvin"><input type="checkbox"
								id="bc-calvin" name="setSecret" value="Y"> 비밀글 설정<span
								class="checkmark"></span> </label>
						</div>
						<div class="form-group">
							<label for="QnA-text" class="col-form-label">문의 내용</label>
							<textarea class="form-control" name="qtnContent" id="QnA-text"
								placeholder="문의 내용을 입력하세요"></textarea>
						</div>
						<input type="hidden" name="qtnerId"
							value="${memberLoggedIn.memberId}" /> <input type="hidden"
							name="productId" value="${p.productId}" />
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" onclick="goQnA();">완료</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 문의하기 모달 끝 -->
</div>



<jsp:include page="/WEB-INF/views/shop/common/footer.jsp" />

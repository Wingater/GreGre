<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>

<!-- 헤더 선언!!-->
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script>
//전체 상담사 저장
var counselorR = [];
</script>

<c:forEach items="${list }" var="counselor">
<script>
counselorR.push(JSON.parse('${counselor}'));
</script>
</c:forEach> 

<script>
$(function(){
	function numberFormat(inputNumber) {
		   return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};
	
	$(".counselor-list").append("<div class='list-filter-wrapper'><span class='counselor-search-list-num' id=''>검색 결과 <em id='search-result-count'><strong>"+counselorR.length+"</strong></em>건</span></div>");
	
	let result = "<div class='counselor-list-wrapper'><div class='counselor-info-list'>";
	for(var i=0; i<counselorR.length; i++){
		result += "<article data-advis-id='"+counselorR[i].advisId+"'class='counselor-info'>";
		result += "<div class='counselor-info-name'><h3 class='counselor-name'>"+counselorR[i].advisName+" <span style='color: #48DA91;'>"+counselorR[i].advisGrade+" 상담사</span></h3>";
		result += "<p class='counselor-simple-greetings'>"+counselorR[i].advisLineIntro+"</p>";
		//<!-- 평점 -->
		result += "<div class='counselor-list-preview'><div class='star-score__wrap--middle'>";
		result += "<span class='star-rating-middle'><span style='width:"+counselorR[i].starPoint*20+"%'>&nbsp;</span></span>"
		result += "<div class='partner-list-box__review-score js-review-star-num'>"+counselorR[i].reviewTotal+"개의 리뷰</div></div></div></div>";
		//상담 이미지
		result += "<div class='counselor-img'><img src='${pageContext.request.contextPath }/resources/upload/member/"+counselorR[i].advisImg+"'alt='상담사 사진'></div>";
		//상담 유형
		result += "<div class='counselor-type'><div><ul class='counselor-type'><li class='counselling-type'>";
		for(var j=0; j<counselorR[i].advisKeyword.length; j++){
			result += (j!=counselorR[i].advisKeyword.length-1)?counselorR[i].advisKeyword[j]+",":counselorR[i].advisKeyword[j];
		}
		result += "</li></ul></div><div><p class='counselor-price'>"+numberFormat(counselorR[i].advisPrice)+"원~</p></div></div></article>";	
	}
	
	result += "</div></div>";
	
	$(".counselor-list").after(result);
	
});
$(function(){
	
	$(".counselor-search-input-box .search-form").on("keyup",function(){
		$(".counselor-list").html("");
		$(".counselor-list-wrapper").html("");
		$(".counselor-list-wrapper").remove();
	
		
		let name = $(this).val().trim();
		
		var nameChk = [];
		
		for(var i=0; i<counselorR.length; i++){
			if(counselorR[i].advisName.indexOf(name)!=-1){
				nameChk.push(counselorR[i]);
			}
		}
		console.log(nameChk);
		if(nameChk != null){
			
			function numberFormat(inputNumber) {
				   return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			};
			
			
			//페이지 동적 처리
			$(".counselor-list").empty();
			
			$(".counselor-list").append("<div class='list-filter-wrapper'><span class='counselor-search-list-num' id=''>검색 결과 <em id='search-result-count'><strong>"+nameChk.length+"</strong></em>건</span></div>");
			
			let result = "<div class='counselor-list-wrapper'><div class='counselor-info-list'>";
			
			for(var i=0; i<nameChk.length; i++){
				result += "<article data-advis-id='"+nameChk[i].advisId+"'class='counselor-info'>";
				result += "<div class='counselor-info-name'><h3 class='counselor-name'>"+nameChk[i].advisName+" <span style='color: #48DA91;'>"+nameChk[i].advisGrade+" 상담사</span></h3>";
				result += "<p class='counselor-simple-greetings'>"+nameChk[i].advisLineIntro+"</p>";
				//<!-- 평점 -->
				result += "<div class='counselor-list-preview'><div class='star-score__wrap--middle'>";
				result += "<span class='star-rating-middle'><span style='width:"+nameChk[i].starPoint*20+"%'>&nbsp;</span></span>"
				result += "<div class='partner-list-box__review-score js-review-star-num'>"+nameChk[i].reviewTotal+"개의 리뷰</div></div></div></div>";
				//상담 이미지
				result += "<div class='counselor-img'><img src='${pageContext.request.contextPath }/resources/upload/member/"+nameChk[i].advisImg+"'alt='상담사 사진'></div>";
				//상담 유형
				result += "<div class='counselor-type'><div><ul class='counselor-type'><li class='counselling-type'>";
				for(var j=0; j<nameChk[i].advisKeyword.length; j++){
					result += (j!=nameChk[i].advisKeyword.length-1)?nameChk[i].advisKeyword[j]+",":nameChk[i].advisKeyword[j];
				}
				result += "</li></ul></div><div><p class='counselor-price'>"+numberFormat(nameChk[i].advisPrice)+"원~</p></div></div></article>";	
			}
			
			result += "</div></div>";
			
			$(".counselor-list").after(result);
			
			
			$("article[data-advis-id]").on("click", function(){
				console.log("클릭함");
				let advisId = $(this).attr("data-advis-id");
				console.log(advisId);
				
				location.href = "${pageContext.request.contextPath}/counselling/bookingMain.do?advisId="+advisId;
			});
		}
		
		
	
		
	});
		
});
</script>
<style>
	.site-section-cover.overlay:before {
		width: 0;
		background-image: url();
	}
	.counselor-search-input-box button {
		width: 48px;
		height: 56px;
		position: absolute;
		left: 0;
		top: 0;
		background:
			url('${pageContext.request.contextPath}/resources/images/counselling/search.png')
			no-repeat 16px center;
		background-size: 24px auto;
		text-indent: -9999px;
	}
a {
	text-decoration: none;
}
	.star-rating {
    	width: 79px;
	}
        .star-rating-middle {
            width: 104px;
        }
        .star-rating-middle,
        .star-rating-middle span {
            display: inline-block;
            height: 20px;
            overflow: hidden;
            background: url(${pageContext.request.contextPath}/resources/images/counselling/star-middle.png)no-repeat;
        }
        .star-rating-middle span {
            background-position: left bottom;
            line-height: 0;
            vertical-align: top;
        }
</style>

<div class="ftco-blocks-cover-1">
	<div class="site-section-cover overlay"
		data-stellar-background-ratio="0.5"
		style="background-image: url('${pageContext.request.contextPath}/resources/images/counselling/counselling.jpg')">
		<div class="container">
			<div class="row align-items-center ">
				<div class="col-md-5 mt-5 pt-5">
					<h1 class="mb-3 font-weight-bold text-teal">상담사 찾기</h1>
					<p>
						<a href="${pageContext.request.contextPath}/" class="text-white">Home</a> <span
							class="mx-3">/</span> <strong>상담센터</strong>
					</p>
				</div>
			</div>
		</div>
	</div>
</div>


</head>
<!-- 여기부터 container -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/counselling/counselorFindStyle.css">

<div class="site-section">
	<div class="counselor-search-container">
		<div class="search-top-menu">홈 > 상담사 찾기</div>
		<!-- 상담사 검색필터 시작  -->
		<div class="counselor-filter">
			<!-- 상담사 검색창 시작-->
			<article class="counselor-filter-search">
				<h3 class="search-title">상담사 이름 검색</h3>
				<div class="counselor-search-input-box">
					<input type="search" class="search-form"
						id="counselor-search-input" placeholder="상담사 이름 검색">
				</div>
			</article>
			<!-- 상담사 검색창 끝 -->

			<!-- 고민 키워드 시작 -->
			<form id="filter">
			<article class="counselor-filter-search-keyword">
				<h3 class="keyword-title">나의 고민키워드</h3>
				<div class="problem-checkbox-wrapper">
					<label for="category-check1" class="level-checkbox0"> <input
						type="checkbox" name="category-check" id="category-check1" onclick="filter()" value="임신"> 임신
					</label> <label for="category-check2" class="level-checkbox0"> <input
						type="checkbox" name="category-check" id="category-check2" onclick="filter()" value="육아"> 육아
					</label>
				</div>
			</article>
			<!-- 고민 키워드 끝 -->

			<!-- 상담사 레벨, 성별 요일 선택 시작  -->
			<section class="counselor-detail-select">
				<h3 class="detail-select-title">상세조건</h3>
				<div class="counselor-detail-checkbox-wrapper">
					<h4>상담사 레벨</h4>
					<label for="type-level1" class="level-checkbox1"> <input
						type="checkbox" name="type-level" id="type-level1" onclick="filter()" value="마스터">마스터 상담사
						<div class="counselor-pay-level">50,000원 ~</div>
					</label> <label for="type-level2" class="level-checkbox1"> <input
						type="checkbox" name="type-level" id="type-level2" onclick="filter()" value="전문">전문 상담사
						<div class="counselor-pay-level">30,000원 ~</div>
					</label> <label for="type-level3" class="level-checkbox1"> <input
						type="checkbox" name="type-level" id="type-level3" onclick="filter()" value="일반">일반 상담사
						<div class="counselor-pay-level">15,000원 ~</div>
					</label>
				</div>
				<div class="counselor-detail-checkbox-wrapper">
					<h4>상담사 성별</h4>
					<label for="type-radio1" class="level-checkbox2"> <input
						type="radio" name="gender-check" id="type-radio1" onclick="filter()" checked="" value="">무관
					</label> <label for="type-radio2" class="level-checkbox2"> <input
						type="radio" name="gender-check" id="type-radio2" onclick="filter()" value="M">남자
					</label> <label for="type-radio3" class="level-checkbox2"> <input
						type="radio" name="gender-check" id="type-radio3" onclick="filter()" value="F">여자
					</label>
				</div>
				<div class="counselor-detail-checkbox-wrapper">
					<h4>상담 가능요일</h4>
					<label for="type-day1" class="level-checkbox3"> <input
						type="radio" name="day-check" id="type-day1" value="" onclick="filter()" checked="">무관
					</label> <label for="type-day2" class="level-checkbox3"> <input
						type="radio" name="day-check" id="type-day2" value="D" onclick="filter()">평일
					</label> <label for="type-day3" class="level-checkbox3"> <input
						type="radio" name="day-check" id="type-day3" value="E" onclick="filter()">주말
					</label>
				</div>
			</section>
			</form>
		</div>
		<!-- 상담사 레벨, 성별 요일 선택 시작 -->
		<!-- 상담사 검색필터 끝 -->

		<!-- 상담사 목록정렬 & 상담사 전체 개수 카운터 시작 -->
		<div class="counselor-list">
			<%-- <div class="list-filter-wrapper">
				<span class="counselor-search-list-num" id="">검색 결과 <em
					id="search-result-count">${totalContents}</em>건
				</span>
			</div> --%>
		</div>
		<!-- 상담사 목록정렬 & 상담사 전체 개수 카운터 끝  -->

		<!-- 상담사 view 영역 시작 -->
		<%-- <div class="counselor-list-wrapper">
			<div class="counselor-info-list">
<<<<<<< HEAD
				<c:forEach items="${list }" var="counselor">
					<article data-advis-id="${counselor.advisId}"
						class="counselor-info">
						<div class="counselor-info-name">
							<h3 class="counselor-name">${counselor.advisName}
								<span style="color: #48DA91;">${counselor.advisGrade} 상담사</span>
							</h3>
							<p class="counselor-simple-greetings">${counselor.advisLineIntro}</p>
							<!-- 평점 -->
							<div class="counselor-list-preview">
								<div class="star-score__wrap--middle">
									<ol>
										<li class="star-score__ico is-all"></li>
										<li class="star-score__ico is-all"></li>
										<li class="star-score__ico is-all"></li>
										<li class="star-score__ico is-all"></li>
										<li class="star-score__ico is-half"></li>
									</ol>
								</div>
								<div class="partner-list-box__review-score js-review-star-num">(21)</div>
							</div>
							<!-- 평점 끝 -->
						</div>
						<!-- 상담사 이미지 -->
						<div class="counselor-img">
							<img
								src="${pageContext.request.contextPath}/resources/images/counselling/${counselor.advisImg}"
								alt="상담사 사진">
						</div>
						<!-- 상담 유형 -->
						<div class="counselor-type">
							<div>
								<ul class="counselor-type">
									<li class="counselling-type"><c:forEach
											items="${counselor.advisKeyword}" var="keyword"
											varStatus="vs">
	                                            ${keyword}${!vs.last?",":""}
	                                        </c:forEach></li>
								</ul>
							</div>
							<div>
								<p class="counselor-price">${counselor.advisPrice}원~</p>
							</div>
						</div>
						<button class="counselor-selectOne">상담사 찜하기</button>
					</article>
				</c:forEach>
=======
                <c:forEach items="${list }" var="counselor">
				    <article data-advis-id="${counselor.advisId}" class="counselor-info">
						    <div class="counselor-info-name">
						    	<h3 class="counselor-name">${counselor.advisName} <span style="color: #48DA91;">${counselor.advisGrade} 상담사</span>
						    	</h3>
						    	<p class="counselor-simple-greetings">${counselor.advisLineIntro}</p>
						    	<!-- 평점 -->
						    	<div class="counselor-list-preview">
						    		<div class="star-score__wrap--middle">
						    			<span class='star-rating'>
        									<span style="width:${reviewRating*20}%"></span>
    									</span>
						    		</div>
						    		<div class="partner-list-box__review-score js-review-star-num">${counselorReviews}</div>
						    	</div>
						    	<!-- 평점 끝 -->
						    </div> 
						    <!-- 상담사 이미지 -->
						    <div class="counselor-img">
						    	<img src="${pageContext.request.contextPath}/resources/images/counselling/${counselor.advisImg}" alt="상담사 사진">
						    </div> 
						    <!-- 상담 유형 -->
						    <div class="counselor-type">
							    <div>
								    <ul class="counselor-type">
                                        <c:forEach items="${counselor.advisKeyword}" var="keyword" varStatus="vs">
                                            <li class="counselling-type">${keyword}${!vs.last?",":""}</li>
                                        </c:forEach>        
								    </ul>
							    </div>
							    <div>
								    <p class="counselor-price">${counselor.advisPrice}원~</p>
							    </div>
						    </div>
					    <button class="counselor-selectOne">상담사 찜하기</button>
                    </article>
                </c:forEach>
>>>>>>> branch 'master' of https://github.com/Wingater/GreGre.git
			</div>
			<!-- 상담사 리스트 끝 -->
			<!-- 페이징 시작 -->
			<div class="paging-wrapper">
				<ul class="paging">
					<li class="paging-num active"><a href="#">1</a></li>
				</ul>
			</div>
			<!-- 페이징 끝 -->
		</div> --%>
	</div>
</div>
<!-- contents end  -->
<script>
function filter(){
	//초기화
	$(".search-form").val("");
	$(".counselor-list").html("");
	$(".counselor-list-wrapper").html("");
	$(".counselor-list-wrapper").remove();
	 var dd = $("#filter").serialize();
	
	$.ajax({
		
		url: "${pageContext.request.contextPath}/counselling/filter.do",
		data: dd,
		type: "GET",
		success: data =>{
			
			function numberFormat(inputNumber) {
				   return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			};
			
			console.log(data);
			
			var resultArr = [];
			$.each(data, function(i, item){
				resultArr[i] = item;
			});
			
			//초기화
			$(".search-form").val("");
			$(".counselor-list").html("");
			$(".counselor-list-wrapper").html("");
			$(".counselor-list-wrapper").remove();
			
			$(".counselor-list").append("<div class='list-filter-wrapper'><span class='counselor-search-list-num' id=''>검색 결과 <em id='search-result-count'><strong>"+resultArr.length+"</strong></em>건</span></div>");
			
			let result = "<div class='counselor-list-wrapper'><div class='counselor-info-list'>";
			
			for(var i=0; i<resultArr.length; i++){
				result += "<article data-advis-id='"+resultArr[i].advisId+"'class='counselor-info'>";
				result += "<div class='counselor-info-name'><h3 class='counselor-name'>"+resultArr[i].advisName+" <span style='color: #48DA91;'>"+resultArr[i].advisGrade+" 상담사</span></h3>";
				result += "<p class='counselor-simple-greetings'>"+resultArr[i].advisLineIntro+"</p>";
				//<!-- 평점 -->
				result += "<div class='counselor-list-preview'><div class='star-score__wrap--middle'>";
				result += "<span class='star-rating-middle'><span style='width:"+resultArr[i].starPoint*20+"%'>&nbsp;</span></span>"
				result += "<div class='partner-list-box__review-score js-review-star-num'>"+resultArr[i].reviewTotal+"개의 리뷰</div></div></div></div>";
				//상담 이미지
				result += "<div class='counselor-img'><img src='${pageContext.request.contextPath }/resources/upload/member/"+resultArr[i].advisImg+"'alt='상담사 사진'></div>";
				//상담 유형
				result += "<div class='counselor-type'><div><ul class='counselor-type'><li class='counselling-type'>";
				for(var j=0; j<resultArr[i].advisKeyword.length; j++){
					result += (j!=resultArr[i].advisKeyword.length-1)?resultArr[i].advisKeyword[j]+",":resultArr[i].advisKeyword[j];
				}
				result += "</li></ul></div><div><p class='counselor-price'>"+numberFormat(resultArr[i].advisPrice)+"원~</p></div></div></article>";	
			}
			
			result += "</div></div>";
			
			$(".counselor-list").after(result);
			
			
			$("article[data-advis-id]").on("click", function(){
				console.log("클릭함");
				let advisId = $(this).attr("data-advis-id");
				console.log(advisId);
				
				location.href = "${pageContext.request.contextPath}/counselling/bookingMain.do?advisId="+advisId;
			});
		},
		error:(xhr,status, err) =>{
			console.log(xhr,status,err);
		}
	});
	
	
};
$(()=>{
	$("article[data-advis-id]").on("click", function(){
		console.log("클릭함");
		let advisId = $(this).attr("data-advis-id");
		console.log(advisId);
		
		location.href = "${pageContext.request.contextPath}/counselling/bookingMain.do?advisId="+advisId;
	});
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
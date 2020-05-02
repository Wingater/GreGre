<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- taglib는 매 jsp 마다 필요함 -->

<!-- 한글깨질때. -->
<fmt:requestEncoding value="utf-8" />
<!-- summernotes -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-bs4.min.js"></script>
<!-- 헤더 선언!!-->
<%@ include file="/WEB-INF/views/shop/admin/common/header.jsp"%>
<style>
.modal-backdrop.show {
	display: none !important;
}

.down-wrap {
	border: 1px;
	width: 100%;
	text-align: left;
	cursor: pointer;
	padding: 6px 8px;
	color: #b8b8b8;
}

.table-bordered>tbody>tr>td {
	background-color: #fff;
}

.main-content {
	padding-right: 70px;
	padding-left: 20px;
}

.table-bordered>thead>tr>th, .table-bordered>tbody>tr>th,
	.table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td,
	.table-bordered>tbody>tr>td, .table-bordered>tfoot>tr>td {
	border: 1px solid #dddddd;
}

.bg_mint {
	background-color: #f8fdff;
	color: #367798;
}

th#optionTh {
	vertical-align: middle;
}

.main-header .navbar-custom-menu, .main-header .navbar-right {
	margin-right: 5px;
	float: right;
	margin-left: auto;
}

.main-header>.navbar {
	height: 30px;
}

.modal-backdrop.in {
	display: none !important;
}

span.mr5.font-size16 {
	float: left;
	margin-top: 6px;
}

span.form-inline {
	float: left;
}

a#optListUpdate {
	float: right;
	margin: 12px 0px;
}

.clearfix.mb5 {
	margin-bottom: 10px;
}

input[name="paymentMethodCode"] {
    margin-left: 10px;
}
</style>

<div class="content-wrapper">
	<!-- Right side column. Contains the navbar and content of the page -->
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#">상품관리ggg</a></li>
			<li class="active">상품등록</li>
		</ol>
	</section>


	<!-- MAIN -->
	<div class="main-content">
		<div class="col-lg-12">
			<h2>상품등록</h2>
		</div>
		<form
			action="${pageContext.request.contextPath}/shop/admin/product/insert.do"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="sellerId" value="igre_mall_test" />
			<!-- 			<div class="form-group row">
				<label for="productId" class="col-sm-2 col-form-label">제품번호</label>
				<div class="col-sm-4">
					<input type="text" name="productId" class="form-control"
						id="staticEmail" value="">
				</div>
			</div> -->
			<div class="form-group row">
				<label for="payment" class="col-sm-2 col-form-label">결제방식</label>
				<div class="col-sm-10">
					<input type="checkbox" name="paymentMethodCode" value="cr" checked >신용카드
					<input type="checkbox" name="paymentMethodCode" value="ph" checked>휴대전화
					<input type="checkbox" name="paymentMethodCode" value="ac" checked>무통장입금
				<!-- 	<input type="checkbox" name="paymentMethodCode" value="va" >가상계좌 -->
					<input type="checkbox" name="paymentMethodCode" value="ra" checked>실시간계좌이체
					<input type="checkbox" name="paymentMethodCode" value="ka" checked>카카오페이
					<input type="checkbox" name="paymentMethodCode" value="to" checked>토스
					<input type="checkbox" name="paymentMethodCode" value="na" checked>네이버페이
				</div>
				<label for="categoryId" class="col-sm-2 col-form-label">카테고리</label>
				<div class="col-sm-10">
					<select name="categoryId" class="form-control" id="categoryId"
						style="width: 25%; display: inline-block;">
						<option value="">선택</option>
						<option value="CA1">분유</option>
						<option value="CA2">이유식</option>
						<option value="CA3">기저귀</option>
						<option value="CA4">물티슈</option>
						<option value="CA5">수유용품</option>
						<option value="CA6">이유용품</option>
						<option value="CA7">목욕용품</option>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label for="productName" class="col-sm-2 col-form-label">상품명</label>
				<div class="col-sm-4">
					<input type="text" name="productName" class="form-control" id="">
				</div>
			</div>
			<div class="form-group row">
				<label for="brandName" class="col-sm-2 col-form-label">브랜드명</label>
				<div class="col-sm-4">
					<input type="text" name="brandName" class="form-control" id="">
				</div>
			</div>
			<div class="form-group row">
				<label for="supplyValue" class="col-sm-2 col-form-label">공급가</label>
				<div class="col-sm-4">
					<input type="number" name="supplyValue" class="form-control" value="0">
				</div>
				<div class="col-form-label">
					<span>원</span>
				</div>
			</div>
			<div class="form-group row">
				<label for="price" class="col-sm-2 col-form-label">판매가</label>
				<div class="col-sm-4">
					<input type="number" name="price" class="form-control" value="0">
				</div>
				<div class="col-form-label">
					<span>원</span>
				</div>
			</div>
			<div class="form-group row">
				<label for="pointRate" class="col-sm-2 col-form-label">포인트적립비율</label>
				<div class="col-sm-4">
					<input type="number" name="pointRate" class="form-control"
						value="0">
				</div>
				<div class="col-form-label">
					<span>%</span>
				</div>
			</div>
			<div class="form-group row">
				<label for="discountPrice" class="col-sm-2 col-form-label">할인금액</label>
				<div class="col-sm-4">
					<input type="number" name="discountPrice" class="form-control"
						value="0">
				</div>
				<div class="col-form-label">
					<span>원</span>
				</div>
			</div>
			<div class="form-group row">
				<label for="productStock" class="col-sm-2 col-form-label">재고수량</label>
				<div class="col-sm-4">
					<input type="number" name="productStock" class="form-control"
						value="999">
				</div>
			</div>
			<div class="form-group row">
				<label for="productStock" class="col-sm-2 col-form-label">배송비설정</label>
				<div class="col-sm-10">
					<input type="radio" name="" id="selectedDelivery-1" value="1"
						checked> 기본 배송비 사용 ( 기본배송비 : 0원, 무료배송비 : 0원)<br> <input
						type="radio" name="" id="selectedDelivery-2" > 개별
					배송비 설정
					<div id="delivery-1">
						기본 배송비 : <input type="text" name="deliveryFee"
							class="form-control number-coma"
							style="width: 100px; display: inline-block; margin: 0;" id="fee1"
							value="0"> 원 ( 무료배송 시 0 입력 )
					</div>
					<div id="delivery-2" style="display: none;">
						조건부무료 배송비 : <input type="text" name="deliveryFee"
							class="form-control number-coma"
							style="width: 100px; display: inline-block;" id="fee2" >
						원 이상시 무료배송
					</div>
				</div>
			</div>
			<div class="form-group row">
				<label for="productState" class="col-sm-2 col-form-label">상품노출</label>
				<div class="col-sm-10">
					<input type="checkbox" name="productState" value="Y" checked>
					상품을 노출합니다.
				</div>
			</div>
			<div class="form-group row">
				<label for="originalImgupload" class="col-sm-2 col-form-label">상품대표이미지</label>
				<div class="col-sm-10">
					<input type="file" name="mainImg"> <i
						class="fa fa-exclamation-triangle"></i> <span class="help-inline">
						* 상품이미지는 가로 세로 동일한 사이즈로 등록해주세요.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*
						파일의 최대 크기는 1MB입니다.
					</span>
				</div>
			</div>
			<div class="form-group row">
				<label for="originalImgupload" class="col-sm-2 col-form-label">상품상세보기
					이미지</label>
				<div class="col-sm-10">
					<input multiple="multiple" type="file" name="subImg" /> <i
						class="fa fa-exclamation-triangle"></i> <span class="help-inline">*최대
						4개까지 업로드 가능합니다.</span>
				</div>
			</div>
			<div class="form-group row">
				<label for="productDetail" class="col-sm-2 col-form-label">상품설명</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="summernote" name="productDetail"
						maxlength="140" rows="7"></textarea>
				</div>
			</div>


			<h4 class="title-icon-bg">
				<strong>추가정보</strong>
			</h4>
			<span class="red"> &nbsp;*선택 항목입니다.</span>
		
								<!-- 일반 / 재고옵션 -->
								<table class="table table-bordered table-product-s"
									style="border-bottom: 0px; margin-bottom: 0px;">
									<colgroup>
										<col style="width: 10%;">
										<col width="">
									</colgroup>
									<tbody>
										<tr style="border-bottom: 0px;">
											<th class="bg_mint text-center" style="border-bottom: 0px;">재고옵션</th>
											<td style="border-bottom: 0px;">
												<div id="useNewOption" class="buttonset2 table-mt5" style="">
													<!-- 신규등록 -->
													<div id="optionDiv1"></div>

													<!-- 옵션사항 시작 -->
													<div class="mt5">
														<!-- 옵션설정 -->
														<table id="optTable" class="table table-bordered"
															style="margin: 10px 0 0 0">
															<colgroup>
																<col style="width: 25%;">
																<col style="width: 70%;">
																<col style="width: 5%;">
															</colgroup>
															<tbody>
																<tr>
																	<th class="text-center">옵션명</th>
																	<th class="text-center">옵션값</th>
																	<th class="text-center"><a
																		class="btn btn-info btn-sm" id="optPlus">추가</a></th>
																</tr>
																<tr>
																	<td class="text-center"><input type="text"
																		name="noTitle[]" id="noTitle0" no="0" value=""
																		maxlength="50" placeholder="50자까지 입력가능."
																		class="form-control input_st4"></td>
																	<td class="text-center"><input type="text"
																		name="optionVal" placeholder="예)블랙,화이트 (,로 구분)"
																		id="optionValue0" value=""
																		class="form-control input_st4"></td>
																	<th class="text-center"></th>
																</tr>

															</tbody>
														</table>


														<div style="text-align: center; padding: 5px;">
															<a class="btn btn-info btn-sm" id="optionSetting">옵션
																적용</a>
														</div>
<!-- 수정 -->
														<!-- 일반옵션 리스트 -->
														<div id="generalDiv">
															<div class="clearfix mb5">
																<div class="float_l mt10">
																	<span class="mr5 font-size16">옵션목록 : <strong>
																		<span class="red" id="totalOptList">0</span></span></strong>개
																	</span> 
																	<span class="form-inline m1 " style="padding-left: 15px;"> 사용여부 
																	<select
																		name="optView" id="optView"
																		class="form-control select-check"
																		style="width: 80px !important;">
																			<option value="1">Y</option>
																			<option value="0">N</option>
																	</select>
																	</span>
																	<a class="btn btn-primary btn-sm ml5" id="optListUpdate2" style="float:right;">선택목록 일괄수정</a>
																</div>
															</div>
														</div>
														<!-- 일반옵션 리스트 끝-->
														<div style="overflow:scroll; overflow-x:hidden; width:100%; height:250px; border:1px solid #cfcfcf;">
													<table id="optListTable" class="table table-bordered" style="border-left:none;">
														<tbody>
														<tr>
															<th style="width:3%" class="text-center" rowspan="2">
																<input type="checkbox" id="optListAll2" name="optListAll2" value="Y">
															</th>
															<th style="width:50%;" class="text-center" id="optNameTd" colspan="2">옵션명</th>
															<th style="width:10%" class="text-center" rowspan="2"> 재고</th>
															<th style="width:10%" class="text-center" rowspan="2">공급가</th>
															<th style="width:10%" class="text-center" rowspan="2">판매가</th>
															<th style="width:10%" class="text-center" rowspan="2">사용여부</th>
															<th style="width:10%" class="text-center" rowspan="2">삭제</th>
														</tr>
														<tr id="optNameTd2">
														</tr>
														</tbody>
													</table>
												</div>
													</div>
													<!-- 옵션사항 끝 -->
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<!-- 일반 /재고옵션끝-->
								
			<!-- 등록버튼 -->

			<div class=" text-center" style="padding-bottom: 50px">
				<input type="submit" class="btn btn-primary btn-lg" id=""
					value="상품등록" />
			</div>


		</form>
	</div>
</div>
<!-- 폼 끝  -->
<script type="text/javascript">
	$('#summernote').summernote({
		placeholder : '제품설명을 입력해주세요.',
		tabsize : 2,
		height : 300,
		focus : true,
		lang : 'ko-KR',
		callbacks : {
			onImageUpload : function(files, editor, welEditable) {
				for (var i = files.length - 1; i >= 0; i--) {
					sendFile(files[i], this);
				}
			}
		}
	});
</script>
<script>
	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({
					data : form_data,
					type : "POST",
					url : '${pageContext.request.contextPath}/shop/admin/product/insertImg.do',
					cache : false,
					contentType : false,
					enctype : 'multipart/form-data',
					processData : false,
					//summbernote 이미지 저장 성공 후 
					success : function(data) {
						var url = '${pageContext.request.contextPath}/resources/upload/shop/productDetail/'
								+ data[1];
						$(el).summernote('editor.insertImage', url);
						$('summernote').append('<img src="'+url+'" width = "400", height = "auto" />');
					}
				});
	}
</script>



<script>
	/* <!--글쓰기 js -->
	 $('#summernote').summernote({
	 placeholder : '제품설명을 입력해주세요.',
	 tabsize : 2,
	 height : 300
	 }); */
</script>
<script>
	$(function() {
		$("#selectedDelivery-1").click(function() {
			console.log("test 클릭클릭");
			$("#delivery-1").show();
			$("#delivery-2").hide();
			$("input:radio[id='selectedDelivery-2']").attr("checked", false);
		});
		$("#selectedDelivery-2").click(function() {
			console.log("test 클릭클릭");
			$("#delivery-2").show();
			$("#delivery-1").hide();
			$("input:radio[id='selectedDelivery-1']").attr("checked", false);
		});
	});
</script>

<script>
	function productValidate() {
		console.log("찍히나");
		console.log("카테고리아이디" + $("#category").val());
		return true;
	}
</script>
<script>
	var optPlusIdx=1;
	var index =0;
	var tidx =0;

	console.log("t123=="+tidx);
	$(function() {
		//입력옵션 추가 하는 스크립트
		//일반옵션 추가하는 곳
		$("#optPlus").click( function() {
							var html = '<tr><td class="text-center"><input type="text" name="optionName" id="noTitle'+optPlusIdx+'" no="0" value="" maxlength="50" placeholder="50자까지 입력가능." class="form-control input_st4"></td><td class="text-center"><input type="text" name="" placeholder="예)블랙,화이트 (,로 구분)" id="optionValue'+optPlusIdx+'" value="" class="form-control input_st4"></td><th class="text-center"><a class="btn btn-danger btn-sm optMinus">삭제</a></th></tr>'
							$("#optTable").append(html)
							optPlusIdx++;
						});

		//일반 옵션 추가된것 삭제해주는 것	 
		$(document).on('click', '.optMinus', function(e) {
			$(this).parent().parent().remove();
		});
	
		
		$(document).on('click', '.optListMinus', function(e) {
			$(this).parent().parent().remove();
		});

	});
	$(function(){
		$("#optionSetting").click( function() {
			var optNameHtml='';
			for( tidx ; tidx <optPlusIdx; tidx++){
				var optionName  = 'noTitle'+tidx;
				 var optionName2 = optionName; 
				var nameResult = document.getElementById(optionName2);
				console.log("tidx=="+optionName2);
				var optName = nameResult.value;

				var optionValue ='optionValue'+tidx+'';
				var optionValue2 = optionValue;
				var optResult = document.getElementById(optionValue2);
				var optValStr = optResult.value.split(',');
				if(tidx==0){
					var optHtml ='';
					for( index  ; index < optValStr.length;index ++){
						optHtml += '<tr class="first-made"><td class="text-center" style="border-left:none;"><input type="checkbox" name="optCeck2[]" value="1"><input type="hidden" name="oListNum[]" value=""></td><td><input type="text" name="optionValue1" id="optVal'+index+'" value="'+optValStr[index]+'" class="form-control input_st4" readonly=""></td><td><input type="text" name="optionStock" value="0" class="form-control number-coma input_st4" idx="1"></td><td><input type="text" name="optionSupplyValue" value="0" class="form-control number-coma input_st4" idx="1"></td><td><input type="text" name="optionPrice" value="0" class="form-control number-coma input_st4" idx="1"></td><td><select name="optionState" class="form-control number-coma input_st4"><option value="Y" selected="">Y</option><option value="N">N</option></select></td><td class="text-center"><a class="btn btn-danger btn-sm optListMinus">삭제</a></td></tr>'
					
					}
					$("#optListTable").append(optHtml);				
				}else{
					var optHtml ='';
					var oIdex = 0;
					for(var opt=0; opt < index ;opt++){
						var optVal  = 'optVal'+opt;
						var optVal2 = optVal;
						var optValResult = document.getElementById(optVal2);
						var optValue = optValResult.value; 
						for(var t=0; t<optValStr.length;t++){
							optHtml = '<tr><td class="text-center" style="border-left:none;"><input type="checkbox" name="optCeck2[]" value="1"><input type="hidden" name="oListNum[]" value=""></td><td><input type="text" name="optionValue1" id="optVal'+oIdex+'" value="'+optValue+'" class="form-control input_st4" readonly=""></td><td><input type="text" name="optionValue2" id="optVal'+oIdex+'" value="'+optValStr[t]+'" class="form-control input_st4" readonly=""></td><td><input type="text" name="optionStock" value="0" class="form-control number-coma input_st4" idx="1"></td><td><input type="text" name="optionSupplyValue" value="0" class="form-control number-coma input_st4" idx="1"></td><td><input type="text" name="optionPrice" value="0" class="form-control number-coma input_st4" idx="1"></td><td><select name="optionState" class="form-control number-coma input_st4"><option value="Y" selected="">Y</option><option value="N">N</option></select></td><td class="text-center"><a class="btn btn-danger btn-sm optListMinus">삭제</a></td></tr>';
							console.log('모지=='+optVal2);
							console.log('optResult=='+optValResult);
							console.log('모지optValue=='+optValue);
							$("#optListTable").append(optHtml);		
							oIdex++;
						}
					}
					$("tr").remove(".first-made"); 
											
				}
					

				optNameHtml +='<th class="text-center">'+optName+'</th>';
				var test = '<input type="hidden" name="optionName" value="'+optName+'" >';
				 $('#optNameTd2').append(test);  
				console.log("뭐야=="+optNameHtml);
				 $('#optNameTd2').append(optNameHtml); 
				$('#optNameTd').attr('colspan',optPlusIdx);
				
			}
			

			console.log('optPlusIdx++ =='+optPlusIdx);
});
	});
</script>

<!-- /.content-wrapper -->
<!--푸터영역-->
<!-- ./wrapper -->
<!-- jQuery 2.1.3 -->

<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
	integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
	crossorigin="anonymous"></script>
<!-- jQuery Knob Chart -->
<script
	src="${pageContext.request.contextPath}/resources/js/admin/jquery.knob.js"
	type="text/javascript"></script>
<!-- Slimscroll -->
<script
	src="${pageContext.request.contextPath}/resources/js/admin/jquery.slimscroll.min.js"
	type="text/javascript"></script>
<!-- FastClick -->
<script
	src='${pageContext.request.contextPath}/resources/js/admin/fastclick.min.js'></script>
<!-- AdminLTE App -->
<script
	src="${pageContext.request.contextPath}/resources/js/admin/app.min.js"
	type="text/javascript"></script>
<!-- AdminLTE for demo purposes -->
<script
	src="${pageContext.request.contextPath}/resources/js/admin/demo.js"
	type="text/javascript"></script>



</body>
</html>
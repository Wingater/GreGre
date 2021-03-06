<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
	</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
  <title>Kiddy &mdash; Website Template by Colorlib</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link href="https://fonts.googleapis.com/css?family=DM+Sans:300,400,700|Indie+Flower" rel="stylesheet">


  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/icomoon/style.css">
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-datepicker.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.fancybox.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/flaticon/font/flaticon.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/aos.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <!-- MAIN CSS -->
<c:if test="${not empty memberLoggedIn }">
<script>
	$(function() {
		location.href='${pageContext.request.contextPath}';
	});
</script>
</c:if>

<!--login css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/login.css"> 
  <script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
  <style>
.enroll-btn{
    padding: 12px 0 !important;
}

sapn.guide {display:none;font-size: 12px;position:absolute; top:12px; right:10px ; }
span.ok{display:none;color:green;}
span.error{display:none;color:red ;}

sapn.pguide {display:none;font-size: 12px;position:absolute; top:12px; right:10px ; }
span.ok1{display:none;color:green;}
span.error2{display:none;color:red ;}
</style>


<body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">


 <!-- contents begin-->
 <div class="site-section">
        <div class="container">
          <div class="row">
            <div class="col">
                  <div class="card-body mx-auto" style="max-width:800px;">
                      <article class="card-body">
                          <h4 class="card-title text-center mb-4 mt-1">판매사 회원 가입</h4>
                          <form name="sellerEnroll" action="sellerEnroll.do" method="post" onsubmit="return enrollValidate3();">

                             <h5>판매사</h5><br />
                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text"> 판매사 상호명</span>
                                  </div>
                                  <input name="compName" class="form-control" id="compName"
                                      type="text">
                              </div>
                              
                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text"> 사업자등록번호</span>
                                  </div>
                                  <input name="compId1" class="form-control" id="compId1" type="text">&nbsp;-&nbsp;
                                  <input name="compId2" class="form-control" id="compId2" type="text">&nbsp;-&nbsp;
                                  <input name="compId3" class="form-control" id="compId3" type="text">
                              </div>
                             
                               <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text"> 판매사 연락처</span>
                                  </div>
                                  <input name="compNum" class="form-control" id="compNum"
                                      placeholder="(-없이)01012345678" type="text">
                              </div>
                              
  
                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text"> 판매사 팩스번호</span>
                                  </div>
                                  <input name="compFax" class="form-control" id="compFax"
                                      type="text">
                              </div>
                              
                              
                              <div class="form-group input-group">
									<div class="input-group-prepend">
										<span class="input-group-text"> 판매사 주소</span>
									</div>
									<input class="form-control"
										style="width: 40%; display: inline;" placeholder="우편번호"
										name="addr1" id="addr1" type="text" readonly="readonly">
									<button type="button" class="btn btn-default"
										onclick="execPostCode();">
										<i class="fa fa-search"></i> 우편번호 찾기
									</button>

								</div>
								<div class="form-group">
									<input class="form-control" style="top: 5px;"
										placeholder="도로명 주소" name="addr2" id="addr2" type="text"
										readonly="readonly" />
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="상세주소" name="addr3"
										id="addr3" type="text" />
								</div>

								<input type="hidden" id="address" name="address"/>
                              
                              	<hr />
                              
                              <h5>영업 담당자</h5><br />
                                                            
                             <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text">영업 담당자 아이디</span>
                                  </div>
                                  <input name="cmemberId" class="form-control" id="cmemberId"
                                      placeholder="4글자 이상" type="text" required>
  
                              </div>
                              <span class="guide ok" >이 아이디는 사용 가능합니다</span>
								<span class="guide error">이 아이디는 사용할 수 없습니다.</span>
								<input type="hidden" name="idDuplicateCheck3" id="idDuplicateCheck3" value="0"/>

                              	<input type="hidden" name="sellerId" id="sellerId"/>

                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text">비밀번호 </span>
                                  </div>
                                  <input name="memberPwd" class="form-control" id="memberPwd"
                                      placeholder="" type="password" required>
                              </div>
                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text">비밀번호 확인</span>
                                  </div>
                                  <input name="memberPwd2"class="form-control" placeholder="" id="memberPwd2"
                                      type="password" required>
                              </div>
  								
  								<span class="pguide ok1" id="alert-success">비밀번호가 일치합니다.</span> 
                              <span class="pguide error2" id="alert-danger">비밀번호가 일치하지 않습니다.</span>
 
                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text"> 영업 담당자 이름</span>
                                  </div>
                                  <input name="sellerName" class="form-control" id="sellerName"
                                      type="text">
                              </div> 
 
                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text">영업 담당자 연락처 </span>
                                  </div>
                                  <input name="phone" class="form-control" id="phone"
                                      placeholder="(-없이)01012345678" type="text">
                              </div>
  
								<div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text">영업 담당자 이메일 </span>
                                  </div>
                                  <input name="sellerEmail" class="form-control" id="sellerEmail"
                                      placeholder="abc@xyz.com" type="email">
                              </div>
                              
                             

  							<hr />
  							<h5>계좌정보</h5><br />
  							
  							
                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text"> 은행명</span>
                                  </div>
                                  <input name="bankName" class="form-control" id="bankName"
                                      type="text">
                              </div> 
  
  							  <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text"> 예금주</span>
                                  </div>
                                  <input name="accountHolder" class="form-control" id="accountHolder"
                                      type="text">
                              </div>
  
                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text"> 계좌번호</span>
                                  </div>
                                  <input name="accountNo" class="form-control" id="accountNo"
                                      placeholder="(-없이)" type="text">
                              </div>   
                              
                              <hr />
                              <h5>상품 정보</h5><br />
                              
  							  <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text"> 브랜드명 </span>
                                  </div>
                                  <input name="brandName" class="form-control" id="brandName"
                                      type="text">
                              </div>
                              
                              <h5>카테고리</h5>
                           	  <div class="checks">

                                  <input name="categories"  id="categories1" value="CA1"type="checkbox">
                                  <label for="categories1"  >분유</label>&nbsp;
                                  
                                  <input name="categories"  id="categories2" value="CA2"type="checkbox">
                                  <label for="categories2" >이유식</label>&nbsp;
                                   
                                  <input name="categories"  id="categories3" value="CA3"type="checkbox">
                                  <label for="categories3" >기저귀</label> &nbsp;
                                  
                                  <input name="categories"  id="categories4" value="CA4"type="checkbox">
                                  <label for="categories4">물티슈</label> &nbsp;
                                  
                                  <input name="categories"  id="categories5" value="CA5"type="checkbox">
                                  <label for="categories5">수유용품</label>&nbsp;
                                  
                                  <input name="categories"  id="categories6" value="CA6"type="checkbox">
                                  <label for="categories6">이유용품</label> &nbsp;
                                  
                                  <input name="categories"  id="categories7" value="CA7"type="checkbox">
                                  <label for="categories7" >목욕용품</label>            
                              </div>                              
                              
                              
                              <div class="form-group input-group">
                                  <div class="input-group-prepend">
                                      <span class="input-group-text">상품 소개 </span>
                                  </div>
                                  <textarea rows="3" cols="67" id="salesAboutprod" name="salesAboutprod"></textarea>
                              </div>
                              
                              	<!-- 판매자 -->
                              <input type="hidden" id="compDiv"name="compDiv" value="S"/>
                            
  
  
                              <div class="form-group">
                                  <button class="btn btn-primary btn-block enroll-btn">가입완료</button>
                              </div>
                          </form>
                      </article>
                  </div>
              </div>
        </div>
      </div>
      </div>
     <!-- contents end-->
  <script>
  $(function(){
		
		$("#cmemberId").on("keyup",function(){
			let cmemberId = $("#cmemberId").val().trim();
			
			//아이디 글자수 검사
			//아이디 재작성시
			if(cmemberId.length <4){
				$(".guide").hide();
				$("#idDuplicateCheck3").val(0);
				return;
			}
			
			$.ajax({
				url:"${pageContext.request.contextPath}/member/"+cmemberId+"/checksId.do",
				type:"get",
				success: data =>{
					console.log(data);
					
					if(data.isUsable3 == true){
						$(".guide.error").hide();
						$(".guide.ok").show();
						$("#idDuplicateCheck3").val(1);
					}
					else {
						$(".guide.error").show();
						$(".guide.ok").hide();
						$("#idDuplicateCheck3").val(0);
					}
				},
					error: (x,s,e) => {
						console.log(x,s,e);
					}
			});
		});
		
		
	});


$(function(){
	  $("#alert-success").hide(); 
	  $("#alert-danger").hide(); 
	  $("input").keyup(function(){
		  var pwd1=$("#memberPwd").val(); 
		  var pwd2=$("#memberPwd2").val(); 
		  if(pwd1 != "" || pwd2 != ""){ 
			  if(pwd1 == pwd2){ 
				  $("#alert-success").show(); 
				  $("#alert-danger").hide(); 
				  $("#submit").removeAttr("disabled"); 
				  }else{ 
					  $("#alert-success").hide(); 
					  $("#alert-danger").show(); 
					  $("#submit").attr("disabled", "disabled"); 
					  } 
			  } 
		  }); 
	  });


	function enrollValidate3(){
		var cmemberId = $("#cmemberId");
		if(cmemberId.val().trim().length<4){
			alert("아이디는 최소 4자리이상이어야 합니다.");
			cmemberId.focus();
			return false;
		}
		
		if($("#idDuplicateCheck3").val() ==0){
			
			alert("아이디 중복 검사 해주세요.");
			return false;
		}
		
		return true;
	}
  
  </script>

<script src="${pageContext.request.contextPath}/resources/js/jquery-migrate-3.0.0.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/owl.carousel.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/jquery.sticky.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/jquery.waypoints.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/jquery.animateNumber.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/jquery.fancybox.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/jquery.stellar.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/jquery.easing.1.3.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/bootstrap-datepicker.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/aos.js"></script>

  <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>




    <!-- Js Plugins -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/member/member.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/shop/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/shop/jquery.countdown.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/shop/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/shop/jquery.zoom.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/shop/jquery.dd.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/shop/jquery.slicknav.js"></script>
    <!-- <script src="js/shop/owl.carousel.min.js"></script> -->
    <script src="${pageContext.request.contextPath}/resources/js/shop/main.js"></script>
	
</body>

</html>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
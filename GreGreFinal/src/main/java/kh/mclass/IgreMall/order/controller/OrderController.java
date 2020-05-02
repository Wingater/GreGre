package kh.mclass.IgreMall.order.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kh.mclass.Igre.member.model.vo.Member;
import kh.mclass.IgreMall.coupon.model.service.CouponService;
import kh.mclass.IgreMall.coupon.model.vo.Coupon;
import kh.mclass.IgreMall.order.model.service.OrderService;
import kh.mclass.IgreMall.order.model.vo.OrderList;
import kh.mclass.IgreMall.order.model.vo.OrderProduct;
import kh.mclass.IgreMall.order.model.vo.PayAccountInfo;
import kh.mclass.IgreMall.order.model.vo.PaymentInfo;
import kh.mclass.IgreMall.product.model.service.ProductService;
import kh.mclass.IgreMall.product.model.vo.Attachment;
import kh.mclass.IgreMall.product.model.vo.ProdOption;
import kh.mclass.IgreMall.product.model.vo.Product;
import kh.mclass.IgreMall.shopMember.model.service.ShopMemberService;
import kh.mclass.IgreMall.shopMember.model.vo.Cart;
import kh.mclass.IgreMall.shopMember.model.vo.ShopMember;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;

@Slf4j
@Controller
@RequestMapping("/shop/order")
public class OrderController {

	@Autowired
	OrderService orderService;
	@Autowired
	ProductService productService;
	@Autowired
	ShopMemberService shopMemberService;
	@Autowired
	CouponService couponService;
//	//토스 API 호출
//	@PostMapping("/shopMemberUpdate.do")
//	@ResponseBody
//	public Map<String, Object> getToss() {
//
//		URL url = null;
//		URLConnection connection = null;
//		StringBuilder responseBody = new StringBuilder();
//		try {
//			url = new URL("https://pay.toss.im/api/v2/payments");
//			connection = url.openConnection();
//			connection.addRequestProperty("Content-Type", "application/json");
//			connection.setDoOutput(true);
//			connection.setDoInput(true);
//
//			org.json.simple.JSONObject jsonBody = new JSONObject();
//			jsonBody.put("orderNo", "1");
//			jsonBody.put("amount", 10000);
//			jsonBody.put("amountTaxFree", 0);
//			jsonBody.put("productDesc", "테스트 결제");
//			jsonBody.put("apiKey", "sk_test_w5lNQylNqa5lNQe013Nq");
//		    jsonBody.put("autoExecute", true);
//		    jsonBody.put("resultCallback", "http://localhost:9090/Igre/callback");
//		    jsonBody.put("callbackVersion", "V2");  
//		    jsonBody.put("retUrl", "http://YOUR-SITE.COM/ORDER-CHECK?orderno=1");
//		    jsonBody.put("retCancelUrl", "http://YOUR-SITE.COM/close");
//
//			BufferedOutputStream bos = new BufferedOutputStream(connection.getOutputStream());
//			
//		    bos.write(jsonBody.toJSONString().getBytes(StandardCharsets.UTF_8));
//			bos.flush();
//			bos.close();
//
//			
//		    BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8));
//			String line = null;
//			while ((line = br.readLine()) != null) {
//				responseBody.append(line);
//			}
//			br.close();
//		} catch (Exception e) {
//			responseBody.append(e);
//		}
//
//		Map<String, Object> map = new HashMap<>();
//		if (result > 0) {
//			map.put("memberName", memberName);
//			map.put("phone", phone);
//			map.put("email", email);
//		}
//
//		return map;
//	}
	// 네이버페이일 경우만
	@GetMapping("/finishPayment.do")
	public ModelAndView getFinish(ModelAndView mav, OrderList orderList, HttpSession session,
			@RequestParam(value = "totalPrice", required = false) String totalPrice,
			@RequestParam(value = "prodPrice", required = false) String prodPrice,
			@RequestParam(value = "totalDiscount", required = false) String totalDiscount,
			@RequestParam(value = "usedPoint", required = false) String usedPoint,
			@RequestParam(value = "usedCoupon", required = false) String usedCoupon,
			@RequestParam(value = "couponListId", required = false) String couponListId,
			@RequestParam(value = "addPoint", required = false) String addPoint,
			RedirectAttributes redirectAttributes) {
		Member m = (Member) session.getAttribute("memberLoggedIn");
		List<OrderProduct> orderProdList = (ArrayList<OrderProduct>) session.getAttribute("orderProdList");
		orderList.setMemberId(m.getMemberId());
		String sellerId = productService.selectSellerId(orderProdList.get(0).getProductId());
		String recptPhone = orderList.getRecptPhone();
		orderList.setRecptPhone(recptPhone.replaceAll("-", ""));
		orderList.setSellerId(sellerId);

		orderList.setDeliveryNo("deliTest1");
		if ("ac".equals(orderList.getPayMethod())) {
			orderList.setPayState("N");// 미입금
			orderList.setDeliveryState("A");// 입금대기
		} else {
			orderList.setPayState("Y");
			orderList.setDeliveryState("B");

		}

		PaymentInfo paymentInfo = new PaymentInfo();
		paymentInfo.setProdPrice(Integer.parseInt(prodPrice));
		paymentInfo.setTotalDiscount(Integer.parseInt(totalDiscount));
		paymentInfo.setUsedPoint(Integer.parseInt(usedPoint));
		paymentInfo.setUsedCoupon(Integer.parseInt(usedCoupon));

		ShopMember sMem = shopMemberService.selectOne(m.getMemberId());

		ShopMember memVal = shopMemberService.selectShopMem(m.getMemberId());

		if (memVal == null) {
			int shopMemResult = shopMemberService.insertShopMem(sMem);
		}

		// 쿠폰사용
		if (paymentInfo.getUsedCoupon() > 0) {
			Coupon coupon = new Coupon();
			for (int i = 0; i < sMem.getCouponList().size(); i++) {
				if (sMem.getCouponList().get(i).getCouponListId().equals(couponListId)) {
					sMem.getCouponList().get(i).setCouponState("N");
					coupon.setMemberId(m.getMemberId());
					coupon.setCouponListId(couponListId);
					coupon.setCouponState("N");
				}
			}
			int couponResult = shopMemberService.updateCoupon(coupon);
			redirectAttributes.addFlashAttribute("msg", couponResult > 0 ? "쿠폰 사용 성공!" : "쿠폰 사용 실패");
		}
		// 포인트사용 및 포인트 적립
		if (paymentInfo.getUsedPoint() > 0 && paymentInfo.getUsedPoint() <= sMem.getPoint()) {
			int afterPoint = sMem.getPoint() - paymentInfo.getUsedPoint() + Integer.parseInt(addPoint);
			sMem.setPoint(afterPoint);
			int pointResult = shopMemberService.updateConsumerInfo(sMem);
			redirectAttributes.addFlashAttribute("msg", pointResult > 0 ? "포인트 사용 성공!" : "포인트 사용 실패");
		} else {
			// 포인트 적립만
			int afterPoint = sMem.getPoint() + Integer.parseInt(addPoint);
			sMem.setPoint(afterPoint);
			int pointResult = shopMemberService.updateConsumerInfo(sMem);
			redirectAttributes.addFlashAttribute("msg", pointResult > 0 ? "포인트 적립 성공!" : "포인트 적립 실패");
		}

		// 주문하기
		int result = orderService.insertOrder(orderList, orderProdList, paymentInfo);
		redirectAttributes.addFlashAttribute("msg", result > 0 ? "주문성공!" : "주문실패");

		// 수량 감소
		if (result > 0) {
			for (int i = 0; i < orderProdList.size(); i++) {
				// 옵션이 있을 경우
				if (orderProdList.get(i).getOptionId() != null) {
					for (int j = 0; j < orderProdList.get(i).getProdCount().length; j++) {
						String optionId = orderProdList.get(i).getOptionId()[j];
						String productId = orderProdList.get(i).getProductId();

						ProdOption option = productService.selectOptionOne(optionId);
						Product product = productService.selectProductOne(productId);

						// 옵션 재고 줄이기
						int optionStock = option.getOptionStock()
								- Integer.parseInt(orderProdList.get(i).getProdCount()[j]);
						option.setOptionStock(optionStock);
						int optResult = productService.updateOption(option);

						// 제품 재고 줄이기
						int productStock = product.getProductStock()
								- Integer.parseInt(orderProdList.get(i).getProdCount()[j]);
						product.setProductStock(productStock);
						int prodResult = productService.updateProduct(product);

					}
				} else {
					String productId = orderProdList.get(i).getProductId();
					Product product = productService.selectProductOne(productId);
					// 제품 재고 줄이기
					int productStock = product.getProductStock()
							- Integer.parseInt(orderProdList.get(i).getProdCount()[0]);
					product.setProductStock(productStock);
					int prodResult = productService.updateProduct(product);

				}
			}
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
		Date time = new Date();
		String orderDate = dateFormat.format(time);

		String method = orderList.getPayMethod();
		String payMethod = "";
		switch (method) {
		case "cr":
			payMethod = "신용카드 결제";
			break;
		case "ac":
			payMethod = "무통장입금";
			break;
		case "ph":
			payMethod = "휴대폰 결제";
			break;
		case "ka":
			payMethod = "카카오페이 결제";
			break;
		case "to":
			payMethod = "토스 결제";
			break;
		case "na":
			payMethod = "네이버페이 결제";
			break;
		case "ra":
			payMethod = "실시간계좌이체";
			break;
		}
		
		
		//장바구니 삭제
		int cartResult=0;
		String[] cartIdArr = (String[])session.getAttribute("cartIdArr");
		if(cartIdArr!=null) {
			for(int i=0;i<cartIdArr.length;i++) {
				String cartId = cartIdArr[i];
				cartResult = shopMemberService.deleteCart(cartId);
			}
		}
		mav.addObject("orderNo", orderList.getOrderNo());
		mav.addObject("orderDate", orderDate);
		mav.addObject("payPrice", totalPrice);
		mav.addObject("payMethod", payMethod);
		mav.setViewName("shop/checkOut/finishPayment");
		return mav;
	}

	/**
	 * 0408 이진희
	 * 
	 * 주문하기완료
	 */
	@PostMapping("/finishPayment.do")
	public ModelAndView finishPayment(ModelAndView mav, OrderList orderList, HttpSession session,
			@RequestParam(value = "bankName", required = false) String bankName,
			@RequestParam(value = "accountHolder", required = false) String accountHolder,
			@RequestParam(value = "accountNo", required = false) String accountNo,
			@RequestParam(value = "expireDate", required = false) String expireDate,
			@RequestParam(value = "totalPrice", required = false) String totalPrice,
			@RequestParam(value = "prodPrice", required = false) String prodPrice,
			@RequestParam(value = "totalDiscount", required = false) String totalDiscount,
			@RequestParam(value = "usedPoint", required = false) String usedPoint,
			@RequestParam(value = "usedCoupon", required = false) String usedCoupon,
			@RequestParam(value = "couponListId", required = false) String couponListId,
			@RequestParam(value = "addPoint", required = false) String addPoint,
			RedirectAttributes redirectAttributes) {

		Member m = (Member) session.getAttribute("memberLoggedIn");
		List<OrderProduct> orderProdList = (ArrayList<OrderProduct>) session.getAttribute("orderProdList");
		orderList.setMemberId(m.getMemberId());
		String sellerId = productService.selectSellerId(orderProdList.get(0).getProductId());
		String recptPhone = orderList.getRecptPhone();
		orderList.setRecptPhone(recptPhone.replaceAll("-", ""));
		orderList.setSellerId(sellerId);

		orderList.setDeliveryNo("deliTest1");
		if ("ac".equals(orderList.getPayMethod())) {
			orderList.setPayState("N");// 미입금
			orderList.setDeliveryState("A");// 입금대기
		} else {
			orderList.setPayState("Y");
			orderList.setDeliveryState("B");

		}

		PaymentInfo paymentInfo = new PaymentInfo();
		paymentInfo.setProdPrice(Integer.parseInt(prodPrice));
		paymentInfo.setTotalDiscount(Integer.parseInt(totalDiscount));
		paymentInfo.setUsedPoint(Integer.parseInt(usedPoint));
		paymentInfo.setUsedCoupon(Integer.parseInt(usedCoupon));

		ShopMember sMem = shopMemberService.selectOne(m.getMemberId());

		ShopMember memVal = shopMemberService.selectShopMem(m.getMemberId());

		if (memVal == null) {
			int shopMemResult = shopMemberService.insertShopMem(sMem);
		}

		// 쿠폰사용
		if (paymentInfo.getUsedCoupon() > 0) {
			Coupon coupon = new Coupon();
			for (int i = 0; i < sMem.getCouponList().size(); i++) {
				if (sMem.getCouponList().get(i).getCouponListId().equals(couponListId)) {
					sMem.getCouponList().get(i).setCouponState("N");
					coupon.setMemberId(m.getMemberId());
					coupon.setCouponListId(couponListId);
					coupon.setCouponState("N");
				}
			}

			int couponResult = shopMemberService.updateCoupon(coupon);
			redirectAttributes.addFlashAttribute("msg", couponResult > 0 ? "쿠폰 사용 성공!" : "쿠폰 사용 실패");
		}
		// 포인트사용 및 포인트 적립
		if (paymentInfo.getUsedPoint() > 0 && paymentInfo.getUsedPoint() <= sMem.getPoint()) {
			int afterPoint = sMem.getPoint() - paymentInfo.getUsedPoint() + Integer.parseInt(addPoint);
			sMem.setPoint(afterPoint);
			int pointResult = shopMemberService.updateConsumerInfo(sMem);
			redirectAttributes.addFlashAttribute("msg", pointResult > 0 ? "포인트 사용 성공!" : "포인트 사용 실패");
		} else {
			// 포인트 적립만
			int afterPoint = sMem.getPoint() + Integer.parseInt(addPoint);
			System.out.println("afterPoint=" + afterPoint);
			sMem.setPoint(afterPoint);
			System.out.println("sMem=" + sMem);
			int pointResult = shopMemberService.updateConsumerInfo(sMem);
			System.out.println("pointRe=" + pointResult);
			redirectAttributes.addFlashAttribute("msg", pointResult > 0 ? "포인트 적립 성공!" : "포인트 적립 실패");
		}

		// 주문하기
		int result = orderService.insertOrder(orderList, orderProdList, paymentInfo);
		redirectAttributes.addFlashAttribute("msg", result > 0 ? "주문성공!" : "주문실패");

		// 수량 감소
		if (result > 0) {
			for (int i = 0; i < orderProdList.size(); i++) {
				// 옵션이 있을 경우
				if (orderProdList.get(i).getOptionId() != null) {
					for (int j = 0; j < orderProdList.get(i).getProdCount().length; j++) {
						String optionId = orderProdList.get(i).getOptionId()[j];
						String productId = orderProdList.get(i).getProductId();

						ProdOption option = productService.selectOptionOne(optionId);
						Product product = productService.selectProductOne(productId);

						// 옵션 재고 줄이기
						int optionStock = option.getOptionStock()
								- Integer.parseInt(orderProdList.get(i).getProdCount()[j]);
						option.setOptionStock(optionStock);
						int optResult = productService.updateOption(option);

						// 제품 재고 줄이기
						int productStock = product.getProductStock()
								- Integer.parseInt(orderProdList.get(i).getProdCount()[j]);
						product.setProductStock(productStock);
						int prodResult = productService.updateProduct(product);

					}
				} else {
					String productId = orderProdList.get(i).getProductId();
					Product product = productService.selectProductOne(productId);
					// 제품 재고 줄이기
					int productStock = product.getProductStock()
							- Integer.parseInt(orderProdList.get(i).getProdCount()[0]);
					product.setProductStock(productStock);
					int prodResult = productService.updateProduct(product);

				}
			}
		}
		// 가상계좌입금일 경우
		if (!bankName.equals("")) {
			orderList.setPayState("N");
			orderList.setDeliveryState("A");
			PayAccountInfo payAccInfo = new PayAccountInfo();
			payAccInfo.setAccountHolder(accountHolder);
			payAccInfo.setBankName(bankName);
			payAccInfo.setAccountNo(accountNo);
			payAccInfo.setOrderNo(orderList.getOrderNo());

			try {
				String strDate = expireDate;
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date exDate = transFormat.parse(strDate);
				java.sql.Date sqlExDate = new java.sql.Date(exDate.getTime());
				payAccInfo.setExpireDate(sqlExDate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int payAccResult = orderService.insertPayAccInfo(payAccInfo);
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
		Date time = new Date();
		String orderDate = dateFormat.format(time);

		String method = orderList.getPayMethod();
		String payMethod = "";
		switch (method) {
		case "cr":
			payMethod = "신용카드 결제";
			break;
		case "ac":
			payMethod = "가상계좌 입금";
			break;
		case "ph":
			payMethod = "휴대폰 결제";
			break;
		case "ka":
			payMethod = "카카오페이 결제";
			break;
		case "to":
			payMethod = "토스 결제";
			break;
		case "na":
			payMethod = "네이버페이 결제";
			break;
		case "ra":
			payMethod = "실시간계좌이체";
			break;
		}
		
		//장바구니 삭제
		int cartResult=0;
		String[] cartIdArr = (String[])session.getAttribute("cartIdArr");
		if(cartIdArr!=null) {
			for(int i=0;i<cartIdArr.length;i++) {
				String cartId = cartIdArr[i];
				cartResult = shopMemberService.deleteCart(cartId);
			}
		}
		
		

		mav.addObject("orderNo", orderList.getOrderNo());
		mav.addObject("orderDate", orderDate);
		mav.addObject("payPrice", totalPrice);
		mav.addObject("payMethod", payMethod);
		mav.setViewName("shop/checkOut/finishPayment");
		return mav;
	}

	@PostMapping("/checkOut.do")
	public ModelAndView checkOut(ModelAndView mav, HttpServletRequest request,
			@RequestParam(value = "check", required = false) String[] cartId,
			@RequestParam(value = "cartIdOne", required = false) String cartIdOne,
			@RequestParam(value = "optionId", required = false) String[] optionId,
			@RequestParam(value = "optionPrice", required = false) String[] optionPrice,
			@RequestParam(value = "count", required = false) String[] count, HttpSession session) {

		Member m = (Member) session.getAttribute("memberLoggedIn");
		ShopMember sMem = shopMemberService.selectOne(m.getMemberId());
		String memberId = m.getMemberId();
		
		List<Coupon> myCouponList = couponService.selectListMyCoupon(memberId);
		sMem.setCouponList(myCouponList);

		List<OrderProduct> orderProdList = new ArrayList<>();
		List<Product> prodList = new ArrayList<>();
		List<Integer> totalAmountList = new ArrayList<>();
		List<Integer> totalPriceList = new ArrayList<>();

		// 바로구매
		if (cartId == null) {
			Product product = (Product) session.getAttribute("p");
			// 결제하기에 필요한 객체 생성
			OrderProduct orderProd = new OrderProduct();
			orderProd.setOptionId(optionId);
			orderProd.setProdCount(count);
			orderProd.setProductId(product.getProductId());
			orderProdList.add(orderProd);
			session.setAttribute("orderProdList", orderProdList);

			List<Attachment> attachList = (List<Attachment>) session.getAttribute("attachList");
			List<ProdOption> optionList = new ArrayList<>();
			int totalAmount = 0;
			int totalPrice = 0;
			// 옵션이 있는경우
			if (optionId != null) {

				for (int i = 0; i < optionId.length; i++) {
					String optionID = optionId[i];
					ProdOption option = productService.selectOptionOne(optionID);
					System.out.println("option" + option);
					option.setOptionPrice(Integer.parseInt(optionPrice[i]));
					option.setOptionStock(Integer.parseInt(count[i]));
					totalAmount += Integer.parseInt(count[i]);
					totalPrice += option.getOptionPrice() * Integer.parseInt(count[i]);
					optionList.add(option);
				}
				product.setOptionList(optionList);
				totalAmountList.add(totalAmount);
				totalPriceList.add(totalPrice);
			}
			// 옵션없는경우
			else {
				int stock = Integer.parseInt(count[0]);
				int prodPrice = (product.getPrice() - product.getDiscountPrice()) * stock;
				totalPriceList.add(prodPrice);
				totalAmountList.add(stock);

			}

			product.setAttachList(attachList);
			prodList.add(product);
		}
		// 장바구니 구매
		else {
			// 상품 한개 바로구매
			if (cartIdOne != null) {
				String cartIdArr[] = new String[1];
				cartIdArr[0] =cartIdOne;
				session.setAttribute("cartIdArr", cartIdArr);
				
				Cart cart = shopMemberService.selectCartOne(cartIdOne);
				Product product = productService.selectProductOne(cart.getProductId());
				prodList.add(product);

				// 결제하기에 필요한 객체 생성
				OrderProduct orderProd = new OrderProduct();
				orderProd.setOptionId(cart.getOptionId());
				orderProd.setProdCount(cart.getProdCount());
				orderProd.setProductId(product.getProductId());
				orderProdList.add(orderProd);
				session.setAttribute("orderProdList", orderProdList);

				List<Attachment> attachList = productService.selectAttachList(cart.getProductId());
				product.setAttachList(attachList);

				List<ProdOption> optionList = new ArrayList<>();
				if (cart.getOptionId() != null) {
					int totalPrice = 0;
					int totalAmount = 0;
					for (int t = 0; t < cart.getOptionId().length; t++) {
						String optId = cart.getOptionId()[t];
						ProdOption prodOption = productService.selectOptionOne(optId);
						optionList.add(prodOption);
						int stock = Integer.parseInt(cart.getProdCount()[t]);
						prodOption.setOptionStock(stock);
						totalAmount += stock;
						totalPrice += (optionList.get(t).getOptionPrice() - product.getDiscountPrice()) * stock;
					}
					totalAmountList.add(totalAmount);
					totalPriceList.add(totalPrice);
					product.setOptionList(optionList);
				} else {
					int stock = Integer.parseInt(cart.getProdCount()[0]);
					int prodPrice = (product.getPrice() - product.getDiscountPrice()) * stock;
					totalPriceList.add(prodPrice);
					totalAmountList.add(stock);
				}

			}
			// 선택된 장바구니 상품만 구매
			else {
				
				String cartIdArr[] = new String[cartId.length];
				cartIdArr= cartId;
				session.setAttribute("cartIdArr", cartIdArr);
				
				List<Cart> cartList = new ArrayList<>();
				for (int i = 0; i < cartId.length; i++) {
					Cart cart = shopMemberService.selectCartOne(cartId[i]);
					cartList.add(cart);
					Product product = productService.selectProductOne(cart.getProductId());
					prodList.add(product);

					// 결제하기에 필요한 객체 생성
					OrderProduct orderProd = new OrderProduct();
					orderProd.setOptionId(cart.getOptionId());
					orderProd.setProdCount(cart.getProdCount());
					orderProd.setProductId(product.getProductId());
					orderProdList.add(orderProd);

					List<Attachment> attachList = productService.selectAttachList(cart.getProductId());
					List<ProdOption> optionList = new ArrayList<>();
					if (cartList.get(i).getOptionId() != null) {
						for (int t = 0; t < cartList.get(i).getOptionId().length; t++) {
							String optId = cartList.get(i).getOptionId()[t];
							ProdOption prodOption = productService.selectOptionOne(optId);
							int stock = Integer.parseInt(cartList.get(i).getProdCount()[t]);
							prodOption.setOptionStock(stock);
							optionList.add(prodOption);
						}
						product.setOptionList(optionList);
					}

					product.setAttachList(attachList);

					// 옵션이 있는 경우
					if (cartList.get(i).getOptionId() != null) {
						int totalPrice = 0;
						int totalAmount = 0;
						for (int j = 0; j < optionList.size(); j++) {
							int stock = Integer.parseInt(cartList.get(i).getProdCount()[j]);
							totalAmount += stock;
							totalPrice += (optionList.get(j).getOptionPrice() - product.getDiscountPrice()) * stock;
						}
						totalAmountList.add(totalAmount);
						totalPriceList.add(totalPrice);
						product.setOptionList(optionList);

					} else {
						int stock = Integer.parseInt(cartList.get(i).getProdCount()[0]);
						int prodPrice = (product.getPrice() - product.getDiscountPrice()) * stock;
						totalPriceList.add(prodPrice);
						totalAmountList.add(stock);
					}
				}
				session.setAttribute("orderProdList", orderProdList);
			}

		}
		log.debug("cartId={}", cartId);
		mav.addObject("prodList", prodList);
		mav.addObject("sMem", sMem);
		mav.addObject("totalAmountList", totalAmountList);
		mav.addObject("totalPriceList", totalPriceList);
		mav.setViewName("shop/checkOut/checkOut");
		return mav;
	}

}

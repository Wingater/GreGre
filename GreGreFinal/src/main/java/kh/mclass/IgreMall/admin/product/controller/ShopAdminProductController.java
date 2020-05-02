package kh.mclass.IgreMall.admin.product.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kh.mclass.Igre.common.util.Utils;
import kh.mclass.IgreMall.admin.product.model.exception.ProductException;
import kh.mclass.IgreMall.admin.product.model.service.AdminProductService;
import kh.mclass.IgreMall.product.model.vo.Attachment;
import kh.mclass.IgreMall.product.model.vo.ProdOption;
import kh.mclass.IgreMall.product.model.vo.Product;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/shop/admin/product")
public class ShopAdminProductController {

	@Autowired
	AdminProductService adminProductService;
	@Autowired
	ServletContext servletContext;

	@Autowired
	ResourceLoader resourceLoader;
	
	@RequestMapping("editProduct.do") 
	public String editProduct(@ModelAttribute Product product, 
							  @RequestParam(value="optionName", required=false)String[] optionName, 
							  @RequestParam(value="optionValue1", required=false)String[] optionValue1, 
							  @RequestParam(value="optionValue2", required=false)String[] optionValue2, 
							  @RequestParam(value="optionStock", required=false)String[] optionStock,
							  @RequestParam(value="optionSupplyValue", required=false)String[] optionSupplyValue,
							  @RequestParam(value="optionPrice", required=false)String[] optionPrice, 
							  @RequestParam(value="optionState", required=false)String[] optionState, 
							  MultipartHttpServletRequest mtfRequest,
							  RedirectAttributes redirectAttributes, 
							  HttpServletRequest request,
							  HttpServletResponse response) throws Exception{
		log.debug("product={}", product);
		product.setDeliveryFee(product.getDeliveryFee().replaceAll(",", ""));
		
		List<ProdOption> prodOptionList = new ArrayList<>();
		if(optionName != null) {
			for(int i=0; i< optionValue1.length;i++) {
				ProdOption prodOption = new ProdOption();
				String optValue = optionValue1[i];
					if(optionValue2 !=null) {
						optValue +=","+optionValue2[i];
					}
					String optionNameRe ="";
					optionNameRe =optionName[0];    			
					if(optionName.length>1) {
						optionNameRe = optionName[1]+ ","+optionName[0];
					}
					prodOption.setOptionName(optionNameRe);
					prodOption.setOptionValue(optValue);
					prodOption.setOptionSupplyValue(Integer.parseInt(optionSupplyValue[i]));
					prodOption.setOptionPrice(Integer.parseInt(optionPrice[i]));
					prodOption.setOptionStock(Integer.parseInt(optionStock[i]));
					prodOption.setOptionState(optionState[i]);
					prodOption.setProductId(product.getProductId());
					prodOptionList.add(prodOption);	
			}
		}
		log.debug("prodOption={}", prodOptionList);

		response.setContentType("text/html;charset=utf-8");

		try {
			List<Attachment> attachList = new ArrayList<>();
			// 메인 이미지파일
			MultipartFile mainImgFile = mtfRequest.getFile("mainImg");
			String mainOriginalFileName = mainImgFile.getOriginalFilename(); // 원본 파일 명
			String mainRenamedFileName = Utils.getRenamedFileName(mainOriginalFileName);
			Attachment attach1 = new Attachment();
			attach1.setOriginalImg(mainOriginalFileName);
			attach1.setRenamedImg(mainRenamedFileName);
			attach1.setProductId(product.getProductId());
			attach1.setImgType("R");
			attachList.add(attach1);
			// 	파일이동
			String saveDirectory1 = request.getServletContext().getRealPath("/resources/upload/shop/productMainImg");
			try {
				mainImgFile.transferTo(new File(saveDirectory1, mainRenamedFileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			/* sub 이미지 */
			// 	sub이미지파일
			List<MultipartFile> fileList = mtfRequest.getFiles("subImg");
			for (MultipartFile f : fileList) {
				// 	비어있는 MultipartFile객체가 전달된 경우(파일 하나만 업로드)
				// 	파일이 없다면 밑에는 실행하지 말아라
				if (f.isEmpty())
					continue;
				// 	파일 재생성 renamedFileName으로 저장하기
				String subOriginalFileName = f.getOriginalFilename();
				String subRenamedFileName = Utils.getRenamedFileName(subOriginalFileName);
				// 파일이동
				String saveDirectory2 = request.getServletContext().getRealPath("/resources/upload/shop/productSubImg");
				try {
					f.transferTo(new File(saveDirectory2, subRenamedFileName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				// 	실제 파일데이터 originalFileName, renamedFileName을 db에 저장
				// 	Attachment객체
				Attachment attach2 = new Attachment();
				attach2.setOriginalImg(subOriginalFileName);
				attach2.setRenamedImg(subRenamedFileName);
				attach2.setProductId(product.getProductId());
				attach2.setImgType("D");
				attachList.add(attach2);
			}
			log.debug("attachList={}", attachList);
			int result = adminProductService.editProduct(product, attachList, prodOptionList);
			
			redirectAttributes.addFlashAttribute("msg", result > 0 ? "등록성공!" : "등록실패");
		} catch (Exception e) {
			log.error("상품 수정 오류!", e);
			throw new ProductException("상품 수정 오류! 관리자에게 문의하세요");
		}
		return "redirect:/shop/admin/product/list.do";
	}
	
	/*
	 * @RequestMapping("editProduct.do") public ModelAndView
	 * productUpdate(ModelAndView mav,Product product,
	 * 
	 * @RequestParam(value="optionName", required=false)String[] optionName,
	 * 
	 * @RequestParam(value="optionValue1", required=false)String[] optionValue1,
	 * 
	 * @RequestParam(value="optionValue2", required=false)String[] optionValue2,
	 * 
	 * @RequestParam(value="optionStock", required=false)String[] optionStock,
	 * 
	 * @RequestParam(value="optionSupplyValue", required=false)String[]
	 * optionSupplyValue,
	 * 
	 * @RequestParam(value="optionPrice", required=false)String[] optionPrice,
	 * 
	 * @RequestParam(value="optionState", required=false)String[] optionState) {
	 * System.out.println("mav 업데이트 돌아가냐"); log.debug("product={}", product);
	 * 
	 * List<ProdOption> prodOptionList = new ArrayList<>(); if(optionName != null) {
	 * 
	 * 
	 * for(int i=0; i< optionValue1.length;i++) {
	 * 
	 * ProdOption prodOption = new ProdOption(); String optValue = optionValue1[i];
	 * if(optionValue2 !=null) { optValue +=","+optionValue2[i]; } String
	 * optionNameRe ="";
	 * 
	 * optionNameRe =optionName[0];
	 * 
	 * if(optionName.length>1) { optionNameRe = optionName[1]+ ","+optionName[0]; }
	 * 
	 * 
	 * prodOption.setOptionName(optionNameRe); prodOption.setOptionValue(optValue);
	 * prodOption.setOptionSupplyValue(Integer.parseInt(optionSupplyValue[i]));
	 * prodOption.setOptionPrice(Integer.parseInt(optionPrice[i]));
	 * prodOption.setOptionStock(Integer.parseInt(optionStock[i]));
	 * prodOption.setOptionState(optionState[i]);
	 * prodOption.setProductId(product.getProductId());
	 * prodOptionList.add(prodOption);
	 * 
	 * }
	 * 
	 * 
	 * } int result = adminProductService.editProduct(product);
	 * log.debug("prodOption={}", prodOptionList);
	 * 
	 * 
	 * mav.setViewName("redirect:/shop/admin/product/edit.do"); return mav; }
	 */
	
	
	
	@RequestMapping("edit.do")
	public ModelAndView productEdit(ModelAndView mav,String productId) {
		Product p = adminProductService.productEdit(productId);
		List<ProdOption> o = adminProductService.productOption(productId);
		String optionName="";
		String optionValue="";
		for(int i=0;i<o.size();i++) {
			System.out.println(o.get(i).getOptionName());
		optionName = o.get(i).getOptionName();
		optionValue += o.get(i).getOptionValue()+" ";
		}
		System.out.println("optionName"+optionName);
		System.err.println("optionValue"+optionValue);
		String[] optName=optionName.split(",");
		 String[] optValue = optionValue.split(" "); 
		System.out.println("결과 optionName="+Arrays.toString(optName));
		System.out.println("결과 optionValue="+Arrays.toString(optValue));
		//수정 한 부분 여기만 지워
		//수정끝
		mav.addObject("p",p);
		mav.addObject("o",o);
		mav.addObject("optName",optName);
		mav.addObject("optValue",optValue);
		
		mav.setViewName("shop/admin/product/updateProduct");
		return mav;

	}
	@RequestMapping("/search.do")
	public ModelAndView searchProduct(ModelAndView mav, @RequestParam("sellerId") String sellerId,
			@RequestParam(value = "productName", required = false) String productName,
			@RequestParam(value = "startDate", defaultValue = "1992-04-14") Date startDate,
			@RequestParam(value = "endDate", defaultValue = "1994-04-7") Date endDate,
			@RequestParam(value = "productState", required = false) String productState) {

		log.debug("서치를 시작합니다.");
		log.debug("productName={}", productName);
		log.debug("sellerId={}", sellerId);
		log.debug("~~~~!!!productState={}", productState);
//		java.sql.Date s=java.sql.Date.valueOf(startDate.toString());
//		java.sql.Date e=java.sql.Date.valueOf(endDate.toString());

//		Map<String, Object> time = new HashMap<String, Object>();
//		time.put("startDate", s);
//		time.put("endDate", e);
//		time.put("sellerId",sellerId);
//		time.put("productState",productState);
//		time.put("productName",productName);
//		if(time.get("startDate")=="") {
//			time.put("startDate","");
//		}if(time.get("endDate")=="") {
//			time.put("endDate","");
//		} if(time.get("productName")=="") {
//			time.put("productName","");
//		} if(time.get("productState")=="") {
//			time.put("productState","");
//		}
		// 리스트에 해당 맵을 넣어서 보내줌
//		List<Map<String, Object>> list = adminProductService.searchProduct(time);

		// 진희
		if (endDate.equals(java.sql.Date.valueOf("1994-04-07"))) {
			endDate = new Date(new java.util.Date().getTime());
		}
		Product p = new Product();
		p.setSellerId(sellerId);
		p.setProductName(productName);
		p.setProductState(productState);
		List<Product> allProdList = adminProductService.productListSeller(p);
		List<Product> list = new ArrayList<>();

		for (int i = 0; i < allProdList.size(); i++) {
			if (!startDate.after(allProdList.get(i).getEnrollDate())
					&& !endDate.before(allProdList.get(i).getEnrollDate())) {
				list.add(allProdList.get(i));
			}
		}
		log.debug("list" + list);
		// 자료형 확인하는 공간
		// 제품 갯수 구하기
		
		
		
		
		int totalProducts = adminProductService.totalProducts(p);
		mav.addObject("totalProducts", totalProducts);
//		log.debug("searchList={}",list);
		mav.addObject("list", list);
		mav.setViewName("shop/admin/product/list");
		return mav;
	}

	@RequestMapping("/delete.do")
	public ModelAndView deleteProduct(ModelAndView mav, String productId) {
		Product p = new Product();
		p.setProductId(productId);
		System.out.println("productId=" + productId);
		int result = adminProductService.deleteProduct(p);

		log.debug("딜리트완료");
		mav.setViewName("redirect:/shop/admin/product/list.do");
		return mav;
	}

	@RequestMapping("/update.do")
	public ModelAndView updateProduct(ModelAndView mav, HttpServletRequest request, HttpServletResponse response,
			 Attachment a,String productId, int discountPrice, int productStock, String productState,
			@RequestParam(value="upFile", required=false) MultipartFile upfile
			) {
		
		
		if(a.getOriginalImg() != null) {
			if(a.getOriginalImg().equals("delete")) {
				a.setOriginalImg(null);
				a.setRenamedImg(null);
			}
			else if(a.getOriginalImg().equals("change")) {
				if(!(upfile.isEmpty())) {

					String originFileName = upfile.getOriginalFilename();
					String renamedFileName = Utils.getRenamedFileName(originFileName);
					
					//파일 이동
					String saveDirectory = request.getServletContext().getRealPath("/resources/upload/board");
					
					try {
						upfile.transferTo(new File(saveDirectory, renamedFileName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
					
					a.setOriginalImg(originFileName);
					a.setRenamedImg(renamedFileName);
					
				} else {
					a.setOriginalImg(null);
					a.setRenamedImg(null);
				}
			}
		}
		System.err.println("왜 ?;");
		Product p = new Product();

		p.setProductId(productId);
		p.setDiscountPrice(discountPrice);
		p.setProductStock(productStock);
		p.setProductState(productState);
		int result = adminProductService.updateProduct(p);
		mav.setViewName("shop/admin/product/");
		log.debug("업데이트완료");
		mav.setViewName("redirect:/shop/admin/product/list.do");

		return mav;
	}

	@GetMapping("/insert.do")
	public ModelAndView insertProduct(ModelAndView mav) {
		mav.setViewName("shop/admin/product/insertProduct");
		return mav;
	}

	@PostMapping("/image")
	public void summer_image(MultipartFile file, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String file_name = file.getOriginalFilename();
		log.debug("file_name={}", file_name);
		String server_file_name = Utils.getRenamedFileName(file_name);
		System.out.println("server file : " + server_file_name);
		String save_folder = request.getServletContext().getRealPath("/resources/upload/shop/productDetail");
		file.transferTo(new File(save_folder + server_file_name));
		out.println("resources/upload" + server_file_name);
		out.close();

	}

	/**
	 * 0326 진희 작업 이미지 파일 업로드 메소드
	 * 
	 * @param file
	 * @param request
	 * @return
	 */
	@PostMapping("/insertImg.do")
	@ResponseBody
	public List<String> insertBoardImg(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
		List<String> list = new ArrayList<String>();
		// 파일명 재생성
		String originalFileName = file.getOriginalFilename();
		String renamedFileName = Utils.getRenamedFileName(originalFileName);
		// 파일 이동 경로
		String saveDirectory = request.getServletContext().getRealPath("/resources/upload/shop/productDetail");
		// 파일 생성.
		try {
			file.transferTo(new File(saveDirectory, renamedFileName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		list.add(originalFileName);
		list.add(renamedFileName);
		list.add("../resources/upload/shop/productDetail/" + renamedFileName);
		return list;
	}

	/*
	 * 0325
	 * 이진희
	 * 0325 이진희
	/*진희수정1*/
	@PostMapping("/insert.do")
	public String insertProduct(@ModelAttribute Product product, 
						@RequestParam(value="optionName", required=false)String[] optionName, 
						@RequestParam(value="optionValue1", required=false)String[] optionValue1, 
						@RequestParam(value="optionValue2", required=false)String[] optionValue2, 
						@RequestParam(value="optionStock", required=false)String[] optionStock,
						@RequestParam(value="optionSupplyValue", required=false)String[] optionSupplyValue,
						@RequestParam(value="optionPrice", required=false)String[] optionPrice, 
						@RequestParam(value="optionState", required=false)String[] optionState, 
							MultipartHttpServletRequest mtfRequest,
							RedirectAttributes redirectAttributes, 
							HttpServletRequest request,
							HttpServletResponse response) throws Exception{
		log.debug("product={}", product);
		product.setDeliveryFee(product.getDeliveryFee().replaceAll(",", ""));
		
		List<ProdOption> prodOptionList = new ArrayList<>();
        if(optionName != null) {
        	
        	
        	for(int i=0; i< optionValue1.length;i++) {
        		
        		ProdOption prodOption = new ProdOption();
        		String optValue = optionValue1[i];
        		if(optionValue2 !=null) {
        			optValue +=","+optionValue2[i];
        		}
        		String optionNameRe ="";
        	
        		optionNameRe =optionName[0];    			
        	
        		if(optionName.length>1) {
        			optionNameRe = optionName[1]+ ","+optionName[0];
        		}
        
 
        		prodOption.setOptionName(optionNameRe);
        		prodOption.setOptionValue(optValue);
        		prodOption.setOptionSupplyValue(Integer.parseInt(optionSupplyValue[i]));
        		prodOption.setOptionPrice(Integer.parseInt(optionPrice[i]));
        		prodOption.setOptionStock(Integer.parseInt(optionStock[i]));
        		prodOption.setOptionState(optionState[i]);
        		prodOption.setProductId(product.getProductId());
        		prodOptionList.add(prodOption);	
        		
        	}
        	
     
        }
        log.debug("prodOption={}", prodOptionList);
        
		response.setContentType("text/html;charset=utf-8");

		try {
			List<Attachment> attachList = new ArrayList<>();
			// 메인 이미지파일
			MultipartFile mainImgFile = mtfRequest.getFile("mainImg");
			String mainOriginalFileName = mainImgFile.getOriginalFilename(); // 원본 파일 명
			String mainRenamedFileName = Utils.getRenamedFileName(mainOriginalFileName);
			Attachment attach1 = new Attachment();
			attach1.setOriginalImg(mainOriginalFileName);
			attach1.setRenamedImg(mainRenamedFileName);
			attach1.setProductId(product.getProductId());
			attach1.setImgType("R");
			attachList.add(attach1);
			// 파일이동
			String saveDirectory1 = request.getServletContext().getRealPath("/resources/upload/shop/productMainImg");
			try {
				mainImgFile.transferTo(new File(saveDirectory1, mainRenamedFileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			/* sub 이미지 */
			// sub이미지파일
			List<MultipartFile> fileList = mtfRequest.getFiles("subImg");
			for (MultipartFile f : fileList) {
				// 비어있는 MultipartFile객체가 전달된 경우(파일 하나만 업로드)
				// 파일이 없다면 밑에는 실행하지 말아라
				if (f.isEmpty())
					continue;
				// 파일 재생성 renamedFileName으로 저장하기
				String subOriginalFileName = f.getOriginalFilename();
				String subRenamedFileName = Utils.getRenamedFileName(subOriginalFileName);
				// 파일이동
				String saveDirectory2 = request.getServletContext().getRealPath("/resources/upload/shop/productSubImg");
				try {
					f.transferTo(new File(saveDirectory2, subRenamedFileName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				// 실제 파일데이터 originalFileName, renamedFileName을 db에 저장
				// Attachment객체
				Attachment attach2 = new Attachment();
				attach2.setOriginalImg(subOriginalFileName);
				attach2.setRenamedImg(subRenamedFileName);
				attach2.setProductId(product.getProductId());
				attach2.setImgType("D");
				attachList.add(attach2);
			}
			log.debug("attachList={}", attachList);
			int result = adminProductService.insertProduct(product, attachList, prodOptionList);

			redirectAttributes.addFlashAttribute("msg", result > 0 ? "등록성공!" : "등록실패");
			return "redirect:/shop/admin/product/insert.do";
		} catch (Exception e) {
			log.error("상품 등록 오류!", e);
			throw new ProductException("상품 등록 오류! 관리자에게 문의하세요");
		}
		
//		return "redirect:/shop/admin/product/insert.do";
	}

	@GetMapping("/list.do")
	public ModelAndView productList(ModelAndView mav, Product p,
			@RequestParam(value="cPage", defaultValue="1") int cPage) {
		
	
		final int numPerPage = 10;
		List<Product> list = adminProductService.productList(cPage, numPerPage, p);
		log.debug("list={}",list);
		
		System.out.println(list.get(0).getAttachList());
		
//		  List<Attachment> attachList = new ArrayList<>(); for (int
//		  i=0;i<list.size();i++) {
//		 Attachment a = adminProductService.selectAttachOne(list.get(i).getProductId());
//		  attachList.add(a); }
		 		
		if (p.getProductName() == null) {
			p.setProductName("");
		}
		if (p.getProductState() == null) {
			p.setProductState("");
		}
		System.out.println(p.getProductState());
		// 아래 ProductId 는 객체 P를 의미함	.
		int totalProducts = adminProductService.totalProducts(p);
		
		
//		mav.addObject("attachList",attachList);
		
		int endPage = ((totalProducts-1)/10)+1; //마지막페이지 번호
		
		if(cPage>endPage) { //크면 마지막페이지고
			cPage = endPage;
		}
		if(cPage<1) {
			cPage = 1;
		}
		  final int pageStart = ((cPage-1)/numPerPage)*numPerPage+1;             
	      final int pageEnd = pageStart+numPerPage-1;

	      final int totalPage= (int)Math.ceil((double)totalProducts/numPerPage); 
	      int pageNo = pageStart;
	      
	      mav.addObject("pageNo",pageNo);
	      mav.addObject("pageEnd", pageEnd);
	      mav.addObject("pageBarSize", numPerPage );
	      mav.addObject("pageStart", pageStart);
	      mav.addObject("totalPage",totalPage);

		mav.addObject("totalProducts", totalProducts);
		mav.addObject("list", list);
		mav.setViewName("shop/admin/product/list");
		mav.addObject("cPage",cPage);
		mav.addObject("endPage",endPage);
		return mav;

		
	}
}

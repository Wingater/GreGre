 package kh.mclass.Igre.mypage.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.emory.mathcs.backport.java.util.Arrays;
import kh.mclass.Igre.counselling.model.vo.BookingInfo;
import kh.mclass.Igre.counselling.model.vo.Counselor;
import kh.mclass.Igre.counselling.model.vo.Review;
import kh.mclass.Igre.member.model.vo.BizMember;
import kh.mclass.Igre.member.model.vo.Member;
import kh.mclass.Igre.mypage.model.service.MyPageService;
import kh.mclass.Igre.mypage.model.vo.Child;
import kh.mclass.Igre.mypage.model.vo.Period;
import kh.mclass.Igre.mypage.model.vo.Vaccination;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/myPage")
@SessionAttributes(value= {"memberLoggedIn"})
public class MyPageController {
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	@Autowired
	private MyPageService mps;
	
	@GetMapping("/myPageMain")
	public ModelAndView mypageview(Member member,Period period,BookingInfo book,ModelAndView mav,HttpSession session,Child child,Vaccination vaccination) {
			
			Member m = (Member) session.getAttribute("memberLoggedIn");
			
			String parentsId = m.getMemberId();
			child.setParentsId(parentsId);
			vaccination.setParentsId(parentsId);
			book.setMemberId(m.getMemberId());
			period.setMemberId(m.getMemberId());
			List<Child> list = mps.selectChild(child);
			List<Vaccination> list2 = mps.selectVaccination(vaccination);
			List<BookingInfo> list3 = mps.selectBookingInfoList(book);
			List<Period> list4 = mps.selectPeriod(period);
			
			
			mav.addObject("list",list);
			mav.addObject("list2",list2);
			mav.addObject("list3",list3);
			mav.addObject("list4",list4);
			mav.addObject("m",m);
			mav.setViewName("myPage/myPageMain");

		return mav;
	}
	
	//기업회원 마이페이지
	@GetMapping("/bizUpdate")
	public ModelAndView mypageBizView(ModelAndView mav,HttpSession session) {
				
			BizMember bz = (BizMember) session.getAttribute("bizmemberLoggedIn");
				
			Counselor c = mps.selectCounselorOne(bz.getCmemberId());
				
			mav.addObject("bz",bz);
			mav.addObject("c", c);
			mav.setViewName("myPage/bizUpdate");

		return mav;
	}
	
	//상담사 정보수정
	@PostMapping("/updateCounselor.do") 
	public String updateCounselor(SessionStatus sessionStatus, HttpSession session, Counselor c, RedirectAttributes redirectAttributes,
								@RequestParam("advisName") String advisName) {
		  
			log.debug("cmmmmmmmmmmm"+c);
			 
//			Counselor c = mps.selectCounselorOne1(bz.getCmemberId());
			
			c.setAdvisName(advisName);
			
			int result = mps.updateCounselor(c); sessionStatus.setComplete();
			System.out.println("@@@@@@@@@@@@@@@@@@1@@@@@@@@@@@@@@@@@@@="+c);
			System.out.println("@@@@@@@@@@@@@@@@@@2@@@@@@@@@@@@@@@@@@@="+result);
			String msg = result > 0 ? "수정 완료!" : "수정 실패! 누락된 항목이 있습니다";
			redirectAttributes.addFlashAttribute("msg", msg);
		  
			return "redirect:/"; 
			
		}
		  
		  
	//(상담사 마이페이지)진행중인 상담 보기  
	@GetMapping("/bookingStatus.do") public ModelAndView
		selectProgressCounselling(@RequestParam(value = "cPage", defaultValue ="1")int cPage, ModelAndView mav, BookingInfo book, HttpSession session,
				HttpServletRequest request, HttpServletResponse response) {
		  
			final int numPerPage =5; 
			
			BizMember bz = (BizMember) session.getAttribute("bizmemberLoggedIn");		
			Counselor c = mps.selectCounselorOne(bz.getCmemberId());
	 
			//예약정보 불러오기 
			List<BookingInfo> list = mps.selectProgressCounselling(c);
				  
			mav.addObject("bz",bz);
			mav.addObject("c",c);
			mav.addObject("list",list);
		  
			return mav; 
		  
		  }
		 
		
	//(상담사 마이페이지)종료된 상담 보기
	@GetMapping("/bookingEndStatus.do") public ModelAndView
			selectEndCounselling(@RequestParam(value = "cPage", defaultValue = "1")int
					cPage, ModelAndView mav, BookingInfo book, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		  
			final int numPerPage =5;
		  
			BizMember bz = (BizMember) session.getAttribute("bizmemberLoggedIn");		
			Counselor c = mps.selectCounselorOne(bz.getCmemberId());
	 
			//예약정보 불러오기 
			List<BookingInfo> list = mps.selectEndCounselling(c);
				  
			mav.addObject("bz",bz);
			mav.addObject("c",c);
			mav.addObject("list",list);
		    
			return mav; 
		  
	}
	
	@GetMapping("periodCalendar.do")
	public ModelAndView periodCalendar(ModelAndView mav,HttpSession session) {
		Member m = (Member) session.getAttribute("memberLoggedIn");
		mav.addObject("m",m);
		mav.setViewName("myPage/periodCalendar");
		return mav;
	}
	
	@GetMapping("myPeriod.do")
	public ModelAndView myPeriod(ModelAndView mav,HttpSession session,Period period) {
		Member m = (Member) session.getAttribute("memberLoggedIn");
		period.setMemberId(m.getMemberId());
		List<Period> list = mps.selectPeriod(period);
		mav.addObject("list",list);
		mav.addObject("m",m);
		mav.setViewName("myPage/myPeriod");
		
		return mav;
	}
	
	@GetMapping("/deleteMember")
	public ModelAndView deleteMember(ModelAndView mav,HttpSession session) {
			
			Member m = (Member) session.getAttribute("memberLoggedIn");
			mav.addObject("m",m);
			mav.setViewName("myPage/deleteMember");

		return mav;
	}
	@GetMapping("vaccinAdd")
	public ModelAndView vaccinAdd(Child child,ModelAndView mav,HttpSession session) {
		Member m = (Member) session.getAttribute("memberLoggedIn");
//		mav childSelect = mps.childSelect(child);
//		mav.addObject("childSelect",childSelect);
		mav.addObject("m",m);
		mav.setViewName("myPage/vaccinAdd");
		
		return mav;
	}
	
//	@GetMapping("memberChildUpdate")
//	public ModelAndView mypagechildview(ModelAndView mav,HttpSession session) {
//		
//		Member m = (Member) session.getAttribute("memberLoggedIn");
//		mav.addObject("m",m);
//		mav.setViewName("myPage/memberChildUpdate");
//
//	return mav;
//}
	
	@GetMapping("/memberUpdate.do")
	public ModelAndView memberUpdate(ModelAndView mav,HttpSession session) {

		Member m = (Member) session.getAttribute("memberLoggedIn");
		mav.addObject("m",m);
		mav.setViewName("myPage/memberUpdate");

		return mav;
	}
	
	@PostMapping("childUpdateInfo")
	public String childUpdateInfo(Child child,RedirectAttributes rda) {
		int result = mps.childUpdateInfo(child);
		String msg = result > 0 ? "수정 완료 " : "누락된 항목이 있습니다";
		rda.addFlashAttribute("msg", msg);
		return "redirect:/myPage/memberChildUpdate.do";
	}
	
	@PostMapping("deleteChild.do")
	public String deleteChild(Child child,RedirectAttributes rda) {
		int result = mps.deleteChild(child);
		String msg = result > 0 ? "수정 완료 " : "누락된 항목이 있습니다";
		rda.addFlashAttribute("msg", msg);
		return "redirect:/myPage/memberChildUpdate.do";
	}
	
	@PostMapping("updateMember.do")
	public String updateMember(SessionStatus ss,HttpSession session,Member member,RedirectAttributes rda,String addr1,String addr2,String addr3) {
		String address = addr1 +"+"+ addr2 +"+"+ addr3;
		member.setAddress(address);
		int result = mps.updateMember(member);
		ss.setComplete();
		String msg = result > 0 ? "수정 완료 다시 로그인 하세요" : "누락된 항목이 있습니다";
		rda.addFlashAttribute("msg", msg);

		return "redirect:/";
	}
	
	@PostMapping("updatePassword")
	public String updatePassword(SessionStatus ss,HttpSession session,Member member,RedirectAttributes rda) {
		String rawPassword = member.getMemberPwd();
		log.debug("암호화전=",rawPassword);
		
		String encryptPassword = bcryptPasswordEncoder.encode(rawPassword);
		log.debug("암호화후=",encryptPassword);
		member.setMemberPwd(encryptPassword);
		int result = mps.updatePassword(member);
		ss.setComplete();
		String msg = result > 0 ? "수정 완료 다시 로그인 하세요" : "누락된 항목이 있습니다";
		rda.addFlashAttribute("msg", msg);

		return "redirect:/";
	}
	
	@PostMapping("/memberChildUpdate.do")
	public String memberChildUpdate(String[] vaccinCode,Date[] vaccinDate,Integer[] nth,Vaccination vaccination ,Member member,Child child,RedirectAttributes ras,String parentsId,String childName) {
		String childId = parentsId+"_"+childName;
		child.setChildId(childId);
	
		System.out.println("배열로"+Arrays.toString(vaccinCode));
		System.out.println("객체로"+vaccination);
//		for(int i=0; i<vaccinCode.length; i++) {
//			
//		}
		
		int result = mps.enroll(child,member,vaccination,vaccinCode,vaccinDate,nth);
		String msg = result > 0 ? "자녀추가 완료!" : "누락된 항목이 있습니다";
		ras.addFlashAttribute("msg", msg);
		
		return "redirect:/myPage/memberChildUpdate.do";
	}
	
	@GetMapping("/memberChildUpdate.do")
	public ModelAndView selectChild(ModelAndView mav , Child child,HttpSession session,Vaccination vaccination) {
		Member m = (Member) session.getAttribute("memberLoggedIn");
		String parentsId = m.getMemberId();
		child.setParentsId(parentsId);
		vaccination.setParentsId(parentsId);
		List<Child> list = mps.selectChild(child);
		List<Vaccination> list2 = mps.selectVaccination(vaccination);
		
		
		
//		Map<String,List<String>> maplist = new HashMap<String, List<String>>();
//		maplist.put("list",list);
//		maplist.put("list2",list2);
//		Map<Child,Map<Child,List<Vaccination>>> map = mps.selectVaccin(maplist);		
		mav.addObject("m",m);
		mav.addObject("list",list);
		mav.addObject("list2",list2);
		mav.setViewName("myPage/memberChildUpdate");
		return mav;
	}
	@PostMapping("memberDelete.do")
	public String memberDelete(SessionStatus ss,HttpSession session,Member member,RedirectAttributes rda) {
		int result = mps.memberDelete(member);
		ss.setComplete();
		String msg = result > 0 ? "탈퇴 완료" : "아 오류다~";
		rda.addFlashAttribute("msg", msg);

		return "redirect:/";
	}
	
	//상담 예약정보 불러오기
		@GetMapping("/counsellingInfo.do")
		public ModelAndView selectCounsellingInfo(@RequestParam(value = "cPage", defaultValue = "1")int cPage,  ModelAndView mav, BookingInfo book, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
			
			final int numPerPage =5;
			
			Member m = (Member)session.getAttribute("memberLoggedIn");
			book.setMemberId(m.getMemberId());
			

			//예약정보 불러오기
			List<BookingInfo> list = mps.selectBookingInfoList(book);
			
			for(int i = 0; i<list.size(); i++) {
				String str = "";
				ArrayList<String> alist = new ArrayList<>();
				for(int j = 0; j<list.get(i).getAdvisKeyword().length; j++) {
					str+=list.get(i).getAdvisKeyword()[j];
					alist.add(list.get(i).getAdvisKeyword()[j]);
				}
				list.get(i).setAdvisKeyStr(str);
				list.get(i).setAdvisKeyList(alist);	
			}
			
			mav.addObject("m",m);
			mav.addObject("list",list);
			return mav;
		}
	
	@PostMapping("periodAdd.do")
	@ResponseBody
	public int periodAdd(Period period, HttpSession session) {
		
		Member m = (Member)session.getAttribute("memberLoggedIn");
		
		period.setMemberId(m.getMemberId());
		
		int result = mps.periodAdd(period);
		
		return result;
	}
	
	//리뷰 작성
	@PostMapping("/reviewWrite.do")
	public String reviewWrite(Review review, RedirectAttributes redirectAttributes, String starPoint) {
		
		review.setStarPoint(Integer.parseInt(starPoint));
		int result = mps.reviewWrite(review);
		
		redirectAttributes.addFlashAttribute("msg", result>0?"리뷰등록 성공!":"리뷰등록 실패!");
		
		return "redirect:/myPage/counsellingInfo.do";
	}

	
	@PostMapping("findPassword.do")
	public String findPassword(Member member,RedirectAttributes redirectAttributes) {
		Member selectMember = mps.findPassword(member);
		String rawPassword = member.getMemberPwd();		
		String encryptPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setMemberPwd(encryptPassword);
		int result = mps.fupdatePassword(member);
		String msg = selectMember!=null?"초기비밀번호 0000 으로 초기화 되었습니다":"입력정보가 일치하지 않습니다";
		redirectAttributes.addFlashAttribute("msg", msg);

		return "redirect:/member/login.do";
	}
	
	@PostMapping("findId")
	public ModelAndView findId(ModelAndView mav , RedirectAttributes redirectAttributes,Member member) {
		
		Member selectmember = mps.findId(member);
		String msg = selectmember!=null?"회원님의 아이디 : "+selectmember.getMemberId() :"입력정보가 일치하지 않습니다";
		mav.addObject("selectmember",selectmember);
		mav.addObject("msg",msg);
		mav.setViewName("member/login");
		return mav;
	}
	
	
	
	
	
}

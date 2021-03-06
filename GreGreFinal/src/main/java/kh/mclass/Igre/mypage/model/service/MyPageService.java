package kh.mclass.Igre.mypage.model.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import kh.mclass.Igre.counselling.model.vo.BookingInfo;
import kh.mclass.Igre.counselling.model.vo.Counselor;
import kh.mclass.Igre.counselling.model.vo.Review;
import kh.mclass.Igre.member.model.vo.BizMember;
import kh.mclass.Igre.member.model.vo.Member;
import kh.mclass.Igre.mypage.model.vo.Child;
import kh.mclass.Igre.mypage.model.vo.Period;
import kh.mclass.Igre.mypage.model.vo.Vaccination;

public interface MyPageService {

	List<Member> memberList();

	int updateMember(Member member);

	int enroll(Child child,Member member,Vaccination vaccination ,String[] vaccinCode,Date[] vaccinDate,Integer[] nth);

	List<Child> selectChild(Child child);

	List<BookingInfo> selectBookingInfoList(BookingInfo book);

	int updatePassword(Member member);

	int memberDelete(Member member);

	int reviewWrite(Review review);
	
	List<Vaccination> selectVaccination(Vaccination vaccination);

	Member findPassword(Member member);

	int fupdatePassword(Member member);


	Member findId(Member member);

	int childUpdateInfo(Child child);

	int deleteChild(Child child);

	int periodAdd(Period period);


	List<BookingInfo> selectProgressCounselling(Counselor c);


	List<BookingInfo> selectEndCounselling(Counselor c);

	int updateCounselor(Counselor c);

	Counselor selectCounselorOne(String cmemberId);

	Counselor selectCounselorOne1(String cmemberId);

	List<Period> selectPeriod(Period period);


}

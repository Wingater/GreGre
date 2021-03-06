package kh.mclass.Igre.member.model.dao;


import kh.mclass.Igre.member.model.vo.Advis;
import kh.mclass.Igre.member.model.vo.BizMember;

import java.util.ArrayList;
import java.util.HashMap;


import kh.mclass.Igre.member.model.vo.Member;
import kh.mclass.Igre.member.model.vo.Seller;

public interface MemberDAO {

	Member selectId(String memberId);
	
	BizMember selectBizId(String cmemberId);
	
	int enroll(Member member);
	

	int enroll(BizMember bizmember);

	int insertAdvis(Advis advis);

	int insert(Seller seller);

	HashMap<String, ArrayList<Integer>> preferList(String memberId);

	Object selectOne(String memberId);

	Object selectOneComp(String cmemberId);

	Object selectOneSomp(String cmemberId);

	int createMenses(Member member);

	int createTbMenses(Member member);




}

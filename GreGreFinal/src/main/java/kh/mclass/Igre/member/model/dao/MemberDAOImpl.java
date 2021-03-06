package kh.mclass.Igre.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.mclass.Igre.member.model.vo.Advis;
import kh.mclass.Igre.member.model.vo.BizMember;
import kh.mclass.Igre.member.model.vo.Member;

import kh.mclass.Igre.member.model.vo.Seller;

import kh.mclass.Igre.member.model.vo.PreferList;


@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sss;

	@Override
	public Member selectId(String memberId) {
		return sss.selectOne("member.selectId", memberId);
	}
	
	@Override
	public int enroll(Member member) {
		// TODO Auto-generated method stub
		return sss.insert("member.enroll",member);
	}



	@Override
	public int enroll(BizMember bizmember) {
		// TODO Auto-generated method stub
		return sss.insert("member.bizenroll",bizmember);
	}

	@Override
	public int insertAdvis(Advis advis) {
		// TODO Auto-generated method stub
		return sss.insert("member.insertAdvis",advis);
	}

	@Override
	public int insert(Seller seller) {
		System.out.println(seller.getSellerId());
		System.out.println(seller);
		return sss.insert("member.insertSeller",seller);
	}



	public HashMap<String, ArrayList<Integer>> preferList(String memberId) {
		Map<String, String> map = new HashMap<>();
		map.put("memberId", memberId);
		List<PreferList> list = sss.selectList("member.preferList", map);
		HashMap<String, ArrayList<Integer>> prefer = new HashMap<>();
		for(int i = 0; i<list.size(); i++) {
			if(!prefer.containsKey(list.get(i).getBoardCode())) {
				prefer.put(list.get(i).getBoardCode(), new ArrayList<Integer>());
			}
			prefer.get(list.get(i).getBoardCode()).add(list.get(i).getPostNo());
		}
		return prefer;
	}

	@Override
	public BizMember selectBizId(String cmemberId) {
		// TODO Auto-generated method stub
		return sss.selectOne("member.selectBizId",cmemberId);
	}

	@Override
	public Object selectOne(String memberId) {
		// TODO Auto-generated method stub
		return sss.selectOne("member.selectOne",memberId);
	}

	@Override
	public Object selectOneComp(String cmemberId) {
		// TODO Auto-generated method stub
		return sss.selectOne("member.selectOneComp",cmemberId);
	}

	@Override
	public Object selectOneSomp(String cmemberId) {
		// TODO Auto-generated method stub
		return sss.selectOne("member.selectOneSomp",cmemberId);
	}

	@Override
	public int createMenses(Member member) {
		// TODO Auto-generated method stub
		return sss.update("member.createMenses",member);
	}

	@Override
	public int createTbMenses(Member member) {
		// TODO Auto-generated method stub
		return sss.update("member.createTbMenses",member);
	}







}

package kh.mclass.IgreMall.shopMember.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mclass.IgreMall.coupon.model.vo.CouponInfo;
import kh.mclass.IgreMall.shopMember.model.dao.ShopMemberDAO;
import kh.mclass.IgreMall.shopMember.model.vo.Cart;
import kh.mclass.IgreMall.shopMember.model.vo.ShopMember;

@Service
public class ShopMemberServiceImpl implements ShopMemberService {
	@Autowired
	ShopMemberDAO shopMemberDAO;

	@Override
	public ShopMember selectOne(String memberId) {
		return shopMemberDAO.selectOne(memberId);
	}

	@Override
	public CouponInfo selectCouponInfoOne(String couponId) {
		return shopMemberDAO.selectCouponInfoOne(couponId);
	}

	@Override
	public int insertCart(Cart cart) {
		return shopMemberDAO.insertCart(cart);
	}

	@Override
	public List<Cart> selectCartList(String memberId) {
		return shopMemberDAO.selectCartList(memberId);
	}
}

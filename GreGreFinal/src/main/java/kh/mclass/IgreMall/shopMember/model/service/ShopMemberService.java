package kh.mclass.IgreMall.shopMember.model.service;

import kh.mclass.IgreMall.coupon.model.vo.CouponInfo;
import kh.mclass.IgreMall.shopMember.model.vo.ShopMember;

public interface ShopMemberService {

	ShopMember selectOne(String memberId);

	CouponInfo selectCouponInfoOne(String couponId);

}
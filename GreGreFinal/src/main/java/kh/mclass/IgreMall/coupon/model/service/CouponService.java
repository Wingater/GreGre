package kh.mclass.IgreMall.coupon.model.service;

import java.util.List;

import kh.mclass.IgreMall.coupon.model.vo.Coupon;
import kh.mclass.IgreMall.event.model.vo.Winner;


public interface CouponService {
	
	List<Coupon> selectListMyCoupon(String memberId);

	List<Winner> SelectList(String memberId);


}

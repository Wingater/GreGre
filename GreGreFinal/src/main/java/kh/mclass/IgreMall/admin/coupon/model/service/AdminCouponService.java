package kh.mclass.IgreMall.admin.coupon.model.service;

import java.util.List;

import kh.mclass.IgreMall.admin.coupon.model.vo.AdminCoupon;
import kh.mclass.IgreMall.admin.coupon.model.vo.CouponPeople;
import kh.mclass.IgreMall.admin.event.vo.WinnerEvent;

public interface AdminCouponService {

	int insertCoupon(AdminCoupon c);

	List<AdminCoupon> couponList();

	AdminCoupon selectCoupon(AdminCoupon a);

	int sendCoupon(CouponPeople cp);

	AdminCoupon selectcurCoupon(AdminCoupon c);

	int WinnerCS(WinnerEvent we);

}

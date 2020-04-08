package kh.mclass.IgreMall.order.model.service;

import java.util.List;

import kh.mclass.IgreMall.order.model.vo.OrderList;
import kh.mclass.IgreMall.order.model.vo.OrderProduct;
import kh.mclass.IgreMall.order.model.vo.PayAccountInfo;
import kh.mclass.IgreMall.order.model.vo.PaymentInfo;

public interface OrderService {

	int insertOrder(OrderList orderList, List<OrderProduct> orderProdList, PaymentInfo paymentInfo);

	int insertPayAccInfo(PayAccountInfo payAccInfo);

	OrderList selectOrderList(String orderNo);

	List<OrderProduct> selectOrderProdList(String orderNo);

	PayAccountInfo selectPayAccInfo(String orderNo);

	PaymentInfo selectPaymentInfo(String orderNo);

	List<OrderList> selectListOrder(String memberId);

}

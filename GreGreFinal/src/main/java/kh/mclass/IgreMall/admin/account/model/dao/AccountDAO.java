package kh.mclass.IgreMall.admin.account.model.dao;

import java.util.List;

import kh.mclass.IgreMall.admin.account.model.vo.Account;
import kh.mclass.IgreMall.admin.account.model.vo.PayMethod;
import kh.mclass.IgreMall.admin.coupon.model.vo.ChartValue;

public interface AccountDAO {

	List<Account> accountList();


	List<PayMethod> pList();


	List<Account> searchList(Account a);


	List<PayMethod> searchPList(Account a);


	List<ChartValue> clist();

}

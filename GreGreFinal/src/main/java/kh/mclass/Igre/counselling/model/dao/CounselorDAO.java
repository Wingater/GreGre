package kh.mclass.Igre.counselling.model.dao;

import java.util.List;
import java.util.Map;

import kh.mclass.Igre.counselling.model.vo.Counselor;
import kh.mclass.Igre.counselling.model.vo.Review;

public interface CounselorDAO {

	int selectCounselorTotalContents();

	List<Counselor> selectCounselorList(int cPage, int numPerPage);

	Counselor selectOne(String advisId);

	int selectReviewTotalContents();

	List<Review> selectReviewList(Counselor c);

	List<Counselor> selectFilter(Map<String, String[]> param);

	double selectStarPoint(String advisId);

	int selectReviewTotal(String advisId);

}

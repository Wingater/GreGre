package kh.mclass.Igre.counselling.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.mclass.Igre.counselling.model.vo.Counselor;
import kh.mclass.Igre.counselling.model.vo.EditReview;
import kh.mclass.Igre.counselling.model.vo.Review;
import kh.mclass.Igre.counselling.model.vo.BookingInfo;
import kh.mclass.Igre.counselling.model.vo.reviewStar;
import kh.mclass.Igre.member.model.vo.Member;

@Repository
public class CounselorDAOImpl implements CounselorDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public int selectCounselorTotalContents() {
		return sqlSession.selectOne("counselor.selectCounselorTotalContents");
	}

	@Override
	public List<Counselor> selectCounselorList(int cPage, int numPerPage) {
		
		int offset = (cPage-1)*numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("counselor.selectCounselorList", null, rowBounds);
	}

	@Override
	public Counselor selectOne(String advisId) {
		
		return sqlSession.selectOne("counselor.selectOne", advisId);
	}

	@Override
	public int selectReviewTotalContents() {
		return sqlSession.selectOne("review.selectReviewTotalContents");
	}

	@Override
	public List<Map<String, String>> selectReviewList(Counselor c, int cPage, int numPerPage) {
		
		int offset = (cPage-1)*numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("review.selectReviewList",c,rowBounds);
	}


	@Override
	public List<Counselor> selectFilter(Map<String, String[]> param) {
		return sqlSession.selectList("counselor.selectFilter", param);
	}

	@Override
	public double selectStarPoint(String advisId) {
		return sqlSession.selectOne("counselor.selectStarPoint",advisId);
	}

	@Override
	public int selectReviewTotal(String advisId) {
		return sqlSession.selectOne("counselor.selectReviewTotal",advisId);
	}
	
	@Override
	public int selectReviewCounselorOne(String advisId) {
		return sqlSession.selectOne("review.selectReviewCounselorOne", advisId);
	}

	@Override
	public List<reviewStar> particularReviewPointCount(String advisId) {
		return sqlSession.selectList("review.particularReviewPointCount", advisId);
	}

	@Override
	public int countReview(Map<String, Object> map) {
		return sqlSession.selectOne("review.countReview", map);
	}

	@Override
	public Double selectReviewRating(String advisId) {

		return sqlSession.selectOne("review.selectReviewRating", advisId);
	}

	@Override
	public List<Map<String, String>> selectCounselorList1(int cPage, int numPerPage) {
		
		int offset = (cPage-1)*numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("counselor.selectCounselorList",null,rowBounds);
	}

	@Override
	public int bookingInsert(BookingInfo info) {
		return sqlSession.insert("counselor.bookingInfo", info);
	}

	@Override
	public int editReview(EditReview edit) {
		return sqlSession.update("review.editReview", edit);
	}

	@Override
	public int deleteReview(int num) {
		return sqlSession.delete("review.deleteReview", num);
	}

	@Override
	public BookingInfo bookingSelect(String appointNo) {
		return sqlSession.selectOne("counselor.bookingSelect", appointNo);
	}

	@Override
	public int recentSelectOne(String memberId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("counselor.recentSelectOne",memberId);
	}




}

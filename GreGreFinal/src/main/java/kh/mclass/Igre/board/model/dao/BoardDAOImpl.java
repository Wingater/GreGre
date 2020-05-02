package kh.mclass.Igre.board.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.mclass.Igre.board.model.vo.Board;
import kh.mclass.Igre.board.model.vo.Post;
import kh.mclass.Igre.board.model.vo.Recommendation;
import kh.mclass.Igre.board.model.vo.Reply;
import kh.mclass.Igre.board.model.vo.Report;
import kh.mclass.Igre.member.model.vo.PreferList;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSessionTemplate sss;

	@Override
	public List<Board> boardList() {
		return sss.selectList("board.boardList");
	}

	@Override
	public List<Post> postList(Map<String, Object> param) {
		
		int offset = ((int)param.get("cPage")-1)*10;
		int limit = 10;
		RowBounds rbn = new RowBounds(offset, limit);
		
		return sss.selectList("board.postList", param, rbn);
	}

	@Override
	public String boardName(Map<String, Object> param) {
		return sss.selectOne("board.boardName",param);
	}

	@Override
	public int postCount(Map<String, Object> param) {
		return sss.selectOne("board.postCount", param);
	}

	@Override
	public int preferIn(PreferList pf) {
		return sss.insert("board.preferIn", pf);
	}

	@Override
	public int preferOut(PreferList pf) {
		return sss.delete("board.preferOut", pf);
	}

	@Override
	public Post postView(Map<String, Object> param) {
		return sss.selectOne("board.postView", param);
	}

	@Override
	public List<Reply> replyList(Map<String, Object> param) {
		int limit = 10;
		int offset = ((Integer)param.get("cPage")-1)*limit;
		RowBounds rbd = new RowBounds(offset, limit);
		
		return sss.selectList("board.replyList", param, rbd);
	}

	@Override
	public int replyCount(Map<String, Object> param) {
		return sss.selectOne("board.replyCount", param);
	}

	@Override
	public int preferCount(Map<String, Object> param) {
		return sss.selectOne("board.preferCount", param);
	}

	@Override
	public int replyWrite(Reply reply) {
		return sss.insert("board.replyWrite", reply);
	}

	@Override
	public int checkComm(Recommendation recom) {
		return sss.selectOne("board.checkComm", recom);
	}

	@Override
	public int postRecom(Recommendation recom) {
		return sss.update("board.postRecom", recom);
	}

	@Override
	public int RecomDecom(Recommendation recom) {
		return sss.insert("board.RecomDecom", recom);
	}

	@Override
	public int replyRecom(Recommendation recom) {
		return sss.update("board.replyRecom", recom);
	}

	@Override
	public int postDecom(Recommendation recom) {
		return sss.update("board.postDecom", recom);
	}

	@Override
	public int replyDecom(Recommendation recom) {
		return sss.update("board.replyDecom", recom);
	}

	@Override
	public String confirmWriter(Post post) {
		return sss.selectOne("board.confirmWriter", post);
	}

	@Override
	public int deletePostR(Post post) {
		
		return sss.delete("board.deletePostR", post);
	}

	@Override
	public int deletePostP(Post post) {
		sss.delete("board.deleteReportP", post);
		return sss.delete("board.deletePostP", post);
	}

	@Override
	public String confirmWriter(Reply reply) {
		return sss.selectOne("board.confirmWriterR", reply);
	}

	@Override
	public int deleteReply(Reply reply) {
		sss.delete("board.deleteReportR", reply);
		return sss.delete("board.deleteReply", reply);
	}

	@Override
	public int checkReport(Report report) {
		return sss.selectOne("board.checkReport", report);
	}

	@Override
	public int submitReport(Report report) {
		return sss.insert("board.submitReport", report);
	}

	@Override
	public int postWrite(Post post) {
		return sss.insert("board.postWrite", post);
	}

	@Override
	public int postViewCount(Map<String, Object> param) {
		return sss.update("board.viewCount", param);
	}

	@Override
	public void replyModify(Reply reply) {
		sss.update("board.replyModify", reply);
	}

	@Override
	public Post postView(Post post) {
		return sss.selectOne("board.postView", post);
	}

	@Override
	public int modifyPost(Post post) {
		return sss.update("board.modifyPost", post);
	}

	@Override
	public int postCountR(Map<String, Object> param) {
		return sss.selectOne("board.postCountR", param);
	}

	@Override
	public int postCountP(Map<String, Object> param) {
		return sss.selectOne("board.postCountP", param);
	}

	@Override
	public List<Post> postListR(Map<String, Object> param) {
		return sss.selectList("board.postListR", param);
	}

	@Override
	public List<Post> postListP(Map<String, Object> param) {
		return sss.selectList("board.postListP", param);
	}

	@Override
	public List<Post> noticeList(Map<String, Object> param) {
		return sss.selectList("board.noticeList", param);
	}

	@Override
	public List<Post> idxNotice() {
		RowBounds rbd = new RowBounds(0, 5);
		return sss.selectList("board.idxNotice",null, rbd);
	}

	@Override
	public List<Post> favList() {
		List<Board> boardCode = sss.selectList("board.boardList");
		Map<String, List> param = new HashMap<>();
		param.put("boardCode", boardCode);
		RowBounds rbd = new RowBounds(0,5);
		return sss.selectList("board.favList", param, rbd);
	}
	
}

package kh.mclass.Igre.admin.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.mclass.Igre.admin.model.vo.Admin;
import kh.mclass.Igre.admin.model.vo.Amember;
import kh.mclass.Igre.admin.model.vo.AdminReport;
import kh.mclass.Igre.board.model.vo.Board;
import kh.mclass.Igre.board.model.vo.Post;
import kh.mclass.Igre.board.model.vo.Reply;
import kh.mclass.Igre.member.model.vo.Member;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public Admin selectOne(String adminId) {
		return sqlSession.selectOne("admin.selectOne", adminId);
	}

	@Override
	public List<Amember> list() {
		return sqlSession.selectList("admin.list");
	}

	@Override
	public Amember MemberSelectOne(String memberId) {
		return sqlSession.selectOne("admin.MemberSelectOne", memberId);
	}
	
	@Override
	public int updateMember(Amember amember) {
		return sqlSession.update("admin.memberUpdate", amember);
	}

	@Override
	public int updateAdmin(Amember amember) {
		return sqlSession.update("admin.adminUpdate", amember);
	}

	@Override
	public int delete(String memberId) {
		return sqlSession.delete("admin.delete", memberId);
	}

	@Override
	public List<Amember> deleteList() {
		return sqlSession.selectList("admin.deleteList");
	}

	@Override
	public List<AdminReport> report() {
		return sqlSession.selectList("admin.report");
	}

	@Override
	public int postDelete(String boardCode, Integer postNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("table", "tb_post_"+boardCode);
		map.put("postNo", postNo);
		return sqlSession.delete("admin.postDelete", map);
	}

	@Override
	public int reportUpdate(String boardCode, Integer postNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardCode", boardCode);
		map.put("postNo", postNo);
		return sqlSession.update("admin.reportUpdate", map);
	}
	//댓글삭제
	@Override
	public int replyDelete(String boardCode, Integer replyNo) {
		Map<String,Object> map = new HashMap<>();
		map.put("table","tb_reply_"+boardCode);
		map.put("replyNo", replyNo);
		return sqlSession.delete("admin.replyDelete", map);
	}
	//댓글처리 Y
	@Override
	public int replyUpdate(String boardCode, Integer postNo, Integer replyNo) {
		Map<String,Object> map = new HashMap<>();
		map.put("boardCode", boardCode);
		map.put("postNo", postNo);
		map.put("replyNo", replyNo);
		return sqlSession.update("admin.replyUpdate", map);
	}

	@Override
	public List<Board> board() {
		return sqlSession.selectList("admin.board");
	}


	@Override
	public List<Post> boardList(Map<String, String> param) {
		return sqlSession.selectList("admin.boardList", param);
	}

	@Override
	public Board boardName(String boardCode) {
		Map<String, String> map = new HashMap<>();
		map.put("boardCode", boardCode);
		return sqlSession.selectOne("admin.boardName", map);
	}

	@Override
	public int boardPostDelete(String boardCode, Integer postNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("table", "tb_post_"+boardCode);
		map.put("postNo", postNo);
		return sqlSession.delete("admin.boardPostDelete", map);
	}

	@Override
	public int noticeUpdate(String boardCode, Integer postNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("table", "tb_post_"+boardCode);
		map.put("boardCode", boardCode);
		map.put("postNo", postNo);
		return sqlSession.update("admin.noticeUpdate", map);
	}

	//등록될 게시글 생성
	@Override
	public int insertboard(Board board) {
		return sqlSession.insert("admin.insertBoard", board);
	}
	//게시판 생성
	@Override
	public void createBoard(Board board) {
		sqlSession.update("admin.createBoard", board);
	}
	//댓글 생성
	@Override
	public void createReply(Board board) {
		sqlSession.update("admin.createReply", board);
	}
	//게시글 시퀀스생성
	@Override
	public void seqPost(Board board) {
		sqlSession.update("admin.seqPost", board);
	}
	//댓글 시퀀스 생성
	@Override
	public void seqReply(Board board) {
		sqlSession.update("admin.seqReply", board);
	}
	//등록된 게시글 삭제
	@Override
	public int boardDelete(String boardCode) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardCode", boardCode);
		return sqlSession.delete("admin.boardDelete", map);
	}
	//댓글 테이블 삭제
	@Override
	public void dropReply(String boardCode) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardCode", boardCode);
		sqlSession.update("admin.dropReply", map);
	}
	//게시판 테이블 삭제
	@Override
	public void dropBoard(String boardCode) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardCode", boardCode);
		sqlSession.update("admin.dropBoard", map);
	}
	//게시판 시퀀스 삭제
	@Override
	public void dropSeqPost(String boardCode) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardCode", boardCode);
		sqlSession.update("admin.dropSeqPost", map);
	}
	//댓글 시퀀스 삭제
	@Override
	public void dropSeqReply(String boardCode) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardCode", boardCode);
		sqlSession.update("admin.dropSeqReply", map);
	}
	//게시글 보기
	@Override
	public Post postView(Map<String, Object> param) {
		return sqlSession.selectOne("admin.postView", param);
	}
	//댓글 보기
	@Override
	public List<Reply> replyView(Map<String, Object> param) {
		return sqlSession.selectList("admin.replyView", param);
	}
	//댓글 조회수
	@Override
	public int replyCount(Map<String, Object> param) {
		return sqlSession.selectOne("admin.replyCount", param);
	}
	//선호수
	@Override
	public int prefCount(Map<String, Object> param) {
		return sqlSession.selectOne("admin.prefCount", param);
	}
	//게시글 갯수
	@Override
	public int postCount(Map<String, String> param) {
		return sqlSession.selectOne("admin.postCount", param);
	}

	@Override
	public List<Member> selectAdmember() {
		return sqlSession.selectList("admin.selectAdmember");
	}

	@Override
	public Member athorityView(String memberId) {
		return sqlSession.selectOne("admin.athorityView", memberId);
	}

	@Override
	public int athorityUpdate(Member member) {
		return sqlSession.update("admin.athorityUpdate", member);
	}

	@Override
	public List<Member> indexMember() {
		return sqlSession.selectList("admin.indexMember");
	}

	@Override
	public List<Admin> indexAdmin() {
		return sqlSession.selectList("admin.indexAdmin");
	}

	@Override
	public int allMemberCnt() {
		return sqlSession.selectOne("admin.allMemberCnt");
	}

	@Override
	public int newMemberCnt() {
		return sqlSession.selectOne("admin.newMemberCnt");
	}
	






}

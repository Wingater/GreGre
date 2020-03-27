package kh.mclass.Igre.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mclass.Igre.board.model.dao.BoardDAO;
import kh.mclass.Igre.board.model.vo.Board;
import kh.mclass.Igre.board.model.vo.Post;
import kh.mclass.Igre.board.model.vo.PostList;
import kh.mclass.Igre.member.model.vo.PreferList;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDAO bd;

	@Override
	public List<Board> boardList() {
		return bd.boardList();
	}

	@Override
	public List<Post> postList(PostList bc, int cPage, int nPP) {
		return bd.postList(bc, cPage, nPP);
	}

	@Override
	public String boardName(String boardCode) {
		return bd.boardName(boardCode);
	}

	@Override
	public int postCount(String boardCode) {
		return bd.postCount(boardCode);
	}

	@Override
	public int preferIn(PreferList pf) {
		return bd.preferIn(pf);
	}

}

package kh.mclass.Igre.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kh.mclass.Igre.board.model.service.BoardService;
import kh.mclass.Igre.board.model.vo.Board;
import kh.mclass.Igre.board.model.vo.Post;
import kh.mclass.Igre.board.model.vo.PostList;
import kh.mclass.Igre.board.model.vo.Reply;
import kh.mclass.Igre.member.model.vo.Member;
import kh.mclass.Igre.member.model.vo.PreferList;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
@SessionAttributes(value= {"memberLoggedIn"})
public class BoardController {
	
	@Autowired
	private BoardService bs;

	@GetMapping("/postList")
	public String postList(@RequestParam("boardCode") String boardCode,
						   @RequestParam(value="cPage", defaultValue="1") int cPage,
						   Model model) {
		String boardName = bs.boardName(boardCode);
		if(boardName == null) {
			boardCode = "B1";
			boardName = "공지사항";
		}
		model.addAttribute("boardName", boardName);
		model.addAttribute("boardCode", boardCode);
		
		List<Board> boardList = bs.boardList();
		model.addAttribute("boardList", boardList);
		
		int postCount = bs.postCount(boardCode);
		model.addAttribute("postCount", postCount);
		
		final int NPP = 10;
		PostList bc = new PostList(boardCode);
		List<Post> postList = bs.postList(bc, cPage, NPP);
		model.addAttribute("postList", postList);
		return "board/postList";
	}
	
	@PostMapping("/preferIn.do")
	@ResponseBody
	public void preferIn(PreferList pf, HttpSession session) {
		log.debug(""+pf);
		Member m = (Member)session.getAttribute("memberLoggedIn");
		log.debug(""+m);
		int result = bs.preferIn(pf);
		if(result>0) {
			if(m.getPrefList().containsKey(pf.getBoardCode())) {
				m.getPrefList().get(pf.getBoardCode()).add(pf.getPostNo());
			} else {
				ArrayList<Integer> list = new ArrayList<>();
				list.add(pf.getPostNo());
				m.getPrefList().put(pf.getBoardCode(), list);
			}
			log.debug("더하기 이후"+m);
			session.setAttribute("memberLoggedIn", m);
		}
	}
	
	@PostMapping("/preferOut.do")
	@ResponseBody
	public void preferOut(PreferList pf, HttpSession session) {
		log.debug(""+pf);
		Member m = (Member)session.getAttribute("memberLoggedIn");
		log.debug(""+m);
		int result = bs.preferOut(pf);
		if(result>0) {
			m.getPrefList().get(pf.getBoardCode()).remove((Integer)pf.getPostNo());
			log.debug("빼기 이후"+m);
			session.setAttribute("memberLoggedIn", m);
		}
	}
	
	@GetMapping("/postView")
	public String postView(@RequestParam("boardCode") String boardCode,
						   @RequestParam("postNo") int postNo,
						   Model model,
						   RedirectAttributes rda) {
		
		Post post = bs.postView(boardCode, postNo);
		if(post == null) {
			rda.addAttribute("msg", "게시글이 존재하지 않습니다.");
			return "redirect:/board/postList?boardCode="+boardCode;
		}
		List<Reply> rpList = bs.replyList(boardCode, postNo, 1);
		
		model.addAttribute("post", post);
		model.addAttribute("replyList", rpList);
		
		int rpCount = bs.replyCount(boardCode, postNo);
		model.addAttribute("replyCount", rpCount);
		
		int prefCount = bs.preferCount(boardCode, postNo);
		model.addAttribute("prefCount", prefCount);
		
		return "board/postView";
	}
}

package kh.mclass.Igre.inquire.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mclass.Igre.chat.model.vo.Msg;
import kh.mclass.Igre.inquire.model.dao.InquireDAO;
import kh.mclass.Igre.inquire.model.vo.InqChatMember;
import kh.mclass.Igre.inquire.model.vo.InqMsg;

@Service
public class InquireServiceImpl implements InquireService {
	
	@Autowired
	private InquireDAO id;

	@Override
	public String findChatId(String memberId) {
		return id.findChatId(memberId);
	}

	@Override
	public Object selectOneChatId(String chatId) {
		return id.selectOneChatId(chatId);
	}

	@Override
	public void createChatRoom(List<InqChatMember> list) {
		int chatRoomId = id.createChatRoom(list);
		list.get(0).setId(chatRoomId);
		list.get(1).setId(chatRoomId);
		id.createChatMember(list);
	}

	@Override
	public void insertChatLog(InqMsg fromMessage) {
		id.insertChatLog(fromMessage);
	}

	@Override
	public List<InqMsg> chatListByChatId(String chatId) {
		return id.chatListByChatId(chatId);
	}

	@Override
	public int updateLastCheck(InqMsg fromMessage) {
		System.out.println("서비스 시작");
		int result = id.updateLastCheck(fromMessage);
		System.out.println("서비스 종료");
		return result;
	}

	@Override
	public int lastCheck(String chatId, String memberId) {
		return id.lastCheck(chatId, memberId);
	}

}

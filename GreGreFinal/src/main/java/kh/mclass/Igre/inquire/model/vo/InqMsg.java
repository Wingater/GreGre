package kh.mclass.Igre.inquire.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class InqMsg {
	private long chatNo;
	private String chatId;
	private String memberId;
	private String msg;
	private long time;
	private InqMsgType type;
}
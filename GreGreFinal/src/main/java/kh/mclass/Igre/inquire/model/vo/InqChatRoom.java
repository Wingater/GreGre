package kh.mclass.Igre.inquire.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@RequiredArgsConstructor
@AllArgsConstructor
@ToString
public class InqChatRoom implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int id;
	@NonNull
	private String chatId;
	private Date regDate;
	private boolean enabled;

}

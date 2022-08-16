package kr.board.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Member {
	
	private int memIdx; 
	
	private String memId;
	
	private String memPassword;
	
	private String memName;
	
	private int memAge;
	
	private String memGender;
	
	private String memEmail;
	
	private String memProfile;
}

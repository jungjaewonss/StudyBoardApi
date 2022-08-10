package kr.board.entity;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
@Setter
@Getter
public class Board {
	
	private int idx;
	
	private String title;
	
	private String content;
	
	private String writer;
	
	private String indate;
	
	private int count; // 조회수
}

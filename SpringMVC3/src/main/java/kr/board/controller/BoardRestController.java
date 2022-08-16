package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@RestController
@RequestMapping("/board")
public class BoardRestController {
	
	
	@Autowired
	BoardMapper mapper;
	
	@RequestMapping("/all")
	public List<Board> boardList(){
		
		List<Board> boardList = mapper.getListss();
		
		return boardList;
	}
	
	@PostMapping("/new") // 등록은 PostMapping
	public int boardWrite(Board board , Model model) {
		int count =  mapper.insertBoard(board);
		
		return count;	
	}
	
	@GetMapping("/{idx}")
	public Board detailBoard(@PathVariable("idx") String idx) {
		Board board = mapper.detailBoard(idx);
		
		return board;
	}
	
	@DeleteMapping("/{idx}")
	public int deleteBoard(@PathVariable("idx") String idx) {
		
		return  mapper.boardDelete(idx);
	}
	
	@PutMapping("/update")
	public void updateBoard(Board board) {
		mapper.boardUpdate(board);
	}
	
	@PutMapping("/count") 
	public Board updateCount(@RequestBody Board board) {
		
		mapper.addCount(board);
		 
		Board addcountBoard =  mapper.detailBoard(board.getIdx()+"");
		
		return addcountBoard;
	}
}

package kr.board.controller;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {
	
	@Autowired
	BoardMapper mapper;
	
	@RequestMapping("/")
	public String main(Model model) {
		
		
		
		model.addAttribute("body", "boardList");
		
		return "main";
	}
	
	@RequestMapping("/boardList")
	@ResponseBody
	public List<Board> boardList(){
		
		List<Board> boardList = mapper.getListss();
		
		return boardList;
	}
	
	@GetMapping("/boardWrite")
	@ResponseBody
	public int boardWrite(Board board , Model model) {
		int count =  mapper.insertBoard(board);
		
		return count;	
	}
	
	@GetMapping("/detailBoard")
	public Board detailBoard(String idx) {
		Board board = mapper.detailBoard(idx);
		
		return board;
	}
	
	@ResponseBody
	@GetMapping("/deleteBoard")
	public int deleteBoard(String idx) {
		
		return  mapper.boardDelete(idx);
	}
	
	@ResponseBody
	@GetMapping("updateBoard")
	public void updateBoard(Board board) {
		
		System.out.println(board);
		
		mapper.boardUpdate(board);
	}
}

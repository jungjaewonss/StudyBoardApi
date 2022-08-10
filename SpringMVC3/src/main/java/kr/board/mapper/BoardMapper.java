package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.board.entity.Board;

@Mapper
public interface BoardMapper {
		
	List<Board> getListss();
	
	int insertBoard(Board board);
	
	Board detailBoard(String idx);
	
	int boardDelete(String idx);
	
	int boardUpdate(Board board);
	
	int addCount(Board board);
	
	
}

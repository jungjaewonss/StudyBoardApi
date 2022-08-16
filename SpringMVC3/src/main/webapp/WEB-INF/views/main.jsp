<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC01</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	
  	$(document).ready(function(){
  		loadList();
  	})
  	
  	
  	
  	
  	function loadList(){
  		// 서버와 통신 : 게시판 리스트 가져오기 
  		$.ajax({
  			url : "board/all",
  			type : "get",
  			dataType : "json", //데이터를 받을형식
  			success : makeView ,
  			error : function(){
  				alert("error");
  			}
  		})
  	}
  	
  	function makeView(data){
  		var listHtml = "<table class ='table table-bordered'>";
  		listHtml += "<tr>"
  			listHtml += "<td>번호</td>"
  			listHtml += "<td>제목</td>"
  			listHtml += "<td>작성자</td>"
  			listHtml += "<td>작성일</td>"
  			listHtml += "<td>조회수</td>"
  		listHtml += "<tr/>"
  		
  		//jquery 에서의 반복문
  		$.each(data , function(index,obj){
  			listHtml += "<tr>"
  	  			listHtml += "<td>"+obj.idx+"</td>"
  	  			listHtml += "<td id='t"+obj.idx+"'><a  href = 'javascript:goContent("+obj.idx+")'>"+obj.title+"</a></td>"
  	  			listHtml += "<td>"+obj.writer+"</td>"
  	  			listHtml += "<td>"+obj.indate.split(' ')[0]+"</td>"
  	  			listHtml += "<td id='addcounts"+obj.idx+"'>"+obj.count+"</td>"
  	  		listHtml += "<tr/>"
  	  		
  	  		var contentid = "content" + obj.idx;
  	  		listHtml += "<tr style = 'display:none' id = "+contentid+" >"
  	  		listHtml += "<td>내용</td>"
  	  		listHtml += "<td colspan='4'>"
  	  		listHtml += "<textarea rows='7' id='textareaContent"+obj.idx+"' class = 'form-control' readonly></textarea>"
  	  		listHtml += "<br>"
  	  		listHtml += "<span id='changeButton"+obj.idx+"'><button class = 'btn btn-primary btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp"
  	  		listHtml += "<button class = 'btn btn-primary btn-sm' onclick='goDelete("+obj.idx+")'>삭제하기</button>"
  	  		listHtml += "</td>"
  	  		listHtml += "</tr>"
  		});
  		
  		listHtml+= "<tr>";
  		listHtml+="<td colsapn='5'>";
  		listHtml+="<button class ='btn btn-primary btn-sm' onclick = 'goForm()'>글쓰기</button>";
  		listHtml+="</td>";
  		listHtml+= "</tr>";
  		listHtml+="</table>";
  		
  		$("#view").html(listHtml); // id 가 view인 것에 접근해서 html 을 집어넣겠다
  	}
  	
  	
  	function goUpdateForm(idx){
  		$("#textareaContent" + idx).attr('readonly',false);
  		
  		
  		var title = $("#t" + idx).text();
  		
  		var newInput = "<input type = 'text' class = 'form-control' id='newTitle"+idx+"' value = '"+title+"'/>";
  		$("#t" + idx).html(newInput);
  		
  		
  		
  		
  		var newButton = "<button class = 'btn btn-info btn-sm' onclick='updateConten("+idx+")'>수정</button>";
  		
  		$("#changeButton" + idx).html(newButton);
  	}
  	
  	function updateConten(idx){
  		
  		var updateTitle = $("#newTitle" + idx).val();
  		var updateContent = $("#textareaContent" + idx).val();
  		
  		$.ajax({
  			url : "board/update",
  			tyle : "put",
  			data : {"idx" : idx , "title" : updateTitle , "content" : updateContent},
  			success : function(){
  				alert('수정완료');
  				location.reload();
  			},
  			error : function(){
  				alert('error');
  			}
  		})
  	}
  	
  	
  	function goDelete(idx){
  		$.ajax({
  			url : "board/" + idx,
  			type : "delete",
  			dataType : "json",
  			success : function(value){
  				if(value > 0) {
  					alert('삭제완료');
  					location.reload();
  				}
  			}
  		})
  	}
  	
  	function goForm(){
  		$("#view").css("display" , "none"); // 감추기
  		
  		$("#wform").css("display" , "block"); //보이게하기
  	
  	}
  	
  	function goList(){
  		$("#view").css("display" , "block");
  		$("#wform").css("display" , "none");
  	}
  	
  	function insertBoard(){
  		var fData = $("#frm").serialize(); // form 에있는 모튼 데이터를 파라미터형식으로 일렬로 저장가능
  		
  		
  		
  		$.ajax({
  			url : "board/new",
  			type : "post",
  			data : fData, // 직렬화한건그냥넘기네 
  			dataType : "json" ,
  			success : function(value){
  					if(value > 0){
  					alert("등록성공");
  					location.href = "/";
  					}
  			},
  			error : function(){
  				alert('error');
  			}
  		})
  		
  		// form 초기화
  		$("#resetButton").click();
  		// $("#resetButton").trigger("click");  //트리거로 클릭도가능
  		
  	}
  	
   function goContent(idx){  
	   if($("#content" + idx).css("display") == 'none'){
		   var idxs = "content"+idx;
		   
		    
		   $.ajax({
			   url : "board/" + idx,
			   type : "get",
			   data : {"idx" : idx},
			   dataType : "json",
			   success : function (value){	   		   
				   $("#textareaContent" + idx).val(value.content);
				   addCount(value);				   
			   },
			   error : function(){
				   alert('통신에러');
			   }
		   })
		   
		   $('#' + idxs).css("display" , "table-row"); // tr일경우 block 이아닌 display 속성을 table-row 로주면 colspan 이먹힌다.
		   $("#textareaContent" + idx).attr('readonly' , true); 	  
	   }
	   else{
		   var idxs = "content"+idx;
		   $('#' + idxs).css("display" , "none"); // tr일경우 block 이아닌 display 속성을 table-row 로주면 colspan 이먹힌다.
		   
		 
	   }
	   
   }
   
   function addCount(value){
	  $.ajax({
		   url : "board/count",
		   type : "put",
		   data : JSON.stringify({"idx" : value.idx , "count" : value.count}),
		   contentType : "application/json;charset=utf-8",
		   dataTyle : "json",
		   success : function(value){
				$("#addcounts" + value.idx).text(value.count);
		   },
		   error : function(){
		   }
	   })
   }
 
  	
  </script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC02</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    <div class="panel-body" id="view">
    	
    
    </div>
    
    <div class="panel-body" style="display: none;" id = "wform">
    	 
    <form id = "frm">	 
    	<table class = "table">
    		<tr>
    			<td>제목</td>	
    			<td><input type="text" name = "title" class = "form-control"/></td>
    		</tr>
    		
    		<tr>
    			<td>내용</td>	
    			<td><textarea rows="7" class="form-control" name = "content"></textarea></td>
    		</tr>
    		
    		<tr>
    			<td>작성자</td>	
    			<td><input type="text" name = "writer" class = "form-control"/></td>
    		</tr>
    		
    		<tr>
    			<td colspan="2" align="center">
    				<button type = "submit" class = "btn btn-success btn-sm" onclick = "insertBoard()">등록</button>
    				<button type = "reset" class = "btn btn-warning btn-sm" id = "resetButton">취소</button>
    				<button type = "button" class = "btn btn-primary btn-sm" onclick = "goList()">목록보기</button>
    			</td>
    			
    		</tr>
    	</table>
      </form>	
    </div>
    
    <div class="panel-footer">인프런_스프1탄_정재원</div>
  </div>
</div>

</body>
</html>

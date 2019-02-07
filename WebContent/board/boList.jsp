<%@page import="mypkg.board.Paging"%>
<%@page import="mypkg.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("EUC-KR"); %>

<%@include file="./../common/top.jsp" %>
<jsp:useBean id="bdao" class="mypkg.board.BoardDao"/>
<%
	//검색 관련 파라미터들
	String mode = request.getParameter("mode") ;
	String keyword = request.getParameter("keyword") ;
	//out.print( "검색 옵션(mode) : " + mode + "<br>") ;
	//out.print( "검색할 단어(keyword) : " + keyword + "<br>") ;
	//페이징 처리 관련 파라미터들
	String pageNumber = request.getParameter("pageNumber") ;
	String pageSize = request.getParameter("pageSize") ;
	
	//mode에 따른 카운터 수가 달라진다.
	int totalCount = bdao.getTotalCount(mode, keyword) ;
	String url = "boList.jsp" ;
	Paging pageInfo = new Paging(pageNumber, pageSize, totalCount, url, mode, keyword);
	
	ArrayList<BoardBean> lists = bdao.getBoardList(pageInfo);
	//out.print( lists.size()) ;
%> 
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>제목</title>
	<script type="text/javascript">
		function writeForm(){
			//alert('글 작성합니다') ;
			location.href='boWriteForm.jsp' ;
		}
		function goSearchAll(){
			location.href='boList.jsp' ;
		}	
		function deleteList( writer, param, password ){
			if( '<%=loginfo%>' == writer ){
				var resp = prompt('사용자 비번을 넣으세요.', "");
				if( resp == password ){
					alert('비번 일치') ;
					location.href='boDeleteProc.jsp?' + param  ;
				}else{
					alert('글 작성 비번이 일치하지 않는 군요') ;
				}
			}else{
				alert('넘의 글은 삭제가 불가능합니다.') ;
			}
		}
	</script>
</head>
<body>
<tr>

	<td valign="top" width="20%">		
		<img src="./../images/pontBoard.png" width="160" height="60" > 
	</td>


<td colspan="5" align="center">
	<h3 align="center">게시판 </h3>
	<div>
	<form action="boList.jsp" method="post">
		<select name="mode">
			<option value="0">--옵션 선택--
			<option value="1">작성자
			<option value="2">제목
			<option value="3">글내용
		</select>
		<input type="text" name="keyword" value="">
		<input type="submit" value="검색" onclick="gdoSearch()">
		<input type="button" value="전체 검색" onclick="goSearchAll()">
	</form>
	</div>
	<table border="0">
		<%=separator%>
		<tr>
			<td>&nbsp;</td>
			<td>글번호</td>
			<td>&nbsp;</td>
			<td>작성자</td>
			<td>&nbsp;</td>
			<td>제목</td>
			<td>&nbsp;</td>
			<td>비밀번호</td>
			<td>&nbsp;</td>
			<td>조회수</td>			
			<td>&nbsp;</td>
			<td>작성일자   </td>
			<td>&nbsp;</td>
			<td>수정</td>			
			<td>&nbsp;</td>
			<td>삭제</td>
			<td>&nbsp;</td>
			<td>댓글</td>
			<td>&nbsp;</td>
		</tr>
		<%=separator%>
		<tr>
			<td>&nbsp;</td>
			<td colspan="10" align="left">
				접속자 : &nbsp; <%=loginfo%> 
				&nbsp;
				<input type="button" value="글 쓰기" onclick="writeForm();">
			</td>
			<td colspan="10" align="right">
				<%=pageInfo.getPagingStatus()%>
			</td>
			<td>&nbsp;</td>
		</tr>
		<%=separator%>	
		<%
			if(lists.size() == 0){
		%>
		<tr>
			<td colspan="7">
				게시물 없음
			</td>
		</tr>
		<% 
			}else{
				for(BoardBean board : lists){
					String param = 
						"no=" + board.getNo() +
						"&pageNumber=" + pageInfo.getPageNumber() ;
					
					String replyInfo = 
						"no=" + board.getNo() +
						"&pageNumber=" + pageInfo.getPageNumber() +
						"&groupno=" + board.getGroupno() +
						"&orderno=" + board.getOrderno() + 
						"&depth=" + board.getDepth() ;
					
					String re = "" ;
					for(int i = 0 ; i < board.getDepth() ; i++){
						re += "RE:" ;
					}
		%>
		<tr>
			<td>&nbsp;</td>
			<td><%=board.getNo()%></td>	<td>&nbsp;</td>
			<td><%=board.getWriter()%></td> <td>&nbsp;</td>
			<td>
				<%  for(int i = 0 ; i < board.getDepth() ; i++) %> &nbsp; <% %>			
				<a href="boDetailView.jsp?no=<%=board.getNo()%>">
					<% if(board.getDepth() != 0) 
						%>	<img src="./../images/re.gif" width="30" height="15"> <%		
					%>
					<%=board.getSubject()%>
				</a>
			</td> <td>&nbsp;</td>
			<td><%=board.getPassword()%></td> <td>&nbsp;</td>
			<td><%=board.getReadhit()%></td> <td>&nbsp;</td>
			<td><%=board.getRegdate()%></td> <td>&nbsp;</td>
			<td><a href="boUpdateForm.jsp?<%=param%>">수정</a></td> <td>&nbsp;</td>
					
			<td> 
				<a href="#" onclick="deleteList('<%=board.getWriter()%>', 
										'<%=param%>', 
										'<%=board.getPassword()%>')">
					삭제
				</a>
			</td> <td>&nbsp;</td>	
			<td><a href="boReplyForm.jsp?<%=replyInfo%>">댓글</a></td> <td>&nbsp;</td>
			
		</tr>
		<%=separator%>
		<% 
				}
			}
		%>		
	</table>
	<%=pageInfo.getPagingHtml()%>
</td>
</tr>
<%@include file="./../common/bottom.jsp" %>

</body>
</html>
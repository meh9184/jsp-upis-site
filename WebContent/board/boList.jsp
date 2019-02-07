<%@page import="mypkg.board.Paging"%>
<%@page import="mypkg.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("EUC-KR"); %>

<%@include file="./../common/top.jsp" %>
<jsp:useBean id="bdao" class="mypkg.board.BoardDao"/>
<%
	//�˻� ���� �Ķ���͵�
	String mode = request.getParameter("mode") ;
	String keyword = request.getParameter("keyword") ;
	//out.print( "�˻� �ɼ�(mode) : " + mode + "<br>") ;
	//out.print( "�˻��� �ܾ�(keyword) : " + keyword + "<br>") ;
	//����¡ ó�� ���� �Ķ���͵�
	String pageNumber = request.getParameter("pageNumber") ;
	String pageSize = request.getParameter("pageSize") ;
	
	//mode�� ���� ī���� ���� �޶�����.
	int totalCount = bdao.getTotalCount(mode, keyword) ;
	String url = "boList.jsp" ;
	Paging pageInfo = new Paging(pageNumber, pageSize, totalCount, url, mode, keyword);
	
	ArrayList<BoardBean> lists = bdao.getBoardList(pageInfo);
	//out.print( lists.size()) ;
%> 
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>����</title>
	<script type="text/javascript">
		function writeForm(){
			//alert('�� �ۼ��մϴ�') ;
			location.href='boWriteForm.jsp' ;
		}
		function goSearchAll(){
			location.href='boList.jsp' ;
		}	
		function deleteList( writer, param, password ){
			if( '<%=loginfo%>' == writer ){
				var resp = prompt('����� ����� ��������.', "");
				if( resp == password ){
					alert('��� ��ġ') ;
					location.href='boDeleteProc.jsp?' + param  ;
				}else{
					alert('�� �ۼ� ����� ��ġ���� �ʴ� ����') ;
				}
			}else{
				alert('���� ���� ������ �Ұ����մϴ�.') ;
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
	<h3 align="center">�Խ��� </h3>
	<div>
	<form action="boList.jsp" method="post">
		<select name="mode">
			<option value="0">--�ɼ� ����--
			<option value="1">�ۼ���
			<option value="2">����
			<option value="3">�۳���
		</select>
		<input type="text" name="keyword" value="">
		<input type="submit" value="�˻�" onclick="gdoSearch()">
		<input type="button" value="��ü �˻�" onclick="goSearchAll()">
	</form>
	</div>
	<table border="0">
		<%=separator%>
		<tr>
			<td>&nbsp;</td>
			<td>�۹�ȣ</td>
			<td>&nbsp;</td>
			<td>�ۼ���</td>
			<td>&nbsp;</td>
			<td>����</td>
			<td>&nbsp;</td>
			<td>��й�ȣ</td>
			<td>&nbsp;</td>
			<td>��ȸ��</td>			
			<td>&nbsp;</td>
			<td>�ۼ�����   </td>
			<td>&nbsp;</td>
			<td>����</td>			
			<td>&nbsp;</td>
			<td>����</td>
			<td>&nbsp;</td>
			<td>���</td>
			<td>&nbsp;</td>
		</tr>
		<%=separator%>
		<tr>
			<td>&nbsp;</td>
			<td colspan="10" align="left">
				������ : &nbsp; <%=loginfo%> 
				&nbsp;
				<input type="button" value="�� ����" onclick="writeForm();">
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
				�Խù� ����
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
			<td><a href="boUpdateForm.jsp?<%=param%>">����</a></td> <td>&nbsp;</td>
					
			<td> 
				<a href="#" onclick="deleteList('<%=board.getWriter()%>', 
										'<%=param%>', 
										'<%=board.getPassword()%>')">
					����
				</a>
			</td> <td>&nbsp;</td>	
			<td><a href="boReplyForm.jsp?<%=replyInfo%>">���</a></td> <td>&nbsp;</td>
			
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
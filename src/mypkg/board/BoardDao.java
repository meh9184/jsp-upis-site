package mypkg.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mypkg.SuperDao;

public class BoardDao extends SuperDao {
	private Connection conn = null ;
	
	public BoardDao() throws Exception {
		Class.forName(driver) ;
		
		conn = DriverManager.getConnection(url, id, password) ;
	}
	
	public int UpdateReadHit( int no ) throws Exception {
		PreparedStatement pstmt = null ;
		String sql = " update boards set readhit = readhit + 1 " ;
		sql += " where no = ?  " ;
		
		conn.setAutoCommit( false ) ; 
		
		pstmt = conn.prepareStatement(sql) ;		 
		
		pstmt.setInt(1, no) ;
		
		int cnt = -1 ;
		
		cnt = pstmt.executeUpdate() ;
		
		conn.commit() ; 
		
		return cnt ;
	}
	
	public BoardBean getBoardByNo( int no ) throws Exception{
		//주어진 글 번호를 이용하여 해당 글의 Bean 정보를 리턴해준다.
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		String sql = "select * from boards where no = ?" ;
		pstmt = conn.prepareStatement(sql) ;
		pstmt.setInt(1, no) ;
		rs = pstmt.executeQuery() ;
		BoardBean board = null ;
		while(rs.next()){
			board = new BoardBean() ;
			board.setContent( rs.getString("content") ) ;
			board.setNo( rs.getInt("no") );
			board.setPassword( rs.getString("password") ) ;
			board.setReadhit( rs.getInt("readhit") ) ;
			board.setRegdate( String.valueOf( rs.getDate("regdate")) ) ;
			board.setSubject( rs.getString("subject") ) ;
			board.setWriter( rs.getString("writer") ) ;			
		}
		if(rs != null){ rs.close() ; }
		if(pstmt != null){ pstmt.close() ; }
		return board ;
	}	
	
	public int DeleteBoard( int no ) throws Exception{
		//넘겨진 글 번호를 이용하여 해당 글을 삭제한다.
		PreparedStatement pstmt = null ;
		String sql = " delete from boards where no = ? " ;
		
		conn.setAutoCommit( false ) ; //오토 커밋 기능 끄기
		
		pstmt = conn.prepareStatement(sql) ;
		
		pstmt.setInt(1, no) ; 
		
		int cnt = -1 ;
		
		cnt = pstmt.executeUpdate() ;
		
		conn.commit() ; 
		
		return cnt ;
	}
	
	public int UpdateBoard( BoardBean board ) throws Exception{
		PreparedStatement pstmt = null ;
		String sql = " update boards set subject=?,writer=?,password=?,content=?,regdate=to_date(?, 'yyyy/MM/dd') " ;
		sql += " where no = ?  " ;
		
		conn.setAutoCommit( false ) ; //오토 커밋 기능 끄기
		
		pstmt = conn.prepareStatement(sql) ;
		
		pstmt.setString(1, board.getSubject()) ;
		pstmt.setString(2, board.getWriter()) ;
		pstmt.setString(3, board.getPassword()) ;
		pstmt.setString(4, board.getContent()) ;
		pstmt.setString(5, board.getRegdate()) ; 
		pstmt.setInt(6, board.getNo()) ; 
		
		int cnt = -1 ;
		
		cnt = pstmt.executeUpdate() ;
		
		conn.commit() ; 
		
		return cnt ;
	}

	public int ReplyBoard( BoardBean board ) throws Exception{
		//댓글을 작성한다.
		PreparedStatement pstmt = null ;
		
		conn.setAutoCommit( false ) ; //오토 커밋 기능 끄기
		
		//다음 문장으로 업데이트를 수행한다.
		//update sample set orderno = orderno + 1 where groupno = 넘어온groupno and orderno > 넘어온orderno ; 
		String sql = " update boards set orderno = orderno + 1 ";
		sql += " where groupno = ? and orderno > ?    " ;
		
		pstmt = conn.prepareStatement(sql) ;
		
		pstmt.setInt(1, board.getGroupno()) ;
		pstmt.setInt(2, board.getOrderno()) ;
		
		pstmt.execute() ;
		
		pstmt = null ;
		sql = "" ;
		
		//다음의 값으로 인서트한다.
		//num : 시퀀스.nextval, groupno : 넘어온groupno사용, orderno은 1증가, depth는 1증가 시켜서 인서트한다.
		sql = " insert into boards(no,subject,writer,password,content,readhit,regdate,groupno,orderno,depth) " ;
		sql += " values(myboard.nextval,?,?,?,?,default,to_date(?, 'yyyy/MM/dd'),?,?,?) " ;
		
		pstmt = conn.prepareStatement(sql) ;
		
		pstmt.setString(1, board.getSubject()) ;
		pstmt.setString(2, board.getWriter()) ;
		pstmt.setString(3, board.getPassword()) ;
		pstmt.setString(4, board.getContent()) ;
		pstmt.setString(5, board.getRegdate()) ; 
		
		pstmt.setInt(6, board.getGroupno()) ;		
		pstmt.setInt(7, board.getOrderno() + 1 ) ;
		pstmt.setInt(8, board.getDepth() + 1 ) ;
		
		int cnt = -1 ;
		
		cnt = pstmt.executeUpdate() ;
		
		conn.commit() ; 
		
		return cnt ;
	}

	public int InsertBoard( BoardBean board ) throws Exception{
		//넘어온 파라미터를 이용하여 데이터 베이스에 인서트시킨다.
		PreparedStatement pstmt = null ;
		String sql = " insert into boards(no,groupno,subject,writer,password,content,readhit,regdate) " ;
		sql += " values(myboard.nextval,myboard.currval,?,?,?,?,default,to_date(?, 'yyyy/MM/dd')) " ;
		
		conn.setAutoCommit( false ) ; //오토 커밋 기능 끄기
		
		pstmt = conn.prepareStatement(sql) ;
		
		pstmt.setString(1, board.getSubject()) ;
		pstmt.setString(2, board.getWriter()) ;
		pstmt.setString(3, board.getPassword()) ;
		pstmt.setString(4, board.getContent()) ;
		pstmt.setString(5, board.getRegdate()) ; 
		
		int cnt = -1 ;
		
		cnt = pstmt.executeUpdate() ;
		
		conn.commit() ; 
		
		return cnt ;
	}
	
	public int getTotalCount(String mode, String keyword) throws Exception{
		//데이터베이스 내에 들어 있는 행의 수를 리턴한다.
		//검색 모드(mode)에 따라서 행의 갯수가 달라진다.
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;		
		
		if(mode == null || mode.equals("null") || mode.equals("") || mode.equals("0")){
			mode = "all" ; //all이면 전체 검색을 의미한다.
		}		
		if(keyword == null || keyword.equals("null")){
			keyword = "" ; 
		}
		//count 함수 : 행 갯수를 구해 주는 오라클 함수
		String sql = "select count(*) as cnt from boards " ;
		
		String whatcolumn = "" ; //boards 컬럼의 검색 기준 컬럼명
		
		if( !mode.equals("all")){ //전체 검색이 아니면 where 절 추가
			if( mode.equals("1") ){ //[작성자]로 검색				
				whatcolumn = " writer " ;
			}else if( mode.equals("2") ){//[제목]으로 검색				
				whatcolumn = " subject " ;
			}else if( mode.equals("3") ){//[글내용]으로 검색
				whatcolumn = " content " ;
			}	
			//검색할 모드에 따라서 where 절의 문장이 달라진다.
			sql += " where " + whatcolumn + " like '%" + keyword + "%'" ;					
		}
		pstmt = conn.prepareStatement(sql) ;
		
		rs = pstmt.executeQuery() ;
		int cnt = -1 ;
		
		while(rs.next()){
			cnt = rs.getInt("cnt") ;
		}
		
		if(rs != null){ rs.close() ; }
		if(pstmt != null){ pstmt.close() ; }
		
		return cnt ;
	}	
	
	public ArrayList<BoardBean> getBoardList(Paging pageInfo) 
			throws Exception{
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;		
		
		//키워드에 따른 검색
		String whatsql = "" ;
		String sql = "select no, subject, writer, password, content, readhit, regdate, groupno, orderno, depth ";  
		sql += " from ( select rownum as rank, no, subject, writer, password, content, readhit, regdate, groupno, orderno, depth "; 
		sql += " from ( ";
		
		//다양한 [검색]의 모드에 따라서 sql 문장이 달라져야 한다.
		//getWhatSql 이 문장을 만들어 준다. 
		whatsql = getWhatSql(pageInfo.getMode(), pageInfo.getKeyword()) ;
		
		sql += whatsql ;
		
		sql += " ) ) ";
		sql += " where rank between ? and ? ";
		
		//System.out.println("sql 문장 : <br>" + sql );
		
		ArrayList<BoardBean> lists 
		= new ArrayList<BoardBean>() ; 
		
		pstmt = conn.prepareStatement(sql) ;
		
		pstmt.setInt(1, pageInfo.getBeginRow()) ;
		pstmt.setInt(2, pageInfo.getEndRow()) ;
		
		rs = pstmt.executeQuery() ;
		
		while(rs.next()){
			BoardBean board = new BoardBean() ;
			board.setContent( rs.getString("content") ) ;
			board.setNo( rs.getInt("no") );
			board.setPassword( rs.getString("password") ) ;
			board.setReadhit( rs.getInt("readhit") ) ;
			board.setRegdate( String.valueOf( rs.getDate("regdate")) ) ;
			board.setSubject( rs.getString("subject") ) ;
			board.setWriter( rs.getString("writer") ) ;
			
			//댓글 달기로 인하여 추가된 항목들
			board.setGroupno( rs.getInt("groupno") ) ;
			board.setOrderno( rs.getInt("orderno") ) ;
			board.setDepth( rs.getInt("depth") );
			
			lists.add(board) ;
		}
		
		if(rs != null){ rs.close() ; }
		if(pstmt != null){ pstmt.close() ; }
		
		return lists ;
	}	
	
	private String getWhatSql(String mode, String keyword) {
		//모드 및 키워드에 따른 sql 문장을 만들어 준다.
		//이 문장은 오라클의 topN절의 가장 안쪽에 사용되는 문장이다.
		String result = ""; 
		String whatcolumn = "" ; //where에 사용할 컬럼 
		if( mode.equals("all") ){
			result += " select no, subject, writer, password, content, readhit, regdate, groupno, orderno, depth  ";
			result += " from boards  ";
			result += " order by groupno desc, orderno asc, depth asc " ;
			
		}else{
			if( mode.equals("1") ){ //[작성자]로 검색				
				whatcolumn = " writer " ;
			}else if( mode.equals("2") ){//[제목]으로 검색				
				whatcolumn = " subject " ;
			}else if( mode.equals("3") ){//[글내용]으로 검색
				whatcolumn = " content " ;
			}	
			result += " select no, subject, writer, password, content, readhit, regdate, groupno, orderno, depth  ";
			result += " from boards  ";
			result += " where " + whatcolumn + " like '%" + keyword + "%'" ;
			result += " order by groupno desc, orderno asc, depth asc " ;			
		} 		
		return result ;
	}

	public ArrayList<BoardBean> getBoardList() 
			throws Exception{
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;		
		
		//order by no asc : no 컬럼으로 오름차순 정렬
		String sql = "select * from boards  order by no asc ";
		
		ArrayList<BoardBean> lists 
		= new ArrayList<BoardBean>() ; 
		
		pstmt = conn.prepareStatement(sql) ;
		
		rs = pstmt.executeQuery() ;
		
		while(rs.next()){
			BoardBean board = new BoardBean() ;
			board.setContent( rs.getString("content") ) ;
			board.setNo( rs.getInt("no") );
			board.setPassword( rs.getString("password") ) ;
			board.setReadhit( rs.getInt("readhit") ) ;
			board.setRegdate( String.valueOf( rs.getDate("regdate")) ) ;
			board.setSubject( rs.getString("subject") ) ;
			board.setWriter( rs.getString("writer") ) ;
			
			//댓글 달기로 인하여 추가된 항목들
			board.setGroupno( rs.getInt("groupno") ) ;
			board.setOrderno( rs.getInt("orderno") ) ;
			board.setDepth( rs.getInt("depth") );
			
			lists.add(board) ;
		}
		
		if(rs != null){ rs.close() ; }
		if(pstmt != null){ pstmt.close() ; }
		
		return lists ;
	}	
}
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
		//�־��� �� ��ȣ�� �̿��Ͽ� �ش� ���� Bean ������ �������ش�.
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
		//�Ѱ��� �� ��ȣ�� �̿��Ͽ� �ش� ���� �����Ѵ�.
		PreparedStatement pstmt = null ;
		String sql = " delete from boards where no = ? " ;
		
		conn.setAutoCommit( false ) ; //���� Ŀ�� ��� ����
		
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
		
		conn.setAutoCommit( false ) ; //���� Ŀ�� ��� ����
		
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
		//����� �ۼ��Ѵ�.
		PreparedStatement pstmt = null ;
		
		conn.setAutoCommit( false ) ; //���� Ŀ�� ��� ����
		
		//���� �������� ������Ʈ�� �����Ѵ�.
		//update sample set orderno = orderno + 1 where groupno = �Ѿ��groupno and orderno > �Ѿ��orderno ; 
		String sql = " update boards set orderno = orderno + 1 ";
		sql += " where groupno = ? and orderno > ?    " ;
		
		pstmt = conn.prepareStatement(sql) ;
		
		pstmt.setInt(1, board.getGroupno()) ;
		pstmt.setInt(2, board.getOrderno()) ;
		
		pstmt.execute() ;
		
		pstmt = null ;
		sql = "" ;
		
		//������ ������ �μ�Ʈ�Ѵ�.
		//num : ������.nextval, groupno : �Ѿ��groupno���, orderno�� 1����, depth�� 1���� ���Ѽ� �μ�Ʈ�Ѵ�.
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
		//�Ѿ�� �Ķ���͸� �̿��Ͽ� ������ ���̽��� �μ�Ʈ��Ų��.
		PreparedStatement pstmt = null ;
		String sql = " insert into boards(no,groupno,subject,writer,password,content,readhit,regdate) " ;
		sql += " values(myboard.nextval,myboard.currval,?,?,?,?,default,to_date(?, 'yyyy/MM/dd')) " ;
		
		conn.setAutoCommit( false ) ; //���� Ŀ�� ��� ����
		
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
		//�����ͺ��̽� ���� ��� �ִ� ���� ���� �����Ѵ�.
		//�˻� ���(mode)�� ���� ���� ������ �޶�����.
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;		
		
		if(mode == null || mode.equals("null") || mode.equals("") || mode.equals("0")){
			mode = "all" ; //all�̸� ��ü �˻��� �ǹ��Ѵ�.
		}		
		if(keyword == null || keyword.equals("null")){
			keyword = "" ; 
		}
		//count �Լ� : �� ������ ���� �ִ� ����Ŭ �Լ�
		String sql = "select count(*) as cnt from boards " ;
		
		String whatcolumn = "" ; //boards �÷��� �˻� ���� �÷���
		
		if( !mode.equals("all")){ //��ü �˻��� �ƴϸ� where �� �߰�
			if( mode.equals("1") ){ //[�ۼ���]�� �˻�				
				whatcolumn = " writer " ;
			}else if( mode.equals("2") ){//[����]���� �˻�				
				whatcolumn = " subject " ;
			}else if( mode.equals("3") ){//[�۳���]���� �˻�
				whatcolumn = " content " ;
			}	
			//�˻��� ��忡 ���� where ���� ������ �޶�����.
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
		
		//Ű���忡 ���� �˻�
		String whatsql = "" ;
		String sql = "select no, subject, writer, password, content, readhit, regdate, groupno, orderno, depth ";  
		sql += " from ( select rownum as rank, no, subject, writer, password, content, readhit, regdate, groupno, orderno, depth "; 
		sql += " from ( ";
		
		//�پ��� [�˻�]�� ��忡 ���� sql ������ �޶����� �Ѵ�.
		//getWhatSql �� ������ ����� �ش�. 
		whatsql = getWhatSql(pageInfo.getMode(), pageInfo.getKeyword()) ;
		
		sql += whatsql ;
		
		sql += " ) ) ";
		sql += " where rank between ? and ? ";
		
		//System.out.println("sql ���� : <br>" + sql );
		
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
			
			//��� �ޱ�� ���Ͽ� �߰��� �׸��
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
		//��� �� Ű���忡 ���� sql ������ ����� �ش�.
		//�� ������ ����Ŭ�� topN���� ���� ���ʿ� ���Ǵ� �����̴�.
		String result = ""; 
		String whatcolumn = "" ; //where�� ����� �÷� 
		if( mode.equals("all") ){
			result += " select no, subject, writer, password, content, readhit, regdate, groupno, orderno, depth  ";
			result += " from boards  ";
			result += " order by groupno desc, orderno asc, depth asc " ;
			
		}else{
			if( mode.equals("1") ){ //[�ۼ���]�� �˻�				
				whatcolumn = " writer " ;
			}else if( mode.equals("2") ){//[����]���� �˻�				
				whatcolumn = " subject " ;
			}else if( mode.equals("3") ){//[�۳���]���� �˻�
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
		
		//order by no asc : no �÷����� �������� ����
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
			
			//��� �ޱ�� ���Ͽ� �߰��� �׸��
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
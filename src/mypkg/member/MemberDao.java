package mypkg.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mypkg.SuperDao;

public class MemberDao extends SuperDao {
	private Connection conn = null ;
	
	public ArrayList<MemberBean> getMemberList(){
		//모든 회원을 조회하여 자바의 컬렉션으로 반환해준다.
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;		
		String sql = "select * from members  " ;		
		ArrayList<MemberBean> lists = new ArrayList<MemberBean>();
		try {
			pstmt = conn.prepareStatement(sql) ;			
			rs = pstmt.executeQuery() ;			
			while( rs.next() ){
				MemberBean member = new MemberBean() ;			
				member.setId(rs.getString("id")) ;
				member.setAddress1(rs.getString("address1")) ;
				member.setAddress2(rs.getString("address2")) ;
				member.setGender(rs.getString("gender")) ;				
				member.setHobby(rs.getString("hobby")) ;
				member.setJob(rs.getString("job")) ;				
				member.setName(rs.getString("name")) ;
				member.setPassword(rs.getString("password")) ;				
				member.setZipcode(rs.getString("zipcode")) ;				
				member.setHiredate(String.valueOf(rs.getDate("hiredate"))) ;				
				member.setMpoint(rs.getInt("mpoint")) ;
				member.setSalary(rs.getInt("salary")) ;
				lists.add(member) ; 
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return lists ;
	}
	
	public int getSelectByMember(MemberBean member){
		PreparedStatement pstmt = null ;
		String sql = "select password from members where id = ? "; 
		ResultSet rs = null ;
		int cnt = -1;
		try {
			pstmt = conn.prepareStatement( sql ) ;
			pstmt.setString(1, member.getId()) ;
			rs = pstmt.executeQuery() ;
			if(rs.next()){ //아이디 존재
				if( rs.getString("password").equals(member.getPassword())){
					cnt = 1 ;
				}else{
					cnt = 0 ;
				}
			}else{ //존재하지 않는 회원
				//코딩할 필요 없음
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(rs != null){rs.close() ; }
				if(pstmt != null){pstmt.close() ; }
				if(conn != null){conn.close() ; }
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}
		
		return cnt  ;
	}

	public MemberBean getMemberById( String id ){
		//해당 아이디를 가지고 멤버 빈 객체를 리턴한다.
		PreparedStatement pstmt = null ;
		String sql = " select * from members where id = ? ";
		ResultSet rs = null ;
		MemberBean member = null ;
		
		try {
			pstmt = conn.prepareStatement( sql ) ;
			
			pstmt.setString(1, id) ;
			rs = pstmt.executeQuery() ; 
			
			if( rs.next() ){
				member = new MemberBean() ;
				
				member.setId(rs.getString("id")) ;
				member.setAddress1(rs.getString("address1")) ;
				member.setAddress2(rs.getString("address2")) ;
				member.setGender(rs.getString("gender")) ;				
				member.setHobby(rs.getString("hobby")) ;
				member.setJob(rs.getString("job")) ;				
				member.setName(rs.getString("name")) ;
				member.setPassword(rs.getString("password")) ;				
				member.setZipcode(rs.getString("zipcode")) ;				
				member.setHiredate(String.valueOf(rs.getDate("hiredate"))) ;				
				member.setMpoint(rs.getInt("mpoint")) ;
				member.setSalary(rs.getInt("salary")) ;			
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if( rs != null ){rs.close() ;}
				if( pstmt != null ){pstmt.close() ;}
				if( conn != null ){conn.close() ;}	
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
		return member ;
	}
	
	public MemberDao() {
		try {
			Class.forName( driver ) ;
			conn = DriverManager.getConnection(url, id, password) ;
			if(conn != null){
				//System.out.println("접속 성공");
			}else{
				System.out.println("MemberDao : 접속 실패");
			}
		} catch (ClassNotFoundException e) {
			System.out.println("클래스 발견 안되요");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("SQL 예외");
			e.printStackTrace();
		}
	}
	
	public int DeleteMember( String id ){
		//회원의 아이디를 이용하여 삭제한다.
		PreparedStatement pstmt = null ;
		
		String sql = " delete from members where id = ? " ; 
		
		int cnt = -1 ; 
		
		try {
			conn.setAutoCommit(false) ;
			pstmt = conn.prepareStatement(sql) ;			
			pstmt.setString(1, id) ;
			
			cnt = pstmt.executeUpdate() ; 
			conn.commit();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally{
			try {
				
				if(pstmt != null){ pstmt.close() ; }
				if(conn != null){ conn.close() ; }
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		
		return cnt  ;
	}
	
	public int UpdateMember( MemberBean member ){
		//멤버 빈 객체를 입력 받아서 DB에 데이터를 수정한다.
		PreparedStatement pstmt = null ;
		
		String sql = " update members set mpoint=?, name=?,password=?,salary=?," ;
		sql += " hiredate=to_date(?, 'yyyy/MM/dd'),gender=?,hobby=?,job=?,zipcode=?," ;
		sql += " address1=?,address2=? where id = ? " ;  
		int cnt = -1 ; 
		
		try {
			conn.setAutoCommit(false) ;
			pstmt = conn.prepareStatement(sql) ;
			
			pstmt.setInt(1, member.getMpoint());			
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getPassword());			
			pstmt.setInt(4, member.getSalary());			
			pstmt.setString(5, member.getHiredate());			
			pstmt.setString(6, member.getGender());
			pstmt.setString(7, member.getHobby());
			pstmt.setString(8, member.getJob());
			pstmt.setString(9, member.getZipcode());
			pstmt.setString(10, member.getAddress1());
			pstmt.setString(11, member.getAddress2());
			pstmt.setString(12, member.getId());
			
			cnt = pstmt.executeUpdate() ; 
			conn.commit();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally{
			try {
				
				if(pstmt != null){ pstmt.close() ; }
				if(conn != null){ conn.close() ; }
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		
		return cnt  ;
	}	
	
	public int InsertMember( MemberBean member ){
		//멤버 빈 객체를 입력 받아서 DB에 데이터를 인서트 시킨다.
		PreparedStatement pstmt = null ;
		
		String sql = " insert into members(id,name,password,salary," ;
		sql += " hiredate,gender,hobby,job,zipcode,address1,address2,mpoint)" ;
		sql += " values(?, ?, ?, ?, to_date(?, 'yyyy/MM/dd'),  ?, ?, ?, ?, ?, ?, ?)" ; 
		
		int cnt = -1 ; 
		
		try {
			conn.setAutoCommit(false) ;
			pstmt = conn.prepareStatement(sql) ;
			
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getPassword());			
			pstmt.setInt(4, member.getSalary());			
			pstmt.setString(5, member.getHiredate());			
			pstmt.setString(6, member.getGender());
			pstmt.setString(7, member.getHobby());
			pstmt.setString(8, member.getJob());
			pstmt.setString(9, member.getZipcode());
			pstmt.setString(10, member.getAddress1());
			pstmt.setString(11, member.getAddress2());
			pstmt.setInt(12, member.getMpoint());
			
			cnt = pstmt.executeUpdate() ; 
			conn.commit();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally{
			try {
				
				if(pstmt != null){ pstmt.close() ; }
				if(conn != null){ conn.close() ; }
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		
		return cnt  ;
	}
}













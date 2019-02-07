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
		//��� ȸ���� ��ȸ�Ͽ� �ڹ��� �÷������� ��ȯ���ش�.
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
			if(rs.next()){ //���̵� ����
				if( rs.getString("password").equals(member.getPassword())){
					cnt = 1 ;
				}else{
					cnt = 0 ;
				}
			}else{ //�������� �ʴ� ȸ��
				//�ڵ��� �ʿ� ����
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
		//�ش� ���̵� ������ ��� �� ��ü�� �����Ѵ�.
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
				//System.out.println("���� ����");
			}else{
				System.out.println("MemberDao : ���� ����");
			}
		} catch (ClassNotFoundException e) {
			System.out.println("Ŭ���� �߰� �ȵǿ�");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("SQL ����");
			e.printStackTrace();
		}
	}
	
	public int DeleteMember( String id ){
		//ȸ���� ���̵� �̿��Ͽ� �����Ѵ�.
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
		//��� �� ��ü�� �Է� �޾Ƽ� DB�� �����͸� �����Ѵ�.
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
		//��� �� ��ü�� �Է� �޾Ƽ� DB�� �����͸� �μ�Ʈ ��Ų��.
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













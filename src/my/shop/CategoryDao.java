package my.shop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import mypkg.SuperDao;

public class CategoryDao extends SuperDao{
	private DataSource ds = null ;
	private Connection conn = null ;
	
	public CategoryBean getCategoryByCnum( int cnum ){
		PreparedStatement pstmt  = null ;
		ResultSet rs = null ; 
		String sql = "select * from category where cnum = ? " ;		
		CategoryBean category = new CategoryBean() ;
		
		try {
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setInt(1, cnum) ;
			rs = pstmt.executeQuery() ;
			
			if(rs.next()){			
				category.setCnum( rs.getInt("cnum" )) ;
				category.setCode( rs.getString("code" )) ;
				category.setCname( rs.getString("cname" )) ;				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if( rs != null ){rs.close() ; }
				if( pstmt != null ){pstmt.close() ; }
				closeConnection();
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}		
		return category ;
	}
	
	public CategoryDao() {
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
	
	//모든 카테고리를 조회한다.
	public ArrayList<CategoryBean> getAllCategory(){
		PreparedStatement pstmt  = null ;
		ResultSet rs = null ; 
		//카테고리 번호 순서로 오름차순 정렬
		String sql = "select * from category order by cnum " ;
		ArrayList<CategoryBean> lists = new ArrayList<CategoryBean>();
		try {
			pstmt = conn.prepareStatement(sql) ;
			rs = pstmt.executeQuery() ;
			
			while(rs.next()){
				CategoryBean category = new CategoryBean() ;
				category.setCnum( rs.getInt("cnum" )) ;
				category.setCode( rs.getString("code" )) ;
				category.setCname( rs.getString("cname" )) ;
				lists.add(category) ;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if( rs != null ){rs.close() ; }
				if( pstmt != null ){pstmt.close() ; }
				closeConnection();
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}
		
		return lists ;
	}
	
	private void closeConnection() {
		try {
			if( conn != null ){conn.close() ; }
		} catch (SQLException e) {			
			e.printStackTrace();
		}
	}

	//카테고리를 등록한다.
	public int InsertCategoy(CategoryBean category){
		PreparedStatement pstmt  = null ;
		ResultSet rs = null ; 
		String sql = "insert into category values(catseq.nextval, ?, ? )  " ;
		int cnt = -1 ; 
		try {
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setString(1, category.getCode()) ;
			pstmt.setString(2, category.getCname()) ;
			
			cnt = pstmt.executeUpdate() ;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if( rs != null ){rs.close() ; }
				if( pstmt != null ){pstmt.close() ; }
				closeConnection();
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}		
		return cnt  ;
	}
	
	//해당 cnum에 대한 카테고리를 삭제한다.
	public int DeleteCategory(int cnum){
		PreparedStatement pstmt  = null ;
		ResultSet rs = null ; 
		String sql = "delete from category where cnum = ?   " ;
		int cnt = -1 ; 
		try {
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setInt(1, cnum) ;			
			cnt = pstmt.executeUpdate() ;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if( rs != null ){rs.close() ; }
				if( pstmt != null ){pstmt.close() ; }
				closeConnection();
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}		
		return cnt  ;
	}
	
	//카테고리를 수정한다.
	public int UpdateCategoy(CategoryBean category){
		PreparedStatement pstmt  = null ;
		ResultSet rs = null ; 
		String sql = "update category set code = ?, cname = ? where cnum = ?  " ;
		int cnt = -1 ; 
		try {
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setString(1, category.getCode()) ;
			pstmt.setString(2, category.getCname()) ;
			pstmt.setInt(3, category.getCnum()) ;
			
			cnt = pstmt.executeUpdate() ;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if( rs != null ){rs.close() ; }
				if( pstmt != null ){pstmt.close() ; }
				closeConnection();
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}		
		return cnt  ;
	}
}

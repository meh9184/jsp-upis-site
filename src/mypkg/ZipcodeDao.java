package mypkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class ZipcodeDao extends SuperDao {
	private Connection conn = null ;
	
	private void closeConnection() {
		//해당 커넥션을 종료시킨다.
		try {
			if(conn != null){ conn.close() ;  }
		} catch (SQLException e) {			
			e.printStackTrace();
		}
	}
	
	public Vector<ZipcodeBean> getZipcodeList(String dong){
	//public Vector<ZipcodeBean> getZipcodeList(String dong, int beginRow, int endRow){
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<ZipcodeBean> ziplists = new Vector<ZipcodeBean>();//벡터 객체를 선언

		try {
			//bunji 컬럼에 널이 들어 있는 경우가 있다.
			//이를 위해서 오라클의 nvl 함수(번지는 의도적으로 스페이스 1개를 넣어서 처리)를 사용하도록 한다.
			String sql = "select zipcode, sido, gugun, dong, nvl(bunji, ' ') bunji from zipcodes where dong like '" + dong + "%'";
			sql += " order by zipcode" ;
			/*String sql = " select zipcode, sido, gugun, dong, bunji, seqnum " ;
			sql += " from (select rownum as rank, zipcode, sido, gugun, dong, bunji, seqnum";
			sql += " from (select zipcode, sido, gugun, dong, nvl(bunji, ' ') bunji, seqnum"; 
			sql += " from zipcodes where dong like '" + dong + "%' order by zipcode))" ;
			sql += " where rank between ? and ? "; */
			
			pstmt = conn.prepareStatement(sql);
			
			/*System.out.println( "beginRow : " + beginRow );
			System.out.println( "endRow : " + endRow );
			
			pstmt.setInt(1, beginRow) ;
			pstmt.setInt(2, endRow) ;*/
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				ZipcodeBean myzip = new ZipcodeBean();
				
				myzip.setZipcode(rs.getString("zipcode"));
				myzip.setSido(rs.getString("sido"));
				myzip.setGugun(rs.getString("gugun"));
				myzip.setDong(rs.getString("dong"));
				myzip.setBunji( rs.getString("bunji"));
				//myzip.setSeqnum(Integer.parseInt(rs.getString("seqnum")));
				
				ziplists.addElement( myzip );
			}
		}catch(Exception ex) {
			System.out.println("Exception" + ex);
			ex.printStackTrace();
		}finally{
			if(rs!= null){try{rs.close();}catch(Exception e){}}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)  closeConnection(); 
		}
		return ziplists;
	}
	
	public int getTotalCount(String dong) throws Exception{
		//데이터베이스 내에 들어 있는 행의 수를 리턴한다.
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;		

		String sql = "select count(*) as cnt from zipcodes " ;
		sql += " where dong like '" + dong + "%'" ; 
				
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
	
	public ZipcodeDao() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, id, password) ;
			
		} catch (ClassNotFoundException e) {
			System.out.println("클래스가 발견되지 않았습니다.");
			e.printStackTrace();
			
		} catch (SQLException e) {
			System.out.println("SQLException 예외 발견.");
			e.printStackTrace();
		}
	}
}
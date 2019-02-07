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
		//�ش� Ŀ�ؼ��� �����Ų��.
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
		Vector<ZipcodeBean> ziplists = new Vector<ZipcodeBean>();//���� ��ü�� ����

		try {
			//bunji �÷��� ���� ��� �ִ� ��찡 �ִ�.
			//�̸� ���ؼ� ����Ŭ�� nvl �Լ�(������ �ǵ������� �����̽� 1���� �־ ó��)�� ����ϵ��� �Ѵ�.
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
		//�����ͺ��̽� ���� ��� �ִ� ���� ���� �����Ѵ�.
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
			System.out.println("Ŭ������ �߰ߵ��� �ʾҽ��ϴ�.");
			e.printStackTrace();
			
		} catch (SQLException e) {
			System.out.println("SQLException ���� �߰�.");
			e.printStackTrace();
		}
	}
}
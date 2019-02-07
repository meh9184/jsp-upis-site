/*package my.shop;

import javax.naming.Context;
import javax.naming.InitialContext;

import javax.sql.DataSource;

public class OrderDao {

}*/
package my.shop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import mypkg.SuperDao;

//장바구니에 담은 목록을 데이터베이스에 저장시킨다.
public class OrderDao extends SuperDao{
	private DataSource ds = null ;
	private Connection conn = null ;
	
	public OrderDao(){
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
	
	public Vector<OrderList> getOrderList(String memid, String startdate, String enddate) throws SQLException{
		//해당 사원의 주문 내역을 목록으로 되돌려 준다.
		//startdate : 검색 시작 일자, enddate : 검색 종료 일자
		String sql = "" ;
		PreparedStatement pstmt = null ;			
		
		Vector<OrderList> orderLists = new Vector<OrderList>() ;

		sql = " select o.oid, o.orderdate, p.name pname, od.qty, p.price, od.qty * p.price as amount " ;  
		sql += " from ((orders o inner join orderdetails od " ;
		sql += " on o.oid=od.oid) inner join products p " ;
		sql += " on od.pnum=p.num) inner join members m " ;
		sql += " on o.mid=m.id " ;
		sql += " where m.id = ? " ;
		if(startdate == null){
			sql += " and o.orderdate between to_date(?, 'yyyy/MM/dd') and to_date(?, 'yyyy/MM/dd') " ;	
		}
		sql += " order by oid, o.orderdate " ;
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memid);
		if(startdate == null){
			pstmt.setString(2, startdate);	
			pstmt.setString(3, enddate);
		}		
		ResultSet rs = pstmt.executeQuery() ;
		
		while(rs.next()){ //해당 사원의 모든 주문 내역
			OrderList orderlist = new OrderList() ;
			
			orderlist.setOrderdate( String.valueOf( rs.getDate("orderdate") )); 
			orderlist.setOid( rs.getInt("oid") );
			orderlist.setPname( rs.getString("pname")); 
			orderlist.setPrice( rs.getInt("price") );
			orderlist.setQty( rs.getInt("qty") ); 
			orderlist.setAmount( rs.getInt("amount") ) ;
			
			orderLists.add(orderlist) ; 
		}		
		
		if( rs != null){ rs.close(); }
		if( pstmt != null){ pstmt.close() ; }
		if( conn != null ) {conn.close() ;}
		
		return orderLists ;
	}
	
	public Vector<OrderBean> getOrderListOld(String mid) throws SQLException{
		//해당 사원의 주문 내역을 목록으로 되돌려 준다.
		String sql = "" ;
		PreparedStatement pstmt = null ;
		
		Vector<OrderBean> orders = new Vector<OrderBean>() ;
		sql = "select * from orders order by oid where mid = ? " ;
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mid);
		ResultSet rs = pstmt.executeQuery() ;
		
		while(rs.next()){ //해당 사원의 모든 주문 내역
			OrderBean order = new OrderBean() ;
			
			order.setMid(mid);
			order.setOrderdate( String.valueOf( rs.getDate("orderdate") ));
			int oid = rs.getInt("oid") ;
			order.setOid( oid );
			
			//해당 주문 아이디(oid)에 대한 상세 주문 내역을 조회한다.
			String whilesql = "select * from orderdetails order by pnum where oid = ? " ;
			PreparedStatement whilepstmt = null ;
			whilepstmt = conn.prepareStatement(whilesql) ;
			whilepstmt.setInt(1, oid);
			ResultSet whilers = whilepstmt.executeQuery() ;
			
			Vector<OrderItem> items = new Vector<OrderItem>() ;
			while(whilers.next()){
				OrderItem item = new OrderItem() ;
				item.setPnum(rs.getInt("pnum"));
				item.setQty(rs.getInt("qty"));
				items.add(item) ;
			}
			order.setOrderItems(items); 
			
			orders.add(order) ;
			
			if( whilers != null){ whilers.close(); }
			if( whilepstmt != null){ whilepstmt.close() ; }
		}		
		
		if( rs != null){ rs.close(); }
		if( pstmt != null){ pstmt.close() ; }
		if( conn != null ) {conn.close() ;}		
		return orders ;
	}	
	
	public int InsertOrder(String memid, Vector<ProductBean> carts) throws SQLException{
		//회원 memid가 구매한 장바구니의 내역(carts)을 데이터베이스에 저장한다.
		PreparedStatement pstmt = null ;
		conn.setAutoCommit( false ) ;
		
		String sql = "" ;
		int cnt = -1 ;
		
		//0. 시퀀스 번호 뽑기
		//dual 테이블 : 함수 수식이나, 연산의 결과를 간단히 조회하기 위한 용도로 만든 dummy 테이블
		sql = "select seqoid.nextval from dual " ;
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery() ;
		
		//seq는 일종의 송장 번호 역할을 수행
		int seq = -1; //이 번호는 주문 테이블과 주문 상세 테이블에 동시에 들어 간다.
		if(rs.next()){ 
			seq = rs.getInt(1) ;
		}
		//2개의 객체 변수(rs와 pstmt)는 재사용을 위하여 다시 초기화 시킨다.
		if( rs != null){ rs.close(); }
		if( pstmt != null){ pstmt = null ; }
		
		//1.주문 테이블에 인서트한다.
		sql = "insert into orders values(?, ?, sysdate) ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, seq); //송장 번호
		pstmt.setString(2, memid); //주문한 고객
		 
		cnt = pstmt.executeUpdate();
		if( pstmt != null){ pstmt = null ; }
		
		//2.주문 상세 테이블에 데이터를 인서트한다.
		
		//각 상품의 포인트는 products 테이블의 point 컬럼을 참고하라
		//select name, point from products ;
		
		int sumTotalPoint = 0 ; //해당 상품들에 대한 총 적립 포인트
		
		for(ProductBean cart: carts){ //2개 이상의 상품을 구해할 수도 있다.
			sql = "insert into orderdetails(odid, oid, pnum, qty) values(seqodid.nextval, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, seq); //송장 번호(orders 테이블과 동일한 값이다.)
			pstmt.setInt(2, cart.getNum()); //상품 번호
			pstmt.setInt(3, cart.getStock()); //판매된 수량
			
			sumTotalPoint += cart.getTotalPoint(); //포인트 누적
			
			cnt = pstmt.executeUpdate();
			if( pstmt != null){ pstmt = null ; }
		}
		
		//3.해당 회원의 포인트를 적립해준다.
		sql = "update members set mpoint = mpoint + ? where id = ?  ";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, sumTotalPoint);
		pstmt.setString(2, memid);
				 
		cnt = pstmt.executeUpdate();
		if( pstmt != null){ pstmt = null ; }
		
		//4. 재고 수량을 변경해 줘야 한다.
		for(ProductBean cart : carts){
			sql = "update products set stock = stock - ? where num = ?  ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cart.getStock()) ; //판매된 수량(이만큼 감소)
			pstmt.setInt(2, cart.getNum()) ; //해당 상품
			
			cnt = pstmt.executeUpdate();
			if( pstmt != null){ pstmt = null ; }
		}
		
		conn.commit() ;
		if( conn != null ) {conn.close() ;}		
		return cnt  ;		
	}
}
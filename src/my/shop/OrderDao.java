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

//��ٱ��Ͽ� ���� ����� �����ͺ��̽��� �����Ų��.
public class OrderDao extends SuperDao{
	private DataSource ds = null ;
	private Connection conn = null ;
	
	public OrderDao(){
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
	
	public Vector<OrderList> getOrderList(String memid, String startdate, String enddate) throws SQLException{
		//�ش� ����� �ֹ� ������ ������� �ǵ��� �ش�.
		//startdate : �˻� ���� ����, enddate : �˻� ���� ����
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
		
		while(rs.next()){ //�ش� ����� ��� �ֹ� ����
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
		//�ش� ����� �ֹ� ������ ������� �ǵ��� �ش�.
		String sql = "" ;
		PreparedStatement pstmt = null ;
		
		Vector<OrderBean> orders = new Vector<OrderBean>() ;
		sql = "select * from orders order by oid where mid = ? " ;
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mid);
		ResultSet rs = pstmt.executeQuery() ;
		
		while(rs.next()){ //�ش� ����� ��� �ֹ� ����
			OrderBean order = new OrderBean() ;
			
			order.setMid(mid);
			order.setOrderdate( String.valueOf( rs.getDate("orderdate") ));
			int oid = rs.getInt("oid") ;
			order.setOid( oid );
			
			//�ش� �ֹ� ���̵�(oid)�� ���� �� �ֹ� ������ ��ȸ�Ѵ�.
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
		//ȸ�� memid�� ������ ��ٱ����� ����(carts)�� �����ͺ��̽��� �����Ѵ�.
		PreparedStatement pstmt = null ;
		conn.setAutoCommit( false ) ;
		
		String sql = "" ;
		int cnt = -1 ;
		
		//0. ������ ��ȣ �̱�
		//dual ���̺� : �Լ� �����̳�, ������ ����� ������ ��ȸ�ϱ� ���� �뵵�� ���� dummy ���̺�
		sql = "select seqoid.nextval from dual " ;
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery() ;
		
		//seq�� ������ ���� ��ȣ ������ ����
		int seq = -1; //�� ��ȣ�� �ֹ� ���̺�� �ֹ� �� ���̺� ���ÿ� ��� ����.
		if(rs.next()){ 
			seq = rs.getInt(1) ;
		}
		//2���� ��ü ����(rs�� pstmt)�� ������ ���Ͽ� �ٽ� �ʱ�ȭ ��Ų��.
		if( rs != null){ rs.close(); }
		if( pstmt != null){ pstmt = null ; }
		
		//1.�ֹ� ���̺� �μ�Ʈ�Ѵ�.
		sql = "insert into orders values(?, ?, sysdate) ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, seq); //���� ��ȣ
		pstmt.setString(2, memid); //�ֹ��� ��
		 
		cnt = pstmt.executeUpdate();
		if( pstmt != null){ pstmt = null ; }
		
		//2.�ֹ� �� ���̺� �����͸� �μ�Ʈ�Ѵ�.
		
		//�� ��ǰ�� ����Ʈ�� products ���̺��� point �÷��� �����϶�
		//select name, point from products ;
		
		int sumTotalPoint = 0 ; //�ش� ��ǰ�鿡 ���� �� ���� ����Ʈ
		
		for(ProductBean cart: carts){ //2�� �̻��� ��ǰ�� ������ ���� �ִ�.
			sql = "insert into orderdetails(odid, oid, pnum, qty) values(seqodid.nextval, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, seq); //���� ��ȣ(orders ���̺�� ������ ���̴�.)
			pstmt.setInt(2, cart.getNum()); //��ǰ ��ȣ
			pstmt.setInt(3, cart.getStock()); //�Ǹŵ� ����
			
			sumTotalPoint += cart.getTotalPoint(); //����Ʈ ����
			
			cnt = pstmt.executeUpdate();
			if( pstmt != null){ pstmt = null ; }
		}
		
		//3.�ش� ȸ���� ����Ʈ�� �������ش�.
		sql = "update members set mpoint = mpoint + ? where id = ?  ";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, sumTotalPoint);
		pstmt.setString(2, memid);
				 
		cnt = pstmt.executeUpdate();
		if( pstmt != null){ pstmt = null ; }
		
		//4. ��� ������ ������ ��� �Ѵ�.
		for(ProductBean cart : carts){
			sql = "update products set stock = stock - ? where num = ?  ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cart.getStock()) ; //�Ǹŵ� ����(�̸�ŭ ����)
			pstmt.setInt(2, cart.getNum()) ; //�ش� ��ǰ
			
			cnt = pstmt.executeUpdate();
			if( pstmt != null){ pstmt = null ; }
		}
		
		conn.commit() ;
		if( conn != null ) {conn.close() ;}		
		return cnt  ;		
	}
}
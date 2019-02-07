package my.shop;

import java.util.Vector;

//1개의 주문에 대한 빈 클래스
public class OrderBean {
	private int oid ; //주문 아이디(일종의 송장 번호 같은 개념)
	private String mid ; //회원 아이디
	private String orderdate ; //주문 일자
	
	//orderItems : 여러 건의 상품 구매 내역을 저장하고 있는 컬렉션
	//OrderItem은 상품 1건에 대한 정보를 담고 있다.
	private Vector<OrderItem> orderItems ;

	public int getOid() {
		return oid;
	}

	public void setOid(int oid) {
		this.oid = oid;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}

	public Vector<OrderItem> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(Vector<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}	
}
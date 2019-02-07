package my.shop;

//고객이 주문한 각 상품에 대한 구매 내역을 구현한 클래스
//특정 테이블에 종속적이지 않고, 여러 개의 테이블을 조인한 결과이다.
//상품 1개당 객체 1개가 만들어진다.
public class OrderList {
	private int oid ; //주문 번호
	//private String memid ; //회원 번호
	private String orderdate ; //주문 일자
	private String pname ; //상품 이름
	private int qty ; //판매 수량
	private int price ; //단가
	private int amount ; //판매 총액	
	
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}	
}
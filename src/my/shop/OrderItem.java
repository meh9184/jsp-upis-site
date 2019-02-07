package my.shop;

//주문 발생시 여러 개의 상품들을 판매할 수 있는 데
//이때 각각 상품들에 대한 상품 번호와 판매 수량을 저장하고 있는 클래스이다.

//이 클래스는 OrderBean 클래스의 멤버 변수로 사용되고 있다.
public class OrderItem {
	private int pnum ; //상품 번호
	private int qty ; //판매 수량

	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}	
}
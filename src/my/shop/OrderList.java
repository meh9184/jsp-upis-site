package my.shop;

//���� �ֹ��� �� ��ǰ�� ���� ���� ������ ������ Ŭ����
//Ư�� ���̺� ���������� �ʰ�, ���� ���� ���̺��� ������ ����̴�.
//��ǰ 1���� ��ü 1���� ���������.
public class OrderList {
	private int oid ; //�ֹ� ��ȣ
	//private String memid ; //ȸ�� ��ȣ
	private String orderdate ; //�ֹ� ����
	private String pname ; //��ǰ �̸�
	private int qty ; //�Ǹ� ����
	private int price ; //�ܰ�
	private int amount ; //�Ǹ� �Ѿ�	
	
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
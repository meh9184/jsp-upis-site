package my.shop;

import java.util.Vector;

//1���� �ֹ��� ���� �� Ŭ����
public class OrderBean {
	private int oid ; //�ֹ� ���̵�(������ ���� ��ȣ ���� ����)
	private String mid ; //ȸ�� ���̵�
	private String orderdate ; //�ֹ� ����
	
	//orderItems : ���� ���� ��ǰ ���� ������ �����ϰ� �ִ� �÷���
	//OrderItem�� ��ǰ 1�ǿ� ���� ������ ��� �ִ�.
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
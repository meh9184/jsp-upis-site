package my.shop;

//�ֹ� �߻��� ���� ���� ��ǰ���� �Ǹ��� �� �ִ� ��
//�̶� ���� ��ǰ�鿡 ���� ��ǰ ��ȣ�� �Ǹ� ������ �����ϰ� �ִ� Ŭ�����̴�.

//�� Ŭ������ OrderBean Ŭ������ ��� ������ ���ǰ� �ִ�.
public class OrderItem {
	private int pnum ; //��ǰ ��ȣ
	private int qty ; //�Ǹ� ����

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
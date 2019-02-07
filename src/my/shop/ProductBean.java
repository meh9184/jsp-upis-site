package my.shop;

public class ProductBean {
	private int num ;
	private String name ;
	private String company ;
	private String image ;
	private int stock ;	
	private int price ;
	private String spec ;
	private String contents ;
	private int point ;
	private String inputdate ; //�԰� ����
	private int cnum ; //ī�װ� ��ȣ(Category ���̺�� ���ν� ����)
	
	//ī�װ� �ڵ��� �̸��� : ���� ���忡 ����.
	private String cname ;	//category ���̺� ������

	//���� �������� �ѱݾ׹� ����Ʈ ������ ���õ� �׸���̴�
	//���� ���̺��� �������� �ʴ� �÷��̴�.
	private int totalPrice ; // �� �Ǹ� �ݾ�
	private int salePrice ; // ��ǰ�� �Ǹ� �ݾ�
	private int totalPoint; // �� ���� ����Ʈ

	public void setStock(int stock) {
		this.stock = stock;
		
		//������ ��� ���� �ѱݾװ� ����Ʈ �ݾ��� ��������.
		this.totalPrice = stock * this.price ;
		this.totalPoint = stock * this.point ;	
	}
	
	public int getTotalPoint() {
		return totalPoint;
	}
	public void setTotalPoint(int totalPoint) {
		this.totalPoint = totalPoint;
	}
	
	
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public int getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getStock() {
		return stock;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getInputdate() {
		return inputdate;
	}
	public void setInputdate(String inputdate) {
		this.inputdate = inputdate;
	}
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
}
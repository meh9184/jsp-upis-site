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
	private String inputdate ; //입고 일자
	private int cnum ; //카테고리 번호(Category 테이블과 조인시 사용됨)
	
	//카테고리 코드의 이름명 : 조인 문장에 사용됨.
	private String cname ;	//category 테이블에 존재함

	//다음 변수들은 총금액및 포인트 적립과 관련된 항목들이다
	//실제 테이블에는 존재하지 않는 컬럼이다.
	private int totalPrice ; // 총 판매 금액
	private int salePrice ; // 상품별 판매 금액
	private int totalPoint; // 총 적립 포인트

	public void setStock(int stock) {
		this.stock = stock;
		
		//수량이 들어 오면 총금액과 포인트 금액은 구해진다.
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
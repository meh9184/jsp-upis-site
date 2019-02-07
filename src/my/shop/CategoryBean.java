package my.shop;

public class CategoryBean {
	private int cnum ; //카테고리 번호
	private String code ; //카테고리 코드
	private String cname ; //카테고리 이름
	
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}	
}
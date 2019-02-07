package mypkg;

public class SuperDao {
	//모든 Dao 파일의 수퍼 클래스로써 공통 변수들은 여기서 정의하고 사용하도록 한다.
	public String driver = "oracle.jdbc.driver.OracleDriver" ; 
	public String url = "jdbc:oracle:thin:@localhost:1521:xe" ;
	public String id = "system" ;
	public String password = "ansdmsghks" ;
}
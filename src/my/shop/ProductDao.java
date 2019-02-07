package my.shop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import mypkg.SuperDao;

public class ProductDao extends SuperDao{
	private DataSource ds = null ;
	private Connection conn = null ;
	public ProductDao() {
		try {
			Class.forName( driver ) ;
			conn = DriverManager.getConnection(url, id, password) ;
			if(conn != null){
				//System.out.println("접속 성공");
			}else{
				System.out.println("MemberDao : 접속 실패");
			}
		} catch (ClassNotFoundException e) {
			System.out.println("클래스 발견 안되요");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("SQL 예외");
			e.printStackTrace();
		}
	}
	public int InsertProduct( MultipartRequest mr ){
		//상품 추가하기(업로드를 위하여 MultipartRequest 객체를 매개 변수로 사용했다.)
		PreparedStatement pstmt = null ;
		String sql = "insert into products(num,name,company,image,stock,price,spec,contents,point,inputdate,cnum)" ;
		sql += " values(catprod.nextval, ?, ?, ?, ?, ?, ?, ?, ?, to_date(?, 'yyyy/MM/dd'), ?)" ;
		int cnt = -1 ;
		try {
			conn.setAutoCommit( false ) ;
			pstmt = conn.prepareStatement( sql ) ;
			
			pstmt.setString(1, mr.getParameter("name")) ;
			pstmt.setString(2, mr.getParameter("company")) ;
			
			// 서버에 실제로 업로드된 화일명 반환
			pstmt.setString(3, mr.getFilesystemName("image")) ;
			
			pstmt.setInt(4, Integer.parseInt(mr.getParameter("stock"))) ;
			pstmt.setInt(5, Integer.parseInt(mr.getParameter("price"))) ;
			
			pstmt.setString(6, mr.getParameter("spec")) ;
			pstmt.setString(7, mr.getParameter("contents")) ;
			
			pstmt.setInt(8, Integer.parseInt(mr.getParameter("point"))) ;
			pstmt.setString(9, mr.getParameter("inputdate")) ;
			
			pstmt.setInt(10, Integer.parseInt(mr.getParameter("cnum"))) ;
			
			cnt = pstmt.executeUpdate() ;
			conn.commit() ;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(pstmt != null){pstmt.close() ; } 
				closeConnection() ; 
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}
		
		return cnt ;
	}
	public int UpdateProduct( MultipartRequest mr ){
		//상품 업데이트(업로드를 위하여 MultipartRequest 객체를 매개 변수로 사용했다.)
		PreparedStatement pstmt = null ;
		String sql = "update products set name=?,company=?,image=?,stock=?,price=?,spec=?,contents=?," ;
		sql += " point=?,inputdate=to_date(?,'yyyy/MM/dd'),cnum=?" ;
		sql += " where num=? " ; 

		int cnt = -1 ;
		try {
			conn.setAutoCommit( false ) ;
			pstmt = conn.prepareStatement( sql ) ;
			
			pstmt.setString(1, mr.getParameter("name")) ;
			pstmt.setString(2, mr.getParameter("company")) ;
			
			// 서버에 실제로 업로드된 화일명 반환
			pstmt.setString(3, mr.getFilesystemName("image")) ;
			
			pstmt.setInt(4, Integer.parseInt(mr.getParameter("stock"))) ;
			pstmt.setInt(5, Integer.parseInt(mr.getParameter("price"))) ;
			
			pstmt.setString(6, mr.getParameter("spec")) ;
			pstmt.setString(7, mr.getParameter("contents")) ;
			
			pstmt.setInt(8, Integer.parseInt(mr.getParameter("point"))) ;
			pstmt.setString(9, mr.getParameter("inputdate")) ;
			
			pstmt.setInt(10, Integer.parseInt(mr.getParameter("cnum"))) ;
			pstmt.setInt(11, Integer.parseInt(mr.getParameter("num"))) ;
			
			cnt = pstmt.executeUpdate() ;
			conn.commit() ;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(pstmt != null){pstmt.close() ; } 
				closeConnection() ; 
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}
		
		return cnt ;
	}
	private void closeConnection() {
		try {
			if( conn != null ){conn.close() ; }
		} catch (SQLException e) {			
			e.printStackTrace();
		}
	}	
	
	/* 스펙 별로 상품 목록 가져오기 */
	public ArrayList<ProductBean> getProductBySpec( String spec ){
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		String sql = "select * from products where spec = ? "  ;		
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>() ;		
		try {
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setString( 1, spec ) ;
			rs = pstmt.executeQuery() ;
			
			while( rs.next() ){
				ProductBean product = MakeBean( rs ) ;
				lists.add(product) ;
			}			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			try {
				if(rs != null){ rs.close() ; }
				if(pstmt != null){ pstmt.close() ; }
				closeConnection() ;
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}		
		return lists ;
	}	
	private ProductBean MakeBean(ResultSet rs) {
		//넘어 오는 rs 객체를 이용하여 ProductBean를 만들어서 리턴한다.
		//여러 군데서 사용되므로 별도의 메소드로 만들었다.
		ProductBean product = new ProductBean() ;
		try {
			product.setCnum( rs.getInt("cnum") );
			product.setCompany( rs.getString("company") );
			product.setContents( rs.getString("contents") ) ;
			product.setImage( rs.getString("image") ) ;
			product.setInputdate( String.valueOf(rs.getDate("inputdate")) ) ;
			product.setName( rs.getString("name") ) ;
			product.setNum( rs.getInt("num") ) ;
			product.setPoint( rs.getInt("point") ) ;
			product.setPrice( rs.getInt("price") ) ;
			product.setSpec( rs.getString("spec") ) ;
			product.setStock( rs.getInt("stock") ) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return product;
	}
	//상품 삭제하기
	public int DeleteProduct( int pnum ){
		PreparedStatement pstmt  = null ;
		ResultSet rs = null ; 
		String sql = "delete from products where num = ?   " ;
		int cnt = -1 ; 
		try {
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setInt(1, pnum) ;			
			cnt = pstmt.executeUpdate() ;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if( rs != null ){rs.close() ; }
				if( pstmt != null ){pstmt.close() ; }
				closeConnection();
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}		
		return cnt  ;
	}	
	public ProductBean getProductByNum(int pnum){
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		//category(카테고리)와 products(상품) 테이블을 조인하여 카테고리 이름까지 조회한다.
		String sql = " select c.cname, p.num, p.name, p.company, p.image, "; 
		sql += " p.stock, p.price, p.spec, p.contents, p.point, p.inputdate, p.cnum "; 
		sql += " from category c inner join products p "; 
		sql += " on c.cnum=p.cnum where p.num = ? ";

		ProductBean product = null ;
		try {
			pstmt = conn.prepareStatement(sql) ;	
			pstmt.setInt(1, pnum) ;
			rs = pstmt.executeQuery() ;			
			if(rs.next()){
				product = MakeBean(rs) ;
				//cname은 별도로 처리해줘야 한다.
				product.setCname(rs.getString("cname")) ;
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(rs != null){ rs.close() ; }
				if(pstmt != null){ pstmt.close() ; }
				closeConnection() ;
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}		
		//상품 번호로 상품 정보 구하기
		return product ;
	}	
	public ArrayList<ProductBean> getAllProduct(){
		//모든 상품 조회하기
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		//카테고리 이름은 category 테이블에 존재하므로 어쩔수 없이 Join 구문을 사용해야 한다.
		String sql = " select c.cnum, c.cname, p.num, p.name, p.company, p.image, p.stock, p.price, p.spec, p.contents, p.point, p.inputdate" ; 
		sql += " from category c inner join products p";
		sql += " on c.cnum=p.cnum" ;
		//카테고리 이름순으로 오름차 정렬후에 상품 이름으로 내림차 정렬하기
		sql += " order by c.cname asc, p.name desc  " ; 

		ArrayList<ProductBean> lists = new ArrayList<ProductBean>() ;		
		try {
			pstmt = conn.prepareStatement(sql) ; 
			rs = pstmt.executeQuery() ;
			
			while( rs.next() ){
				ProductBean product = MakeBean( rs ) ;
				//cname은 별도로 챙겨 주자
				product.setCname(rs.getString("cname")) ;				
				lists.add(product) ;
			}			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			try {
				if(rs != null){ rs.close() ; }
				if(pstmt != null){ pstmt.close() ; }
				closeConnection() ;
			} catch (Exception e2) {
				e2.printStackTrace() ;
			}
		}		
		return lists ;
	}
	/* 카테고리별로 상품 목록 가져 오기 */
	// category 파라미터가 all이면 전체 상품을 조회한다.
	public String SelectByCategory( HttpServletRequest request ) throws SQLException{
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;

		Vector<ProductBean> lists = null ;
		
		String category = (String)request.getAttribute("category") ;
		if(category == null){ category = "all" ;  }
		
		//2개의 테이블을 서브 쿼리를 이용하여 데이터를 조회하고 있다.
		String sql = "select * from products " ;
		
		//all 이 아닌 경우 where 절을 사용하여 필터링
		if( !category.trim().equalsIgnoreCase("all")){ //사용자가 특정 카테고리를 클릭한 경우 
			sql += "where cnum in (select cnum from category  where code like ? ) ";			
		}
		
		pstmt=conn.prepareStatement(sql);
		
		if( !category.trim().equalsIgnoreCase("all")){ 
			pstmt.setString(1, category + "%");	
		}
		rs = pstmt.executeQuery();
		lists = this.makeVector(rs);		
		String result = getCategoryString(lists, request) ;
		
		rs.close() ;
		pstmt.close() ;
		
		return result;
		//return lists;		
	}
	public Vector<ProductBean> makeVector(ResultSet rs) throws SQLException{
		Vector<ProductBean> vector = new Vector<ProductBean>();
		while(rs.next()){
			ProductBean product = new ProductBean();
			//product.setCategory( rs.getString("category") ) ;
			//product.setCname( rs.getString("cname") ) ;
			product.setCnum( Integer.parseInt(rs.getString("cnum") )) ;
			product.setCompany( rs.getString("company") ) ;
			product.setContents( rs.getString("contents") ) ;
			product.setImage( rs.getString("image") ) ;
			product.setInputdate( String.valueOf( rs.getDate("inputdate") ));
			product.setName( rs.getString("name") );
			product.setNum( Integer.parseInt(rs.getString("num") ));
			product.setPoint( Integer.parseInt(rs.getString("point") ));
			product.setPrice( Integer.parseInt(rs.getString("price") ));
			//product.setSalePrice( Integer.parseInt(rs.getString("salePrice") )) ;
			product.setSpec( rs.getString("spec") ) ;
			product.setStock( Integer.parseInt(rs.getString("stock") ));
			//product.setTotalPoint( Integer.parseInt(rs.getString("totalPoint") )) ;
			//product.setTotalPrice( Integer.parseInt(rs.getString("totalPrice") )) ;
			
 			vector.add( product );
		}//while---------
		return vector ;	
	} 
	private String getCategoryString(Vector<ProductBean> lists, HttpServletRequest request) {
		//컬렉션을 이용하여 쇼핑몰의 상품 목록을 테이블 태그 형식으로 만들어 준다.
		int colsu = (Integer)request.getAttribute("colsu") ;
		String viewPage =  (String)request.getAttribute("viewPage") ;
		
		String stable = "" ;
		int cnt = 0 ;
		stable = "<center>" ;
		stable += "<table border=0 width=450><tr>" ;
		for(ProductBean list : lists ){			
			stable += "<td>" ;
			/*이미지, 이름 가격, 포인트 */
			//if( request == null){ System.out.println("리퀘스트 널");}
			//if( list == null){ System.out.println("list 널");}
			String imgpath = null ;
			if( list.getImage() == null){ 
				imgpath = ""; 
			}else{
				//ServletContext application = request.getServletContext() ;
				imgpath = request.getRealPath( "/images/" + list.getImage().trim() ) ;
				//imgpath = application.getRealPath( "/images/" + list.getImage().trim() ) ;	
			}					
			
			//System.out.println( "imgpath : " + imgpath );
			
			String pattern = "###,###원" ;
			DecimalFormat df1 = new DecimalFormat(pattern) ;
			
			pattern = "[###,###] point" ;
			DecimalFormat df2 = new DecimalFormat(pattern) ;
			
			String imsi = 
					"<center>" +
					"<a href=" + viewPage + "?num=" + list.getNum() + ">" +
					"<img src='" + imgpath + "' width=100 height=100 border=0></a><br>" + 
					list.getName() + "<br>" + 
					"<font color=red>" + df1.format( list.getPrice() ) + "</font><br>" + 
					"<font color=blue>" + df2.format( list.getPoint() ) + "</font>" + 
					"</center>" ;
			
			stable += imsi ;
			stable += "</td>" ;
			
			++cnt ;
			if(cnt % colsu == 0){ //colsu 마다 1행(tr 태그)씩 추가 되어야 한다.
				stable += "</tr><tr>" ;
			}
		}
		stable += "<tr></table>" ;
		stable += "</center>" ;
		
		return stable;		
	}
	public ProductBean SelectByNum(int num) throws SQLException{
		//해당 상품 번호를 이용하여 상품의 모든 정보를 Bean 객체로 리턴한다.
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		
		String sql = " select c.cname, p.num, p.name, p.company, p.company, p.image, " ;
		sql += "p.stock, p.price, p.spec, p.contents, p.point, p.inputdate, p.cnum " ;   
		sql +=" from category c inner join products p " ;
		sql += " on c.cnum=p.cnum where num=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs=pstmt.executeQuery();
		
		ArrayList<ProductBean> arr	= this.makeArrayList(rs);
		ProductBean product =null;
		
		if(arr != null && arr.size() != 0){
			product=arr.get(0);
		}
		rs.close() ;
		pstmt.close() ;		
		return product ;
	}
	public ArrayList<ProductBean> makeArrayList(ResultSet rs) throws SQLException{
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		while(rs.next()){
			ProductBean product = new ProductBean() ;
			
			//product.setCategory( rs.getString("category") ) ;
			product.setCname( rs.getString("cname") ) ;
			product.setCnum( rs.getInt("cnum"));
			product.setCompany( rs.getString("company")) ;
			product.setContents( rs.getString("contents")) ;
			product.setImage( rs.getString("image")) ;
			
			product.setInputdate( String.valueOf(rs.getDate("inputdate"))) ;
			
			product.setName( rs.getString("name"));
			product.setNum( rs.getInt("num")) ;
			product.setPoint( rs.getInt("point")) ;
			product.setPrice( rs.getInt("price")) ;
			
			product.setSalePrice( 0 ) ; // rs.getInt("salePrice")) ;
			product.setSpec( rs.getString("spec")) ;
			product.setStock( rs.getInt("stock")) ;
			
			product.setTotalPoint( 0 ) ; // rs.getInt("totalPoint")) ;
			
			lists.add(product);
			
		}//while---------
		return lists ;		
	} 	
}
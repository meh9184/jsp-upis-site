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
				//System.out.println("���� ����");
			}else{
				System.out.println("MemberDao : ���� ����");
			}
		} catch (ClassNotFoundException e) {
			System.out.println("Ŭ���� �߰� �ȵǿ�");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("SQL ����");
			e.printStackTrace();
		}
	}
	public int InsertProduct( MultipartRequest mr ){
		//��ǰ �߰��ϱ�(���ε带 ���Ͽ� MultipartRequest ��ü�� �Ű� ������ ����ߴ�.)
		PreparedStatement pstmt = null ;
		String sql = "insert into products(num,name,company,image,stock,price,spec,contents,point,inputdate,cnum)" ;
		sql += " values(catprod.nextval, ?, ?, ?, ?, ?, ?, ?, ?, to_date(?, 'yyyy/MM/dd'), ?)" ;
		int cnt = -1 ;
		try {
			conn.setAutoCommit( false ) ;
			pstmt = conn.prepareStatement( sql ) ;
			
			pstmt.setString(1, mr.getParameter("name")) ;
			pstmt.setString(2, mr.getParameter("company")) ;
			
			// ������ ������ ���ε�� ȭ�ϸ� ��ȯ
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
		//��ǰ ������Ʈ(���ε带 ���Ͽ� MultipartRequest ��ü�� �Ű� ������ ����ߴ�.)
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
			
			// ������ ������ ���ε�� ȭ�ϸ� ��ȯ
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
	
	/* ���� ���� ��ǰ ��� �������� */
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
		//�Ѿ� ���� rs ��ü�� �̿��Ͽ� ProductBean�� ���� �����Ѵ�.
		//���� ������ ���ǹǷ� ������ �޼ҵ�� �������.
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
	//��ǰ �����ϱ�
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
		//category(ī�װ�)�� products(��ǰ) ���̺��� �����Ͽ� ī�װ� �̸����� ��ȸ�Ѵ�.
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
				//cname�� ������ ó������� �Ѵ�.
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
		//��ǰ ��ȣ�� ��ǰ ���� ���ϱ�
		return product ;
	}	
	public ArrayList<ProductBean> getAllProduct(){
		//��� ��ǰ ��ȸ�ϱ�
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		//ī�װ� �̸��� category ���̺� �����ϹǷ� ��¿�� ���� Join ������ ����ؾ� �Ѵ�.
		String sql = " select c.cnum, c.cname, p.num, p.name, p.company, p.image, p.stock, p.price, p.spec, p.contents, p.point, p.inputdate" ; 
		sql += " from category c inner join products p";
		sql += " on c.cnum=p.cnum" ;
		//ī�װ� �̸������� ������ �����Ŀ� ��ǰ �̸����� ������ �����ϱ�
		sql += " order by c.cname asc, p.name desc  " ; 

		ArrayList<ProductBean> lists = new ArrayList<ProductBean>() ;		
		try {
			pstmt = conn.prepareStatement(sql) ; 
			rs = pstmt.executeQuery() ;
			
			while( rs.next() ){
				ProductBean product = MakeBean( rs ) ;
				//cname�� ������ ì�� ����
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
	/* ī�װ����� ��ǰ ��� ���� ���� */
	// category �Ķ���Ͱ� all�̸� ��ü ��ǰ�� ��ȸ�Ѵ�.
	public String SelectByCategory( HttpServletRequest request ) throws SQLException{
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;

		Vector<ProductBean> lists = null ;
		
		String category = (String)request.getAttribute("category") ;
		if(category == null){ category = "all" ;  }
		
		//2���� ���̺��� ���� ������ �̿��Ͽ� �����͸� ��ȸ�ϰ� �ִ�.
		String sql = "select * from products " ;
		
		//all �� �ƴ� ��� where ���� ����Ͽ� ���͸�
		if( !category.trim().equalsIgnoreCase("all")){ //����ڰ� Ư�� ī�װ��� Ŭ���� ��� 
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
		//�÷����� �̿��Ͽ� ���θ��� ��ǰ ����� ���̺� �±� �������� ����� �ش�.
		int colsu = (Integer)request.getAttribute("colsu") ;
		String viewPage =  (String)request.getAttribute("viewPage") ;
		
		String stable = "" ;
		int cnt = 0 ;
		stable = "<center>" ;
		stable += "<table border=0 width=450><tr>" ;
		for(ProductBean list : lists ){			
			stable += "<td>" ;
			/*�̹���, �̸� ����, ����Ʈ */
			//if( request == null){ System.out.println("������Ʈ ��");}
			//if( list == null){ System.out.println("list ��");}
			String imgpath = null ;
			if( list.getImage() == null){ 
				imgpath = ""; 
			}else{
				//ServletContext application = request.getServletContext() ;
				imgpath = request.getRealPath( "/images/" + list.getImage().trim() ) ;
				//imgpath = application.getRealPath( "/images/" + list.getImage().trim() ) ;	
			}					
			
			//System.out.println( "imgpath : " + imgpath );
			
			String pattern = "###,###��" ;
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
			if(cnt % colsu == 0){ //colsu ���� 1��(tr �±�)�� �߰� �Ǿ�� �Ѵ�.
				stable += "</tr><tr>" ;
			}
		}
		stable += "<tr></table>" ;
		stable += "</center>" ;
		
		return stable;		
	}
	public ProductBean SelectByNum(int num) throws SQLException{
		//�ش� ��ǰ ��ȣ�� �̿��Ͽ� ��ǰ�� ��� ������ Bean ��ü�� �����Ѵ�.
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
package my.shop;

import java.sql.SQLException;
import java.util.Vector;

//카트 클래스 : 주문자가 상품을 장바구니에 담으면 이를 컬렉션으로 저장하기 위한 클래스
public class MyCartList {
	//key는 상품 번호, value는 판매된 수량
	private Vector<ProductBean> carts = null ;
	
	public MyCartList() { //생성자에서 카트 컬렉션 준비
		carts = new Vector<ProductBean>() ;
	}
	
	public void RemoveAllProduct(){
		//카트의 모든 내용 비우기 : mallCalculate.jsp에서 사용 되고 있다.
		//로그아웃 하지 않고, 카트를 비울 때 사용하면 된다
		carts.removeAllElements() ; 
	}
	
	public Vector<ProductBean> getAllProducts(){
		//모든 카트 리스트를 리턴한다.
		//결재를 할 때 어떠어떠한 물건을 구매했는 지 보여 줘야 한다. 
		return carts ;
	}
	
	/* 장바구니에서 상품 내용을 수정한다. */
	public void EditProduct(int num, int stock){
		for(ProductBean cart : carts){			
			if(num == cart.getNum()){	//해당 상품 번호에 대하여		
				cart.setStock(stock) ; //상품의 재고 수량을 수정한다.
				break; //해당 상품에 대하여 이미 처리되었으므로 루틴 강제 종료
			}
		}//for------
	}
	
	/* 장바구니에서 상품 삭제 */
	public void DeleteProduct(int num){
		for(ProductBean cart : carts){			
			if(num == cart.getNum()){			
				carts.removeElement(cart) ;
				break; //삭제되면 루틴을 강제로 종료
			}
		}//for------
	}//DeleteProduct()-----------------
	
	public void AddProduct(int num, int stock){
		//해당 상품 번호에 대한 수량을 추가한다.
		
		//isExists 변수 : 들어온 상품이 이미 장바구니에 존재한다면 true가 됨
		boolean isExists = false ; //[디폴트는 존재하지 않는다]라고 가정 
		
		for(ProductBean cart : carts){
			if( cart.getNum() == num){ 
				//이전에 장바구니에 담았던 적이 있는 경우
				//이전 수량 + 신규 수량을 누적해야 한다. 
				cart.setStock(cart.getStock() + stock ) ;
				isExists = true ; //true의 의미 : 이미 존재하는 상품입니다.
				break ;
			}
		}
		if(!isExists){ //새로운 상품이 장바구니에 들어 오는 경우
			ProductDao pdao =new ProductDao();
			ProductBean newCart = null ;			
			try {
				//newCart는 새로 구매한 상품 정보
				newCart = pdao.SelectByNum(num);
				newCart.setStock(stock);	
				
				carts.add(newCart) ; //나의 카트에 담는다.
			} catch (SQLException e) {				
				e.printStackTrace();
			}
		}
	}
}
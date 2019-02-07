package my.shop;

import java.sql.SQLException;
import java.util.Vector;

//īƮ Ŭ���� : �ֹ��ڰ� ��ǰ�� ��ٱ��Ͽ� ������ �̸� �÷������� �����ϱ� ���� Ŭ����
public class MyCartList {
	//key�� ��ǰ ��ȣ, value�� �Ǹŵ� ����
	private Vector<ProductBean> carts = null ;
	
	public MyCartList() { //�����ڿ��� īƮ �÷��� �غ�
		carts = new Vector<ProductBean>() ;
	}
	
	public void RemoveAllProduct(){
		//īƮ�� ��� ���� ���� : mallCalculate.jsp���� ��� �ǰ� �ִ�.
		//�α׾ƿ� ���� �ʰ�, īƮ�� ��� �� ����ϸ� �ȴ�
		carts.removeAllElements() ; 
	}
	
	public Vector<ProductBean> getAllProducts(){
		//��� īƮ ����Ʈ�� �����Ѵ�.
		//���縦 �� �� ���� ������ �����ߴ� �� ���� ��� �Ѵ�. 
		return carts ;
	}
	
	/* ��ٱ��Ͽ��� ��ǰ ������ �����Ѵ�. */
	public void EditProduct(int num, int stock){
		for(ProductBean cart : carts){			
			if(num == cart.getNum()){	//�ش� ��ǰ ��ȣ�� ���Ͽ�		
				cart.setStock(stock) ; //��ǰ�� ��� ������ �����Ѵ�.
				break; //�ش� ��ǰ�� ���Ͽ� �̹� ó���Ǿ����Ƿ� ��ƾ ���� ����
			}
		}//for------
	}
	
	/* ��ٱ��Ͽ��� ��ǰ ���� */
	public void DeleteProduct(int num){
		for(ProductBean cart : carts){			
			if(num == cart.getNum()){			
				carts.removeElement(cart) ;
				break; //�����Ǹ� ��ƾ�� ������ ����
			}
		}//for------
	}//DeleteProduct()-----------------
	
	public void AddProduct(int num, int stock){
		//�ش� ��ǰ ��ȣ�� ���� ������ �߰��Ѵ�.
		
		//isExists ���� : ���� ��ǰ�� �̹� ��ٱ��Ͽ� �����Ѵٸ� true�� ��
		boolean isExists = false ; //[����Ʈ�� �������� �ʴ´�]��� ���� 
		
		for(ProductBean cart : carts){
			if( cart.getNum() == num){ 
				//������ ��ٱ��Ͽ� ��Ҵ� ���� �ִ� ���
				//���� ���� + �ű� ������ �����ؾ� �Ѵ�. 
				cart.setStock(cart.getStock() + stock ) ;
				isExists = true ; //true�� �ǹ� : �̹� �����ϴ� ��ǰ�Դϴ�.
				break ;
			}
		}
		if(!isExists){ //���ο� ��ǰ�� ��ٱ��Ͽ� ��� ���� ���
			ProductDao pdao =new ProductDao();
			ProductBean newCart = null ;			
			try {
				//newCart�� ���� ������ ��ǰ ����
				newCart = pdao.SelectByNum(num);
				newCart.setStock(stock);	
				
				carts.add(newCart) ; //���� īƮ�� ��´�.
			} catch (SQLException e) {				
				e.printStackTrace();
			}
		}
	}
}
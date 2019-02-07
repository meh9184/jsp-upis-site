package mypkg.board;

import java.text.DecimalFormat;

public class Paging {
	//����¡ ���� ����
	private int totalCount = 0 ; //�� ���ڵ� �Ǽ�
	private int totalPage = 0 ; //��ü ������ ��
	
	private int pageNumber = 0 ; //������ ������ �ѹ�(ǥ�� ������ �������� 1���� totalPage�����̴�.)
	private int pageSize = 0 ; //�� �������� ������ �Ǽ�
	private int beginRow = 0 ; //���� �������� ���� ��
	private int endRow = 0 ; //���� �������� �� ��
	
	private int pageCount = 10 ; //������ ������ ��ũ ��
	private int beginPage = 0 ; //����¡ ó�� ���� ������ ��ȣ
	private int endPage = 0 ; //����¡ ó�� �� ������ ��ȣ
	
	private String url = "" ; 
	private String pagingHtml = "";//�ϴ��� ���� ������ ��ũ
	private String pagingStatus = ""; //��� ������ ���� ������ ��ġ ǥ��
	
	//�˻��� ���� ���� �߰�
	private String mode = "" ; //�˻� ���(�ۼ���, ������, ��ü �˻��� all) ���
	private String keyword = "" ; //�˻��� �ܾ�  

	public Paging(String _pageNumber, String _pageSize, int totalCount, String url, String mode, String keyword) {
		if( _pageNumber == null || _pageNumber.equals("null")){
			_pageNumber = "1" ;
		}
		this.pageNumber = Integer.parseInt( _pageNumber ) ;
		
		if( _pageSize == null || _pageSize.equals("null") ) {
			_pageSize = "10" ;
		}
		this.pageSize = Integer.parseInt( _pageSize ) ;
		
		this.totalCount = totalCount ;
		this.url = url ; 
		
		this.totalPage =  (int)Math.ceil((double)totalCount/pageSize) ;
		this.beginRow = ( pageNumber - 1 ) * pageSize + 1 ;
		this.endRow = pageNumber * pageSize  ; 
		
		this.beginPage = ( pageNumber - 1 ) / pageCount * pageCount  + 1  ; 
		this.endPage = this.beginPage + this.pageCount - 1 ;   
		
		if( endPage > totalPage ){ endPage = totalPage ; }
		
		if(mode == null || mode.equals("null") || mode.equals("") || mode.equals("0")){
			mode = "all" ; //all�̸� ��ü �˻��� �ǹ��Ѵ�.
		}
		this.mode = mode ;
		
		if(keyword == null || keyword.equals("null")){
			keyword = "" ; 
		}
		this.keyword = keyword ;		
		
		this.pagingHtml = getPagingHtml( this.url ) ;
		
		//this.pagingStatus = "[" + this.beginPage + "-" + this.endPage + "] " + this.pageNumber + "/" + this.totalPage ;  // [1-10] 1/100
		this.pagingStatus = "�� " + new DecimalFormat("###,###").format(this.totalCount) + "��[" + this.pageNumber + "/" + this.totalPage + "]" ;	

		//DisplayInformation() ;
	}

	private String getPagingHtml( String url ){ //����¡ ���ڿ��� �����.
		String result = "" ;
		
		//add_param ���� : �˻� �����Ͽ� �߰��Ǵ� �Ķ���� ����Ʈ
		String add_param = "&mode=" + mode + "&keyword=" + keyword ; 
		
		if ( pageNumber <= pageCount ) {//1���� 10������������ [��ó��]�� [����]�� ���� 
			result += "��ó��&nbsp;&nbsp;";
			result += "����&nbsp;&nbsp;";			
		} else {
			result += "<a href='" + url + "?pageNumber=" + 1 + 
				"&pageSize=" + pageSize + add_param + "'>��ó��</a>&nbsp;&nbsp;";
			
			result += "<a href='" + url + "?pageNumber=" + (beginPage - 1) + 
				"&pageSize=" + pageSize + add_param + "'>����</a>&nbsp;&nbsp;";
		}		
		//������ ���� ��ȣ ���� ~ �� ��ȣ ���� ǥ��
		for (int i = beginPage ; i <= endPage ; i++) {
			if(i == pageNumber){ //���� �������̸� ��ũ�� ����, ���������� ǥ��
				result += "<font color='red'><b>" + i + "</b></font>&nbsp;";
			}else{
				result += "<a href='" + url + "?pageNumber=" + i + 
					"&pageSize=" + pageSize + add_param + "'>" + i + "</a>&nbsp;";	
			}			
		}		
		//���������� [����]�� [�ǳ�]�� ����
		if ( pageNumber >= (totalPage / pageCount * pageCount + 1) ) {
			result += "����&nbsp;&nbsp;";
			result += "�� ��&nbsp;&nbsp;";	
		} else {			
			result += "<a href='" + url + "?pageNumber=" + (endPage + 1) + 
				"&pageSize=" + pageSize + add_param + "'>����</a>&nbsp;&nbsp;";
			
			result += "<a href='" + url + "?pageNumber=" + totalPage + 
				"&pageSize=" + pageSize + add_param + "'>�� ��</a>";
		}
		return result ;
	}	

	private void DisplayInformation() {
		System.out.println("�� ���ڵ� �Ǽ� : " + totalCount + "\n");
		System.out.println("��ü ������ �� : " + totalPage + "\n");
		System.out.println("������ ������ �ѹ� : " + pageNumber + "\n");
		System.out.println("�� �������� ������ �Ǽ� : " + pageSize + "\n");
		System.out.println("���� �������� ���� �� : " + beginRow + "\n");
		System.out.println("���� �������� �� �� : " + endRow + "\n");
		System.out.println("������ ������ ��ũ �� : " + pageCount + "\n");
		System.out.println("����¡ ó�� ���� ������ ��ȣ : " + beginPage + "\n");
		System.out.println("����¡ ó�� �� ������ ��ȣ : " + endPage + "\n");
		System.out.println("��û URL : " + url + "\n");
		//System.out.println("�ϴ��� ���� ������ ��ũ : " + pagingHtml + "\n");
		System.out.println("��� ������ ���� ������ ��ġ ǥ�� : " + pagingStatus + "\n");	
		System.out.println("�˻� ��� : " + mode + "\n");
		System.out.println("�˻� Ű���� : " + keyword + "\n");
	}
	
	public String getPagingHtml() {	return pagingHtml;}
	public int getPageNumber() {	return pageNumber;}
	public int getPageSize() {	return pageSize;}	
	public String getPagingStatus() {	return pagingStatus;}	
	public int getBeginRow() {	return beginRow;}
	public int getEndRow() {	return endRow;}
	
	//�� �˻��� ���Ͽ� �˻� ���� �˻� Ű���� �׸��� �߰���
	public String getMode() {return mode;}
	public String getKeyword() { return keyword; 	}	 
}
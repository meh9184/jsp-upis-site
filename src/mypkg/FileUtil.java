package mypkg;

import java.io.File;

public class FileUtil {
	//���� ���� ���� ��ƿ��Ƽ Ŭ����
	public static boolean DeleteFile( String delFileFullName ){
		//�Ѱ��� (��ü ��� ���Ե�) ���� �̸��� �����Ѵ�.
		//System.out.println(" ������ ���� �� : ");
		//System.out.println( delFileFullName );
		
		File delfile = new File( delFileFullName ) ;
		boolean bool = false  ;
		
		if( delfile.exists() ){
			//������ �Ǹ� true�� �����Ѵ�.
			bool =  delfile.delete() ;
			//System.out.println("���� �Ǹ� ��ȯ �� ? " + bool ); 
		}
		return bool ; 
	}
}
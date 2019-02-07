package mypkg;

import java.io.File;

public class FileUtil {
	//파일 조작 관련 유틸리티 클래스
	public static boolean DeleteFile( String delFileFullName ){
		//넘겨진 (전체 경로 포함된) 파일 이름을 삭제한다.
		//System.out.println(" 삭제될 파일 명 : ");
		//System.out.println( delFileFullName );
		
		File delfile = new File( delFileFullName ) ;
		boolean bool = false  ;
		
		if( delfile.exists() ){
			//삭제가 되면 true를 리턴한다.
			bool =  delfile.delete() ;
			//System.out.println("삭제 되면 반환 값 ? " + bool ); 
		}
		return bool ; 
	}
}
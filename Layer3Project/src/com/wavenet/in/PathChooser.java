package com.wavenet.in;
import java.io.File;
import java.util.ArrayList;
public class PathChooser {
	public static String Path="";
	public static int getFolderPath(String folderPath,String sessionId)
    {
try{
	
  File file=new File(folderPath);
  File fileList[]=file.listFiles();
  int counter=0,dir=0;
  for( File f:fileList)
      {
	  if(f.isDirectory())
	  { dir++;
	 	  if((f.getName()).equalsIgnoreCase(sessionId))
		        {
	 		  folderPath=f.getPath();
	 		 getInsideTheFolder(folderPath);
			  break;
		  }
	 	 else
		    {
			  counter++;
		  }
	  }  
  }
  if(counter==dir)
     {
	  return 1;
    }
}
catch(Exception e){
e.printStackTrace();
}
return 0;
  }
	public static void getInsideTheFolder(String pathlocal)
	{
	 try{
		 File f=new File(pathlocal);
		 File files[]=f.listFiles();
		  for(File ff:files)
		  {
			  if(ff.isDirectory())
			  {
		Path=(ff.getAbsolutePath().replace('\\', '/'))+"/L3Messages/";
				   break;
			  }
		  }
	 }	
	 catch(Exception e){
		 e.printStackTrace();
	   }
	}
	public static  ArrayList<String> getSession(String path)
	{
		ArrayList<String>Sessionid=new ArrayList<String>();
		File file=new File(path);
		File []files=file.listFiles();
		for(File ff:files)
		{
			if(ff.isDirectory())
			{
				Sessionid.add(ff.getName());
			}
		}
		return Sessionid;
	}
	public static ArrayList<String> getDviceList(String SesssionId)
	{ ArrayList<String> deviceID=new ArrayList<String>();
	 File file=new File(SesssionId);
	 File files[]=file.listFiles();
	 for(File ff:files)
		{
		 String name[]=ff.getName().split("_");
		 deviceID.add(name[0]);
		}
		return deviceID;
	}
}

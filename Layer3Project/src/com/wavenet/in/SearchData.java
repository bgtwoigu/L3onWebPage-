package com.wavenet.in;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.zip.GZIPInputStream;
import java.util.List;
public class SearchData {
public	List<String> lines = new ArrayList<String>();
public 	List<String> searchString = new ArrayList<String>();
public	List<String> FinalList = new ArrayList<String>();
public List<String> HightLightDataList = new ArrayList<String>();
	public static final int showIndex = 150;
	public DeviceID deviceIdObject;
	public SearchData(DeviceID deviceIdObject)
	{
		this.deviceIdObject=deviceIdObject;
	}
	public void decompressGzipFile(String gzipFile, String newFile) {
		try {
			File fileremove = new File(newFile);
			if (fileremove.exists()) {
				fileremove.deleteOnExit();
			}
			FileInputStream fis = new FileInputStream(gzipFile);
			GZIPInputStream gis = new GZIPInputStream(fis);
			FileOutputStream fos = new FileOutputStream(newFile);
			byte[] buffer = new byte[1024 * 1024];
			int len;
			while ((len = gis.read(buffer)) != -1) {
				fos.write(buffer, 0, len);
				fos.flush();
			}
			fos.close();
			gis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int getData(String inputString,List<String> dataList ) {
		Iterator<String> itr = dataList.iterator();
		long convertString = Long.parseLong(inputString.trim());
		int index = 0;
		boolean searchFlag=false;
		try {
			while (itr.hasNext()) {
				String string = itr.next().toString().trim();
				if (index > 0) {
					long number = Long.parseLong(string);
					
					if (convertString <= number) {
						searchFlag=true;
						break;
					}
				}
				index++;
			}
		} catch (Exception io) {
			io.printStackTrace();
		}
		if(searchFlag)
		{
			return index;	
		}
		else
		{
			return -1;
		}	
	}

	public void writeFile(InputStream input) {
		String buffer[];
		if (input != null) {
			String splitby = ",";
			InputStreamReader inspr = new InputStreamReader(input);
			BufferedReader bfr = new BufferedReader(inspr);
			String text = "";
			try {
				while ((text = bfr.readLine()) != null) {
					buffer = text.split(splitby);
					if (buffer.length > 1) {
						lines.add(text);
						searchString.add(buffer[1]);
					}
				}
				bfr.close();
			} catch (IOException e) {
			}
		}
	}
	public void writeFile2(InputStream input) {
		if (input != null) {
			InputStreamReader inspr = new InputStreamReader(input);
			BufferedReader bfr = new BufferedReader(inspr);
			String text = "";
			int k=0;
			try {
				while ((text = bfr.readLine()) != null) {
					
					if (k > 1) {
						lines.add(text);
					}
					k++;
				}
				bfr.close();
			} catch (IOException e) {
			}
		}

	}
	public List<String> SingleDeviceDataOnTable(int index) {
		FinalList.clear();
			if (index - showIndex <= 0) {
				if (lines.size() > 2 * showIndex) {
					for (int i = 0; i < 2 * showIndex; i++) {
						FinalList.add(lines.get(i).toString());
					}
				} else {
					for (int i = 0; i < lines.size(); i++) {
						FinalList.add(lines.get(i).toString());
					}
				}
			} else {
				int uperDiff = index - showIndex;
				int limit = uperDiff+2 *showIndex;
				if (limit < lines.size()) {
					for (int i = uperDiff; i < limit; i++) {
						FinalList.add(lines.get(i).toString());
					}
				} else {
					for (int i = lines.size()-2*showIndex; i < lines.size(); i++) {
						FinalList.add(lines.get(i).toString());
					}
				}

			}
			for(int i=0;i<FinalList.size();i++)
			{
			String	buffer[] = FinalList.get(i).toString().split(",");
				if (buffer.length > 1) {
				
					HightLightDataList.add(buffer[1]);
				}
			}
		/********************************More Than one Device************************************/
		return FinalList;
	}
	public List<String> multipleDeviceData(int index,int deviceIdNo,InputStream input2[],String path,String fileName[])
	{ 
		FinalList.clear();
		/*****Case 1: if File has Sufficent Data To display ***************************/
		 try{
			 List<String>uperList=new ArrayList<String>();
				List<String>lowerList=new ArrayList<String>();
				
		if(deviceIdNo==0)
		  {
		
			 if(index-showIndex<=0&&lines.size()>2*showIndex)
			  {
				 for (int i = 0; i < 2*showIndex; i++) {
						FinalList.add(lines.get(i).toString());
					} 
					
			 }
			 else if(index-showIndex<=0&&lines.size()<2*showIndex)
			 {
				 for (int i = 0; i < lines.size(); i++) {
					
						FinalList.add(lines.get(i).toString());
						 
					}  
				 if(FinalList.size()<2*showIndex)
				  { 
					  for(int k=1;k<deviceIdObject.sameDeviceID;k++) 
					  {  
					       if(deviceIdObject.fileIndex+k<deviceIdObject.sameDeviceID)
					        {   lines.clear();
					          
					    	   decompressGzipFile(path+deviceIdObject.deviceMatch.get(deviceIdObject.fileIndex+k), fileName[k-1]);
					            writeFile2(input2[k-1]);
					           
					             if(FinalList.size()<2*showIndex)
					                {
					            	 for(int i=0;i<lines.size();i++)
							            {
							            	FinalList.add(lines.get(i).toString());	
							            } 
					            	
					                     lines.clear();
					             }
					             else
					             {
					            	 
					            	 break;
					             }    	 
					       }  
					  }
				 }
				
			 }
			 else if(index-showIndex>0&&lines.size()>2*showIndex)
			 {
				for(int i=index-showIndex;i<2*showIndex+(index-showIndex);i++)
				 {
					FinalList.add(lines.get(i));
				 }
			 }
			
			 /*****End OF Case 1:  ********************************************************/
		  }
		/*****START  Case 2:  ********************************************************/
		else{
			int uperLimt=index-showIndex;
			int lowerLimit=lines.size()-index;
			 if(uperLimt<0)
			    { 
				 for(int i=index;i>0;i--)
				 {
					 uperList.add(lines.get(i).toString());
				 }
			      for(int i=index;i<lines.size();i++)
			      {
			    	  lowerList.add(lines.get(i).toString());
			      }
			 	 for(int i=deviceIdObject.fileIndex;i>0;i--)
			 	 {
			 		
			 		 if(i-1>=0&&uperList.size()<showIndex)
			 		     {
			 			 lines.clear();
			 			decompressGzipFile(path+deviceIdObject.deviceMatch.get(i-1), fileName[i-1]);
			 			 writeFile2(input2[i-1]);
			 			
			 			 if(lines.size()>showIndex-uperList.size())
			 			 { 
			 				 for(int j=lines.size()-1;j>showIndex-uperList.size();j--)
			 				    {
			 					 if(uperList.size()<showIndex) 
			 					uperList.add(lines.get(j).toString());
			 					 else
			 						 break;
			 				 }
			 			 }
			 			 else
			 			   {
			 				for(int j=lines.size()-1;j>0;j--)
			 				 {
			 					 uperList.add(lines.get(j).toString());
			 				 }
			 			 }
			 		 }
			 		 else
			 			 break;
			 	 }
			 }
			 else
			 {
				 
				 for(int i=index;i>index-showIndex;i--)
				 {
					 uperList.add(lines.get(i).toString());
				 }
			 }
			 /*****End OF  Case 2:  ********************************************************/ 
			 if(lowerLimit>showIndex)
			   {
				 for(int i=index;i<lines.size();i++)
				 {
					 if(lowerList.size()<showIndex)
					 {
						 lowerList.add(lines.get(i));
					 }
					 else
						 break;
				 }
			 }
			 else
			 {   
				 if(lowerList.size()<showIndex)
				 {
					for(int i=deviceIdObject.fileIndex;i<deviceIdObject.sameDeviceID;i++)
					{
						if(i+1<deviceIdObject.sameDeviceID&&lowerList.size()<showIndex)
						{
							 lines.clear();
					 			decompressGzipFile(path+deviceIdObject.deviceMatch.get(i+1), fileName[i]);
					 			 writeFile2(input2[i]);
					 				 for(int j=0;j<lines.size();j++)
								       {
					 					  if(lowerList.size()<showIndex)
										 lowerList.add(lines.get(j));
					 					  else
					 						  break;
									     }  		 
						}
						else
							break;
					}
				 }
			
			 }
		}
		 
	
		 for(int j=uperList.size()-1;j>0;j--)
		 {
			 FinalList.add(uperList.get(j).toString());
		 }
		 for(int j=0;j<lowerList.size();j++)
		 {
			 FinalList.add(lowerList.get(j).toString());
		 }
		for(int i=0;i<FinalList.size();i++)
		{
		String	buffer[] = FinalList.get(i).toString().split(",");
			if (buffer.length > 1) {
			
				HightLightDataList.add(buffer[1]);
			}
		}
		
		 }
		 catch(Exception io){
			 io.printStackTrace();
		 }
		return FinalList;
	}
}

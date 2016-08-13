package com.wavenet.in;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;

public class DeviceID {
	public ArrayList<String> deviceMatch = new ArrayList<String>();
	public ArrayList<String> spliting = new ArrayList<String>();
	public String finalFile = null;
	public ArrayList<String> DeviceIDList = new ArrayList<String>();
	public ArrayList<String> startTime = new ArrayList<String>();
	public static int DeviceCounter = 10;
	public static int TimeCounter = 30;
	public int fileIndex=0;
	public int sameDeviceID=0;
	public CharSequence chr = "";
	public DeviceID() {
	}
	public void getDeviceName(String device, String filePath, String timeTicks) {
		File files = new File(filePath);
		File fileArray[] = files.listFiles();
		for (File findFile : fileArray) {
			if (findFile.getName().split("_")[0].equals(device)) {
				deviceMatch.add(findFile.getName());
				DeviceCounter = 20;
			}
		}
		if (DeviceCounter == 10) {
			System.out.println("Device ID doesn't Found");
			
		} else {
			Collections.sort(deviceMatch);
			for (String deviceList : deviceMatch) {
				String bb[] = deviceList.split("\\.");
				String bb2[] = bb[0].split("_");
				startTime.add(bb2[1]);
				spliting.add(bb2[bb2.length - 1]);
			     }
			Collections.sort(spliting);
			Collections.sort(startTime);
			/****************************/
			CharSequence deveiceSequence = deviceMatch.get(0).split("_")[0];
			boolean notFoundflag = false;
			for (String getName : deviceMatch) {
		          if(getName.contains(deveiceSequence))
		          {
		        	  sameDeviceID++;
		          }
			}
			for (String getName : deviceMatch) {
				if (getName.contains(deveiceSequence) && getName.contains(timeTicks)) {
					notFoundflag = true;
					finalFile = getName;
					TimeCounter = 50;
					break;
				}
				 fileIndex++;
			}
			/******************************************************/
			if (!notFoundflag) {
				try{
				long long_finalTime = Long.parseLong(timeTicks);
				fileIndex=0;
				for (int i = 0; i < spliting.size(); i++) {
					long long_start = Long.parseLong(startTime.get(i).toString().trim());
					long long_endTime = Long.parseLong(spliting.get(i).toString().trim());
					if (long_start <= long_finalTime && long_endTime >= long_finalTime) {
						if (deviceMatch.get(i).contains(spliting.get(i))) {
							finalFile = deviceMatch.get(i);
							TimeCounter = 50;
							break;
						}
				  	}
					fileIndex++;
				}
			}
				catch(Exception er){
					er.printStackTrace();
				}
			}
		}
	}
}

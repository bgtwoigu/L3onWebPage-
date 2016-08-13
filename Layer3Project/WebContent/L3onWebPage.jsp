<%@page import="java.util.Enumeration"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.awt.image.DataBuffer"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.omg.CORBA.Request"%>
<%@page import="com.wavenet.in.*"%>
<%@page import="java.io.*"%>
<%@page import="java.io.FileInputStream.*"%>
<%@page import="java.io.FileOutputStream.*"%>
<%@page import="java.util.zip.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
 <%@page import="org.json.simple.*"%>
<%@page import="java.io.*,javax.servlet.*,java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <meta charset="utf-8">
      <title>L3Messages</title>
      <link href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
      <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
      <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
      <!-- CSS -->
      <style>
      html, body{
    height: 100%;
    background: #d0e4fe;
}

         .ui-widget-header {
            background:black;
            border: 1px solid #b9cd6d;
            color: #FFFFFF;
            font-weight: bold;
             font-size: 0.8em;
         }
         .ui-widget-content {
            background: #00FFFF;
            border: 1px solid #DDDDDD;
            color: #333333;
            overflow-y:auto;
         }
         #resizable { 
          position: absolute;
         background: #00FFFF;
         overflow-y:auto;
         padding: 0.8em;
          text-align: left; margin: 0;    font-size: 0.8em;
            }
            #bigDiv{
             position: absolute;
             background: #00FFFF;
             padding: 0.8em;
              width:100%;
             font-size: 0.8em;
            }
            #appendDiv{
             background: #00FFFF;
             position: absolute;
             background: #00FFFF;
             padding: 0.8em;
             height:30%;
             width:100%;
            }
            .div2{
             position: fixied;
             width:100%;
              border: 1px solid #b9cd6d;
              height:70%;
              overflow-y: auto;
              font-size: 0.8em;
              margin-left: auto;
              margin-right: auto;
            }
.users {
	table-layout: fixed;
	width: 100%;
	white-space: nowrap;
}
/* Column widths are based on these cells */
.users td {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	width:18%;
	}

.users th {
	background: #1589FF;
	color: white;
}

.users td, .users th {
	text-align: left;
	width:10%;
	padding: 5px 10px;
}

.users tr:nth-child(even) {
	background: lightblue;
}

.users tr:HOVER {
	background-color: yellow;
}

.users  td:hover {
	cursor: pointer;
}

div h1 {
	background-color: blue;
	color: white;
	height: 50px;
	text-align: center;
	text-decoration: underline;
	width:100%;
	font-size-adjust: 0.4;
}
.clearfix{clear:both;}
tbody {
 display: inline-block;
 overflow-x: scroll;
}
table thead th {
 position: absolute;
    width: 100%;
    overflow-x: scroll;
}
​
      </style>
      <script>
         $(function() {
            $( "#resizable" ).resizable();
         }); 
      </script>
   </head>

   <body bgcolor=#00FFFF>
      <!-- HTML --> 
       <div><h1>L3Message</h1></div>
      <div class="div2">
		<%!int showIndex = 100;int modifiedIndex=-1;%>
		<table class="users" id="dataTable">
		   <col style="width: 17%">
			<col style="width: 11%">
			<col style="width: 8%">
			<col style="width: 12%">
			<col style="width: 8%">
			<col style="width: 8%">
		    <col style="width: 28%">
		    <col style="width: 7%">
				<%
				/******************************************************/
				try  { 
				// response.setContentType("application/json");
				 String sessionId = "";
				 String deviceId ="";
					String time_ticks ="";
				 	char[] buf=null;
				          if(request.getMethod().equalsIgnoreCase("GET"))
				              {
				        	   
				        	   deviceId = request.getParameter("deviceId");
							   time_ticks = request.getParameter("timeTicks");
							   sessionId = request.getParameter("sessionID");
				              }
				          else if(request.getMethod().equalsIgnoreCase("POST")){   	
				    	 try  { 
				    	        BufferedReader bufr=request.getReader();
				    	        String thisLine=null;
				    	        String array[]={};
				    	         String str=Character.toString('"');
				    	        while ((thisLine = bufr.readLine()) != null) {
				    	        	
				    	        	 if(thisLine.contains("sessionID"))
				    	        	 {
				    	        		 array=thisLine.split(":");
				    	        		 sessionId=array[1].replace(str, "");
				    	        	 }
				    	        	 else if(thisLine.contains("deviceId"))
				    	        	 {
				    	        		 array=thisLine.split(":");
				    	        		 deviceId=array[1].replace(str, "");
				    	        	 }
				    	        	 else if(thisLine.contains("timeInTicks"))
				    	        	 {
				    	        		 array=thisLine.split(":");
				    	        		 time_ticks=array[1].replace(str, "");
				    	        	 }
				    	        	
				    	         } 
				    	  System.out.println("All Values ="+sessionId+"=Time="+time_ticks+"=device id="+deviceId);
				    	 }catch(Exception e){
				    		 out.println("WRONG INPUT VALUES");
				    	 }
				          }
					String unzipFilesPath = request.getRealPath("/WebContent/WEB-INF/UntarFiles").replace('\\', '/') + "/";
					String p1[] = unzipFilesPath.split("/WebContent");
					unzipFilesPath = p1[0] + p1[1];
					String url = request.getRealPath("/WebContent/WEB-INF/ResourceFolder").replace('\\', '/') + "/";
					String p2[] = url.split("/WebContent");
					String projectPath = p2[0] + p2[1];
					
					
					/******************************************************/
					String untarPath = unzipFilesPath + "unZip.csv";
					PathChooser pchooser = new PathChooser();
					List<String> linesFile2 = new ArrayList<String>();
					if ((PathChooser.getFolderPath(projectPath, sessionId)) == 1) {
						out.write("<script type='text/javascript'>\n");
						out.write("alert(' Folder Doesnt exist ');\n");
						out.write("</script>\n");
					} else {
						File file = new File(PathChooser.Path);
						File files[] = file.listFiles();
						String fileNames = "";
						String splitBy = "_";
						String FinalPath = "";
						
						DeviceID deviceObject = new DeviceID();
						SearchData searchdata = new SearchData(deviceObject);
						if (deviceId != null && deviceId != "" && time_ticks != null && time_ticks != "")
							deviceObject.getDeviceName(deviceId, PathChooser.Path, time_ticks);
						int count = 10;

						if (DeviceID.DeviceCounter != 10 && DeviceID.TimeCounter != 30) {
							for (File f : files) {
								fileNames = "" + f.getName();

								if (deviceObject.finalFile == null) {
									out.write("<script type='text/javascript'>\n");
									out.write("alert(' Time_Ticks doesn't found ');\n");
									out.write("</script>\n");
								} else if (fileNames.contains(deviceObject.finalFile) && deviceObject.finalFile != null) {
									count = 20;
									/**********untar file function*************/
									String newPath = PathChooser.Path + fileNames;
									searchdata.decompressGzipFile(newPath, untarPath);
									break;
								}
							}
						} else {
							out.write("<script type='text/javascript'>\n");
							out.write("alert(' invalid Device ID or Time_Ticks ');\n");
							out.write("</script>\n");
						}
						if (count == 20) {
							InputStream input = application.getResourceAsStream("/WEB-INF/UntarFiles/unZip.csv");
							searchdata.writeFile(input);
							int indexArray[] = {0, 1, 13, 14, 17,18, 16, 19,15,20};
							List<String> FinalList = new ArrayList<String>();
							int index = searchdata.getData(time_ticks, searchdata.searchString);

							if (deviceObject.sameDeviceID == 1) {
								FinalList = searchdata.SingleDeviceDataOnTable(index);
							} else {
								String untarPath2[] = new String[deviceObject.sameDeviceID];
								InputStream inputStream[] = new InputStream[deviceObject.sameDeviceID];
								for (int i = 1; i < deviceObject.sameDeviceID; i++) {
									untarPath2[i] = unzipFilesPath + "unZip" + i + ".csv";
									searchdata.decompressGzipFile(PathChooser.Path+deviceObject.deviceMatch.get(i), untarPath2[i]);
									inputStream[i] = application
											.getResourceAsStream("/WEB-INF/UntarFiles/unZip" + i + ".csv");
								}
								FinalList = searchdata.multipleDeviceData(index, deviceObject.fileIndex, inputStream,
										PathChooser.Path, untarPath2);
							}
							/**************HTML TABLE ******************/
							String newBuffer[];
							/*****************New Code *****************/
							if (searchdata.getData(time_ticks, searchdata.HightLightDataList) == -1) {
								out.write("<script type='text/javascript'>\n");
								out.write("alert(' Time_Ticks Doesn't Found ');\n");
								out.write("</script>\n");
							}
							/***********************End OF New Code*************/
						       response.setContentType("text/html");
							String str[] = {"Time Stamp", "Time_In_Ticks", "Technology", "Protocol", "Cell_ID",
									"Radio_Mode","Call_State","MessageDirection", "MessageName", "DecodedMessage"};
							for (int j = 0; j < FinalList.size(); j++) {
								if (j == 0) {
									//out.print("<thead>");
									out.print("<tr>");
									for (int i = 0; i < str.length; i++) {
										out.print(" <th class='row-1 row-ID'>" + str[i] + "</th>");
									}
									out.print("</tr>");
									//out.print("</thead>");
									out.print("<tr>");
								} else {
									String splitby = ",";
									newBuffer = FinalList.get(j).toString().split(splitby);
									for (int i = 0; i < indexArray.length; i++) {
										out.println("<td>" + newBuffer[indexArray[i]] + "</td>");
									}
									out.print("</tr>");
								}
							}
							/***************************Color Change *******************************************/
							 modifiedIndex = searchdata.getData(time_ticks, searchdata.HightLightDataList);
							int lengthOfList=searchdata.HightLightDataList.size();
							System.out.println("index found="+modifiedIndex+"Length="+searchdata.HightLightDataList.size());
							if (modifiedIndex >= 0) {
			%>
			<script language='javascript'>
				var input =<%=modifiedIndex%>;
				var len=<%=lengthOfList%>;
				var highLight=0;
				  if(input+10>=len-1)
					 {
					 highLight=input;
					 }
				  else
					   {
					  highLight=input+10;
					   }
				
				document.getElementById('dataTable').getElementsByTagName('tr')[input].style.backgroundColor = '#BA9EB0';
				document.getElementById('dataTable').getElementsByTagName('tr')[highLight].scrollIntoView(false);
		
				
	</script>
			<%
				}	
							/************************************************************************************/
						}
					}

				} catch (Exception e) {
					 out.println(e.getMessage());
					   out.println("Cause="+e.getCause());
					   out.println("hroughable Massage="+e.getLocalizedMessage());
					   out.println("StAK tRACE="+e.getStackTrace());
					   out.println("Rest Of Exception="+e.getClass());	   
				}
			%>
		</table>
      </div>
      <script type="text/javascript">
      var x = document.getElementById("dataTable").rows.length;
       if(x<1)
    	   {
    	   alert("No Data Found");
    	   Redirect();
    	   }
      </script>
      <script>
		var column_num;
		var row_num;
		var values = "";
		var oldRow=-1;
		var messageName="";
		var row=<%=modifiedIndex%>;
		var cell_index=10;
		var v=cell_index;
		$('#dataTable tr > *:nth-child('+v+')').hide();
		$( document ).ready(function() {
			var tableValue = document.getElementById('dataTable');
			values = tableValue.rows[row].cells[cell_index-1].innerHTML;
			messageName=tableValue.rows[row].cells[8].innerHTML
			document.getElementById('messageName').innerHTML = messageName;
			document.getElementById('values').innerHTML = values; 
		});
		$(document)
				.ready(
						function() {
							$("#dataTable td").click(function() 
									             {
								                values="";
								                messageName="";
												column_num = parseInt($(this)
														.index());
												row_num = parseInt($(this)
														.parent().index());
												var table = document.getElementById('dataTable');
												document.getElementById('dataTable').getElementsByTagName('tr')[row_num].style.backgroundColor = '#CC6699';
												values = table.rows[row_num].cells[cell_index-1].innerHTML;
												document.getElementById('values').innerHTML = values;
												var tableValues = document.getElementById('dataTable');
												messageName=tableValues.rows[row_num].cells[8].innerHTML;
												document.getElementById('messageName').innerHTML = messageName;
												if(oldRow!=-1)
												{
													document.getElementById('dataTable').getElementsByTagName('tr')[oldRow].style.backgroundColor = 'lightblue';
												}
												values = "";
												messageName="";
												oldRow=row_num;
												row_num = -1;
												column_num = -1;
												String.prototype.split = function(
														delimiter,
														keepDelimiters) {
													if (!keepDelimiters) {
														return this
																._split(delimiter);
													} else {
														var res = [];
														var start = 0, index;
														while ((index = this
																.indexOf(
																		delimiter,
																		start)) != -1) {
															res
																	.push(this
																			.substr(
																					start,
																					index
																							- start));
															res.push(delimiter);
															start = index + 1;
														}
														res.push(this
																.substr(start));
														return res;
													}
												};
												$("#result")
														.html(
																"Row_num ="
																		+ row_num
																		+ "  ,  Rolumn_num ="
																		+ column_num);
											});
						});
	</script>
	<div id="appendDiv"></div>
	   <div id="bigDiv">
         <h3 class="ui-widget-header">Decoded Message:&nbsp;&nbsp;&nbsp;<span id="messageName"></span></h3>
         <span id="values"> </span>
        </div>
        
  </body>
</html>   
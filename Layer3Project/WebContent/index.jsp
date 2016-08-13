<%@page import="com.wavenet.in.DeviceID"%>
<%@page import="java.util.ArrayList"%>
 <%@page import="org.json.simple.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.wavenet.in.PathChooser"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="application/json; charset=ISO-8859-1">
<title>Input From</title>

<style>
.center {
	height: 250px;
	width: 600px;
	position: fixed;
	top: 50%;
	left: 50%;
	margin-top: -100px;
	margin-left: -200px;
	border: 3px solid #8AC007;
}
</style>
</head>
<body bgcolor=#00FFFF>

      <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
      <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script type=text/javascript>

$(document).ready(function(){   
    $('#getData').click(function(){  
        $.ajax({  
            url:'welcome.jsp',  
            type:'post',  
            dataType: 'json',  
            success: function(data) {  
                $('#name').val(data.name);  
                $('#email').val(data.email);  
            }  
        });  
    });  
}); 
</script>
	<div class="center">
		<form name="inputform"  method="GET" action="L3onWebPage.jsp">
			<div class="textfield" align="center">
				<br> <br>
				<%
					DeviceID.DeviceCounter = 10;
					DeviceID.TimeCounter = 30;
  /****************************************************************/
				%>
				<label for="Session ID:">Session ID: </label> <select
					name=sessionID>
					<%
					 String url=request.getRealPath("/WebContent/WEB-INF/ResourceFolder").replace('\\', '/') + "/";
					 String p2[]=url.split("/WebContent");
					 String projectPath = p2[0]+p2[1];
						String sessionId = "";
						/******************************************************/
						ArrayList<String> sessionFolders = PathChooser.getSession(projectPath);
						Iterator itr = sessionFolders.iterator();	
						while (itr.hasNext()) {
					%>
					<option><%=itr.next()%></option>
					<%
						}
					%>
				</select> <br> <br> <label for="Device ID">Device ID:</label> <input
					type="text" id="deviceId" name="deviceId" maxlength="14" />
			</div>
			<br>
			<div class="textfield" align="center">
				<label for="Time_Ticks">Time_Ticks:</label> <input type="text"
					id="timeTicks" name="timeTicks" maxlength="13" /> <br> <br>
				<input type="submit" value="Submit" onclick="validateForm" />
			</div>
			<div align="center">
				<br> <br>
			</div>
		</form>
	</div>
	<center></center>
</body>
</html>
/***********************************/

 /***********************************/
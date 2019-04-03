<%@ include file="Config.jsp"%>
<%
	Class.forName(SQLDRIVER);
	Connection con = DriverManager.getConnection(PROTOCOL+"://"+HOSTADDR+":"+PORTNO+"/"+DB,DBUSERNAME,DBPASSWORD);
	Statement st = con.createStatement();
%>
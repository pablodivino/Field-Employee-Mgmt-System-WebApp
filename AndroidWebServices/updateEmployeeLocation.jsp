<%@ page contentType="application/json" language="java" import="java.sql.*,java.util.*" errorPage="" %>

<%@ include file="../DBConnect.jsp" %>

<%

String employeeid= request.getParameter("employeeId");
String lat= request.getParameter("lat");
String lng= request.getParameter("lng");

String InsertQuery = "INSERT INTO `locations`(`employee_id`, `Long`, `Lat`) VALUES ('"+employeeid+"','"+lng+"','"+lat+"')";
String UpdateQuery = "UPDATE `employees` SET `lat`='"+lat+"',`long`='"+lng+"' WHERE `imei`="+employeeid;


PreparedStatement pstmt = con.prepareStatement(InsertQuery, Statement.RETURN_GENERATED_KEYS);  
pstmt.executeUpdate();

pstmt = con.prepareStatement(UpdateQuery, Statement.RETURN_GENERATED_KEYS);  
pstmt.executeUpdate();
%>
<%
	con.close();
%>
<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>

<%
	String id= request.getParameter("empId");

	String Query = "UPDATE `employees` SET `imei`= NULL, `status`= 'Inactive' WHERE `employee_id`= "+id;
	PreparedStatement pstmt = con.prepareStatement(Query, Statement.RETURN_GENERATED_KEYS);  
	pstmt.executeUpdate();
%>
<%
	pstmt.close();
	con.close();
%>
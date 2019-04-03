<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>

<%
	String id= request.getParameter("empId");

	String Query = "UPDATE `food_cost` SET `approval_status`= 'Approved' WHERE `employee_id`= "+id;
	PreparedStatement pstmt = con.prepareStatement(Query, Statement.RETURN_GENERATED_KEYS);  
	pstmt.executeUpdate();
	String TQuery = "UPDATE `travel_cost` SET `approval_status`= 'Approved' WHERE `employee_id`= "+id;
	pstmt = con.prepareStatement(TQuery, Statement.RETURN_GENERATED_KEYS);  
	pstmt.executeUpdate();
%>
<%
	pstmt.close();
	con.close();
%>
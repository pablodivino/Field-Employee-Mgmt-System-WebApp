<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>

<%
	String id= request.getParameter("EmployeeId");
	String address = request.getParameter("Eadd");
	String area = request.getParameter("Earea");
	String city = request.getParameter("Ecity");
	String contact = request.getParameter("Econ");
	String email = request.getParameter("Eemail");

	String Query = "UPDATE `employees` SET `address`='"+address+"',`area`='"+area+"',`city`='"+city+"',`contact`="+contact+",`email`='"+email+"' WHERE `employee_id`= "+id;
	PreparedStatement pstmt = con.prepareStatement(Query, Statement.RETURN_GENERATED_KEYS);  
	pstmt.executeUpdate();
%>
<%
	pstmt.close();
	con.close();
%>
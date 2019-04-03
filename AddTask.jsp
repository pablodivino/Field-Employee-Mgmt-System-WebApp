<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>

<%
	String customer_name= request.getParameter("CustomerID");
	String employee_name= request.getParameter("ATEM");
	String task_type= request.getParameter("TaskTypeID");
	String desc= request.getParameter("ATD");
	String date= request.getParameter("ATDP");
	String time= request.getParameter("ATTD") + ":00";

	String Query ="INSERT INTO `tasks`(`employee_id`, `customer_id`, `task_type_id`, `description`, `scheduled_date`, `scheduled_time`) VALUES ("+employee_name+","+customer_name+","+task_type+",'"+desc+"','"+date+"','"+time+"')";
	PreparedStatement pstmt = con.prepareStatement(Query, Statement.RETURN_GENERATED_KEYS);  
	pstmt.executeUpdate();  

%>

<%
	pstmt.close();
	con.close();
%>
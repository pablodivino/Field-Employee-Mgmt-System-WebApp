<%@ page contentType="application/json" language="java" import="java.sql.*,java.util.*" errorPage="" %>

<%@ include file="../DBConnect.jsp" %>

<%

String taskId= request.getParameter("taskId");
String amount= request.getParameter("amount");
String comments= request.getParameter("comments");

String UpdateQuery = "UPDATE `tasks` SET `payment_collected`='"+amount+"',`end_time`= now(),`comments`='"+comments+"',`status`='Complete' WHERE `task_id`="+taskId;


PreparedStatement pstmt = con.prepareStatement(UpdateQuery, Statement.RETURN_GENERATED_KEYS);  
pstmt.executeUpdate();
%>
<%
	con.close();
%>
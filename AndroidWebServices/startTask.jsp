<%@ page contentType="application/json" language="java" import="java.sql.*,java.util.*" errorPage="" %>

<%@ include file="../DBConnect.jsp" %>

<%

String taskId= request.getParameter("taskId");

String UpdateQuery = "UPDATE `tasks` SET `start_time`= now(),`status`='Started' WHERE `task_id`="+taskId;

PreparedStatement pstmt = con.prepareStatement(UpdateQuery, Statement.RETURN_GENERATED_KEYS);  
pstmt.executeUpdate();
%>
<%
	con.close();
%>
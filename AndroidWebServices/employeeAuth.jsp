<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>

<%@ include file="../DBConnect.jsp" %>
<%
	String id = request.getParameter("id");

	ResultSet rs = st.executeQuery("Select * from employees where imei ="+ id);
	rs.next();
	
	String str="{\"id\" : \""+rs.getString(14)+"\",\"firstname\" : \""+rs.getString(2)+"\",\"lastname\" : \""+rs.getString(3)+"\",\"empId\" : \""+rs.getString(1)+"\"}";
	
	str= "["+str+"]";
	
	response.getWriter().write(str);
	response.getWriter().flush();
	response.getWriter().close();
	st.close();
	con.close();
%>

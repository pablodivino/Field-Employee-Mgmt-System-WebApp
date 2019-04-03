<%@ page contentType="application/json" language="java" import="java.sql.*,java.util.*" errorPage="" %>

<%@ include file="../DBConnect.jsp" %>
<%
	String contact = request.getParameter("contact");
	String IMEI = request.getParameter("IMEI");
	String str;
		
	int result = st.executeUpdate("Update employees set imei="+IMEI+" where contact ="+ contact);

	ResultSet rs = st.executeQuery("Select * from employees where imei ="+ IMEI);
	rs.next();
	
	str="{\"id\" : \""+rs.getString(14)+"\",\"firstname\" : \""+rs.getString(2)+"\",\"lastname\" : \""+rs.getString(3)+"\"}";
	
	str= "["+str+"]";
	
	response.getWriter().write(str);
	response.getWriter().flush();
	response.getWriter().close();
	st.close();
	con.close();
%>

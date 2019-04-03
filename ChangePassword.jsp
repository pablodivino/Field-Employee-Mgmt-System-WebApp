<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<%@ include file="DBConnect.jsp"%>
<%
	boolean flag =false;
	String opass=(String) request.getParameter("op");
	String npass=(String) request.getParameter("np");	
	Cookie ck = null;
	Cookie[] cs = null; 
	String user="";
	cs = request.getCookies();
	if(cs!=null)
	{
		for (int i = 0; i < cs.length; i++)
		{
			ck = cs[i];
			if(ck.getName().equals("user"))
			{
				user=(String) ck.getValue();		 
			}
		}
	}	
	ResultSet rs = st.executeQuery("SELECT * FROM `users` where username='"+user+"' && password=password('"+opass+"')");
	if(rs.next())
	{
		st.executeUpdate("UPDATE `users` SET `password`=password('"+npass+"') WHERE username='"+user+"'");
		%>1<%
	}
	else
	{
		%>2<%
	}
%>
<% st.close();con.close();%>

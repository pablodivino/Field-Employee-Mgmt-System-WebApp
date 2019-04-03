<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>

<%
	boolean flag =false;	
	String uname = request.getParameter("user");
	String pass=request.getParameter("pass");
	
	ResultSet rs = st.executeQuery("select * from users where username='"+uname+"' && password=password('"+pass+"')");
	if(rs.next()){
		flag=true;
	}
	
	if(flag){
		Cookie u = new Cookie("user",uname);
		u.setMaxAge(360000);
		response.addCookie(u);
		response.sendRedirect("home.jsp");
	}
	else{
		response.sendRedirect("index.jsp?err=f");
	}
%>
<%
	st.close();
	con.close();
%>

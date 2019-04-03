<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>

<%

	String SQLDRIVER = "com.mysql.jdbc.Driver";
	String PROTOCOL ="jdbc:mysql";
	String HOSTADDR = "localhost";
	String PORTNO ="3306";
	String DB = "macgray2.0";
	String DBUSERNAME = "root";
	String DBPASSWORD = "";

	Class.forName(SQLDRIVER);
	Connection con = DriverManager.getConnection(PROTOCOL+"://"+HOSTADDR+":"+PORTNO+"/"+DB,DBUSERNAME,DBPASSWORD);
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select `employee_id`,`long`,`lat` from employees");
	rs.next();
	String emp_element = "{\"id\":\""+rs.getString(1)+"\", \"long\":\""+rs.getString(2)+"\", \"lat\":\""+rs.getString(3)+"\"}"; 

	while(rs.next()){
		emp_element += ", {\"id\":\""+rs.getString(1)+"\", \"long\":\""+rs.getString(2)+"\", \"lat\":\""+rs.getString(3)+"\"}";
	}

	String json = "["+emp_element+"]" ;

	response.getWriter().write(json);
	response.getWriter().flush();
	response.getWriter().close();
	st.close();
	con.close();
%>
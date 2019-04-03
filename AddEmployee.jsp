<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>

<%
	String first_name = request.getParameter("EFN");
	String last_name = request.getParameter("ELN");
	String department = request.getParameter("ED");
	String address = request.getParameter("EAD");
	String dob = request.getParameter("EDOB");
	String area = request.getParameter("EA");
	String city = request.getParameter("ECT");
	String contact = request.getParameter("ECON");
	String email = request.getParameter("EEM");

	String Query = "INSERT INTO `macgray2.0`.`employees` (`employee_id`, `first_name`, `last_name`, `dob`, `department`, `address`, `area`, `city`, `contact`, `email`, `average`) VALUES (NULL, '"+first_name+"', '"+last_name+"', '"+dob+"', '"+department+"', '"+address+"', '"+area+"', '"+city+"', "+contact+", '"+email+"', NULL)";
	PreparedStatement pstmt = con.prepareStatement(Query, Statement.RETURN_GENERATED_KEYS);  
	pstmt.executeUpdate();  
	ResultSet keys = pstmt.getGeneratedKeys();    
	keys.next();
	
	String AddedEmployee = "{\"id\":\""+keys.getInt(1)+"\", \"first_name\":\""+first_name+"\", \"last_name\":\""+last_name+"\", \"contact\":\""+contact+"\", \"department\":\""+department+"\"}";

%>
<%= AddedEmployee%>

<%
	pstmt.close();
	con.close();
%>
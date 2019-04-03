<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>

<%
	String company_name = request.getParameter("CompanyName");
	String customer_name = request.getParameter("CustomerName");
	String address = request.getParameter("Address");
	String area = request.getParameter("Area");
	String city = request.getParameter("City");
	String contact = request.getParameter("Contact");
	String email = request.getParameter("Email");
	String lat = request.getParameter("Latitude");
	String lng = request.getParameter("Longitude");

	String Query ="INSERT INTO `macgray2.0`.`customers` (`customer_id`, `company_name`, `customer_name`, `address`, `area`, `city`, `contact`, `email`,`lat`,`long`) VALUES (NULL, '"+company_name+"', '"+customer_name+"', '"+address+"', '"+area+"', '"+city+"', "+contact+", '"+email+"','"+lat+"','"+lng+"')";
	PreparedStatement pstmt = con.prepareStatement(Query, Statement.RETURN_GENERATED_KEYS);  
	pstmt.executeUpdate();  
	ResultSet keys = pstmt.getGeneratedKeys();    
	keys.next();

	String AddedCustomer = "{\"id\":\""+keys.getInt(1)+"\", \"customer\":\""+company_name+","+area+","+city+"\"}";
%>
<%= AddedCustomer%>

<%
	pstmt.close();
	con.close();
%>
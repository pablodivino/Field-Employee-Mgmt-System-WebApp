<%@ page contentType="application/json" language="java" import="java.sql.*,java.util.*" errorPage="" %>

<%@ include file="../DBConnect.jsp" %>
<%@ include file="../MailServer.jsp"%>
<%
	String id = request.getParameter("id");
	String str;

	ResultSet result = st.executeQuery("Select * from employees where contact="+id);
	if(result.next()){
		Random rand = new Random();
		int pin = rand.nextInt(900000) + 100000;
		String email = result.getString(10);

	    MimeMessage message = new MimeMessage(mailSession);
	    message.setFrom(new InternetAddress(EMAIL));
	    message.addRecipient(Message.RecipientType.TO,
	                               new InternetAddress(email));
	    message.setSubject("MacGray Employee Verification Pin");
	    message.setText("Your Employee Verification Pin Number is:"+pin);
	    Transport.send(message);
		int rs = st.executeUpdate("Update employees set PIN="+pin+" where contact ="+ id);
		
		str="{\"pin\" : \""+pin+"\"}";
		
		str= "["+str+"]";
	}else{
		str="{\"pin\" : \"404\"}";
		str= "["+str+"]";
	}
	
	response.getWriter().write(str);
	response.getWriter().flush();
	response.getWriter().close();
	st.close();
	con.close();
%>

<%@ page import="java.io.*,java.util.*,javax.mail.*,javax.mail.internet.*,javax.activation.*,javax.servlet.http.*,javax.servlet.*" %>

<% 
  Properties properties = new Properties();

  // Setup mail server
  properties.put("mail.smtp.host", SMTP);
  properties.put("mail.smtp.socketFactory.port", SMTP_PORT);
  properties.put("mail.smtp.socketFactory.class",  
            "javax.net.ssl.SSLSocketFactory");  
  properties.put("mail.smtp.auth", "true");  
  properties.put("mail.smtp.port", SMTP_PORT);  
  final String E_MAIL = EMAIL;
  final String E_MAIL_PASSWORD = EMAIL;
   // Get the default Session object.
  Session mailSession = Session.getInstance(properties,new javax.mail.Authenticator() {  
    protected PasswordAuthentication getPasswordAuthentication() {  
      return new PasswordAuthentication(EMAIL,EMAIL_PASSWORD);//change accordingly  
    }  
  });
%>
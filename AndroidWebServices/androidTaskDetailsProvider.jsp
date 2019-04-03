<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>

<%@ include file="../DBConnect.jsp" %>
<%
	String id = request.getParameter("id");

	ResultSet rs = st.executeQuery("SELECT `tasks`.`task_id`, `customers`.`company_name`, `customers`.`customer_name`, `customers`.`address`, `customers`.`area`, `customers`.`city`, `customers`.`contact`, `customers`.`email`, `parent_type`.`name` as task_type,`task_types`.`name` as sub_type, `tasks`.`scheduled_date`, `tasks`.`scheduled_time`, `tasks`.`description`, `tasks`.`start_time`, `tasks`.`end_time`, `tasks`.`comments`, `tasks`.`status`, `customers`.`lat`, `customers`.`long` FROM tasks inner join customers inner join task_types inner join task_types as parent_type on tasks.customer_id=customers.customer_id && tasks.task_type_id=task_types.task_type_id && task_types.parent_id = parent_type.task_type_id where `tasks`.`task_id`="+id);
	rs.next();
	String TaskType,SubType;
	if(rs.getString(9)!=null){
		TaskType=rs.getString(9);
		SubType=rs.getString(10);
	}
	else{
		TaskType=rs.getString(10);
		SubType = "";
	}
	String str="{\"id\" : \""+rs.getString(1)+"\", \"companyname\" : \""+rs.getString(2)+"\", \"customername\" : \""+rs.getString(3)+"\", \"address\" : \""+rs.getString(4)+"\", \"area\" : \""+rs.getString(5)+"\", \"city\" : \""+rs.getString(6)+"\", \"contact\" : \""+rs.getString(7)+"\", \"email\" : \""+rs.getString(8)+"\", \"tasktype\" : \""+TaskType+"\", \"subtype\" : \""+SubType+"\", \"scheduleddate\" : \""+rs.getString(11)+"\", \"scheduledtime\" : \""+rs.getString(12)+"\", \"description\" : \""+rs.getString(13)+"\", \"starttime\" : \""+rs.getString(14)+"\", \"endtime\" : \""+rs.getString(15)+"\", \"comments\" : \""+rs.getString(16)+"\", \"status\" : \""+rs.getString(17)+"\", \"lat\" : \""+rs.getString(18)+"\", \"lng\" : \""+rs.getString(19)+"\"}";
	
	str= "["+str+"]";
	
	response.getWriter().write(str);
	response.getWriter().flush();
	response.getWriter().close();
	st.close();
	con.close();
%>

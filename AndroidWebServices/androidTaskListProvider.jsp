<%@ page contentType="application/json" language="java" import="java.sql.*" errorPage="" %>

<%@ include file="../DBConnect.jsp" %>
<%

	String FilterBy= request.getParameter("filterBy");
	String Val = request.getParameter("value");
	String empId = request.getParameter("empId");
	String Query= "";
	// if(FilterBy.matches("task_types.name") || FilterBy.matches("Status")){
	// 	Val = "'"+Val+"'";
	// }
	if(FilterBy.matches("scheduled_date")){
	Query += " && scheduled_date='"+Val+"'";
	}else{
		Query +=" && scheduled_date=curdate()";

		if(FilterBy.matches("Status")){
		Query +=" && "+FilterBy+"='"+Val+"'";
		}else{
			Query +=" && (Status='Started' || Status='Scheduled')";
		}
	}

	

	ResultSet rs = st.executeQuery("SELECT `tasks`.`task_id`, `customers`.`company_name`, `customers`.`area`, `customers`.`city`, `task_types`.`name`, `parent_type`.`name` as parent_name, `tasks`.`scheduled_time`, `customers`.`lat`, `customers`.`long` FROM tasks inner join customers inner join task_types inner join task_types as parent_type on tasks.customer_id=customers.customer_id && tasks.task_type_id=task_types.task_type_id && task_types.parent_id = parent_type.task_type_id where employee_Id="+empId+Query);
	rs.next();
	String Tasktype;
	if(rs.getString(6)!=null){
		Tasktype=rs.getString(6)+">"+rs.getString(5);
	}
	else{
		Tasktype=rs.getString(5);
	}
	String str="{ \"id\": \""+rs.getString(1)+"\", \"companyname\" : \""+rs.getString(2)+","+rs.getString(3)+","+rs.getString(4)+"\",\"tasktype\": \""+Tasktype+"\" ,\"time\": \""+rs.getString(7)+"\",\"lat\": \""+rs.getString(8)+"\",\"lng\": \""+rs.getString(9)+"\"}";
	while(rs.next())
	{
		if(rs.getString(6)!=null){
		Tasktype=rs.getString(6)+">"+rs.getString(5);
		}
		else{
		Tasktype=rs.getString(5);
		}
		str = str+ " ,{ \"id\": \""+rs.getString(1)+"\", \"companyname\" : \""+rs.getString(2)+","+rs.getString(3)+","+rs.getString(4)+"\",\"tasktype\": \""+Tasktype+"\" ,\"time\": \""+rs.getString(7)+"\",\"lat\": \""+rs.getString(8)+"\",\"lng\": \""+rs.getString(9)+"\"}";
		
	}
	str= "["+str+"]";
	
	response.getWriter().write(str);
	response.getWriter().flush();
	response.getWriter().close();
	st.close();
	con.close();
%>
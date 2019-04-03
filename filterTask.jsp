<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp" %>
<%
	String FilterBy = request.getParameter("filterby");
	if(FilterBy.matches("Employee")){
%>	
	<%ResultSet EmployeeList = st.executeQuery("Select * from employees order by first_name");%>
		<div id="FilterEmployeeMenu">
		<paper-input id="FilterEmployee" label="Filter Employee" onkeyup="filterTaskMenuEmployees()"></paper-input>
		<paper-menu>
			<%while(EmployeeList.next()){%>
				<paper-material elevation="1" EmpName="<%= EmployeeList.getString(2)%> <%= EmployeeList.getString(3)%> <%= EmployeeList.getString(9)%>" onClick="addEmployeeFilter('<%= EmployeeList.getString(1)%>','<%= EmployeeList.getString(2)%> <%= EmployeeList.getString(3)%>')" class="filteremployees">
					<b><%= EmployeeList.getString(2)%> <%= EmployeeList.getString(3)%></b><br>
					<%= EmployeeList.getString(9)%>
	 			</paper-material>
			<%}%>
		</paper-menu>
		</div>
		<% EmployeeList.close(); %>
<%	
	}else if(FilterBy.matches("Task Type")){
%>

		<% ResultSet TasksList = st.executeQuery("Select DISTINCT(name) from task_types where parent_id='0'");%>
		<paper-dropdown-menu label= "Types" id="Filter">
  			<paper-menu id="TaskTypeFilterMenu" class="dropdown-content" style="width:auto;" selected="0">
    			<%while(TasksList.next()){%>
    			<paper-item onclick="addTaskTypeFilter('<%= TasksList.getString(1)%>')"><%= TasksList.getString(1)%></paper-item>
    			<%}%>
  			</paper-menu>
		</paper-dropdown-menu>
		<% TasksList.close(); %>
<%	
	}else if(FilterBy.matches("Status")){
%>

		<paper-menu id="FilterMenu" style="background-color:#eee; margin-top:40px">
    		<paper-item style="padding-left:20px; color:#666" onclick="addStatusFilter('Scheduled')">Scheduled</paper-item>
    		<paper-item style="padding-left:20px; color:#666" onclick="addStatusFilter('Started')">Started</paper-item>
    		<paper-item style="padding-left:20px; color:#666" onclick="addStatusFilter('Complete')">Complete</paper-item>
    		<paper-item style="padding-left:20px; color:#666" onclick="addStatusFilter('Cancelled')">Cancelled</paper-item>
		</paper-menu>
<%	
	}
%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>

<%
	String id = request.getParameter("id");
	String label = request.getParameter("label");
	String table = request.getParameter("TableName");
	String query = request.getParameter("Query");

	ResultSet rs = st.executeQuery("Select * from "+table+" where "+query);
%>

<%if(rs.next()){
	rs.beforeFirst();
%>
<paper-dropdown-menu id="<%= id%>" label="<%= label%>" class="addTaskDropdown">
	<paper-menu class="dropdown-content" >

		 <%while(rs.next()){%>
		<paper-item class="addTaskDropdownItems" key="<%= rs.getString(1)%>"><%= rs.getString(2)%><%if(table.equals("employees")){%> <%= rs.getString(3)%><%}%>
		</paper-item>
		<%}%>

	</paper-menu>
</paper-dropdown-menu>

<script type="text/javascript">
TaskType.addEventListener('iron-select',function(event){
	var tasktype = event.target.selectedItem.getAttribute("key");
	$("#SubTypeContainer").hide();
	$("#SubType").prop('disabled', true);
	$("#Employee").prop('disabled', true);
	$("#Time").prop('disabled', true);
	$("#NextButton").prop('disabled',true);

	$.ajax({
		url: 'AddTaskDropdown.jsp?id=SubType&&label=Sub Type&&TableName=task_types&&Query= parent_id=\''+tasktype+'\'',
		type: 'GET',
		dataType: 'html',
		success: function(Data){
			var d = Data.trim();
			if(d != "404"){

				$("#SubTypeContainer").html(Data);
				$("#SubTypeContainer").show();
			}else{
				$.ajax({
					url: 'AddTaskDropdown.jsp?id=Employee&&label=Employee&&TableName=employees&&Query=status!=\'Inactive\'',
					type: 'GET',
					dataType: 'html',
					success: function(Data){
						$("#EmployeeContainer").html(Data);
					}
				});
			}
			
		}
	});
});

SubType.addEventListener('iron-select',function(event){
	var tasktype = event.target.selectedItem.getAttribute("key");
	$("#Employee").prop('disabled', true);
	$("#Time").prop('disabled', true);
	$("#NextButton").prop('disabled',true);
	$.ajax({
		url: 'AddTaskDropdown.jsp?id=Employee&&label=Employee&&TableName=employees&&Query=status!=\'Inactive\'',
		type: 'GET',
		dataType: 'html',
		success: function(Data){
			$("#EmployeeContainer").html(Data);
		}
	});
});
Employee.addEventListener('iron-select',function(event){
	$("#NextButton").prop('disabled',true);
	$("#employeeDates").attr("ng-disabled",false);
	$("#Time").prop('disabled',false);
	$("#Time").removeAttr('selected');
});

</script>

<%}else{%>
404
<%}%>

<%
 st.close();
 con.close();
%>
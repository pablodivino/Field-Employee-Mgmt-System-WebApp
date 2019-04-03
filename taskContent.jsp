<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<%@ include file="DBConnect.jsp"%>

<%
	// String FilterBy= request.getParameter("filterBy");
	// String Val = request.getParameter("value");
	
	String FD = request.getParameter("FD");
	String FDT = request.getParameter("FDT");
	String FE = request.getParameter("FE");
	String FEN = request.getParameter("FEN");
	String FT = request.getParameter("FT");
	String FS = request.getParameter("FS");
	String FDDef = request.getParameter("FDDef");

	String FilterQuery = "1";

	if(!FD.matches("NA")){
		//Date Filter Here
		FilterQuery += " and scheduled_date between '"+FD+"' and '"+FDT+"'";
	}
	if(!FE.matches("NA")){
		FilterQuery += " and tasks.employee_id="+FE;
	}
	if(!FT.matches("NA")){
		ResultSet tasktypes = st.executeQuery("select * from task_types where task_type_id in (select task_type_id from task_types where name='"+FT+"') or parent_id in (select task_type_id from task_types where name='"+FT+"')");
		String taskTypeQuery="( ";
		tasktypes.next();
		taskTypeQuery+= "task_types.task_type_id="+tasktypes.getString(1);
		while(tasktypes.next()){
			taskTypeQuery+= " or task_types.task_type_id="+tasktypes.getString(1);
		}
		taskTypeQuery+= " )";
		FilterQuery += " and "+taskTypeQuery;
	}
	if(!FS.matches("NA")){
		FilterQuery += " and tasks.status='"+FS+"'";
		//$("#FilterTagContainer").append("");
	}

	ResultSet tasks = st.executeQuery("SELECT customers.company_name,customers.area,customers.city,customers.contact,task_types.name,tasks.scheduled_date,tasks.scheduled_time,employees.first_name,employees.last_name,employees.contact,tasks.status,tasks.task_id,`parent_type`.`name` as parent_name FROM tasks inner join customers inner join task_types inner join employees inner join task_types as parent_type on tasks.customer_id = customers.customer_id && tasks.employee_id = employees.employee_iD && tasks.task_type_id = task_types.task_type_id && task_types.parent_id = parent_type.task_type_id where "+FilterQuery+" order by scheduled_date");

	String curr_date="null";
%>

<style is="custom-style">
	.tasks{
		height:230px;
		background-color:#fafafa !important;
		width:180px;
		margin:10px;
		float:left;
		padding:10px;
	}

	.tag{
		height:20px;
		line-height:20px;
		vertical-align:middle;
		background-color:rgba(0, 0, 0, 0.6);
		border-radius:10px;
		font-size:12px;
		color:#fff;
		padding:0px 10px;
		margin:5px;
		float:left;
		cursor:pointer;
	}
	.tag:hover{
		text-decoration:line-through;
	}
	.tasksPopUpButton{
		display:inline-block;
		position:absolute;
		bottom:5px;
		right:5px;
		--paper-icon-button-ink-color:#51ccdb;
		color:#51ccdb;
	}

	#TaskContainer{
		width:220px;
		margin:auto;
	}

	@media screen and (min-width: 890px) {
	    #TaskContainer{
	        width:440px;
	    }
	}

	@media screen and (min-width: 1110px) {
	    #TaskContainer{
	        width:660px;
	    }
	}

	@media screen and (min-width: 1330px) {
	    #TaskContainer{
	        width:880px;
	    }
	}

	@media screen and (min-width: 1550px) {
	    #TaskContainer{
	        width:1100px;
	    }
	}

	.company{
		color:#51ccdb;
		font-size:15px;
	}

	#Sort{
		position:fixed;
		top: 10px;
		right: 210px;
		height:30px;
		min-width:30px;
		border-radius:15px;
		z-index:10;
		background-color:rgba(81, 204, 219, 0.8);
		color:#FFFFFF;
		line-height:30px;
		vertical-align:middle;
	}
	#SortMenu{
		display:none;
		width:160px;
		background-color:#FFFFFF;
		position:fixed;
		top: 50px;
		right:210px;
		z-index:10;
		padding:10px 0px;
		cursor:pointer;
	}
</style>

<div style="width:100%">
	
	<div id="TaskContainer">
		<br>
		<!-- <br> -->
		<!-- <br>
		<br> -->
		<div id="FilterTagContainer">
			<%
				if(!FD.matches(FDDef) || !FDT.matches(FDDef)){
					if(FD.matches(FDT)){
					%>
					<div class="tag" onclick="removeTag('FD'); removeTag('FD2'); setToday();"> DT:<%=FD%> X</div>
					<%
					}else{
						%>
					<div class="tag" onclick="removeTag('FD'); removeTag('FD2'); setToday();"> DT:<%=FD%> TO <%=FDT%> X</div>
					<%
					}
				}
				if(!FE.matches("NA")){
				%>
					<div class="tag" onclick="removeTag('FE')"> EMP:<%=FEN%> X</div>
				<%
				}
				if(!FT.matches("NA")){
				%>
					<div class="tag" onclick="removeTag('FT')"> TT:<%=FT%> X</div>
				<%
				}
				if(!FS.matches("NA")){
				%>
					<div class="tag" onclick="removeTag('FS')"> ST:<%=FS%> X</div>
				<%
				}
			%>
		</div>
		<br />
	<%if(tasks.next()){
	tasks.beforeFirst();
	%>
		
		
		<% while(tasks.next()){
			String Tasktype;
			String SubType ="";
			if(tasks.getString(13)!=null){
			Tasktype=tasks.getString(13);
			SubType=tasks.getString(5);
			}
			else{
				Tasktype=tasks.getString(5);
				SubType="";
			}
		%>



			<%if(!curr_date.matches(tasks.getString(6))){
				curr_date=tasks.getString(6);
			%>
			<div style="height:30px;width:100%;border-bottom:2px solid #51ccdb;color:#51ccdb;float:left;margin:10px 0px">
				<p style="margin:5px;margin-left:20px;font-size:18px;font-weight:bold"><%= tasks.getString(6)%></p>
			</div>
			
			<%}%>
			<paper-material elevation="1" class="tasks">
				<p class="company">
					<b>
						<%= tasks.getString(1)%>
					</b>
				</p>
				<p class="company">
					<%= tasks.getString(2)%>,<%= tasks.getString(3)%>
				</p>
				<p class="company">
					<%= tasks.getString(4)%>
				</p>
				<br>
				<p>
					<%= Tasktype%>
				</p>
				<p>
					<%= SubType%>
				</p>
            	<p>
            		<%= tasks.getString(6)%> <%= tasks.getString(7)%>
            	</p>
            	<p>
            		<%= tasks.getString(8)%> <%= tasks.getString(9)%>
            	</p>
            	<p>
            		<%= tasks.getString(10)%>
            	</p>
            	<br />
            	<p class="company">
            		<%= tasks.getString(11)%>
            	</p>
            	<paper-icon-button class="tasksPopUpButton" icon="vaadin-icons:external-link" onClick="taskPopUp(<%= tasks.getString(12)%>)"></paper-icon-button>
			</paper-material>
		<%}%>
	<%}else{%>
		<paper-material style="width:90%;height:50px;margin:auto !important; background-color:#fafafa;line-height:50px;vertical-align:middle; font-size:18px;color:#51ccdb;margin-top:75px !important; border-radius:3px;" elevation="2">
			<center>
				No Records Found!!
				<paper-icon-button title="Clear Filters" style="margin-top:0px !important" icon="clear" noink id="ClearFilter" onclick="clearAllFilter()"></paper-icon-button>
			</center>
		</paper-material>
	<%}%>

		<br>
		<br>
	</div>
</div>

<div id="TaskPopUpContainer">
</div>

<script>
	
	$(".tasks").hover(function() {
		$(this).prop('elevation', 3);
	}, function() {
		$(this).prop('elevation', 1);
	});

	function taskPopUp(Task_id){
		$.ajax({
			url: 'TaskPopUp.jsp?TaskId='+Task_id,
			type: 'GET',
			dataType: 'html',
		})
		.done(function(data) {
			$('#TaskPopUpContainer').html(data).show();
		});
	}

	$("#Sort").click(function(){
		$("#SortMenu").toggle();
	});

</script>

<%
	st.close();
	con.close();
%>
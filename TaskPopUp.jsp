<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>
<link rel="import" href="bower_components/paper-material/paper-material.html">
<link rel="import" href="bower_components/paper-button/paper-button.html">
<style>
	#TaskPopUp{
		width: 620px;
		height: 420px;
		padding: 10px;
		background-color:#FFF;
		position: fixed;
		top: 50%;
		margin-top:-220px;
		left: 50%;
		margin-left:-320px;
		font-size: 13px;
	}
	#TaskPopUp div{
		width:270px;
		height:100%;
		margin:10px;
		padding:10px;
		float:left;
	}
	#TaskPopUp p{
		margin:0px;
		padding: 0px;
		margin-left: 20px;
	}
	#TaskPopUp div p{
		margin-left:0px;
		margin-bottom:3px;
	}
	#CloseButton{
		position:fixed;
		top:50%;
		margin-top:-227px;
		left: 50%;
		margin-left:287px;
	}
	#TaskPopUp paper-icon-button:hover{
		color: #900;
	}

	#ImageContainer{
		width: 640px;
		height:460px;
		position: fixed;
		top: 50%;
		margin-top:-220px;
		left: 50%;
		margin-left:-320px;
		font-size: 13px;
		background-size: 100%;
    	background-repeat: no-repeat;
    	display:none;
	}

	#CloseImageButton{
		position:absolute;
		top:5px;
		right:5px;
		color:#900;
		cursor:pointer;
	}
</style>

<%
	String TaskId = request.getParameter("TaskId");
	ResultSet tasks = st.executeQuery("SELECT customers.company_name,customers.customer_name,customers.address,customers.area,customers.city,customers.contact,customers.email,employees.first_name,employees.last_name,employees.contact,employees.email,tasks.scheduled_date,tasks.scheduled_time,tasks.status,task_types.name,tasks.start_time,tasks.end_time,tasks.URL,tasks.comments,tasks.reading,tasks.payment_collected,tasks.description FROM tasks inner join customers inner join task_types inner join employees on tasks.customer_id = customers.customer_id && tasks.employee_id = employees.employee_id && tasks.task_type_id = task_types.task_type_id where tasks.Task_Id="+TaskId);

	tasks.next();
%>

<paper-material id="TaskPopUp" elevation="4">
	<div>
		<p>
			<b style="font-size: 22px; color: #51ccdb">
				<%= tasks.getString(1)%>
			</b>
		</p>
		<p style="font-size: 16px;">
				<b><%= tasks.getString(2)%></b>
		</p>
		<p><b>ADD:</b><%= tasks.getString(3)%>, <%= tasks.getString(4)%>, <%= tasks.getString(5)%></p>
		<p><b>NO:</b><%= tasks.getString(6)%></p>
		<p><b>EMAIL:</b><%= tasks.getString(7)%></p>
		<br/>
		<p style="margin-bottom: 16px;">
			<b style="font-size: 16px">
				<%= tasks.getString(8)%> <%=tasks.getString(9)%>
			</b>
		</p>
		<p><b>NO:</b><%= tasks.getString(10)%></p>
		<p><b>EMAIL:</b><%= tasks.getString(11)%></p>
		<p><b>SCHEDULED TIME:</b><%= tasks.getString(12)%>, <%= tasks.getString(13)%></p>
		<p><b style="font-size: 16px"><%= tasks.getString(14)%></b></p>
		<p>
			<b>
				Task Type:
			</b>
			<%= tasks.getString(15)%>
		</p>
	</div>
	<div>
		<p>
			<b>
				Task Description:
			</b><br>
			<%= tasks.getString(22)%>
		</p>
		<p>
			<b>
				Time Started:
			</b>
			<%= tasks.getString(16)%>
		</p>
		<p>
			<b>
				Time Completed:
			</b>
			<%= tasks.getString(17)%>
		</p>
		<p>
			<b>
				Meter Reading:			
			</b>
			<%= tasks.getString(20)%>
		</p>
		<p>
			<b>
				Payment Collection:			
			</b>
			<%= tasks.getString(21)%>
		</p>
		
		<p>
			<b>
				Comments:
			</b><br>
			<%= tasks.getString(19)%>
		</p>
		<br/>
		<%if(tasks.getString(18)!=null){%>
		<img src="Images/Task_Details/<%= tasks.getString(18)%>" alt="No image Available" width="250" onClick="openImage('Images/Task_Details/<%= tasks.getString(18)%>')" style="cursor: pointer;">
		<%}%>
	</div>

	<paper-icon-button icon="icons:close" onClick="closePopUp()" id="CloseButton" noink></paper-icon-button>
</paper-material>

<div id="ImageContainer">
	<paper-icon-button icon="icons:close" onClick="closeImage()" id="CloseImageButton" noink></paper-icon-button>
</div>


<script>
	function closePopUp(){
		$('#TaskPopUpContainer').hide();
	}

	function openImage(src){
		$("#ImageContainer").css('background-image', 'url('+src+')');
		$("#ImageContainer").show();
	}

	function closeImage(){
		$("#ImageContainer").hide();
	}
</script>
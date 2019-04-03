<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<%@ include file="DBConnect.jsp" %>

<%
	ResultSet EmployeeList = st.executeQuery("select * from employees");
%>

	<script src="bower_components/platform/platform.js"></script>
	<script src="bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>
		<link rel="import" href="bower_components/iron-form/iron-form.html">


<style>
	#Employees{
		width:660px;
		margin:auto;
	}
	
	@media screen and (min-width: 1330px) {
	    #Employees{
	        width:880px;
	    }
	}

	@media screen and (min-width: 1550px) {
	    #Employees{
	        width:1100px;
	    }
	}

	.emps{
		height:250px;
		width:90%;
		padding:5px;
		padding-left:25px;
		padding-right:25px;
		margin:auto;
		margin-top:20px;
		background-color:#fafafa;
	}

	legend{
		color: #51ccdb;
		font-size: 18px;
		font-weight: bold;
		margin-top:10px;
	}
	.emps p{
		margin-top:5px;
	}
	#Ename{
		width:100%;
		height:20px;
	}
	.Edetails{
		width:50%;
		height:200px;
		float:left;
	}
	#Ename paper-icon-button{
		padding: 0px;
		width: 24px;
		color: #999;
	}
	#Ename paper-icon-button:hover{
		color: #900;
	}
	#EmployeeEdit{
		position: absolute;
		top: 0px;
		right: 0px;
		margin-top: 3px;
		margin-right: 3px;
		padding: 0px;
	}
	#EditEmployeeDialog{
		width: 130px;
		height: 70px;
		position: absolute;
		top: 0px;
		right: 0px;
		margin-top: 33px;
		margin-right: 7px;
		display: none;
		font-size: 10px;
	}
	

</style>

<div style="width:100%">
	<div id="Employees">
		<br>
		<% while(EmployeeList.next()){%>
			<paper-material id="Emp<%= EmployeeList.getString(1)%>" elevation="2" class="emps">
				<div id="Ename">
					<legend>
						<%= EmployeeList.getString(2)%> <%= EmployeeList.getString(3)%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<paper-icon-button icon="vaadin-icons:map-marker" noink onClick="loadEmployeeMap(<%= EmployeeList.getString(1)%>)"></paper-icon-button>

						<!--<paper-icon-button id="EmployeeEdit" icon="icons:more-vert" onClick="loadEmployeeEditMenu()"></paper-icon-button>-->

						<paper-menu-button id="EmployeeEdit" horizontal-Align="right" vertical-Offset="35">
							<paper-icon-button icon="icons:more-vert" noink class="dropdown-trigger"></paper-icon-button>
							<paper-menu class="dropdown-content">
						    	<paper-item onClick='loadEditContact(<%= EmployeeList.getString(1)%>,"<%= EmployeeList.getString(6)%>","<%= EmployeeList.getString(7)%>","<%= EmployeeList.getString(8)%>","<%= EmployeeList.getString(9)%>","<%= EmployeeList.getString(10)%>")'>Edit Contact</paper-item>
						    	<paper-item onClick="loadDeleteIMEI(<%= EmployeeList.getString(1)%>)">Delete IMEI</paper-item>
						    	<paper-item onClick="loadDeactivate
						    	(<%= EmployeeList.getString(1)%>)">Deactivate</paper-item>
						    	<paper-item onClick="employeePopUp(<%= EmployeeList.getString(1)%>)">Gallery</paper-item>
							</paper-menu>
						</paper-menu-button>
					</legend>
					
					<paper-material elevation="3" class="editMsgs" id="sDeleteMsg" style="width: 220px; right: calc(50% - 110px); color: #090;">DELETED IMEI SUCCESSFULLY!!!</paper-material>
					<paper-material elevation="3" class="editMsgs" id="fDeleteMsg" style="width: 400px; right: calc(50% - 200px); color: #900;">ERR!!! SOMETHING WENT WRONG! PLEASE TRY AGAIN!</paper-material>
					<paper-material elevation="3" class="editMsgs" id="sDeactivateMsg" style="width: 200px; right: calc(50% - 100px); color: #090;">EMPLOYEE DEACTIVATED!!!</paper-material>
					<paper-material elevation="3" class="editMsgs" id="fDeactivateMsg" style="width: 400px; right: calc(50% - 200px); color: #900;">ERR!!! SOMETHING WENT WRONG! PLEASE TRY AGAIN!</paper-material>
					

				</div>
				<br>
				<div class="Edetails">
					<p>
						<%= EmployeeList.getString(6)%>, <%= EmployeeList.getString(7)%>, <%= EmployeeList.getString(8)%>
					</p>
					<p>
	            		<b>
	            			DOB:
	            		</b>
	            		<%= EmployeeList.getString(4)%>
	            	</p>
	            	<p>
	            		<b>
	            			Contact:
	            		</b>
	            		<%= EmployeeList.getString(9)%>
	            	</p>
	            	<p>
	            		<b>
	            			E-Mail:
	            		</b>
	            		<%= EmployeeList.getString(10)%>
	            	</p>
	            	<p>
	            		<b>
	            			Department:
	            		</b> 
	            		<%= EmployeeList.getString(5)%>
	            	</p>
	            </div>
	            <div class="Edetails">
	            	<p>
	            		<b>
	            			Task Completed in Last Month :
	            		</b> 45 
	            	</p>
	            	<p>
	            		<b>
	            			Tasks this week : 
	            		</b> 14 
	            	</p>
	            	<p>
	            		<b>
	            			Monthly Allowance : 
	            		</b> 2000 
	            	</p>
	            </div>
			</paper-material>
		<%}%>
		<br>
		<br>
	</div>
</div>	

<div id="EmployeePopUpContainer" style="display:none">
</div>

<script type="text/javascript">
	function loadEmployeeMap(id){
		loadMap();
		var map = document.querySelector('google-map');

		map.addEventListener('google-map-ready', function(e) {
	    	employeeMarker(id);
	  	});
	}

	function loadEmployeeEditMenu()
	{
		$('#EditEmployeeDialog').toggle(100);
	}


	function employeePopUp(Employee_id){
		$.ajax({
			url: 'EmployeePopUp.jsp?EmployeeId='+Employee_id,
			type: 'GET',
			dataType: 'html',
		})
		.done(function(data) {
			$('#EmployeePopUpContainer').html(data).show();
		});
	}	

	function loadDeleteIMEI(id)
	{
		$.ajax({
			url: 'deleteIMEI.jsp?empId='+id,
			type: 'GET',
			dataType: 'html',
			success: function(Data){	
				$("#sDeleteMsg").fadeIn().fadeOut(2500);
			},
			error: function(){
				$("#fDeleteMsg").fadeIn().fadeOut(2500);
			}
		});
	}

	function loadDeactivate(id)
	{
		$.ajax({
			url: 'deactivate.jsp?empId='+id,
			type: 'GET',
			dataType: 'html',
			success: function(Data){	
				$("#sDeactivateMsg").fadeIn().fadeOut(2500);
			},
			error: function(){
				$("#fDeactivateMsg").fadeIn().fadeOut(2500);
			}
		});
	}
</script>
<script src="JS/jquery-ui.js"></script>
<script src="JS/jquery-2.2.2.min.js"></script>

<%
	st.close();
	con.close();
%>
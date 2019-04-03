<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>MacGray</title>

	<!-- Link Polymer elements -->
	<script src="bower_components/platform/platform.js" async="async"></script>
	<script src="bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>
	<link rel="import" href="bower_components/vaadin-icons/vaadin-icons.html" />
	<link rel="import" href="bower_components/iron-icon/iron-icon.html">
	<link rel="import" href="bower_components/paper-material/paper-material.html">
	<link rel="import" href="bower_components/paper-dropdown-menu/paper-dropdown-menu.html">
	<link rel="import" href="bower_components/paper-button/paper-button.html">
	<link rel="import" href="bower_components/paper-menu/paper-menu.html">
	<link rel="import" href="bower_components/paper-item/paper-item.html">
	<link rel="import" href="bower_components/paper-input/paper-textarea.html">
	<link rel="import" href="bower_components/paper-input/paper-input.html">
	<link rel="import" href="bower_components/paper-fab/paper-fab.html">
	<link rel="import" href="bower_components/iron-icon/iron-icon.html">
	<link rel="import" href="bower_components/iron-form/iron-form.html">
	<link rel="import" href="bower_components/paper-icon-button/paper-icon-button.html">
	<link rel="import" href="bower_components/paper-spinner/paper-spinner.html">
	<link rel="import" href="bower_components/google-map/google-map.html">
	<link rel="import" href="bower_components/gold-email-input/gold-email-input.html">

	<!-- Link Polymer elements -->

	<!-- Link Roboto Fonts -->

	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,300italic,400italic,500,500italic,700,700italic">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,700">
	<!-- Link Roboto Fonts -->

	<link rel="stylesheet" href="bower_components/angular-material/angular-material.css" />
	<link rel="stylesheet" href="CSS/main.css" />

	<!-- Add Scripts -->

	<script src="JS/jquery-2.2.2.min.js"></script>
	<script src="JS/jquery-ui-1.11.4/jquery-ui.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript"
  src="https://maps.googleapis.com/maps/api/js?sensor=false">
  </script>



	<!-- Polymer Custom Styles -->
	<style is="custom-style">
		paper-dropdown-menu {
			--paper-input-container-input:{
	  			font-size:14px;
    		};
		}

		#EmployeeMenu paper-menu{
			--paper-menu-selected-item:{
				color:#51ccbd !important;
			};
		}

		#MapsMenu paper-menu{
			--paper-menu-selected-item:{
				color:#51ccbd !important;
			};
		}

		#FilterEmployeeMenu paper-menu{
			--paper-menu-selected-item:{
				font-weight: normal;
				background-color:#eee;
			};
		}
	</style>
	<!-- Polymer Custom Styles -->
	<%@ include file="DBConnect.jsp"%>
</head>
<body ng-app="MacGray">
	<div ng-controller="AngController"></div>

	<!-- angular scripts -->
	<script src="bower_components/angular/angular.js" ></script>
    <script src="bower_components/angular-aria/angular-aria.js" ></script>
    <script src="bower_components/angular-animate/angular-animate.js" ></script>
    <script src="bower_components/angular-material/angular-material.js" ></script>
    <script>
    	angular.module('MacGray', ['ngMaterial']);
    </script>
	<!-- angular scripts -->

	<!-- Left Navigation Bar -->
	<paper-material elevation="4" id="LeftNavigationBar">
		<div id="LogoBackground">
			<img src="Images/Logo.png" alt="" id="logo" />
		</div>
		<paper-menu>
			<paper-item onClick="clearAllFilters()">
				<iron-icon icon="vaadin-icons:lines-list"></iron-icon>
				Tasks
			</paper-item>
			<paper-item onClick="loadMap()">
				<iron-icon icon="vaadin-icons:map-marker"></iron-icon>
				Locate
			</paper-item>
			<paper-item onClick="loadEmployee()">
				<iron-icon icon="vaadin-icons:user-card"></iron-icon>
				Employee
			</paper-item>

			<hr color="#555"/>

			<paper-item onClick="loadAddTask()">
				<iron-icon icon="vaadin-icons:plus"></iron-icon>
				Add Task
			</paper-item>
			<paper-item onClick="loadChangePassword()">
				<iron-icon icon="vaadin-icons:safe-lock"></iron-icon>
				Change Password
			</paper-item>
			<paper-item onClick="logout()">
				<iron-icon icon="vaadin-icons:power-off"></iron-icon>
				Logout
			</paper-item>
		</paper-menu>
	</paper-material>
	<!-- Left Navigation Bar -->
	
	<!-- Task Menu -->
	<paper-material id="TaskMenu" elevation="4">
	<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-d");
	%>
		<input type="hidden" id="FD" defaultVal="<%=sdf.format(new java.util.Date())%>" value="<%=sdf.format(new java.util.Date())%>">
		<input type="hidden" id="FD2" defaultVal="<%=sdf.format(new java.util.Date())%>" value="<%=sdf.format(new java.util.Date())%>">
		<input type="hidden" id="FE" defaultVal="NA" value="NA">
		<input type="hidden" id="FEN" defaultVal="NA" value="NA">
		<input type="hidden" id="FT" defaultVal="NA" value="NA">
		<input type="hidden" id="FS" defaultVal="NA" value="NA">
		<div style="display:inline-block">
			<p>Filter Tasks</p>
			<paper-dropdown-menu label="Filter By" id="FilterBy">
				<paper-menu id="FilterTask" class="dropdown-content" selected="0">
					<paper-item class="filterItem">Date</paper-item>
					<paper-item class="filterItem">Employee</paper-item>
					<paper-item class="filterItem">Task Type</paper-item>
					<paper-item class="filterItem">Status</paper-item>
				</paper-menu>
			</paper-dropdown-menu>
		</div>
		<paper-icon-button icon="clear" noink style="" id="ClearFilter" onclick="clearAllFilters()"></paper-icon-button>

		<div id="DateFilterContents">
			<paper-dropdown-menu label="Select date filter" id="DateFilter" style="margin-bottom:50px">
					<paper-menu id="FilterTaskDate" class="dropdown-content" selected="2">
						<paper-item class="dateFilterItem" onclick = "selectDate(-30)">Last 30 Days</paper-item>
						<paper-item class="dateFilterItem" onclick = "selectDate(-7)">Last Week</paper-item>
						<paper-item class="dateFilterItem" onclick = "selectDate(0)">Today</paper-item>
						<paper-item class="dateFilterItem" onclick = "selectDate(7)">Next Week</paper-item>
						<paper-item class="dateFilterItem" onclick = "selectDate(30)">Next 30 Days</paper-item>
						<paper-item class="dateFilterItem" onclick = "showDatePicker(1)">Select Specific Date</paper-item>
						<paper-item class="dateFilterItem" onclick = "showDatePicker(2)">Select Range</paper-item>
					</paper-menu>
				</paper-dropdown-menu>
			<div id="DatePickerCurrDate" style="display:none">
				<p>Date:</p>
				<div id="DatePickerCurr" ng-controller="AngController" ng-cloak >
					<md-content>
						<md-datepicker ng-model="myDate" md-placeholder="SelectDate" id="TasksDatePicker" ng-change="selectSingleDate()">
						</md-datepicker>
					</md-content>
				</div>
			</div>

			<div id="DatePickerFromDate" style="display:none">
				<p>From:</p>
				<div id="DatePickerFrom" ng-controller="AngController" ng-cloak >
					<md-content>
						<md-datepicker ng-model="myDate" md-placeholder="SelectDate" id="TasksDatePicker" ng-change="selectFromDate()">
						</md-datepicker>
					</md-content>
				</div>
			</div>

			<div id="DatePickerToDate" style="display:none">	
				<p>To:</p>
				<div id="DatePickerTo" ng-controller="AngController" ng-cloak >
					<md-content>
						<md-datepicker ng-model="myDate" md-placeholder="SelectDate" id="TasksDatePicker" ng-change="selectToDate()">
						</md-datepicker>
					</md-content>
				</div>
				<paper-button raised id="DateFilterButton" onClick="swapDatesIfRequired()"> OK </paper-button>
			</div>
		</div>

		<div id="TasksMenuContent">
		</div>
	</paper-material>
	<!-- Task Menu -->

	<!-- Maps Menu -->
		<%ResultSet EmployeeList = st.executeQuery("Select * from employees where status!='Inactive' order by first_name");%>
		<paper-material id="MapsMenu" elevation="4">
		<div>
			<p>Employee</p>
		</div>
		<paper-input id="SearchMapEmployee" label="Filter Employee" onkeyup="filterMapEmployees()"></paper-input>
		<paper-menu id="MapsMenuList">
			<% while(EmployeeList.next()){%>
				<paper-material elevation="1" EmpName="<%= EmployeeList.getString(2)%> <%= EmployeeList.getString(3)%> <%= EmployeeList.getString(9)%>" onClick="employeeMarker(<%= EmployeeList.getString(1)%>)" class="mapemployees">
					<b><%= EmployeeList.getString(2)%> <%= EmployeeList.getString(3)%></b><br>
					<%= EmployeeList.getString(9)%>
	 			</paper-material>
			<%}%>
		</paper-menu>
	</paper-material>
	<% EmployeeList.close();%>
	<!-- Maps Menu -->

	<!-- Employee Menu -->
	<%ResultSet EmpList = st.executeQuery("Select * from employees order by first_name");%>
	<paper-material id="EmployeeMenu" elevation="4">
		<div>
			<p>Employee</p>
		</div>
		<paper-input id="SearchEmployee" label="Filter Employee" onkeyup="filterMenuEmployees()"></paper-input>
		<paper-menu id="EmployeeMenuList">
			<% 
				while(EmpList.next()){
			%>
				<paper-material elevation="1" EmpName="<%= EmpList.getString(2)%> <%= EmpList.getString(3)%> <%= EmpList.getString(9)%>" onClick="scrollEmployee(<%= EmpList.getString(1)%>)" class="menuemployees">
					<b><%= EmpList.getString(2)%> <%= EmpList.getString(3)%></b><br>
					<%= EmpList.getString(9)%>
	 			</paper-material>
			<%}%>
		</paper-menu>
		<hr color="#ddd"> 
		<paper-button raised id="AddEmployeeButton" onClick="showAddEmployeeDialog()">
			 Add Employee
		</paper-button>
	</paper-material>
	<% EmpList.close();%>
	<!-- Employee Menu -->

	<!-- Edit Employee Contact -->
	<paper-material elevation="3" id="EditContact">
			<form is="iron-form" id="EditEmployeeForm" method="post" action="editEmployee.jsp">	
					<center>
						<h3 style="color: #51ccdb">Edit Employee</h3>
					</center>
				<input type="hidden" name="EmployeeId" id="EmployeeId">
				<paper-input label="Address" id="Eadd" name="Eadd" required></paper-input>
				<paper-input label="Area" id="Earea" name="Earea" required></paper-input>
				<paper-input label="City" id="Ecity" name="Ecity" required></paper-input>
				<paper-input label="Contact" id="Econ" name="Econ" required maxlength="10" minlength="10" auto-validate pattern="[0-9]*" error-message="Please enter valid Contact Number" prevent-invalid-input></paper-input>
				<gold-email-input id="Eemail" label="Email" name="Eemail" auto-validate error-message="Please enter valid Email Address" required></gold-email-input>
				<center>
					<div class="editButtons">
						<paper-fab icon="check" onClick='editEmployee()' style="background-color:#51ccdb"></paper-fab>
					</div>
					<div class="editButtons">
						<paper-fab icon="close" onClick='closeEditContact()' style="background-color:#900"></paper-fab>
					</div>
				</center>
			</form>	
	</paper-material>
	<!-- Edit Employee Contact -->

	<!-- Add Employee Dialog -->
	<form is="iron-form" id="AddEmployeeForm" method="post" action="AddEmployee.jsp">
	<paper-material elevation="3" id="AddEmployeeDialog">
		<center>
			<h1>Add Employee</h1>
		</center>
		<paper-input label="First Name" name="EFN" required></paper-input>
		<paper-input label="Last Name" name="ELN" required></paper-input>
		<paper-dropdown-menu label="Department" noink name="ED" required>
			<paper-menu class="dropdown-content">
				<paper-item>Service</paper-item>
				<paper-item>Sales</paper-item>
			</paper-menu>
		</paper-dropdown-menu>
		<paper-input label="Date Of Birth" name="EDOB" type="Date" required></paper-input>
		<paper-input label="Address" name="EAD" required></paper-input>
		<paper-input label="Area" name="EA" required></paper-input>
		<paper-input label="City" name="ECT" required></paper-input>
		<paper-input label="Contact" name="ECON" required maxlength="10" minlength="10" auto-validate pattern="[0-9]*" error-message="Please enter valid Contact Number" prevent-invalid-input></paper-input>
		<gold-email-input label="Email" name="EEM" auto-validate error-message="Please enter valid Email Address" required></gold-email-input>
		<center>
			<div class="CPButtons">
				<paper-fab icon="check" onClick='addEmployee()' style="background-color:#51ccdb"></paper-fab>
			</div>
			<div class="CPButtons">
				<paper-fab icon="close" onClick='closeAddEmployeeDialog()' style="background-color:#900"></paper-fab>
			</div>
		</center>
	</paper-material>
	<div class="output"></div>
	</form>
	<!-- Add Employee Dialog -->

	<!-- Add Task Menu -->
	<form is="iron-form" id="AddTaskForm" method="get" action="AddTask.jsp">

	<paper-material id="AddTaskMenu" elevation="4">
		<div>
			<p>Add Task</p>
		</div>
		<div id="AddTaskP1">
		<input type="hidden" name="CustomerID" id="CustomerID" />
		<paper-input id="CustomerName" label="Customer Name" list="customers" onChange="customerChanged()"></paper-input>
		<%ResultSet CustomerList = st.executeQuery("Select * from customers");%>
		<datalist id="customers">
			<%while(CustomerList.next()){%>
				<option CustomerId="<%= CustomerList.getString(1)%>" value="<%= CustomerList.getString(2)%>,<%= CustomerList.getString(5)%>,<%= CustomerList.getString(6)%>"></option>
			<%}%>
		</datalist>
		<% CustomerList.close();%>
		<br />
		
		<paper-dropdown-menu label="Machine Type" id="MachineType" disabled>
			<paper-menu class="dropdown-content" >
				<paper-item class="addTaskDropdownItems" label="Copier1">Copier</paper-item>
				<paper-item class="addTaskDropdownItems" label="Vending1">Vending</paper-item>
			</paper-menu>
		</paper-dropdown-menu>
		<br />

		<input type="hidden" name="TaskTypeID" id="TaskTypeID"/>
		<div id="TaskTypeContainer">
		<paper-dropdown-menu id="TaskType" label="Task Type" class="addTaskDropdown" disabled>
			<paper-menu class="dropdown-content" >
			</paper-menu>
		</paper-dropdown-menu>
		</div>
		<br />

		
		<div id="SubTypeContainer" style="display:none;">
		<paper-dropdown-menu id="SubType" label="Sub Type" class="addTaskDropdown" disabled>
  			<paper-menu class="dropdown-content" >
  			</paper-menu>
		</paper-dropdown-menu>
		</div>
		<br/>
		
		<input type="hidden" name="ATEM" id="ATEM"/>
		<div id="EmployeeContainer">
		<paper-dropdown-menu id="Employee" label="Employee" class="addTaskDropdown" disabled>
  			<paper-menu class="dropdown-content" selected="0">
  			</paper-menu>
		</paper-dropdown-menu>
		</div>
		<br>

		<input type="hidden" id="ATDP" name="ATDP" value="<%=sdf.format(new java.util.Date())%>">
		<div ng-controller="AngController" ng-cloak id="AddTaskDatePicker">
			<md-content>
				<md-datepicker id="employeeDates" ng-model="myDate" md-placeholder="Select Date" md-date-filter="disableDates" ng-change="employeeDateChanged()">
				</md-datepicker>
			</md-content>
		</div>
		
		<div>
		<paper-dropdown-menu id="Time" name="ATTD" label="Time" disabled>
  			<paper-menu class="dropdown-content" selected="-1">
  				<paper-item>09:00</paper-item>
  				<paper-item>10:00</paper-item>
  				<paper-item>11:00</paper-item>
  				<paper-item>12:00</paper-item>
  				<paper-item>13:00</paper-item>
  				<paper-item>14:00</paper-item>
  				<paper-item>15:00</paper-item>
  				<paper-item>16:00</paper-item>
  				<paper-item>17:00</paper-item>
  			</paper-menu>
		</paper-dropdown-menu>
		</div>
		<br/>

		<div class="buttons">
			<paper-button raised id="NextButton" onClick="addTaskNextPage()" disabled>Next</paper-button>
		</div>
		<div class="buttons">
			<paper-button raised id="CancelButton" onClick="hideAddTaskMenu()">
				<iron-icon icon="close"></iron-icon>
			</paper-button>
		</div>
		</div>
		<div id="AddTaskP2" style="display:none">
		<br><br>
			<div id="AddTaskP1Details">
				<b><p id="ATCN"></p></b>
				<p id="ATCA"></p>
				<p id="ATMT"></p>
				<p id="ATTT"></p>
				<p id="ATST"></p>
				<p id="ATEN"></p>
				<p id="ATDT"><%=sdf.format(new java.util.Date())%></p>
			</div>
			<br>
			<paper-textarea id="Description" name="ATD" label="Description" max-rows="10"></paper-textarea>

			<div class="buttons">
				<paper-button raised id="ConfirmButton" onClick="addNewTask()">Confirm</paper-button>
			</div>
			<div class="buttons">
				<paper-button raised id="BackButton" onClick="addTaskPrevPage()">
					<iron-icon icon="arrow-back"></iron-icon>
				</paper-button>
			</div>
			
		</div>
		
	</paper-material>	
	</form>
	<!-- Add Task Menu -->

	<!-- Add Customer Dialog -->
	<form is="iron-form" id="AddCustomerForm" method="post" action="AddCustomer.jsp">
	<paper-material elevation="3" id="AddCustomerDialog">
		<center>
			<h1>Add Customer</h1>
		</center>
		<input type="hidden" id="CLat" name="Latitude">
		<input type="hidden" id="CLong" name="Longitude">
		<paper-input label="Company Name" id="CompanyName" name="CompanyName" required></paper-input>
		<paper-input label="Customer Name" name="CustomerName" required></paper-input>
		<paper-input label="Address" name="Address" required></paper-input>
		<paper-input label="Area" name="Area" id="CArea" required></paper-input>
		<paper-input label="City" name="City" id="CCity" required></paper-input>
		<paper-input label="Contact" name="Contact" required required maxlength="10" minlength="10" auto-validate pattern="[0-9]*" error-message="Please enter valid Contact Number"></paper-input>
		<gold-email-input label="Email" name="Email" required auto-validate error-message="Please enter valid Email Address"></gold-email-input>
		<center>
			<div class="CPButtons">
				<paper-fab icon="check" onClick='addCustomer()' style="background-color:#51ccdb"></paper-fab>
			</div>
			<div class="CPButtons">
				<paper-fab icon="close" onClick='closeAddCustomerDialog()' style="background-color:#900"></paper-fab>
			</div>
		</center>
	</paper-material>
	</form>
	<!-- Add Customer Dialog -->

	<!-- Change Password Dialog -->
	<paper-material elevation="3" id="ChangePasswordDialog">
		<center>
			<h1>Change Password</h1>
			<p id="Message">Please Enter Details</p>
			<paper-input id="OP" label="Old Password" type="password"></paper-input>
			<paper-input id="NP" label="New Password" type="password"></paper-input>
			<paper-input id="RP" label="Retype Password" type="password"></paper-input>		

			<div class="CPButtons"><paper-fab icon="check" onClick='changePassword()' style="background-color:#51ccdb"></paper-fab></div>
			<div class="CPButtons"><paper-fab icon="close" onClick='cancelChangePassword()' style="background-color:#900"></paper-fab></div>
		</center>
	</paper-material>
	<!-- Change Password Dialog -->

	<!-- Content -->
	<div id="Content"></div>
	<!-- Content -->
	<script src="JS/script.js"></script>

</body>
</html>

<%
	st.close();
	con.close();
%>
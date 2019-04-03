// Initial Scripts
$(document).ready(function() {
	loadTask();
	var src = location.search.split('src=')[1]
	if(src == "addemployee"){
		loadEmployee();
	}
});

// document.onkeydown = function(evt) {
//     evt = evt || window.event;
//     if (evt.keyCode == 27) { 
//     }
// }; On Esc Pressed

// Initial Scripts


//Task Menu Scripts
var selectedDate="";
angular.module('MacGray',['ngMaterial']).controller('AngController', function($scope){
	$scope.myDate = new Date();
	var DisabledDates = "'2016-03-26','2016-03-12'";


	$scope.disableDates = function(date){
		return !DisabledDates.includes(getFormattedDate(date));
	}
	$scope.dateChanged = function(date){
		//alert("date");
		$("#FD").val(getFormattedDateWOQ($scope.myDate));
		loadTask();
	}
	$scope.selectSingleDate = function(date){
		//alert("date");
		$("#FD").val(getFormattedDateWOQ($scope.myDate));
		$("#FD2").val(getFormattedDateWOQ($scope.myDate));
		swapDatesIfRequired();
	}
	$scope.selectFromDate = function(date){
		//alert("date");
		$("#FD").val(getFormattedDateWOQ($scope.myDate));
	}
	$scope.selectToDate = function(date){
		//alert("date");
		$("#FD2").val(getFormattedDateWOQ($scope.myDate));
	}

	$scope.employeeDateChanged = function(date){
		$("#ATDT").html(getFormattedDateWOQ($scope.myDate));
		$("#ATDP").val(getFormattedDateWOQ($scope.myDate));
	}
});

$('.filterItem').on('click', function(event) {
	var FilterBy = $(this).html().trim();
	if (FilterBy == "Date") {
		$("#TasksMenuContent").html("");
		$("#DateFilterContents").show();

	}else{
		$("#DateFilterContents").hide();
		$.ajax({
			url: 'filterTask.jsp?filterby='+FilterBy,
			type: 'GET',
			dataType: 'html',
			success: function(Data){
				$("#TasksMenuContent").html(Data);
			}
		});
	}
});

function selectDate(change){

	$("#DatePickerCurrDate").hide();
	$("#DatePickerFromDate").hide();
	$("#DatePickerToDate").hide();
	var d = new Date();
	$("#FD").val(getFormattedDateWOQ(d));
	d.setDate(d.getDate()+change);
	$("#FD2").val(getFormattedDateWOQ(d));
	swapDatesIfRequired();
}

function setToday(){
	$("#FilterTaskDate").prop('selected', '2');
}

function showDatePicker(n){
	if(n=='1'){
		$("#DatePickerFromDate").hide();
		$("#DatePickerToDate").hide();
		$("#DatePickerCurrDate").show();
	}else{
		$("#DatePickerCurrDate").hide();
		$("#DatePickerFromDate").show();
		$("#DatePickerToDate").show();
	}
}

function swapDatesIfRequired(){
	var d1 = new Date($("#FD").val());
	var d2 = new Date($("#FD2").val());

	if(d1>d2){
		$("#FD").val(getFormattedDateWOQ(d2));
		$("#FD2").val(getFormattedDateWOQ(d1));
	}

	loadTask();
}
function filterTaskMenuEmployees(){
	var SearchString = $("#FilterEmployee").val().trim().toLowerCase();
	var $array = $(".filteremployees");
	$array.each(function(index, el) {
		if($(this).attr("EmpName").toLowerCase().includes(SearchString)){
			$(this).stop().slideDown(700);
		}else{
			$(this).stop().slideUp(700);
		}
	});

}


$("#TasksDatePicker").on('change', function() {
	alert("Date Changed");
	loadTask();
});

function dateChanged(){
	alert("Date Changed");
}

function addEmployeeFilter(value,empname){
	$("#FE").val(value);
	$("#FEN").val(empname);
	loadTask();
}
function addTaskTypeFilter(value){
	$("#FT").val(value);
	loadTask();
}
function addStatusFilter(value){
	$("#FS").val(value);
	loadTask();
}

function removeTag(filt){
	$("#"+filt).val($("#"+filt).attr('defaultVal'));
	loadTask();
}

function clearAllFilters(){
	$("#FE").val($("#FE").attr('defaultVal'));
	$("#FD").val($("#FD").attr('defaultVal'));
	$("#FD2").val($("#FD2").attr('defaultVal'));
	$("#FT").val($("#FT").attr('defaultVal'));
	$("#FS").val($("#FS").attr('defaultVal'));
	$("#DatePickerCurrDate").hide();
	$("#DatePickerFromDate").hide();
	$("#DatePickerToDate").hide();
	setToday();
	loadTask();
}


//Task Menu Scripts


// Left Navigation Bar Scripts
function logout(){
	window.location.replace("Logout.jsp");
}

function loadTask(){
	$("#EmployeeMenu").hide();
	$("#AddTaskMenu").hide();
	$("#MapsMenu").hide();
	$("#TasksMenu").show();

	var fd = $("#FD").val();
	var fdt = $("#FD2").val();
	var fe = $("#FE").val();
	var fen = $("#FEN").val();
	var ft = $("#FT").val();
	var fs = $("#FS").val();
	var fddef = $("#FD").attr('defaultVal');
	$.ajax({
		url: 'taskContent.jsp?FD='+fd+'&FDT='+fdt+'&FE='+fe+'&FT='+ft+'&FS='+fs+'&FEN='+fen+'&FDDef='+fddef,
		type: 'GET',
		dataType: 'html',
		success: function(Data){
			$("#Content").html(Data);
		}
	});
}

function loadMap(){
	$("#EmployeeMenu").hide();
	$("#AddTaskMenu").hide();
	$("#TasksMenu").hide();
	$("#MapsMenu").show();

	$.ajax({
		url: 'locate.jsp',
		type: 'GET',
		dataType: 'html',
		success: function(Data){
			$("#Content").html(Data);
			$("#Map").resize();
		}
	});
}

function loadEmployee(){
	$("#AddTaskMenu").hide();
	$("#TasksMenu").hide();
	$("#MapsMenu").hide();
	$("#EmployeeMenu").show();

	$.ajax({
		url: 'employee.jsp',
		type: 'GET',
		dataType: 'html',
		success: function(Data){
			$("#Content").html(Data);
		}
	});
	
}

function loadAddTask(){
	$("#AddTaskMenu").show();
}
// Left Navigation Bar Scripts


// Change Password Scripts


function loadChangePassword(){
	$("#Message").css('color','#039').html("Please Enter Details");
	$("#OP").val("");
	$("#NP").val("");
	$("#RP").val("");
	$("#ChangePasswordDialog").toggle(100);
}

function changePassword(){
	var op= $("#OP").val();
	var np= $("#NP").val();
	var rp= $("#RP").val();
			
	if(np==rp){
		$.ajax({
			type:"GET",
			url:"ChangePassword.jsp?op="+op+"&np="+np,
			dataType:"html",
			success: function(data){
				var status = data.trim();
				if(status=='1'){
					$("#Message").css('color','#090').html("Password Changed");
					$("#OP").val("");
					$("#NP").val("");
					$("#RP").val("");
					$("#ChangePasswordDialog").delay(1000).hide(100);
				}
				else{
					$("#Message").css('color','#900').html("Cannot Change the Password!!");
					$("#OP").val("");
					$("#NP").val("");
					$("#RP").val("");
				}
			}
		});
	}
	else{
		$("#Message").css('color','#900').html("Passwords do not match");
	}
}

function cancelChangePassword(){
	$("#OP").val("");
	$("#NP").val("");
	$("#RP").val("");
	$("#ChangePasswordDialog").hide();
}

// Change Password Scripts


// Add Task Menu Scripts
function getFormattedDate(date){
	return "'"+date.getFullYear()+'-'+ (date.getMonth()+1)+'-'+date.getDate()+"'";
}

function getFormattedDateWOQ(date){
	return date.getFullYear()+'-'+ (date.getMonth()+1)+'-'+date.getDate();
}

function addTaskNextPage(){
	$("#AddTaskP1").hide();
	var usr = $("#CustomerName").val().split(",");
	$("#ATCN").html(usr[0]);
	$("#ATCA").html(usr[1]+","+usr[2]);
	$("#ATMT").html($("#MachineType").val()+" Machine");
	$("#ATTT").html($("#TaskType").val());
	if($("#SubType").val().trim()!=""){
		$("#ATST").html($("#SubType").val());
		$("#TaskTypeID").val(SubType.selectedItem.getAttribute("key"));
	}
	else{
		$("#TaskTypeID").val(TaskType.selectedItem.getAttribute("key"));
	}
	$("#ATEN").html($("#Employee").val());
	var date = $("#ATDT").html();
	$("#ATDT").html(date+" "+$("#Time").val()+":00");
	$('#ATEM').val(Employee.selectedItem.getAttribute("key"));
	$("#AddTaskP2").show();
}

function addTaskPrevPage(){
	$("#AddTaskP2").hide();
	$("#AddTaskP1").show();
}
function hideAddTaskMenu(){
	$("#AddTaskForm").trigger('reset');
	$("#TaskType").prop('disabled', true);
	$("#SubTypeContainer").hide();
	$("#SubType").prop('disabled', true);
	$("#Employee").prop('disabled', true);
	$("#Time").prop('disabled', true);
	$('#AddTaskMenu').hide();
}

function customerChanged(){
	var CustomerSelected = $('#customers option[value="'+$('#CustomerName').val()+'"]').attr('CustomerId');
	

	if(CustomerSelected == null && $("#CustomerName").val() != ""){
		$("#AddCustomerDialog").show();
		$("#CompanyName").val($("#CustomerName").val()).focus();

	}
	else
	{
		$("#CustomerID").val(CustomerSelected);
		$("#MachineType").prop('disabled',false).focus();

	}
}
var selectedMachine = "";
MachineType.addEventListener('iron-select', function(event){
	selectedMachine = event.target.selectedItem.innerText.trim();
	$("#TaskType").prop('disabled', true);
	$("#SubTypeContainer").hide();
	$("#SubType").prop('disabled', true);
	$("#Employee").prop('disabled', true);
	$("#Time").prop('disabled', true);
	$("#NextButton").prop('disabled',true);
	$.ajax({
		url: 'AddTaskDropdown.jsp?id=TaskType&&label=Task Type&&TableName=task_types&&Query= parent_id=\'0\' and machine_type=\''+selectedMachine+'\'',
		type: 'GET',
		dataType: 'html',
		success: function(Data){
			$("#TaskTypeContainer").html(Data);
		}
	});
});

Time.addEventListener('iron-select',function(event){
	$("#NextButton").prop('disabled', false);
})


function addNewTask(){
	$("#AddTaskForm").submit();
}
AddTaskForm.addEventListener('iron-form-response', function(event) {
	
	loadTask();
	addTaskPrevPage();
	hideAddTaskMenu();
});
// Add Task Menu Scripts

// EmployeeMenu Scripts
function scrollEmployee(id){
	$("html, body").animate({
		"scrollTop": $("#Emp"+id).position().top
	});
}




$(".employees").hover(function() {
		$(this).prop('elevation', 3);
	}, function() {
		$(this).prop('elevation', 1);
});

function showAddEmployeeDialog(){
	$("#AddEmployeeDialog").show();
}

function loadEditContact(id,add,area,city,con,em)
	{
		$('#EditContact').show();
		$('#EmployeeId').val(id);
		$('#Eadd').val(add);
		$('#Earea').val(area);
		$('#Ecity').val(city);
		$('#Econ').val(con);
		$('#Eemail').val(em);
	}

	function closeEditContact()
	{
		$('#EditContact').hide();	
	}

	function editEmployee()
	{
		$("#EditEmployeeForm").submit();
	}

	EditEmployeeForm.addEventListener('iron-form-response', function(event) {
		loadEmployee();
		$("#EditContact").hide();
	});
// EmployeeMenu Scripts

// Maps Menu Scripts
function employeeMarker(id){
	$(".markers").attr('animation',"");
	$("#Map").attr("longitude",$("#Marker"+id).attr("longitude"));
	$("#Map").attr("latitude",$("#Marker"+id).attr("latitude"))
	$("#Marker"+id).attr("animation","BOUNCE");
	window.setTimeout(function(){
		$(".markers").attr('animation',"");
	},1500);
}


function filterMapEmployees(){
	var SearchString = $("#SearchMapEmployee").val().trim().toLowerCase();
	var $array = $(".mapemployees");
	$array.each(function(index, el) {
		if($(this).attr("EmpName").toLowerCase().includes(SearchString)){
			$(this).stop().slideDown(700);
		}else{
			$(this).stop().slideUp(700);
		}
	});
}

function filterMenuEmployees(){
	var SearchString = $("#SearchEmployee").val().trim().toLowerCase();
	var $arr = $(".menuemployees");
	$arr.each(function(index, el) {
		if($(this).attr("EmpName").toLowerCase().includes(SearchString)){
			$(this).stop().slideDown(700);
		}else{
			$(this).stop().slideUp(700);
		}
	});
}

$(".mapemployees").hover(function() {
		$(this).prop('elevation', 3);
	}, function() {
		$(this).prop('elevation', 1);
});
// Maps Menu Scripts

// Add Employee Dialog Scripts
function addEmployee(){
		$("#AddEmployeeForm").submit();
}

AddEmployeeForm.addEventListener('iron-form-response', function(event) {
	var id = event.detail.response.id;
	var first_name = event.detail.response.first_name;
	var last_name = event.detail.response.last_name;
	var department = event.detail.response.department;
	var contact = event.detail.response.contact;
	$("#EmployeeMenuList").append('<paper-material elevation="1" EmpName="'+first_name+' '+last_name+' '+department+' '+contact+'" onclick="scrollEmployee('+id+')" class="employees"><b>'+first_name+' '+last_name+'</b><br />'+contact+'</paper-material>');
	$("#MapsMenuList").append('<paper-material elevation="1" EmpName="'+first_name+' '+last_name+' '+department+' '+contact+'" onclick="employeeMarker('+id+')" class="mapemployees"><b>'+first_name+' '+last_name+'</b><br />'+contact+'</paper-material>');

	loadEmployee();
	closeAddEmployeeDialog();
});

function closeAddEmployeeDialog(){
	$("#AddEmployeeForm").trigger('reset');
	$("#AddEmployeeDialog").hide();
}
// Add Employee Dialog Scripts

// Add Customer Dialog Scripts
function addCustomer(){
	$("#AddCustomerForm").submit();
}

AddCustomerForm.addEventListener('iron-form-presubmit', function(event){
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode( { 'address': $("#CAdd").val()+","+$("#CArea").val()+","+$("#CCity").val()}, function(results, status) {

	  if (status == google.maps.GeocoderStatus.OK) {
	    var latitude = results[0].geometry.location.lat();
	    var longitude = results[0].geometry.location.lng();
	    $("#CLat").val(latitude);
	    $("#CLong").val(longitude);
	  } 
	  else{
	  	geocoder.geocode({'address':$("#CArea").val()+","+$("#CCity").val()}, function(results,status){
	  		if (status == google.maps.GeocoderStatus.OK) {
		    	var latitude = results[0].geometry.location.lat();
		    	var longitude = results[0].geometry.location.lng();
			    $("#CLat").val(latitude);
			    $("#CLong").val(longitude);
			 } 
	  	});
	  }
	}); 
});

AddCustomerForm.addEventListener('iron-form-response', function(event) {
	$("#CustomerID").val(event.detail.response.id);
	$("#CustomerName").val(event.detail.response.customer);
	$("#customers").append('<option CustomerID="'+event.detail.response.id+'" value="'+event.detail.response.customer+'"></option>');
	closeAddCustomerDialog();
	$("#MachineType").prop('disabled',false).focus();
});
function closeAddCustomerDialog(){
	$("#AddCustomerForm").trigger('reset');
	$("#AddCustomerDialog").hide();
}
// Add Customer Dialog Scripts
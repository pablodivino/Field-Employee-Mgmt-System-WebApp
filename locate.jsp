<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp" %>

<%
	ResultSet employees = st.executeQuery("Select * from employees where status!='Inactive'");
%>
<style>
	paper-spinner{
		height:20px;
		width:20px;
		position:fixed;
		top: 20px;
		left: 50%;
		margin-left: -10px;
	}
</style>

<paper-spinner active></paper-spinner>

<google-map id="Map" latitude="23.0300" longitude="72.5800" disableDefaultUi="true" fit-to-markers>
	<% while(employees.next()){%>
		<google-map-marker class="markers" id="Marker<%= employees.getString(1)%>" latitude="<%= employees.getString(11)%>" longitude="<%= employees.getString(12)%>" title="<%= employees.getString(2)%> <%= employees.getString(3)%>">
			<div>
				<p><b><%= employees.getString(2)%> <%= employees.getString(3)%></b></p>
				<p><%= employees.getString(5)%> Department</p>
				<p><%= employees.getString(6)%>,</p>
				<p><%= employees.getString(7)%>, <%= employees.getString(8)%></p>
				<p>(M): <%= employees.getString(9)%></p>
				<p>(E): <%= employees.getString(10)%></p>
			</div>
		</google-map-marker>
	<%}%>
</google-map>

<script>

	$(document).ready(function() {
		setSize();
		$('paper-spinner').prop('active', 'false');
	});

	$(window).resize(function(){
		setSize();
	});

	function setSize(){
		$('#Map').height(parseInt($(window).height()));
	}
	
	var map = document.querySelector('google-map');

	map.addEventListener('google-map-ready', function(e) {
    	window.setInterval(function(){
  			reloadMarkers();
		}, 10000);
  	});

  	function reloadMarkers(){
  		$.ajax({
  			url: 'employeeLocationJSON.jsp',
  			type: 'GET',
  			dataType: 'json',
  		})
  		.done(function(data) {
  			$.each(data, function(index,employee){
				$("#Marker"+employee.id).attr("longitude",employee.long);
				$("#Marker"+employee.id).attr("latitude",employee.lat);	
			});
  		})
  		.fail(function(data){
  			console.log(data);
  		});
  	}

</script>
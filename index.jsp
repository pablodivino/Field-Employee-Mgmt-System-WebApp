<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>MacGray</title>

		<!-- Link Polymer elements -->
		<script src="bower_components/platform/platform.js" async="async"></script>
		<link rel="import" href="bower_components/iron-icons/iron-icons.html">
		<link rel="import" href="bower_components/paper-material/paper-material.html">
		<link rel="import" href="bower_components/paper-input/paper-input.html">
		<link rel="import" href="bower_components/paper-fab/paper-fab.html">
		<link rel="import" href="bower_components/paper-icon-button/paper-icon-button.html">
		<!-- Link Polymer elements -->

		<!-- Link Roboto Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,300italic,400italic,500,500italic,700,700italic">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,700">
		<!-- Link Roboto Fonts -->
		
		<script src="JS/jquery-2.2.2.min.js"></script>


		<style>
			body{
				background-image:url(Images/exciting-industrial-office-design-with-decoration-design-ideas.jpg);
				background-position:center;
				background-attachment: fixed;
				background-size:cover;
				font-family:Roboto, sans-serif;
			}

			#Error
			{
				color:#03c;
				height:15px;
				width:100%;
				text-align:center;
			}

			#LoginSurface{
				position:absolute;
				top:50%;
				margin-top:-175px;
				left:50%;
				margin-left:-250px;
				height:350px;
				width:500px;
				background-color:#FFF;
				border-radius:3px;
			}

			#LoginSurface paper-input{
				width:300px;
				margin-left:100px;
			}

			#LoginSurface paper-fab{
				color:#FFF;
				background-color: #03c;
				cursor:pointer;
			}
		</style>

	</head>

	<body>
		<paper-material elevation="2" id="LoginSurface">
			<br>
			<br>
			<div id="Error">
				<% if(request.getParameter("err")!=null){ %>
             	Invalid Username or Password!
				<% } %>
			</div>
			<br />
			<form action="Login.jsp" id="LoginForm" method="post">
				<paper-input label="Username" id="User" name="user" required></paper-input>
				<paper-input id="Pass" label="Password" type="password" name="pass" required>
					<!-- <paper-icon-button suffix onclick="clearInput()" icon="help-outline" alt="Reset Password" title="Reset Password"></paper-icon-button> -->
				</paper-input>
        		<br/>
        		<center>
        			<paper-fab is="iron-input" icon="fingerprint" onclick="submitForm()"></paper-fab>
        		</center>
			</form>
		</paper-material>

		<script>
			function submitForm(){
				var blank = false;
				if($('#User').val()==""){
					$('#User').focus();
					blank = true;
				}else if ($('#Pass').val()=="") {
					$('#Pass').focus();
					blank=true;
				}

				if(!blank){
					$('#LoginForm').submit();
				}
			}

			$(document).keypress(function(event) {
				if(event.which == 13){
					submitForm();
				}
			});
		</script>
	</body>
</html>
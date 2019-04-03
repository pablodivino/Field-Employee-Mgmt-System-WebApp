<html>
	<head>
		<script src="JS/jquery-2.2.2.min.js"></script>
		<script src="JS/jquery-ui.js"></script>
	</head>
	<body>
		<input id="Test" type="Hidden"></input>
		<button id="Button1">Hello</button>
		<button id="Button2">HHHHHH</button>
		<script>
			$("button").click(function(event) {
				/* Act on the event */
				$("#Test").val($(this).html());
				
			});

			$("input[type=hidden]").bind("change", function() {
       			alert($(this).val()); 
			 });

		</script>
	</body>

</html>
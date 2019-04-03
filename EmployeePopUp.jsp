<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="DBConnect.jsp"%>
<link rel="import" href="bower_components/paper-material/paper-material.html">
<link rel="import" href="bower_components/paper-button/paper-button.html">
<link rel="Stylesheet" type="text/css" href="CSS/smoothDivScroll.css" />

<style>
	#GalleryContainer{
		width: 720px;
		height: 520px;
		padding: 10px;
		position: fixed;
		top: 50%;
		margin-top:-260px;
		left: 50%;
		margin-left:-360px;
		font-size: 13px;
	}
	#ThumbnailContainer{
		width: 730px;
		height:90px;
		padding:5px;
		position:absolute;
		left:0px;
		bottom:60px;
		background-color:#111;
	}
	#ImageContainer{
		width:100%;
		height:380px;
		margin-top:-10px;
		background-color:#333;
		border-top-left-radius:3px;
		border-top-right-radius:3px;
	}
	#Image{
		width:100%;
		height:100%;
		background-size:contain;
		background-position:center;
		background-repeat:no-repeat;
	}
	#ButtonContainer{
		width:100%;
		height:60px;
		margin-top:100px;
		background-color:#333;
	}
	#CloseImageButton{
		position:absolute;
		top:5px;
		right:5px;
		color:#900;
		cursor:pointer;
		text-shadow: 1px 1px #eee;
	}
	.NavButtons{
		height:100px;
		line-height:100px;
		color:#999;
		background-color:#111;
		position:absolute;
		top:0px;
		cursor:pointer;
	}
	.NavButtons:hover{
		color:#EEE;
	}

	#ThumbnailScroller{
		width:calc(100% - 120px);
		margin-left: 50px;
		margin-top: -5px;
		height:90px;
		padding:5px;
		padding-left: 15px;
	}
	.Thumbnails{
		width:90px;
		height:90px;
		margin-left: 5px;
		margin-right: 5px;
		float:left;
		background-size:cover;
		display:none;
	}
	#ApproveButton{
		width:200px;
		height:40px;
		margin-top:10px;
		margin-left:40px;
		background-color:#51ccdb;
		color:#FFF;
		font-weight:bold;
		font-size:16px;
	}
	#grad {
	width:calc(100% - 40px);
	height:90px;
	padding-top:10px;
	padding-left:40px;
	position:absolute;
	bottom:0px;
	left:0px;
	font-size:15px;
	color:#FFF;
    background: #333; /* For browsers that do not support gradients */
    background: -webkit-linear-gradient(rgba(0, 0, 0, 0.0), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.7)); /* For Safari 5.1 to 6.0 */
    background: -o-linear-gradient(rgba(0, 0, 0, 0.0), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.7)); /* For Opera 11.1 to 12.0 */
    background: -moz-linear-gradient(rgba(0, 0, 0, 0.0), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.7)); /* For Firefox 3.6 to 15 */
    background: linear-gradient(rgba(0, 0, 0, 0.0), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.7)); /* Standard syntax */
}

</style>
<%
	String EmpId = request.getParameter("EmployeeId");
%>
<div id="GalleryContainer">
	<paper-material elevation="2" id="ImageContainer">
		<paper-icon-button icon="icons:close" onClick="closeImagePopUp()" id="CloseImageButton" noink></paper-icon-button>
		<div id="Image">
			<div id="Grad">
				<b><p id="BillType"></p></b>
				<p id="BillDate"></p>
				<p id="BillCost"></p>
				<p id="BillDesc"></p>
			</div>
		</div>
	</paper-material>
	<paper-material id="ThumbnailContainer" elevation="4">
			<paper-icon-button class="NavButtons" disabled icon="icons:chevron-left" id="Prev" style="left:0px" onClick="prevPage()" noink></paper-icon-button>
		<div id="ThumbnailScroller">
			<%
				int pageNo = 1;
				int index = 0;
			%>
			<%
				ResultSet foodbills = st.executeQuery("Select * from food_cost where approval_status='Pending' && employee_id="+EmpId);	
			%>
			<% while(foodbills.next()){
				if(index<6){
					index++;
				}else{
					index=0;
					pageNo++;
				}
				int imageNo = (pageNo-1)*6+index;
			%>
				<div class="Thumbnails P<%= pageNo%>" id="I<%= imageNo%>" style="background-image: url('Images/Food_Bills/<%= foodbills.getString(5)%>');" BType="Food Bill" BDate="<%= foodbills.getString(3)%>" BCost="<%= foodbills.getString(4)%>"></div>
			<%}%>
			<%
				ResultSet travelbills = st.executeQuery("Select * from travel_cost where approval_status='Pending' && employee_id="+EmpId);	
			%>
			<% while(travelbills.next()){
				if(index<6){
					index++;
				}else{
					index=0;
					pageNo++;
				}
				int imageNo = (pageNo-1)*6+index;
			%>
			<div class="Thumbnails P<%= pageNo%>" id="I<%= imageNo%>" BType="Travel Bill" BDate="<%= travelbills.getString(3)%>" BCost="<%= travelbills.getString(7)%>" BMOT="<%= travelbills.getString(4)%>" BFrom="<%= travelbills.getString(5)%>" BTo="<%= travelbills.getString(6)%>" style="background-image: url('Images/Travel_Bills/<%= travelbills.getString(8)%>');"></div>
			<%}%>
			<input type="hidden" id="Pages" value="<%= pageNo%>">
		</div>
		
			<paper-icon-button class="NavButtons" id="Next" icon="icons:chevron-right" style="right:0px" onclick="nextPage()" noink></paper-icon-button>
	</paper-material>
	</paper-material>
	<paper-material id="ButtonContainer" elevation="2">
		<paper-button raised id="ApproveButton" onclick="approveBills(<%= EmpId%>)">Approve All</paper-button>
	</paper-material>
	</paper-material>
</div>

<script type="text/javascript">

	var currPage = 1;
	var totalPages = 0;
	jQuery(document).ready(function($) {
		$(".P1").show();
		totalPages = $("#Pages").val();
		if(totalPages==1){
			$("#Next").prop('disabled', true);
		}
		var places = $('.Thumbnails');

		var first = places.first();
		$("#Image").css('background-image', first.css('background-image'));
	});

	function prevPage(){
		$("#Next").prop('disabled', false);
		$(".Thumbnails").hide();
		$(".P"+(currPage-1)).show();
		currPage--;
		if(currPage==1){
			$("#Prev").prop('disabled', true);
		}
	}

	function approveBills(empId){
		$.ajax({
			url: 'approveBills.jsp?empId='+empId,
			type: 'GET',
		})
		.done(function() {
			alert("Bills Approved Successfully!");
			closeImagePopUp();
		})
		.fail(function() {
			console.log("error");
		})
		.always(function() {
			console.log("complete");
		});
		
	}

	function nextPage(){
		$("#Prev").prop('disabled', false);
		$(".Thumbnails").hide();
		$(".P"+(currPage+1)).show();
		currPage++;
		if(currPage==totalPages){
			$("#Next").prop('disabled', true);
		}
	}

	function closeImagePopUp(){
		$("#GalleryContainer").hide();
	}

	$(".Thumbnails").click(function(event) {
		$("#Image").css('background-image', $(this).css('background-image'));
		$(".Thumbnails").css({
			'border': '0px solid #51ccdb',
			'width': '90px',
			'height': '90px'
		});
		$(this).css({
			'border': '2px solid #51ccdb',
			'width': '86px',
			'height': '86px'
		});
		$("#BillType").html($(this).attr('BType'));
		$("#BillDate").html("Date: "+$(this).attr('BDate'));
		$("#BillCost").html("Cost: "+$(this).attr('BCost'));
		if($(this).attr('BType')=="Travel Bill"){
			$("#BillDesc").html($(this).attr('BMOT') + " from "+ $(this).attr('BFrom') +" to "+ $(this).attr('BTo'));
		}else{
			$("#BillDesc").html("");
		}
	});
</script>
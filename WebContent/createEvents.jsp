<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create Event</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/all.min.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	
	<link rel="manifest" href="site.webmanifest">
	
	<script src="https://npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha.6/css/bootstrap.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.0/moment-with-locales.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
	<script src="https://rawgit.com/tempusdominus/bootstrap-4/master/build/js/tempusdominus-bootstrap-4.min.js"></script>
	<link href="https://rawgit.com/tempusdominus/bootstrap-4/master/build/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	

	<%
		String username = (String)request.getSession().getAttribute("username");
		if(username == null || username.trim().length() == 0) {
			username= "";
		}
	%>
	<script>
		function createNewEvent() {
			eventName = document.getElementById('eventNameInput').value;
			eventDesc = document.getElementById('eventDescInput').value;
			eventWebsite = document.getElementById('websiteInput').value;
			eventLocation = document.getElementById('eventLocationInput').value;
			expirationDate = document.getElementById('datetimepickerInput').value;
			
			$
					.ajax({
						url : "createEventServlet",
						data : {
							name : eventName,
							desc : eventDesc,
							website : eventWebsite,
							location : eventLocation,
							expDate : expirationDate
						},
						success : function(result) {
							console.log(result);
							if (result === "") {
								window.location.href = "index.jsp";
							} else {
								document.getElementById('errorMessage').innerHTML = result;
								return false;
							}
						}
					})
		}
	</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
       	<a class="navbar-brand font-weight-bold" href="index.jsp">Play</a>
       	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
   			<span class="navbar-toggler-icon"></span>
 		</button>
 			
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ml-auto">
			<% if(username != "") { %>
   				<li class="nav-item">
     				<a class="nav-link" href="#">Profile</a>
   				</li>
   				<li class="nav-item">
     				<a class="nav-link" href="#">Logout</a>
   				</li>
   			<% } else { %>
   				<li class="nav-item">
     				<a class="nav-link" href="#">Login</a>
   				</li>
   				<li class="nav-item">
     				<a class="nav-link" href="#">Register</a>
   				</li>
   			<% } %>
   			</ul>
		</div>
   	</nav>

	<div class="container-fluid">
		<form method="POST" onsubmit="return false;">
			<div class="form-group">
				<br />
				<label for="eventNameInput">Event Name</label> <input
					type="text" class="form-control" id="eventNameInput"
					placeholder="Enter name of event">
			</div>
			<div class="form-group">
				<label for="eventDescInput">Description</label> <input
					type="text" class="form-control" id="eventDescInput"
					placeholder="Enter a short description of your event.">
			</div>
			<div class="form-group">
				<label for="websiteInput">Website</label> <input
					type="text" class="form-control" id="websiteInput"
					placeholder="Enter website for event">
			</div>
			<div class="form-group">
				<label for="eventLocationInput">Location</label> <input
					type="text" class="form-control" id="eventLocationInput"
					placeholder="Location of event">
			</div>
			
		
			<div class="container">

            <div class="form-group">
                <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
                    <input type="text" class="form-control" id="datetimepickerInput" data-target="#datetimepicker1"/>
                    	<span class="input-group-addon" data-target="#datetimepicker1" data-toggle="datetimepicker">
                       		<span class="fa fa-calendar"></span>
                    	</span>
                    	<script>
                    	$(function () {
                    	    $('#datetimepicker1').datetimepicker({
                    	        format: 'MM/DD/YYYY HH:mm'
                    	    });
                    	});
                    	</script>
                    
               </div>
           	</div>
			</div>
			
			<small id="errorMessage" class="form-text text-muted">&nbsp;</small>
			<button type="submit" class="btn btn-primary" onclick="return createNewEvent();">Create Event</button>
		</form>


	</div>

	<script src="bootstrap/bootstrap.bundle.min.js" ></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create Event</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/css/all.min.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="stylesheet" href="css/createEvents.css">
	
	<link rel="manifest" href="site.webmanifest">
	
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.0/moment-with-locales.js"></script>
	<script src="datetimepicker/tempusdominus-bootstrap-4.min.js"></script>
	<link href="datetimepicker/tempusdominus-bootstrap-4.min.css" rel="stylesheet"/>
	

	<%
		String username = (String)session.getAttribute("username");
		if (username == null) {
			username = "";
		}
		boolean loggedIn = false;
		if (username.equals("")) {
			loggedIn = false;
		} else {
			loggedIn = true;
		}
	%>
	<script>
		var latitude;
		var longitude;
		function createNewEvent() {
			eventName = document.getElementById('eventNameInput').value;
			eventDesc = document.getElementById('eventDescInput').value;
			eventWebsite = document.getElementById('websiteInput').value;
			expirationDate = document.getElementById('datetimepickerInput').value;
			eventCategory = document.getElementById('eventCategoryInput').value;
			
			$
					.ajax({
						url : "createEventServlet",
						data : {
							name : eventName,
							desc : eventDesc,
							website : eventWebsite,
							lat : latitude,
							lng : longitude,
							expDate : expirationDate,
							category : eventCategory
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
			<% if(loggedIn) { %>
   				<li class="nav-item">
     				<a class="nav-link" href="profile.jsp">Profile</a>
   				</li>
   				<li class="nav-item">
     				<a class="nav-link" href="LogoutServlet">Logout</a>
   				</li>
   			<% } else { %>
   				<li class="nav-item">
     				<a class="nav-link" href="login.jsp">Login</a>
   				</li>
   				<li class="nav-item">
     				<a class="nav-link" href="logout.jsp">Register</a>
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
			    <label for="eventCategoryLabel">Choose a Categoy...</label>
			    <select class="form-control" id="eventCategoryInput">
			      <option>Art</option>
			      <option>Concert</option>
			      <option>Food</option>
			      <option>Beach</option>
			      <option>Party</option>
			      <option>Market</option>
			    </select>
		  	</div>	
		
			<label for="eventDateInput">Date/Time</label>
            <div class="form-group">
                <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
                    <input type="text" class="form-control" id="datetimepickerInput" data-target="#datetimepicker1"/>
                    	<div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                    	<div class="input-group-text">
                       		<i class="far fa-calendar"></i>
                       	</div>
                    	</div>
                    	<script>
                    	$(function () {
                    	    $('#datetimepicker1').datetimepicker({
                    	        format: 'MM/DD/YYYY HH:mm'
                    	    });
                    	});
                    	</script>
                    
               </div>
           	</div>
           	
           	<form method="POST" onsubmit="return false;">
				<label for="eventLocationInput">Location</label>
				<div id="floating-panel">
	      			<input id="address" type="textbox" value="Los Angeles">
	      			<button id="submit" type="submit" value="Geocode" style="display:none;">
	    		</div>
    		</form>
    		<div id="map"></div>
    		
    		<small id="errorMessage" class="form-text text-muted">&nbsp;</small>
			<button type="submit" class="btn btn-primary" onclick="return createNewEvent();">Create Event</button>
			<br/>
			<br/>
    	</form>
    		<script>
      			function initMap() {
        			var map = new google.maps.Map(document.getElementById('map'), {
          				zoom: 8,
          				center: {lat: 34.0522, lng: -118.243}
        			});
        			var geocoder = new google.maps.Geocoder();

		        	document.getElementById('submit').addEventListener('click', function() {
			    		geocodeAddress(geocoder, map);
        			});
      			}
				var markersArray = [];
				
      			function geocodeAddress(geocoder, resultsMap) {
        			var address = document.getElementById('address').value;
        			geocoder.geocode({'address': address}, function(results, status) {
         				 if (status === 'OK') {
           					resultsMap.setCenter(results[0].geometry.location);
           					clearMarkers();
							var marker = new google.maps.Marker({
              					map: resultsMap,
              					position: results[0].geometry.location
            				});
							markersArray.push(marker);
							latitude = results[0].geometry.location.lat();
							longitude = results[0].geometry.location.lng();
          				} else {
            				alert('Geocode was not successful for the following reason: ' + status);
          				}
        			});
      			}
      			
      			function clearMarkers() {
      				for (var i = 0; i < markersArray.length; i++ ) {
      				    markersArray[i].setMap(null);
      				  }
      				  markersArray.length = 0;
      			}
    		</script>
    		<script async defer
   			 src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBjFhnU6F3rpushBW0hf6kHMUzXVXPn2Xo&callback=initMap">
    		</script>
			
			
		


	</div>

	
</body>
</html>
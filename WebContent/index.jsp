<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/css/all.min.css">
	<link rel="stylesheet" href="css/index.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">

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
</head>
<body>
	<div class="container-fluid p-0 d-flex flex-column h-100">
		<nav class="navbar navbar-expand-lg navbar-dark">
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
	     				<a class="nav-link" href="register.jsp">Register</a>
	   				</li>
	   			<% } %>
	   			</ul>
			</div>
	   	</nav>
	
		<div id="map" class="flex-grow-1"></div>
	</div>

	<script src="jquery/jquery-3.3.1.min.js"></script>
	<script src="bootstrap/bootstrap.bundle.min.js"></script>
	<script>
		var map;
		
		var JSONString;
		var events;
		
		function loadEvents() {
			$
				.ajax({
					url : "EventsServlet",
					data : {
						
					},
					success : function(result) {
						if (result === "") {
						} else {
							JSONString = result;
							events = JSON.parse(JSONString);
							
								let i;
								for (i = 0; i < events.length; i++) {
							        
							        var myLatLng = {
										lat : events[i].latitude,
										lng : events[i].longitude
									};
							        
									var image = '';
									
									if(events[i].colorCode == 0) {
										//black
										image = 'https://cdn3.iconfinder.com/data/icons/web-ui-3/128/Marker-2-64.png'
									} else if (events[i].colorCode == 1) {
										//blue
										image = 'https://cdn4.iconfinder.com/data/icons/web-ui-color/128/Marker-64.png';
									} else if (events[i].colorCode == 2) {
										//green
										image = 'https://cdn3.iconfinder.com/data/icons/web-ui-color/128/Marker_green-64.png';
									} else if (events[i].colorCode == 3) {
										//red
										image = 'https://cdn4.iconfinder.com/data/icons/web-ui-color/128/Marker_red-64.png';
									}
									
							        let marker = new google.maps.Marker({
										position: myLatLng,
										animation: google.maps.Animation.DROP,
										map: map,
										icon: image,
										
										store_id: events[i].eventID,
										store_creatorID: events[i].creator.userID,
										store_username: events[i].creator.username,
										store_latitude: events[i].latitude,
										store_longitude: events[i].longitude,
										store_createdAt: events[i].createdAt,
										store_upvotes: events[i].upvotes,
										store_description: events[i].description,
										store_expirationDate: events[i].expirationDate,
										store_website: events[i].website,
										store_colorCode: events[i].colorCode,
										store_comments: events[i].comments
										
									});
									marker.addListener('click', function() {
										alert("ID: " + marker.get('store_id') + '\n' + 'Upvotes: ' + marker.get('store_upvotes'));
								    });
							    }
							return false;
						}
					}
				})
		}
		
		
		function initMap() {
			var myLatLng = {
				lat : 34.025364,
				lng : -118.284502
			};

			map = new google.maps.Map(document.getElementById('map'), {
				center : myLatLng,
				zoom : 12,
				streetViewControl : false,
				mapTypeControl : false,
				scaleControlOptions : google.maps.ControlPosition.TOP_LEFT,
				styles : [
					  {
						    "elementType": "geometry",
						    "stylers": [
						      {
						        "color": "#242f3e"
						      }
						    ]
						  },
						  {
						    "elementType": "labels.text.fill",
						    "stylers": [
						      {
						        "color": "#746855"
						      }
						    ]
						  },
						  {
						    "elementType": "labels.text.stroke",
						    "stylers": [
						      {
						        "color": "#242f3e"
						      }
						    ]
						  },
						  {
						    "featureType": "administrative",
						    "elementType": "geometry",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "administrative.land_parcel",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "administrative.locality",
						    "elementType": "labels.text.fill",
						    "stylers": [
						      {
						        "color": "#d59563"
						      }
						    ]
						  },
						  {
						    "featureType": "administrative.neighborhood",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "landscape",
						    "elementType": "labels.icon",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "poi",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "poi",
						    "elementType": "labels.text",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "poi",
						    "elementType": "labels.text.fill",
						    "stylers": [
						      {
						        "color": "#d59563"
						      }
						    ]
						  },
						  {
						    "featureType": "poi.park",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "poi.park",
						    "elementType": "geometry",
						    "stylers": [
						      {
						        "color": "#263c3f"
						      },
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "poi.park",
						    "elementType": "labels.text.fill",
						    "stylers": [
						      {
						        "color": "#6b9a76"
						      },
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "road",
						    "elementType": "geometry",
						    "stylers": [
						      {
						        "color": "#38414e"
						      }
						    ]
						  },
						  {
						    "featureType": "road",
						    "elementType": "geometry.stroke",
						    "stylers": [
						      {
						        "color": "#212a37"
						      }
						    ]
						  },
						  {
						    "featureType": "road",
						    "elementType": "labels",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "road",
						    "elementType": "labels.icon",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "road",
						    "elementType": "labels.text.fill",
						    "stylers": [
						      {
						        "color": "#9ca5b3"
						      }
						    ]
						  },
						  {
						    "featureType": "road.arterial",
						    "elementType": "labels",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "road.highway",
						    "elementType": "geometry",
						    "stylers": [
						      {
						        "color": "#746855"
						      }
						    ]
						  },
						  {
						    "featureType": "road.highway",
						    "elementType": "geometry.stroke",
						    "stylers": [
						      {
						        "color": "#1f2835"
						      }
						    ]
						  },
						  {
						    "featureType": "road.highway",
						    "elementType": "labels",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "road.highway",
						    "elementType": "labels.text.fill",
						    "stylers": [
						      {
						        "color": "#f3d19c"
						      }
						    ]
						  },
						  {
						    "featureType": "road.local",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "transit",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "transit",
						    "elementType": "geometry",
						    "stylers": [
						      {
						        "color": "#2f3948"
						      }
						    ]
						  },
						  {
						    "featureType": "transit.station",
						    "elementType": "labels.text.fill",
						    "stylers": [
						      {
						        "color": "#d59563"
						      }
						    ]
						  },
						  {
						    "featureType": "water",
						    "elementType": "geometry",
						    "stylers": [
						      {
						        "color": "#17263c"
						      }
						    ]
						  },
						  {
						    "featureType": "water",
						    "elementType": "labels.text",
						    "stylers": [
						      {
						        "visibility": "off"
						      }
						    ]
						  },
						  {
						    "featureType": "water",
						    "elementType": "labels.text.fill",
						    "stylers": [
						      {
						        "color": "#515c6d"
						      }
						    ]
						  },
						  {
						    "featureType": "water",
						    "elementType": "labels.text.stroke",
						    "stylers": [
						      {
						        "color": "#17263c"
						      }
						    ]
						  }
						]
			});
			// Create add event button
			<% if (loggedIn) { %>
				var controlUI = document.createElement('button');
				controlUI.classList.add('w-50');
				controlUI.classList.add('btn');
				controlUI.classList.add('btn-light');
				controlUI.style.margin = '10px';
				controlUI.title = 'Click to add a new event';
				controlUI.innerHTML = 'Add Event';
				controlUI.index = 1;
				
				controlUI.addEventListener('click', function() {
					window.location.href = "createEvents.jsp";
				});
			<% } %>
						
			// Create the search box and link it to the UI element.
			var input = document.createElement('input');
			input.classList.add('form-control');
			input.type = 'text';
			input.placeholder = 'Search';
			input.style.marginTop = '10px';
			input.style.marginLeft = '10px';
			var searchBox = new google.maps.places.SearchBox(input);
			
			// one div to rule them all
			var div = document.createElement('div');
			div.classList.add('d-flex');
			div.classList.add('flex-column');
			div.appendChild(input);
			<% if (loggedIn) { %>
				div.appendChild(controlUI);
			<% } %>
			
			// push div to map
			map.controls[google.maps.ControlPosition.TOP_LEFT]
				.push(div);
			
			// Bias the SearchBox results towards current map's viewport.
			map.addListener('bounds_changed', function() {
				searchBox.setBounds(map.getBounds());
			});
			
			/* var markers = []; */
			searchBox.addListener('places_changed', function() {
				var places = searchBox.getPlaces();

				if (places.length == 0) {
					return;
				}

				// Clear out the old markers.
				/* markers.forEach(function(marker) {
					marker.setMap(null);
				});
				markers = []; */

				// For each place, get the icon, name and location.
				var bounds = new google.maps.LatLngBounds();
				places.forEach(function(place) {
					if (!place.geometry) {
						console.log("Returned place contains no geometry");
						return;
					}
					var icon = {
						url : place.icon,
						size : new google.maps.Size(71, 71),
						origin : new google.maps.Point(0, 0),
						anchor : new google.maps.Point(17, 34),
						scaledSize : new google.maps.Size(25, 25)
					};

					// Create a marker for each place.
					/* markers.push(new google.maps.Marker({
						map : map,
						icon : icon,
						title : place.name,
						position : place.geometry.location
					})); */

					if (place.geometry.viewport) {
						// Only geocodes have viewport.
						bounds.union(place.geometry.viewport);
					} else {
						bounds.extend(place.geometry.location);
					}
				});
				map.fitBounds(bounds);
			});
			loadEvents();
		}
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyARjj3ad8bc8Fh1K_d3khuBu_3AbOc_mW0&libraries=places&callback=initMap"
		async defer></script>
</body>
</html>
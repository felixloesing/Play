<%@page import="classes.DatabaseConnector"%>
<%@page import="java.util.Vector"%>
<%@page import="classes.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import="classes.Event" %>
<%@page import="classes.EventDateParser" %>
<%@page import="java.util.Date" %>
<%
	String username = (String)session.getAttribute("username");
	if (username == null) {
		username = "";
	}
	
	String userID = (String)session.getAttribute("userID");
	if (userID == null) {
		userID = "";
	}
	
	boolean loggedIn = false;
	if (!username.equals("")) {
		loggedIn = true;
	}

	ArrayList<Event> events = DatabaseConnector.getEvents(Integer.valueOf(userID));
%>


<html>
<head>
	<meta charset="UTF-8">
	<title>Profile</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/css/all.min.css">
	<link rel="stylesheet" href="css/details.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">
	
	<script src="jquery/jquery-3.3.1.min.js"></script>
	<script>
	function deleteEvent(eID) {
		$
				.ajax({
					url : "DeleteServlet",
					data : {
						eventID : eID,
					},
					success : function(result) {
						console.log(result);
						if (result === "") {
							window.location.href = "index.jsp";
						} else {
							return false;
						}
					}
				})
	}
	
	</script>
</head>
<body>
	<div class="container-fluid p-0">
		<nav class="navbar navbar-expand-lg navbar-dark">
	       	<a class="navbar-brand font-weight-bold" href="index.jsp">Play</a>
	       	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	   			<span class="navbar-toggler-icon"></span>
	 		</button>
	 			
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ml-auto">
				<% if(loggedIn) { %>
	   				<li class="nav-item d-flex" style="color: rgba(255,255,255,.5)">
	     				Hi, <%= username %> (<a class="nav-link p-0" href="LogoutServlet">logout</a>)
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
	   	
	   	<br/>
	   	<br/>
		<div class="w-75 mx-auto mt-5">
			<div class="border p-5 bg-white rounded">
				<h2 class="text-center">Hi, <%= username %>!</h2>
				<br>
				<h3 class="text-left">Events you created</h3>
				<% for (Event ev : events) {  %>
					<p><%= ev.getName() %> <br> <%= ev.getAddress() %></p>
					<button id="deleteButton" class="btn btn-dark mx-auto" data-toggle="modal" data-target="" onclick="return deleteEvent(<%=ev.getEventID()%>);">Delete Event</button>
					<br/>
				<%} %>
			</div>
		</div>	   	
	</div>

	<script src="jquery/jquery-3.3.1.min.js"></script>
	<script src="bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
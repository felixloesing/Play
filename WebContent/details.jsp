<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import="classes.Event" %>
<%
	String username = (String)session.getAttribute("username");
	if (username == null) {
		username = "";
	}
	boolean loggedIn = false;
	if (!username.equals("")) {
		loggedIn = true;
	}
	
	Event e = (Event)request.getAttribute("event");
	
	if(e == null) {
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
	   	rd.forward(request, response);
	}
	
%>


<html>
<head>
	<meta charset="UTF-8">
	<title><%= e.getName() %> details</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/css/all.min.css">
	<link rel="stylesheet" href="css/details.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">
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
	   				<li class="nav-item">
	     				<span class="navbar-text">
<%--     						Hi, <%= username %>!  --%>
  						</span>
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
	   	
	   	<!-- <div class="card w-75 mx-auto">
		  <img src="event-backgrounds/dinner.jpg" class="card-img-top" alt="...">
		  <div class="card-body">
		    <h5 class="card-title">Card title</h5>
		    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
		    <a href="#" class="btn btn-primary">Go somewhere</a>
		  </div>
		</div> -->
	   	
		<div class="w-75 my-5 mx-auto bg-light">
			<div class="row mx-0">
				<div id="img-placeholder" class="col-8">
					<!-- <img src="event-backgrounds/dinner.jpg"> -->
				</div>
				<div class="col-4">
					<p class="h4 mt-2">
						<%= e.getExpirationDate() %>
					</p>
					<h3 class="mt-4"><%= e.getName() %></h3>
					<p class="h5 text-muted"><%= e.getCreator().getUsername() %></p>
					<p class="mt-5"><!-- price range of event? --></p>
				</div>
			</div>
			
			<div class="w-75 mx-auto mt-4 pb-4">
				<p><strong>Description</strong></p>
				<p class="text-muted"><%= e.getDescription() %></p>
				<a href="<%= e.getWebsite() %>" class="mb-5"><strong>More info at...</strong></a>
			</div>
			<!-- TODO upvote section  -->
			<!-- TODO comment section  -->
		</div>	   	
	</div>

	<script src="jquery/jquery-3.3.1.min.js"></script>
	<script src="bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
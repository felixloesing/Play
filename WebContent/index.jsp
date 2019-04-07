<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/all.min.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">

	<%
		boolean loggedIn = false;
		// check if logged in
	%>
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
	</div>

	<script src="jquery/jquery-3.3.1.min.js" ></script>
	<script src="bootstrap/bootstrap.bundle.min.js" ></script>
</body>
</html>
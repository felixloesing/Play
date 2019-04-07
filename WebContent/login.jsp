<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/css/all.min.css">
	<link rel="stylesheet" href="css/login.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">

	<%
		boolean loggedIn = false;
		// check if logged in
	%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		function login() {
			uname = document.getElementById('usernameInput').value;
			pw1 = document.getElementById('passwordInput').value;
			$
					.ajax({
						url : "LoginServlet",
						data : {
							username : uname,
							password : pw1
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
	<div class="container-fluid p-0 d-flex flex-column h-100">
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
	     				<a class="nav-link active" href="login.jsp">Login</a>
	   				</li>
	   				<li class="nav-item">
	     				<a class="nav-link" href="register.jsp">Register</a>
	   				</li>
	   			<% } %>
	   			</ul>
			</div>
	   	</nav>

		<div class="align-self-center flex-grow-1">
			<div class="h-100 d-flex flex-column justify-content-center">
				<div class="border p-5 bg-white rounded">
					<h2 class="text-center">Login</h2>
					<form class="w-100" method="POST" onsubmit="return false;">
						<div class="form-group">
							<br />
							<label for="usernameInput">Username</label> <input
								type="text" class="form-control" id="usernameInput"
								aria-describedby="emailHelp" placeholder="Enter username">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Password</label> <input
								type="password" class="form-control" id="passwordInput"
								placeholder="Password">
						</div>
						<small id="errorMessage" class="form-text text-muted">&nbsp;</small>
						<div class="text-center">
							<button type="submit" class="btn btn-dark" onclick="return login();">Login</button>
						</div>
					</form>
				</div>
			</div>
		</div>

	</div>

	<script src="jquery/jquery-3.3.1.min.js" ></script>
	<script src="bootstrap/bootstrap.bundle.min.js" ></script>
</body>
</html>

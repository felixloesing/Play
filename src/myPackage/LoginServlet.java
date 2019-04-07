package myPackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.DatabaseConnector;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		/*
		int status = DB.login(username, password);
		
		if (status == 1) {
			System.out.println("match2");
			HttpSession session = request.getSession();
			session.setAttribute("registeredUser", username);
		}
		*/
		
		String responseString = "";
		if (username.equals("")) {
			responseString = "Please enter your username.";
			
		} else if (password.equals("")) {
			responseString = "Please enter your password.";
			
		} else if (DatabaseConnector.getUser(username) == null) {
			//user does not exist
			responseString = "The username is not valid.";
		} else {
			//user exists
			if (DatabaseConnector.login(username, password) == null) {
				responseString = "The username and password do not match";
			} else {
				responseString = "";
			}
		}
		
		System.out.println("status login: " + responseString);
		response.getWriter().write(responseString);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

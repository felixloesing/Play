package myPackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
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
				String UsernameString = DatabaseConnector.getUser(username).getUsername();
				responseString = "";
				HttpSession session = request.getSession();
				session.setAttribute("username", UsernameString);
				String userID = String.valueOf(DatabaseConnector.getUser(username).getUserID());
				session.setAttribute("userID", userID);
			}
		}
		
		System.out.println("status login: " + responseString);
		response.getWriter().write(responseString);
		return;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

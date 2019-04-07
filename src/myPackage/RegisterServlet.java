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
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		
		String responseString = "";
		if (username.equals("")) {
			responseString = "Please enter your username.";
			
		} else if (!password1.equals(password2)) {
			responseString = "Passwords do not match";
			
		} else if (password1.equals("")) {
			responseString = "Please enter your password.";
			
		} else if (password2.equals("")) {
			responseString = "Please confirm your password.";
			
		} else if (DatabaseConnector.getUser(username) != null) {
			//user does not exist
			responseString = "The username is already taken.";
		} else {
			//user exists
			if (DatabaseConnector.createUser(username, password1, password2) == false) {
				responseString = "An error occured.";
			} else {
				responseString = "";
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				int userID = DatabaseConnector.getUser(username).getUserID();
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

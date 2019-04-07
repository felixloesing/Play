package myPackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

import classes.DatabaseConnector;
import classes.Event;
import classes.User;
/**
 * Servlet implementation class createEventServlet
 */
@WebServlet("/createEventServlet")
public class createEventServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createEventServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String name = request.getParameter("eventName");
		String desc = request.getParameter("eventDesc");
		String website = request.getParameter("eventWebsite");
		String location = request.getParameter("eventLocation");
		String expDate =  request.getParameter("expirationDate");
		
		String username = request.getParameter("username");
		User creator = DatabaseConnector.getUser(username);
		int creatorID = creator.getUserID();
		
		String responseString = "";
		
		if(name == null || name.trim().length() == 0) {
			responseString = "Please enter an event name,";
		}
		else if(desc == null || desc.trim().length() == 0) {
			responseString = "Please enter a description for your event.";
		}
		else if(website == null || desc.trim().length() == 0) {
			responseString = "Please enter a website for your event.";
		}
		else if(location == null || location.trim().length() == 0) {
			responseString = "Please enter a location your event.";
		}
		else if(expDate == null || expDate.trim().length() == 0) {
			responseString = "Please enter a date for your event";
		}
		else {
			String latitude = "0";
			String longitude = "0";
			if(DatabaseConnector.createEvent(name, creatorID, latitude, longitude, desc, expDate, website)) {
				
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

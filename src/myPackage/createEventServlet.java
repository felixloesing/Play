package myPackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import classes.DatabaseConnector;
import classes.Event;
import classes.User;

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
		
		String name = request.getParameter("name");
		String desc = request.getParameter("desc");
		String website = request.getParameter("website");
		String latitude = request.getParameter("lat");
		String longitude = request.getParameter("lng");
		String expDate =  request.getParameter("expDate");
		String category = request.getParameter("category");
		
		HttpSession session = request.getSession();
		String username = (String)session.getAttribute("username");
		if(username == null || username.trim().length() == 0) {
			username = "";
		}
		int creatorID = 1;
		
		if(username != "") {
			User creator = DatabaseConnector.getUser(username);
			creatorID = creator.getUserID();
		}
		
		String responseString = "";
		
		if(name.equals("")) {
			responseString = "Please enter an event name,";
		}
		else if(desc.equals("")) {
			responseString = "Please enter a description for your event.";
		}
		else if(website.equals("")) {
			responseString = "Please enter a website for your event.";
		}
		else if(longitude.equals("") || latitude.equals("")) {
			responseString = "Please enter a location your event.";
		}
		else if(expDate.equals("")) {
			responseString = "Please enter a date for your event";
		}
		else {
			try {
			    SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
			    Date parsedDate = dateFormat.parse(expDate);
			    Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
			    DatabaseConnector.createEvent(name, creatorID, latitude, longitude, desc, timestamp, website, category);
			} 
			catch (ParseException e) {
				System.out.println("Exception :" + e);
			}
			
		}
		
		System.out.println("event status: " + responseString);
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

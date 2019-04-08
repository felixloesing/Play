package myPackage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import classes.DatabaseConnector;
import classes.Event;

/**
 * Servlet implementation class EventsServlet
 */
@WebServlet("/EventsServlet")
public class EventsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//DatabaseConnector.createEvent("Felix", 3, "34.027502", "-118.284466", "Tennis", new Timestamp(2019-1900, 11, 10, 12, 50, 0, 0), "test.com");
		
		ArrayList<Event> events = DatabaseConnector.getEvents();
				
		String json = new Gson().toJson(events);
				
		response.getWriter().write(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

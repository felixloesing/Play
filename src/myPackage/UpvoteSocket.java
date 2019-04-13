package myPackage;

import java.io.IOException;
import java.util.Map;
import java.util.Vector;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;

import classes.DatabaseConnector;
import classes.Event;

@ServerEndpoint(value = "/upvoteSocket")
public class UpvoteSocket {
private static Vector<Session> sessionVector = new Vector<Session>(); 
	
	@OnOpen
	public void open(Session session) {
		//System.out.println("upvotes Connection Made!");
		sessionVector.add(session);
	}
	
	@OnMessage
	public void onMessage(String message, Session session) {
		//System.out.println("Message received: " + message);
		String eventIDString = "";
		String messageString = "";
		
        try {
        	@SuppressWarnings("rawtypes")
			Map jsonJavaRootObject = new Gson().fromJson(message, Map.class);
        	eventIDString = jsonJavaRootObject.get("eventID").toString();
        	messageString = jsonJavaRootObject.get("message").toString();

			boolean success = false;
			
			if (messageString.equals("upvote")) {
				success = DatabaseConnector.upvoteEvent(Integer.valueOf(eventIDString));
			} else if (messageString.equals("downvote")) {
				success = DatabaseConnector.downVotes(Integer.valueOf(eventIDString));
			}
			Event e = DatabaseConnector.getEvent(Integer.valueOf(eventIDString));
			
			
			for (Session s : sessionVector) {
				try {
					if(success) {
						s.getBasicRemote().sendText(String.valueOf(e.getUpvotes()));
					} else {
						s.getBasicRemote().sendText("Error");
					}
					
				} catch (IOException ex) {
					ex.printStackTrace();
				}
			}
		} catch (JsonSyntaxException e) {
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
	}
	
	@OnClose
	public void close(Session session) {
		//System.out.println("upvotes Disconnected!");
		sessionVector.remove(session);
	}
	
	@OnError
	public void error(Throwable error) {
		System.out.println("upvotes Error!");
	}
}

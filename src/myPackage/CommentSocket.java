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

@ServerEndpoint(value = "/commentSocket")
public class CommentSocket {

private static Vector<Session> sessionVector = new Vector<Session>(); 
	
	@OnOpen
	public void open(Session session) {
		//System.out.println("CommentSocket Connection Made!");
		sessionVector.add(session);
	}
	
	@OnMessage
	public void onMessage(String message, Session session) {
		//System.out.println("Message received: " + message);
		String creatorIDString = "";
		String eventIDString = "";
		String messageString = "";
        
		
        try {
        	@SuppressWarnings("rawtypes")
			Map jsonJavaRootObject = new Gson().fromJson(message, Map.class);
        	creatorIDString = jsonJavaRootObject.get("creatorID").toString();
        	eventIDString = jsonJavaRootObject.get("eventID").toString();
        	messageString = jsonJavaRootObject.get("message").toString();
			  
			
			boolean success = DatabaseConnector.createComment(
					Integer.valueOf(creatorIDString), 
					Integer.valueOf(eventIDString), messageString);
			String usernameString = DatabaseConnector.getUser(
					Integer.valueOf(creatorIDString)).getUsername();
			
			for (Session s : sessionVector) {
				try {
					if(success) {
						s.getBasicRemote().sendText(usernameString + 
								": " + messageString);
					} else {
						s.getBasicRemote().sendText("Sorry, an error occured "
								+ "while posting your comment");
					}
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} catch (JsonSyntaxException e) {
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
	}
	
	@OnClose
	public void close(Session session) {
		//System.out.println("CommentSocket Disconnected!");
		sessionVector.remove(session);
	}
	
	@OnError
	public void error(Throwable error) {
		System.out.println("CommentSocket Error!");
	}

}

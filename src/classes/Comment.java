package classes;

import java.sql.Timestamp;
import java.util.Date;

public class Comment {
	private int commentID;
	private User creator;
	private String message;
	private Date createdAt;
	
	public Comment(int commentID, int creatorID, String username, String message, Timestamp createdAt) {
		this.commentID = commentID;
		this.creator = new User(creatorID, username); // join in the username
		this.message = message;
		this.createdAt = createdAt;
	}

	public int getCommentID() {
		return commentID;
	}

	public User getCreator() {
		return creator;
	}

	public String getMessage() {
		return message;
	}

	public Date getCreatedAt() {
		return createdAt;
	}
}

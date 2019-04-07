package myPackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DB {

	public DB() {
		// TODO Auto-generated constructor stub
	}
	
	public static int registerUser(String username, String password) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		PreparedStatement pStatement2 = null;
		ResultSet rSet = null;
		ResultSet rSet2 = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Play?user=root&password=root");
			
			pStatement2 = connection.prepareStatement("SELECT * FROM Users WHERE username=?");
			pStatement2.setString(1, username);
			rSet2 = pStatement2.executeQuery();
			int n = 0;
			while (rSet2.next()) {
				String rString = rSet2.getString("username");
				if (rString.equals(username)) {
					n++;
				}
				
			}
			System.out.println("Number of users: " + n);
			if (n > 0) {
				return 0;
			}
			System.out.println("does this still run?? ");
			pStatement = connection.prepareStatement("INSERT INTO Users(username, pw) VALUES (?, ?)");
			pStatement.setString(1, username);
			pStatement.setString(2, password);
			pStatement.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println("sqle add page: " + sqle.getMessage());
			return 0;
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if (rSet != null) {
					rSet.close();
				}
				if (pStatement != null) {
					pStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle closing: " + sqle.getMessage());
			}
		}
		return 1;
	}
	
	public static int login(String username, String password) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		PreparedStatement pStatement2 = null;
		ResultSet rSet = null;
		ResultSet rSet2 = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Play?user=root&password=root");
			
			pStatement2 = connection.prepareStatement("SELECT * FROM Users WHERE username=?");
			pStatement2.setString(1, username);
			rSet2 = pStatement2.executeQuery();
			int n = 0;
			while (rSet2.next()) {
				String rString = rSet2.getString("username");
				if (rString.equals(username)) {
					n++;
				}
				
			}
			System.out.println("Number of users: " + n);
			if (n == 0) {
				return 2;
			}
			
			
			pStatement = connection.prepareStatement("SELECT * FROM Users WHERE username=? AND pw=?");
			pStatement.setString(1, username);
			pStatement.setString(2, password);
			rSet = pStatement.executeQuery();
			while (rSet.next()) {
				String un = rSet.getString("username");
				String pw = rSet.getString("pw");
				if (un.equals(username) && pw.equals(password)) {
					System.out.println("match");
					return 1;
					
				}
						
			}
			return 0;
		} catch (SQLException sqle) {
			System.out.println("sqle login: " + sqle.getMessage());
			return 0;
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
			return 0;
		} finally {
			try {
				if (rSet != null) {
					rSet.close();
				}
				if (pStatement != null) {
					pStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle closing: " + sqle.getMessage());
				return 0;
			}
		}
	}
	
	public static void addSearch(String username, String searchTerm) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet rSet = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Play?user=root&password=root");
			pStatement = connection.prepareStatement("INSERT INTO Searches(searchTerm, username) VALUES (?, ?)");
			pStatement.setString(1, searchTerm);
			pStatement.setString(2, username);
			pStatement.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println("sqle add page: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if (rSet != null) {
					rSet.close();
				}
				if (pStatement != null) {
					pStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle closing: " + sqle.getMessage());
			}
			System.out.println("Successfully added search: " + searchTerm);
		}
	}
	
	public static ArrayList<String> returnResults(String username) {
		Connection connection = null;
		PreparedStatement pStatement = null;
		ResultSet rSet = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Play?user=root&password=root");
			pStatement = connection.prepareStatement("SELECT * FROM Searches WHERE username=? ORDER BY created DESC");
			pStatement.setString(1, username);
			rSet = pStatement.executeQuery();
			
			ArrayList<String> list = new ArrayList<String>();
			
			while (rSet.next()) {
				String loc = rSet.getString("searchTerm");
				list.add(loc);
			}
			
			return list;
			
		} catch (SQLException sqle) {
			System.out.println("sqle login: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if (rSet != null) {
					rSet.close();
				}
				if (pStatement != null) {
					pStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle closing: " + sqle.getMessage());
			}
		}
		return null;
	}
	
}

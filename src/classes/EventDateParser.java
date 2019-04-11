package classes;

import java.util.Date;

public class EventDateParser {
	private int month;
	private int day;
	private int hour;
	private int minute;
	
	@SuppressWarnings("deprecation")
	public EventDateParser(Date eventDate) {
		this.month = eventDate.getMonth();
		this.day = eventDate.getDate();
		this.hour = eventDate.getHours();
		this.minute = eventDate.getMinutes();
	}
	
	public String getMonth() {
		if(month == 1) {
			return "Jan";
		}
		else if (month == 2) {
			return "Feb";
		}
		else if(month == 3) {
			return "Mar";
		}
		else if(month == 4) {
			return "Apr";
		}
		else if(month == 5) {
			return "May";
		}
		else if(month == 6) {
			return "Jun";
		}
		else if(month == 7) {
			return "Jul";
		}
		else if(month == 8) {
			return "Aug";
		}
		else if(month == 9) {
			return "Sep";
		}
		else if(month == 10) {
			return "Oct";
		}
		else if(month == 11) {
			return "Nov";
		}
		else if(month == 12) {
			return "Dec";
		}
		else {
			System.out.println("Invalid month");
			return null;
		}
	}
	
	public int getDay() {
		return day;
	}
	
	public int getHour() {
		return hour;
	}
	
	public int getMinute() {
		return minute;
	}
}

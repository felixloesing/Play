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
	
	public int getMonth() {
		return month;
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

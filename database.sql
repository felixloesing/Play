DROP DATABASE if exists Play;
CREATE DATABASE Play;
USE Play;
CREATE TABLE User (
	userID int(11) primary key not null auto_increment,
	username varchar(50) not null,
	password varchar(50) not null
);
INSERT INTO User (username, password) VALUES ('Barack', 'asdf');
INSERT INTO User (username, password) VALUES ('GeorgeW', 'asdf');
INSERT INTO User (username, password) VALUES ('DonaldUser', 'asdf');
CREATE TABLE Event (
	eventID int(11) primary key not null auto_increment,
	name varchar(50) not null
);
CREATE TABLE Comment (
	commentID int(11) primary key not null auto_increment,
	userID int(11) not null,
	eventID int(11) not null,
	FOREIGN KEY fk1(userID) REFERENCES User(userID),
	FOREIGN KEY fk2(pageID) REFERENCES Event(eventID)
);
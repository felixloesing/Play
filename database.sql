DROP DATABASE if exists Play;
CREATE DATABASE Play;
USE Play;

SET @@global.time_zone = '-07:00';

SET @@session.time_zone = '-07:00';

CREATE TABLE `User` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC));
  
INSERT INTO User (username, password)
	VALUES 	('Carson', 'pw'), 
			('Fariz', 'pw'),
            ('Felix', 'pw'),
            ('Michael', 'pw');

CREATE TABLE `Event` (
  `eventID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `creatorID` INT NOT NULL,
  `latitude` VARCHAR(45) NOT NULL,
  `longitude` VARCHAR(45) NOT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upvotes` INT NOT NULL DEFAULT 0,
  `description` VARCHAR(2000) NOT NULL,
  `expirationDate` DATETIME NOT NULL,
  `website` VARCHAR(500) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`eventID`),
  INDEX `userID_idx` (`creatorID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`creatorID`)
    REFERENCES `Play`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `Comment` (
  `commentID` INT NOT NULL AUTO_INCREMENT,
  `creatorID` INT NOT NULL,
  `eventID` INT NOT NULL,
  `message` VARCHAR(1000) NOT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`commentID`),
  INDEX `userID_idx` (`creatorID` ASC),
  INDEX `eventID_idx` (`eventID` ASC),
  CONSTRAINT `userID_comment`
    FOREIGN KEY (`creatorID`)
    REFERENCES `Play`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `eventID`
    FOREIGN KEY (`eventID`)
    REFERENCES `Play`.`Event` (`eventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: medical1
-- Source Schemata: medical
-- Created: Fri Dec  8 11:21:38 2017
-- Workbench Version: 6.3.9
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema medical1
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `medical1` ;
CREATE SCHEMA IF NOT EXISTS `medical1` ;

-- ----------------------------------------------------------------------------
-- Table medical1.address
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical1`.`address` (
  `UserId` VARCHAR(20) NOT NULL,
  `Bno` VARCHAR(45) NULL DEFAULT NULL,
  `Loc` VARCHAR(45) NULL DEFAULT NULL,
  `City` VARCHAR(45) NULL DEFAULT NULL,
  `State` VARCHAR(45) NULL DEFAULT NULL,
  `Pincode` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`UserId`),
  CONSTRAINT `address_ibfk_1`
    FOREIGN KEY (`UserId`)
    REFERENCES `medical1`.`personinfo` (`UserID`),
  CONSTRAINT `address_ibfk_2`
    FOREIGN KEY (`UserId`)
    REFERENCES `medical1`.`personinfo` (`UserID`)
    ON DELETE CASCADE,
  CONSTRAINT `address_ibfk_3`
    FOREIGN KEY (`UserId`)
    REFERENCES `medical1`.`personinfo` (`UserID`)
    ON DELETE CASCADE,
  CONSTRAINT `address_ibfk_4`
    FOREIGN KEY (`UserId`)
    REFERENCES `medical1`.`personinfo` (`UserID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table medical1.admin
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical1`.`admin` (
  `AdminID` VARCHAR(25) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AdminID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table medical1.appointments
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical1`.`appointments` (
  `appid` INT(11) NOT NULL AUTO_INCREMENT,
  `userid` VARCHAR(20) NOT NULL,
  `docid` INT(11) NOT NULL,
  `dateofapp` DATE NULL DEFAULT NULL,
  `timeslot` VARCHAR(45) NULL DEFAULT NULL,
  `timing` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`appid`, `userid`, `docid`),
  INDEX `docid` (`docid` ASC),
  INDEX `userid` (`userid` ASC),
  CONSTRAINT `appointments_ibfk_1`
    FOREIGN KEY (`userid`)
    REFERENCES `medical1`.`personinfo` (`UserID`)
    ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_2`
    FOREIGN KEY (`docid`)
    REFERENCES `medical1`.`docinfo` (`docid`)
    ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_3`
    FOREIGN KEY (`userid`)
    REFERENCES `medical1`.`personinfo` (`UserID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 67
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table medical1.docinfo
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical1`.`docinfo` (
  `docid` INT(11) NOT NULL AUTO_INCREMENT,
  `dname` VARCHAR(45) NULL DEFAULT NULL,
  `dphone` VARCHAR(45) NULL DEFAULT NULL,
  `daddress` VARCHAR(45) NULL DEFAULT NULL,
  `dfield` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`docid`),
  INDEX `field_idx` (`dfield` ASC),
  CONSTRAINT `docinfo_ibfk_1`
    FOREIGN KEY (`dfield`)
    REFERENCES `medical1`.`field` (`fieldid`)
    ON DELETE SET NULL,
  CONSTRAINT `docinfo_ibfk_2`
    FOREIGN KEY (`dfield`)
    REFERENCES `medical1`.`field` (`fieldid`)
    ON DELETE SET NULL,
  CONSTRAINT `field`
    FOREIGN KEY (`dfield`)
    REFERENCES `medical1`.`field` (`fieldid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table medical1.field
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical1`.`field` (
  `fieldid` INT(11) NOT NULL,
  `field` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`fieldid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table medical1.personinfo
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `medical1`.`personinfo` (
  `UserID` VARCHAR(20) NOT NULL,
  `Pass` VARCHAR(45) NOT NULL,
  `Fname` VARCHAR(45) NULL DEFAULT NULL,
  `Lname` VARCHAR(45) NULL DEFAULT NULL,
  `Gender` VARCHAR(10) NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `phone` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Routine medical1.appid
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `medical1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `appid`(in userr varchar(20),in doc int)
begin
 select p.userid, p.fname,p.lname,p.gender,p.dob,p.phone,d.docid,d.dname,d.dphone,d.daddress,f.field,a.dateofapp,a.timeslot,a.timing from personinfo p,docinfo d,appointments a, field f  where p.userid=userr and p.userid=a.userid and d.docid=doc and a.docid=d.docid and d.dfield=f.fieldid;
 end$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine medical1.appoint
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `medical1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `appoint`(in dates date,in times varchar(45),in doc int)
if (select count(*) from appointments where dateofapp=dates and timing=times and docid=doc)=1 then
 signal sqlstate '40000'
			set message_text='Appointments full for this time';
 end if$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine medical1.dates
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `medical1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `dates`(in datee date)
begin
if datee<now() then
delimiter sqlstate '40000'
			set message_text='Date is already over';
 end if;
end$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine medical1.del
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `medical1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del`(in userr varchar(20),in doc int)
begin
delete from appointments where userid=userr and docid=doc;
end$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine medical1.pass
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `medical1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pass`(in password varchar(45))
begin
if length(password)<6 then
 DELIMITER sqlstate '40000'
			set message_text='Password should be more than 6 Characters';
 end if;
 end$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Trigger medical1.trig3
-- ----------------------------------------------------------------------------
DELIMITER $$
USE `medical1`$$
CREATE DEFINER=`root`@`localhost` trigger trig3
before insert on appointments
for each row 
begin 
call dates(new.dateofapp);
end;

-- ----------------------------------------------------------------------------
-- Trigger medical1.trig1
-- ----------------------------------------------------------------------------
DELIMITER $$
USE `medical1`$$
CREATE DEFINER=`root`@`localhost` trigger `trig1`
before insert on appointments
for each row
begin
call appoint(new.dateofapp,new.timing,new.docid);
end;

-- ----------------------------------------------------------------------------
-- Trigger medical1.trig2
-- ----------------------------------------------------------------------------
DELIMITER $$
USE `medical1`$$
CREATE DEFINER=`root`@`localhost` trigger trig2
 before insert on personinfo
 for each row
 begin 
 call pass(new.pass);
 end;
SET FOREIGN_KEY_CHECKS = 1;

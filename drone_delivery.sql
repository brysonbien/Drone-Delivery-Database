-- CS4400: Introduction to Database Systems (Summer 2022)
-- Phase II: Create Table & Insert Statements [v0]
-- Team 2
-- Elliot Willner (ewillner3)
-- Bryson Bien (bbien6)
-- Maxwell Sikora (msikora3)
-- Directions:
-- Please follow all instructions for Phase II as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.
-- ------------------------------------------------------
-- CREATE TABLE STATEMENTS AND INSERT STATEMENTS BELOW
-- ------------------------------------------------------
DROP DATABASE IF EXISTS drone_delivery;
CREATE DATABASE IF NOT EXISTS drone_delivery;
CREATE SCHEMA IF NOT EXISTS drone_delivery;
USE drone_delivery;

DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS ITEM;
DROP TABLE IF EXISTS DRONE_PILOT;
DROP TABLE IF EXISTS FLOOR_WORKER;
DROP TABLE IF EXISTS STORE;
DROP TABLE IF EXISTS DRONE;
DROP TABLE IF EXISTS ORDERS;
DROP TABLE IF EXISTS CONTAIN;
DROP TABLE IF EXISTS EMPLOY;

CREATE TABLE USERS (
    fname VARCHAR(50),
    lname VARCHAR(50),
    address VARCHAR(500),
    birthdate DATE,
    uname VARCHAR(40) NOT NULL,
    PRIMARY KEY(uname),
    UNIQUE(uname)
    );
INSERT INTO USERS VALUES("Aaron", "Wilson", "220 Peachtree Street", "1963-11-11", "awilson5"),("Claire", "Soares", "706 Living Stone Way", "1965-09-03", "csoares8"),("Ella", "Charles", "22 Peachtree Street", "1974-05-06", "echarles19"),("Erica", "Ross", "22 Peachtree Street", "1975-04-02", "eross10"),("Harmon", "Stark",  "53 Tanker Top Lane", "1971-10-27", "hstark16"),("Jared", "Stone", "101 Five Finger Way", "1961-01-06", "jstone5"),("Lina", "Rodriguez", "360 Corkscrew Circle", "1975-04-02", "lrodriguez5"),("Sarah", "Prince", "22 Peachtree Street", "1968-06-15", "sprince6"),("Trey", "McCall", "360 Corkscrew Circle", "1973-03-19", "tmccall5");

CREATE TABLE CUSTOMER (
	uname VARCHAR(40),
    rating INT,
    credit INT,
    PRIMARY KEY(uname),
    CONSTRAINT uname_fk1 FOREIGN KEY(uname) REFERENCES USERS(uname)
    );
INSERT INTO CUSTOMER VALUES("awilson5", 2, 100),("jstone5", 4, 40),("lrodriguez5", 4, 60),("sprince6", 5, 30);

CREATE TABLE EMPLOYEE (
	taxID VARCHAR(40) NOT NULL,
    uname VARCHAR(40),
    hired DATE,
    salary INT,
    service INT,
    PRIMARY KEY(taxID, uname),
    UNIQUE(taxID),
    CONSTRAINT uname_fk2 FOREIGN KEY(uname) REFERENCES USERS(uname)
    );
INSERT INTO EMPLOYEE VALUES("111-11-1111", "awilson5", "2020-03-15", 46000, 9),("888-88-8888", "csoares8", "2019-02-05", 57000, 26),("777-77-7777", "echarles19", "2021-01-02", 27000, 3),("444-44-4444", "eross10", "2020-04-17", 61000, 10),("555-55-5555", "hstark16", "2018-07-23", 59000, 20),("222-22-2222", "lrodriguez5","2019-04-15", 58000, 20),("333-33-3333", "tmccall5", "2018-10-17", 33000, 29);

CREATE TABLE ITEM (
	barcode VARCHAR(40) NOT NULL,
    weight INT,
	iname VARCHAR(40), 
    PRIMARY KEY(barcode),
    UNIQUE(barcode)
    );
INSERT INTO ITEM VALUES("ss_2D4E6L", 3, "shrimp salad"),("ap_9T25E36L", 4, "antipasto platter"),("pr_3C6A9R", 6, "pot roast"),("hs_5E7L23M", 3, "hoagie sandwich"),("clc_4T9U25X", 5, "chocolate lava cake");

CREATE TABLE DRONE_PILOT (
	licenseID VARCHAR(40) NOT NULL,
    taxID VARCHAR(40),
    uname VARCHAR(40),
    experience INT,
    PRIMARY KEY(licenseID, taxID, uname),
    UNIQUE(licenseID),
    CONSTRAINT uname_fk3 FOREIGN KEY(uname) REFERENCES EMPLOYEE(uname),
    CONSTRAINT taxID_fk2 FOREIGN KEY(taxID) REFERENCES EMPLOYEE(taxID)
    );
INSERT INTO DRONE_PILOT VALUES("314159","111-11-1111", "awilson5", 41),("287182", "222-22-2222", "lrodriguez5", 67),("181633", "333-33-3333", "tmccall5", 10);

CREATE TABLE FLOOR_WORKER (
	uname VARCHAR(40),
    taxID VARCHAR(40),
    PRIMARY KEY(uname, taxID),
    CONSTRAINT uname_fk4 FOREIGN KEY(uname) REFERENCES EMPLOYEE(uname),
    CONSTRAINT taxID FOREIGN KEY(taxID) REFERENCES EMPLOYEE(taxID)
    );
INSERT INTO FLOOR_WORKER VALUES("eross10", "444-44-4444"),("hstark16", "555-55-5555"),("echarles19", "777-77-7777"),("lrodriguez5", "222-22-2222");    

CREATE TABLE STORE (
	storeID VARCHAR(40) NOT NULL,
    sname VARCHAR(40),
    manager VARCHAR(40),
    revenue INT,
    PRIMARY KEY(storeID),
    UNIQUE(storeID),
    CONSTRAINT manager_fk1 FOREIGN KEY(manager) REFERENCES FLOOR_WORKER(uname)
    );
INSERT INTO STORE VALUES("pub", "Publix", "hstark16", 200),("krg", "Kroger", "echarles19", 300);

CREATE TABLE DRONE (
	droneTag VARCHAR(40) NOT NULL,
    storeID VARCHAR(40),
    rem_trips INT,
    capacity INT,
    serve VARCHAR(40),
    control VARCHAR(40),
    PRIMARY KEY(droneTag, serve),
    UNIQUE(droneTag),
    CONSTRAINT serve_fk1 FOREIGN KEY(serve) REFERENCES STORE(storeID),
    CONSTRAINT control_fk1 FOREIGN KEY(control) REFERENCES DRONE_PILOT(licenseID)
	);
INSERT INTO DRONE VALUES("Publix's drone #1", "pub", 3, 10, "pub", "314159"),("Publix's drone #2", "pub", 2, 20, "pub", "181633"),("Kroger's drone #1", "krg", 4, 15, "krg", "287182");

CREATE TABLE ORDERS (
	orderID VARCHAR(40) NOT NULL,
    request VARCHAR(40),
    deliver VARCHAR(40),
    sold_on DATE,
    PRIMARY KEY(orderID),
    UNIQUE(orderID),
    CONSTRAINT request_fk1 FOREIGN KEY(request) REFERENCES CUSTOMER(uname),
    CONSTRAINT deliver_fk1 FOREIGN KEY(deliver) REFERENCES DRONE(droneTag)
    );
INSERT INTO ORDERS VALUES("pub_303", "sprince6", "Publix's drone #1", "2021-05-23"),("krg_217", "jstone5", "Kroger's drone #1", "2021-05-23"),("pub_306", "awilson5", "Publix's drone #2", "2021-05-22"),("pub_305", "sprince6", "Publix's drone #2", "2021-05-22");

CREATE TABLE CONTAIN (
	price1 INT,
    quantity1 INT,
    barcode VARCHAR(40),
    orderID VARCHAR(40),
    PRIMARY KEY(barcode, orderID),
    CONSTRAINT barcode_fk1 FOREIGN KEY(barcode) REFERENCES ITEM(barcode),
    CONSTRAINT orderID_fk1 FOREIGN KEY(orderID) REFERENCES ORDERS(orderID)
    );
INSERT INTO CONTAIN VALUES(4, 1, "ap_9T25E36L", "pub_303"),(15,2,"pr_3C6A9R", "krg_217"),(3,2, "hs_5E7L23M", "pub_306"),(10,1, "ap_9T25E36L", "pub_306"),(3,2, "clc_4T9U25X", "pub_305");

CREATE TABLE EMPLOY (
	storeID VARCHAR(40),
    uname VARCHAR(40),
    taxID VARCHAR(40),
    PRIMARY KEY(storeID, uname, taxID),
	CONSTRAINT storeID_fk1 FOREIGN KEY(storeID) REFERENCES STORE(storeID),
    CONSTRAINT uname_fk5 FOREIGN KEY(uname) REFERENCES FLOOR_WORKER(uname),
    CONSTRAINT taxID_fk4 FOREIGN KEY(taxID) REFERENCES FLOOR_WORKER(taxID)
    );
INSERT INTO EMPLOY VALUES("pub", "hstark16", "555-55-5555"),("pub", "eross10", "444-44-4444"),("pub", "awilson5", "111-11-1111"),("pub", "tmccall5", "333-33-3333"),("krg", "echarles19", "777-77-7777"),("krg", "eross10", "444-44-4444"),("krg", "lrodriguez5", "222-22-2222");
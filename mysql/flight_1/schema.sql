-- drop table flight cascade;
-- drop table aircraft cascade;
-- drop table employee cascade;
-- drop table certificate cascade;

CREATE TABLE flight (
    flno NUMERIC(4,0) PRIMARY KEY,
    origin VARCHAR(20),
    destination VARCHAR(20),
    distance NUMERIC(6,0),
    departure_date DATE,
    arrival_date DATE,
    price NUMERIC(7,2),
    aid NUMERIC(9,0),
    FOREIGN KEY (aid) REFERENCES aircraft(aid)
);

CREATE TABLE aircraft(
	aid NUMERIC(9,0) PRIMARY KEY,
	name VARCHAR(30),
	distance NUMERIC(6,0)
);

CREATE TABLE employee (
    eid NUMERIC(9,0) PRIMARY KEY,
    name VARCHAR(30),
    salary NUMERIC(10,2)
);

CREATE TABLE certificate (
    eid NUMERIC(9,0),
    aid NUMERIC(9,0),
    PRIMARY KEY (eid, aid),
    FOREIGN KEY (eid) REFERENCES employee (eid),
    FOREIGN KEY (aid) REFERENCES aircraft (aid)
);
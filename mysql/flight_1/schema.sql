CREATE TABLE aircraft(
	aid NUMERIC(9,0) PRIMARY KEY,
	name VARCHAR(30),
	distance NUMERIC(6,0)
);

CREATE TABLE flight (
    flno NUMERIC(4,0) PRIMARY KEY,
    origin VARCHAR(20),
    destination VARCHAR(20),
    distance NUMERIC(6,0),
    departure_date DATETIME,
    arrival_date DATETIME,
    price NUMERIC(7,2),
    aid NUMERIC(9,0),
    FOREIGN KEY (aid) REFERENCES aircraft(aid)
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


INSERT INTO aircraft (AID, name, distance) VALUES ('1', 'Boeing 747-400', '8430');
INSERT INTO aircraft (AID, name, distance) VALUES ('2', 'Boeing 737-800', '3383');
INSERT INTO aircraft (AID, name, distance) VALUES ('3', 'Airbus A340-300', '7120');
INSERT INTO aircraft (AID, name, distance) VALUES ('4', 'British Aerospace Jetstream 41', '1502');
INSERT INTO aircraft (AID, name, distance) VALUES ('5', 'Embraer ERJ-145', '1530');
INSERT INTO aircraft (AID, name, distance) VALUES ('6', 'SAAB 340', '2128');
INSERT INTO aircraft (AID, name, distance) VALUES ('7', 'Piper Archer III', '520');
INSERT INTO aircraft (AID, name, distance) VALUES ('8', 'Tupolev 154', '4103');
INSERT INTO aircraft (AID, name, distance) VALUES ('16', 'Schwitzer 2-33', '30');
INSERT INTO aircraft (AID, name, distance) VALUES ('9', 'Lockheed L1011', '6900');
INSERT INTO aircraft (AID, name, distance) VALUES ('10', 'Boeing 757-300', '4010');
INSERT INTO aircraft (AID, name, distance) VALUES ('11', 'Boeing 777-300', '6441');
INSERT INTO aircraft (AID, name, distance) VALUES ('12', 'Boeing 767-400ER', '6475');
INSERT INTO aircraft (AID, name, distance) VALUES ('13', 'Airbus A320', '2605');
INSERT INTO aircraft (AID, name, distance) VALUES ('14', 'Airbus A319', '1805');
INSERT INTO aircraft (AID, name, distance) VALUES ('15', 'Boeing 727', '1504');


INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (99.0, 'Los Angeles', 'Washington D.C.', 2308.0, '2005-04-12 09:30', '2005-04-12 09:40', 235.98, 1);
INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (13.0, 'Los Angeles', 'Chicago', 1749.0, '2005-04-12 08:45', '2005-04-12 08:45', 220.98, 3);
INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (346.0, 'Los Angeles', 'Dallas', 1251.0, '2005-04-12 11:50', '2005-04-12 07:05', 225-43, 2);
INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (387.0, 'Los Angeles', 'Boston', 2606.0, '2005-04-12 07:03', '2005-04-12 05:03', 261.56, 6);
INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (7.0, 'Los Angeles', 'Sydney', 7487.0, '2005-04-12 05:30', '2005-04-12 11:10', 278.56, 3);
INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (2.0, 'Los Angeles', 'Tokyo', 5478.0, '2005-04-12 06:30', '2005-04-12 03:55', 780.99, 9);
INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (33.0, 'Los Angeles', 'Honolulu', 2551.0, '2005-04-12 09:15', '2005-04-12 11:15', 375.23, 7);
INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (34.0, 'Los Angeles', 'Honolulu', 2551.0, '2005-04-12 12:45', '2005-04-12 03:18', 425.98, 5);
INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (76.0, 'Chicago', 'Los Angeles', 1749.0, '2005-04-12 08:32', '2005-04-12 10:03', 220.98, 9);
INSERT INTO flight (FLNO, origin, destination, distance, departure_date, arrival_date, price, aid) VALUES (68.0, 'Chicago', 'New York', 802.0, '2005-04-12 09:00', '2005-04-12 12:02', 202.45, 10);



INSERT INTO employee (EID, name, salary) VALUES ('242518965', 'James Smith', '120433');
INSERT INTO employee (EID, name, salary) VALUES ('141582651', 'Mary Johnson', '178345');
INSERT INTO employee (EID, name, salary) VALUES ('11564812', 'John Williams', '153972');
INSERT INTO employee (EID, name, salary) VALUES ('567354612', 'Lisa Walker', '256481');
INSERT INTO employee (EID, name, salary) VALUES ('552455318', 'Larry West', '101745');
INSERT INTO employee (EID, name, salary) VALUES ('550156548', 'Karen Scott', '205187');
INSERT INTO employee (EID, name, salary) VALUES ('390487451', 'Lawrence Sperry', '212156');
INSERT INTO employee (EID, name, salary) VALUES ('274878974', 'Michael Miller', '99890');
INSERT INTO employee (EID, name, salary) VALUES ('254099823', 'Patricia Jones', '24450');
INSERT INTO employee (EID, name, salary) VALUES ('356187925', 'Robert Brown', '44740');
INSERT INTO employee (EID, name, salary) VALUES ('355548984', 'Angela Martinez', '212156');
INSERT INTO employee (EID, name, salary) VALUES ('310454876', 'Joseph Thompson', '212156');
INSERT INTO employee (EID, name, salary) VALUES ('489456522', 'Linda Davis', '27984');
INSERT INTO employee (EID, name, salary) VALUES ('489221823', 'Richard Jackson', '23980');
INSERT INTO employee (EID, name, salary) VALUES ('548977562', 'William Ward', '84476');
INSERT INTO employee (EID, name, salary) VALUES ('310454877', 'Chad Stewart', '33546');
INSERT INTO employee (EID, name, salary) VALUES ('142519864', 'Betty Adams', '227489');
INSERT INTO employee (EID, name, salary) VALUES ('269734834', 'George Wright', '289950');
INSERT INTO employee (EID, name, salary) VALUES ('287321212', 'Michael Miller', '48090');
INSERT INTO employee (EID, name, salary) VALUES ('552455348', 'Dorthy Lewis', '152013');
INSERT INTO employee (EID, name, salary) VALUES ('248965255', 'Barbara Wilson', '43723');
INSERT INTO employee (EID, name, salary) VALUES ('159542516', 'William Moore', '48250');
INSERT INTO employee (EID, name, salary) VALUES ('348121549', 'Haywood Kelly', '32899');
INSERT INTO employee (EID, name, salary) VALUES ('90873519', 'Elizabeth Taylor', '32021');
INSERT INTO employee (EID, name, salary) VALUES ('486512566', 'David Anderson', '43001');
INSERT INTO employee (EID, name, salary) VALUES ('619023588', 'Jennifer Thomas', '54921');
INSERT INTO employee (EID, name, salary) VALUES ('15645489', 'Donald King', '18050');
INSERT INTO employee (EID, name, salary) VALUES ('556784565', 'Mark Young', '205187');
INSERT INTO employee (EID, name, salary) VALUES ('573284895', 'Eric Cooper', '114323');
INSERT INTO employee (EID, name, salary) VALUES ('574489456', 'William Jones', '105743');
INSERT INTO employee (EID, name, salary) VALUES ('574489457', 'Milo Brooks', '20');

INSERT INTO certificate (EID, AID) VALUES ('11564812', '2');
INSERT INTO certificate (EID, AID) VALUES ('11564812', '10');
INSERT INTO certificate (EID, AID) VALUES ('90873519', '6');
INSERT INTO certificate (EID, AID) VALUES ('141582651', '2');
INSERT INTO certificate (EID, AID) VALUES ('141582651', '10');
INSERT INTO certificate (EID, AID) VALUES ('141582651', '12');
INSERT INTO certificate (EID, AID) VALUES ('142519864', '1');
INSERT INTO certificate (EID, AID) VALUES ('142519864', '2');
INSERT INTO certificate (EID, AID) VALUES ('142519864', '3');
INSERT INTO certificate (EID, AID) VALUES ('142519864', '7');
INSERT INTO certificate (EID, AID) VALUES ('142519864', '10');
INSERT INTO certificate (EID, AID) VALUES ('142519864', '11');
INSERT INTO certificate (EID, AID) VALUES ('142519864', '12');
INSERT INTO certificate (EID, AID) VALUES ('142519864', '13');
INSERT INTO certificate (EID, AID) VALUES ('159542516', '5');
INSERT INTO certificate (EID, AID) VALUES ('159542516', '7');
INSERT INTO certificate (EID, AID) VALUES ('242518965', '2');
INSERT INTO certificate (EID, AID) VALUES ('242518965', '10');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '1');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '2');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '3');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '4');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '5');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '6');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '7');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '8');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '9');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '10');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '11');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '12');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '13');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '14');
INSERT INTO certificate (EID, AID) VALUES ('269734834', '15');
INSERT INTO certificate (EID, AID) VALUES ('274878974', '10');
INSERT INTO certificate (EID, AID) VALUES ('274878974', '12');
INSERT INTO certificate (EID, AID) VALUES ('310454876', '8');
INSERT INTO certificate (EID, AID) VALUES ('310454876', '9');
INSERT INTO certificate (EID, AID) VALUES ('355548984', '8');
INSERT INTO certificate (EID, AID) VALUES ('355548984', '9');
INSERT INTO certificate (EID, AID) VALUES ('356187925', '6');
INSERT INTO certificate (EID, AID) VALUES ('390487451', '3');
INSERT INTO certificate (EID, AID) VALUES ('390487451', '13');
INSERT INTO certificate (EID, AID) VALUES ('390487451', '14');
INSERT INTO certificate (EID, AID) VALUES ('548977562', '7');
INSERT INTO certificate (EID, AID) VALUES ('550156548', '1');
INSERT INTO certificate (EID, AID) VALUES ('550156548', '12');
INSERT INTO certificate (EID, AID) VALUES ('552455318', '2');
INSERT INTO certificate (EID, AID) VALUES ('552455318', '7');
INSERT INTO certificate (EID, AID) VALUES ('552455318', '14');
INSERT INTO certificate (EID, AID) VALUES ('556784565', '2');
INSERT INTO certificate (EID, AID) VALUES ('556784565', '3');
INSERT INTO certificate (EID, AID) VALUES ('556784565', '5');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '1');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '2');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '3');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '4');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '5');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '7');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '9');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '10');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '11');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '12');
INSERT INTO certificate (EID, AID) VALUES ('567354612', '15');
INSERT INTO certificate (EID, AID) VALUES ('573284895', '3');
INSERT INTO certificate (EID, AID) VALUES ('573284895', '4');
INSERT INTO certificate (EID, AID) VALUES ('573284895', '5');
INSERT INTO certificate (EID, AID) VALUES ('574489456', '6');
INSERT INTO certificate (EID, AID) VALUES ('574489456', '8');
INSERT INTO certificate (EID, AID) VALUES ('574489457', '7');


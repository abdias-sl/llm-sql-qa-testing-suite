CREATE TABLE Manufacturers (
  Code INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL
);

CREATE TABLE Products (
  Code INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  Manufacturer INT NOT NULL,
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
);

CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  Headquarter VARCHAR(255) NOT NULL,
  Founder VARCHAR(255) NOT NULL,
  Revenue REAL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  Price DECIMAL NOT NULL,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code),
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
);
create database FarmIn;
use FarmIn

-- Table: Investors
CREATE TABLE Investors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(25),
    pan_card text NOT null,
    adhar_no  varchar(12) NOT NULL,
    address TEXT not null,
    CONSTRAINT unique_adhar_investor UNIQUE (adhar_no)
);

INSERT INTO Investors (name, email, password_hash, pan_card,adhar_no,address)
VALUES
    ('Bhageerathan pilla', 'abhiramns@gmail.com', 'password123', "","923343940932","maneesh kuar vilasam"),
    ('Abhijith', 'abhijith@gmail.com', 'password123', "","021273940932","Barvthi vilasam");



CREATE TABLE Admin(
    id int PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

INSERT INTO Admin (name, email, password_hash)
VALUES
    ('Abhiram', 'abhiramns@gmail.com', 'password123');


-- Table: Farmers
CREATE TABLE Farmers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(25),
    adhar_no varchar(12),
    address TEXT not null,
    CONSTRAINT unique_adhar_farmer UNIQUE (adhar_no)
);

INSERT INTO Farmers (name, email, password_hash,adhar_no,address)
VALUES
    ('Rajupatel', 'Rajupatel@geci.com', 'password123', "122233434","Navikulam district"),
    ('Jane Johnson', 'jane.johnson@gmail.com', 'password456', "8575675","redfium district");



create table Crops(
    id int primary key auto_increment,
    name varchar(100),
    category varchar(100),
    verity VARCHAR(100),
    market_price decimal(10,4),
    time_span int(10),
    season varchar(100),
    description varchar(500)
);


INSERT INTO Crops (name,category,verity,market_price,time_span,season,description)
VALUES
    ('Wheat', 'cerial','malgo',200, '10', "monsooon","A very good crop ");


create table FarmLands(
    id int primary key auto_increment,
    farmer_id int,
    address varchar(300),
    area int ,
    avg_temp int,
    avg_humidity int,
    avg_pressure int,
    latitude decimal(4,2),
    longitude decimal(4,2),
    document varchar(100)
);


INSERT INTO FarmLands (address, farmer_id,area, avg_temp, avg_humidity, avg_pressure, latitude, longitude,document)
VALUES
    ('123 Main St, Bangalore, Karnataka',1, 100, 25, 70, 1013, 12.97, 77.59,"doc");




-- Table: Requests
CREATE TABLE FundingRequests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    farmer_id INT,
    farmland_id INT,
    crop_id INT,
    total_amount INT,
    avilable_amount INT,
    starting_date DATE,
    ending_date DATE,
    area INT,
    state varchar(10) default 'pending'
    -- CONSTRAINT fk_farmer FOREIGN KEY (farmer_id) REFERENCES Farmers (id),
    -- CONSTRAINT fk_farmland FOREIGN KEY (farmland_id) REFERENCES FarmLands (id),
    -- CONSTRAINT fk_crop FOREIGN KEY (pick_id) REFERENCES Picks (id),
    -- CONSTRAINT unique_farmland UNIQUE (farmer_id, farmland_id),
    -- CONSTRAINT chk_total_amount CHECK (total_amount >= 50000)
);

INSERT INTO FundingRequests (farmer_id, farmland_id, crop_id, total_amount,avilable_amount,starting_date,ending_date,area)
VALUES 
   (1, 1, 1, 480000,460,'2023-01-03','2023-04-03',20);




-- Table: Assets
CREATE TABLE CropEquity (
    id INT PRIMARY KEY AUTO_INCREMENT,
    request_id INT,
    qty int,
    price INT
);



CREATE TABLE Holdings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    investor_id INT,
    qty int,
    crop_equity INT,
    date_of_buy Date
);

insert into Holdings values(1,1,12,1,'2023-02-03');

CREATE TABLE SellRequest (
    id INT PRIMARY KEY AUTO_INCREMENT,
    investor_id INT,
    qty int,
    crop_equity INT
);

-- Table: Farmer_history
CREATE TABLE Farmer_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    request_id int,
    profit INT
);


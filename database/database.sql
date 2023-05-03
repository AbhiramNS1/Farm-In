create database FarmIn
use FarmIn

-- create table Investors(
--     id int primary key auto_increment,
--     name varchar(100),
--     email varchar(255) not null,
--     password_hash varchar(25),
--     wallet_address varchar(42),
--     holdings int default 0
-- );

-- create table Farmers(
--     id int primary key auto_increment,
--     name varchar(100),
--     email varchar(255) not null,
--     password_hash varchar(25),
--     total_loan_amount int(10),
--     total_repayment_amount int(10)
-- );




-- INSERT INTO Picks (name, symbol, yeild, expense, date_of_harvest, time_peroid)
-- VALUES
--     ('Wheat', 'WHT', 5000, 2000, '2023-07-31', 120),
--     ('Corn', 'CRN', 8000, 3000, '2023-09-30', 180),
--     ('Rice', 'RCE', 6000, 2500, '2023-11-30', 150),
--     ('Soybeans', 'SOY', 4000, 1500, '2023-10-31', 90),
--     ('Cotton', 'CTN', 3000, 1800, '2023-12-31', 210),
--     ('Barley', 'BLY', 4500, 2200, '2023-08-31', 100),
--     ('Oats', 'OTS', 3500, 1700, '2023-06-30', 75),
--     ('Potatoes', 'POT', 2000, 1200, '2023-10-15', 120),
--     ('Sugarcane', 'SGC', 7000, 2800, '2023-11-15', 180),
--     ('Sorghum', 'SRG', 5500, 2400, '2023-09-15', 120);




-- table to store new requests from farmers .These requests are moved to Picks after verification and approval.

-- create table Requests(
--     id int primary key auto_increment,
--     farmer_id int,
--     farmland_id int,
--     crop_id int,
--     total_amount int
-- );

-- create table Picks(
--     id int primary key auto_increment,
--     name varchar(100),
--     symbol varchar(4),
--     yeild int,
--     expense int,
--     date_of_harvest date,
--     time_peroid int
-- );

-- create table FarmLands(
--     id int primary key auto_increment,
--     address vaarchar(300),
--     area int ,
--     avg_temp int,
--     avg_humidity int,
--     avg_pressure int,
--     avg_windspeed int,
--     latitude decimal(4,2),
--     longitude decimal(4,2)
-- );

-- create table Assets(
--     id int primary key auto_increment,
--     investor_id int,
--     name varchar(100),
--     contract_address varchar(100),
--     todays_value int
-- );

-- create table Investor_history(
--     id int primary key auto_increment,
--     investor_id int,
--     contract_address varchar(100),
--     Profit int,
--     farmer_id int
-- );

-- create table Farmer_history(

-- )



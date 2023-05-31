create database FarmIn;
use FarmIn

-- Table: Investors
CREATE TABLE Investors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(25),
    wallet_address VARCHAR(42),
    holdings INT DEFAULT 0,
    total_invested_amount INT DEFAULT 0,
    CONSTRAINT uk_email UNIQUE (email)
);

INSERT INTO Investors (name, email, password_hash, wallet_address,  total_invested_amount,holdings)
VALUES
    ('Abhiram', 'abhiramns@gmail.com', 'password123', '0x1234567890abcdef', 10000,1000),
    ('Abhijith', 'abhijith@gmail.com', 'password123', '0xabcdef1234567890',20000, 2500),
    ('HariKrishnan', 'harikrishnan@gmail.com', 'password123', '0x4567890abcdef123',32000, 5000),
    ('Anagha', 'anaghar@gmail.com', 'password123', '0x7890abcdef123456', 45000,7500),
    ('David Brown', 'david.brown@gmail.com', 'passworddef', '0x90abcdef12345678',54000, 1500),
    ('Emily Davis', 'emily.davis@gmail.com', 'passwordegh', '0xabcdef1234567890',300000, 30000),
    ('Matthew Taylor', 'matthew.taylor@geci.com', 'passwordhij', '0xdef1234567890abc',450000, 5000),
    ('Olivia Martin', 'olivia.martin@geci.com', 'passwordklm', '0x1234567890abcdef',90000, 2000),
    ('Daniel Anderson', 'daniel.anderson@geci.com', 'passwordnop', '0xabcdef1234567890',23000, 1250),
    ('Sophia Thomas', 'sophia.thomas@geci.com', 'passwordqrs', '0x4567890abcdef123',490000, 40000);


-- Table: Farmers
CREATE TABLE Farmers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(25),
    total_loan_amount INT(10),
    total_repayment_amount INT(10)
);

INSERT INTO Farmers (name, email, password_hash, total_loan_amount, total_repayment_amount)
VALUES
    ('Rajupatel', 'Rajupatel@geci.com', 'password123', 5000, 2500),
    ('Jane Johnson', 'jane.johnson@gmail.com', 'password456', 3000, 1500),
    ('Michael Williams', 'michael.williams@geci.com', 'password789', 2000, 1000),
    ('Sarah Brown', 'sarah.brown@gmail.com', 'passwordabc', 4000, 2000),
    ('David Davis', 'david.davis@geci.com', 'passworddef', 3500, 1750),
    ('Emily Taylor', 'emily.taylor@gmail.com', 'passwordegh', 4500, 2250),
    ('Matthew Martin', 'matthew.martin@gmail.com', 'passwordhij', 2500, 1250),
    ('Olivia Anderson', 'olivia.anderson@geci.com', 'passwordklm', 6000, 3000),
    ('Daniel Thomas', 'daniel.thomas@gmail.com', 'passwordnop', 1500, 750),
    ('Sophia Wilson', 'sophia.wilson@geci.com', 'passwordqrs', 3800, 1900);



create table Picks(
    id int primary key auto_increment,
    name varchar(100),
    symbol varchar(4),
    todays_price int,
    todays_change decimal(5,2),
    date_of_harvest date,
    time_peroid int,
    request_id int UNIQUE,
    total_qantity int
);


INSERT INTO Picks (name, symbol,todays_price, todays_change, date_of_harvest, time_peroid, request_id,total_qantity)
VALUES
    ('Wheat', 'WHT', 500, 2, '2023-07-31', 120,3,30000),
    ('Corn', 'CRN', 800, 3, '2023-09-30', 180,2,2000),
    ('Rice', 'RCE', 600, 2.5, '2023-11-30', 150,6,4000),
    ('Soybeans', 'SOY', 400, 1.5, '2023-10-31', 90,4,12000),
    ('Cotton', 'CTN', 300, 1.8, '2023-12-31', 210,9,34000),
    ('Barley', 'BLY', 450, 2.2, '2023-08-31', 100,10,1200),
    ('Oats', 'OTS', 350, 1.7, '2023-06-30', 75,12,2300),
    ('Potatoes', 'POT', 200, 1.2, '2023-10-15', 120,11,34000),
    ('Sugarcane', 'SGC', 700, 2.8, '2023-11-15', 180,15,5500),
    ('Sorghum', 'SRG', 550, 2.4, '2023-09-15', 120,8,2340);


create table FarmLands(
    id int primary key auto_increment,
    address varchar(300),
    area int ,
    avg_temp int,
    avg_humidity int,
    avg_pressure int,
    avg_windspeed int,
    latitude decimal(4,2),
    longitude decimal(4,2)
);


INSERT INTO FarmLands (address, area, avg_temp, avg_humidity, avg_pressure, avg_windspeed, latitude, longitude)
VALUES
    ('123 Main St, Bangalore, Karnataka', 100, 25, 70, 1013, 10, 12.97, 77.59),
    ('456 Elm St, Mumbai, Maharashtra', 200, 26, 75, 1015, 12, 19.07, 72.87),
    ('789 Oak St, Delhi, Delhi', 150, 24, 68, 1012, 8, 28.61, 77.23),
    ('321 Pine St, Kolkata, West Bengal', 180, 23, 72, 1010, 9, 22.57, 88.36),
    ('654 Maple St, Chennai, Tamil Nadu', 250, 27, 74, 1014, 11, 13.08, 80.27),
    ('987 Birch St, Hyderabad, Telangana', 120, 25, 70, 1013, 10, 17.39, 78.49),
    ('246 Cedar St, Ahmedabad, Gujarat', 190, 26, 75, 1015, 12, 23.03, 72.58),
    ('579 Walnut St, Pune, Maharashtra', 220, 24, 68, 1012, 8, 18.52, 73.85),
    ('135 Ash St, Jaipur, Rajasthan', 140, 23, 72, 1010, 9, 26.91, 75.79),
    ('468 Spruce St, Lucknow, Uttar Pradesh', 170, 27, 74, 1014, 11, 26.84, 80.95),
    ('791 Poplar St, Bhopal, Madhya Pradesh', 160, 26, 70, 1013, 10, 23.24, 77.39),
    ('124 Pine St, Chandigarh, Punjab', 190, 25, 75, 1015, 12, 30.75, 76.78),
    ('357 Oak St, Guwahati, Assam', 200, 24, 68, 1012, 8, 26.14, 91.77),
    ('680 Maple St, Kochi, Kerala', 220, 23, 72, 1010, 9, 9.96, 76.26),
    ('913 Elm St, Patna, Bihar', 180, 27, 74, 1014, 11, 25.61, 85.14),
    ('246 Cedar St, Raipur, Chhattisgarh', 150, 25, 70, 1013, 10, 21.25, 81.63),
    ('579 Walnut St, Dehradun, Uttarakhand', 170, 26, 75, 1015, 12, 30.32, 78.03),
    ('135 Ash St, Jaipur, Rajasthan', 160, 24, 68, 1012, 8, 26.92, 75.82),
    ('189 Painav St, Idukki, Kerala', 163, 26, 70, 1012, 4, 29.92, 75.82),
    ('468 Spruce St, Thiruvananthapuram, Kerala', 200, 23, 72, 1010, 9, 8.52,76.01);




-- Table: Requests
CREATE TABLE Requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    farmer_id INT,
    farmland_id INT,
    pick_id INT,
    total_amount INT,
    total_qty int,
    CONSTRAINT fk_farmer FOREIGN KEY (farmer_id) REFERENCES Farmers (id),
    CONSTRAINT fk_farmland FOREIGN KEY (farmland_id) REFERENCES FarmLands (id),
    CONSTRAINT fk_crop FOREIGN KEY (pick_id) REFERENCES Picks (id),
    CONSTRAINT unique_farmland UNIQUE (farmer_id, farmland_id),
    CONSTRAINT chk_total_amount CHECK (total_amount >= 50000)
);

INSERT INTO Requests (farmer_id, farmland_id, pick_id, total_amount,total_qty)
VALUES 
    (2,20,5,200000,2300),(3, 7, 3, 450000,1200),(4, 10, 2, 250000,130),(5, 4, 8, 380000,2000),
    (6, 16, 9, 470000,2400),(7, 3, 6, 300000,123),(8, 19, 4, 410000,234),(9, 11, 10, 490000,40000),
    (10, 12, 7, 420000,340),(1, 5, 1, 280000,240),(2, 8, 5, 360000,560),(3, 18, 3, 430000,43000),
    (4, 2, 2, 210000,400),(5, 13, 8, 390000,200),(6, 15, 9, 480000,460);




-- Table: Assets
CREATE TABLE Assets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    investor_id INT,
    pick_id INT,
    contract_address VARCHAR(100),
    profit int,
    qty int,
    CONSTRAINT fk_investor FOREIGN KEY (investor_id) REFERENCES Investors (id),
    CONSTRAINT fk_pick FOREIGN KEY (pick_id) REFERENCES Picks (id)
);

INSERT INTO Assets (investor_id, pick_id, contract_address,profit,qty)
SELECT 
    FLOOR(RAND() * 10) + 1, 
    P.id, 
    CONCAT('0x', LPAD(HEX(RAND()*1000000000000), 8, '0')), 
    FLOOR(RAND() * 500) + 100,
    FLOOR(RAND() * 500) + 10
FROM Picks P
ORDER BY RAND()
LIMIT 10;


-- Table: Investor_history
CREATE TABLE Investor_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    investor_id INT,
    contract_address VARCHAR(100),
    profit INT,
    farmer_id INT,
    CONSTRAINT fk_investor_id FOREIGN KEY (investor_id) REFERENCES Investors (id),
    CONSTRAINT fk_farmer_id FOREIGN KEY (farmer_id) REFERENCES Farmers (id)
);

INSERT INTO Investor_history (investor_id, contract_address, profit, farmer_id)
VALUES
    (1, '0x123abc', 5000, 3),
    (2, '0x456def', 3000, 2),
    (1, '0x789ghi', 2000, 1),
    (3, '0xabc123', 4000, 4),
    (2, '0xdef456', 1500, 5),
    (3, '0xghi789', 1000, 2),
    (4, '0x123def', 2500, 3),
    (5, '0x456ghi', 3500, 1),
    (4, '0x789abc', 1800, 4),
    (5, '0xdef123', 2200, 2);


-- Table: Farmer_history
CREATE TABLE Farmer_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    farmer_id INT,
    pick_id INT,
    sold_quantity INT,
    sold_price INT,
    sale_date DATE,
    CONSTRAINT fk_farmer_id_history FOREIGN KEY (farmer_id) REFERENCES Farmers (id),
    CONSTRAINT fk_pick_id_history FOREIGN KEY (pick_id) REFERENCES Picks (id)
);

INSERT INTO Farmer_history (farmer_id,pick_id, sold_quantity, sold_price, sale_date)
VALUES
    (1, 1, 500, 1000, '2023-05-01'),
    (2, 2, 800, 1200, '2023-05-03'),
    (1, 3, 600, 1500, '2023-05-02'),
    (3, 4, 400, 900, '2023-05-04'),
    (2, 5, 300, 800, '2023-05-05'),
    (3, 1, 700, 1100, '2023-05-06'),
    (4, 2, 250, 1300, '2023-05-07'),
    (5, 3, 350, 1000, '2023-05-08'),
    (4, 4, 200, 1200, '2023-05-09'),
    (5, 5, 450, 1500, '2023-05-10');


CREATE TABLE Payment (
    id INT PRIMARY KEY AUTO_INCREMENT,
    investor_id INT,
    amount DECIMAL(12, 2),
    date DATETIME DEFAULT NOW(),
    pick_id INT
);


INSERT INTO Payment (investor_id, amount, pick_id)
VALUES
    (1, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) + 1),
    (2, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) +5),
    (3, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) + 3),
    (3, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) + 2),
    (2, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) + 1),
    (6, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) + 1),
    (6, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) + 4),
    (2, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) + 3),
    (1, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) + 2),
    (3, FLOOR(RAND() * (40000 - 5000 + 1)) + 5000, FLOOR(RAND() * 10) + 1);


DROP DATABASE IF EXISTS vistacare;
-- DROP DATABASE vistacare;

CREATE DATABASE vistacare;
USE vistacare;



CREATE TABLE ServiceCategory(
    categoryId INT PRIMARY KEY,
    name VARCHAR(70) NOT NULL,
    description VARCHAR(200) NOT NULL,
    startDate DATE NOT NULL
);


CREATE TABLE service(
    serviceId INT PRIMARY KEY,
    name VARCHAR(100),
    description VARCHAR(150),
    categoryId INT,
    price INT,
    FOREIGN KEY (categoryId) REFERENCES ServiceCategory(categoryId),
    order_date DATE
);


CREATE TABLE product(
    productId INT PRIMARY KEY,
    categoryId INT,
    FOREIGN KEY (categoryId) REFERENCES ServiceCategory(categoryId),
    productName VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    stockLevel INT,
    discount INT    
);
CREATE TABLE customer (
    customerID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    phNo CHAR(10) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    passwd VARCHAR(50) NOT NULL,
    address VARCHAR(250) NOT NULL
);



CREATE TABLE delivery_person (
    deliveryID INT PRIMARY KEY,
    customerID INT,
    FOREIGN KEY (customerID) REFERENCES customer(customerID),
    dispatch_date DATE NOT NULL,
    name VARCHAR(50) NOT NULL,
    phNo CHAR(10) NOT NULL,
    zip_code INT(6),
    email VARCHAR(50) NOT NULL,
    passwd VARCHAR(50) NOT NULL
);




CREATE TABLE admin (
    ID INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(250) NOT NULL,
    username VARCHAR(50) NOT NULL,
    passwd VARCHAR(50) NOT NULL,
    phonenumber VARCHAR(15) NOT NULL
);


CREATE TABLE user (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    passwd VARCHAR(50) NOT NULL CHECK(length(passwd)>=0)
);


CREATE TABLE orders (
    orderId INT PRIMARY KEY,
    serviceId INT,
    userId INT NOT NULL,
    productId INT,
    Order_date DATE,
    FOREIGN KEY (serviceId) REFERENCES service(serviceId),
    FOREIGN KEY (userId) REFERENCES user(userID),
    FOREIGN KEY (productId) REFERENCES product(productId)
);


CREATE TABLE serviceProvider(
    provideId INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) NOT NULL,
    passwd VARCHAR(50) NOT NULL,
    subType VARCHAR(50),
    rating INT NOT NULL,
    name VARCHAR(50) NOT NULL
);


CREATE TABLE WareHouseManager(
    managerID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    managerName VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(80) NOT NULL,
    passwd VARCHAR(50) NOT NULL
);


CREATE TABLE WareHouse(
    WareHouseID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    managerId INT,
    FOREIGN KEY (managerId) REFERENCES WareHouseManager(managerId),
    name VARCHAR(250) NOT NULL,
    Location VARCHAR(400) NOT NULL
);


CREATE TABLE places (
    orderId INT NOT NULL,
    customerId INT NOT NULL,
    DateOfOrderPlaced DATE NOT NULL,
    PRIMARY KEY (orderId, customerId),
    INDEX customerId_idx (customerId ASC) VISIBLE,
    CONSTRAINT orderID
      FOREIGN KEY (orderId)
      REFERENCES orders (orderId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT customerId
      FOREIGN KEY (customerId)
      REFERENCES customer (customerID)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);
    
CREATE TABLE pays (
  custID INT NOT NULL,
  payment_mode VARCHAR(20) NOT NULL,
  PRIMARY KEY (custID),
  CONSTRAINT custID
    FOREIGN KEY (custID)
    REFERENCES customer (customerID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE delivers (
  deliversdateTime DATETIME NOT NULL,
  status VARCHAR(15) NOT NULL,
  ordId INT NOT NULL,
  PRIMARY KEY (ordId),
  INDEX orderId_idx (ordId ASC) VISIBLE,
  CONSTRAINT ordId
    FOREIGN KEY (ordId)
    REFERENCES orders (orderId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE contains (
  productId INT NOT NULL,
  ordrId INT NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (ordrId, productId),
  INDEX productId_idx (productId ASC) VISIBLE,
  CONSTRAINT productId
    FOREIGN KEY (productId)
    REFERENCES product (productId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT ordrId
    FOREIGN KEY (ordrId)
    REFERENCES orders (orderId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE stores (
  prodId INT NOT NULL,
  WareHouseId INT NOT NULL,
  Quantity INT NOT NULL,
  DateOfStored DATE NOT NULL,
  PRIMARY KEY (prodId, wareHouseId),
  INDEX wareHouseId_idx (wareHouseId ASC) VISIBLE,
  CONSTRAINT wareHouseId
    FOREIGN KEY (wareHouseId)
    REFERENCES WareHouse (wareHouseID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT prodId
    FOREIGN KEY (prodId)
    REFERENCES product (productId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE provides (
  categoryId INT NOT NULL,
  serviceId INT NOT NULL,
  prodctId INT NOT NULL,
  PRIMARY KEY (categoryId, serviceId, prodctId),
  INDEX serviceId_idx (serviceId ASC) VISIBLE,
  INDEX prodctId_idx (prodctId ASC) VISIBLE,
  CONSTRAINT categoryId
    FOREIGN KEY (categoryId)
    REFERENCES ServiceCategory (categoryId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT serviceId
    FOREIGN KEY (serviceId)
    REFERENCES service (serviceId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT prodctId
    FOREIGN KEY (prodctId)
    REFERENCES product (productId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE updates (
  wareHsId INT NOT NULL,
  deliveryId INT NOT NULL,
  PRIMARY KEY (wareHsId, deliveryId),
  INDEX deliveryId_idx (deliveryId ASC) VISIBLE,
  CONSTRAINT wareHsId
    FOREIGN KEY (wareHsId)
    REFERENCES WareHouse (wareHouseID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT deliveryId
    FOREIGN KEY (deliveryId)
    REFERENCES delivery_person (deliveryID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



INSERT INTO admin (id, name, age, email, username, passwd, phonenumber) VALUES
(1, 'Aditya Sharma', 35, 'aditya.sharma@gmail.com', 'adityas', 'Adity3', '123-456-7890'),
(2, 'Bhavesh Patel', 40, 'bhavesh.patel@gmail.com', 'bhaveshp', 'Bhavesh56', '234-567-8901'),
(3, 'Chetna Singh', 45, 'chetna.singh@gmail.com', 'chetnas', 'Chetn89', '345-678-9012'),
(4, 'Dinesh Gupta', 50, 'dinesh.gupta@gmail.com', 'dineshg', 'Dine23!', '456-789-0123'),
(5, 'Ekta Joshi', 55, 'ekta.joshi@gmail.com', 'ektaj', 'Ekt456', '567-890-1234'),
(6, 'Firoz Khan', 60, 'firoz.khan@gmail.com', 'firozk', 'Firo789', '678-901-2345'),
(7, 'Gitanjali Patel', 65, 'gitanjali.patel@gmail.com', 'gitalip', 'Gitanjali123!', '789-012-3456'),
(8, 'Harshita Sharma', 70, 'harshita.sharma@gmail.com', 'harhitas', 'Harshita@456', '890-123-4567'),
(9, 'Irfan Khan', 75, 'irfan.khan@gmail.com', 'irfank', 'Irf789', '901-234-5678'),
(10, 'Jasbir Singh', 80, 'jasbir.singh@gmail.com', 'jasbirs', 'Jasb3!', '012-345-6789'),
(11,'admin',20,'admin@gmail.com','mdhv','admin2024@iiitd','987-157-7460');


ALTER TABLE orders ADD COLUMN productprice DECIMAL(10, 2);
ALTER TABLE orders ADD COLUMN servicePrice DECIMAL(10, 2);

ALTER TABLE orders ADD COLUMN productQuantity INT;


INSERT INTO customer (name, age, phNo, gender, email, passwd, address) VALUES
('Ananya Mishra', 25, '1234567890', 'Female', 'ananya.mishra@gmail.com', 'Ananya123!', '123 Cross Road, Delhi, India'),
('Akash Sharma', 30, '9876543210', 'Male', 'akash.sharma@gmail.com', 'Akash@456', '456 Avenue, Bangalore, India'),
('Bhavana Patel', 35, '4567890123', 'Female', 'bhavana.patel@gmail.com', 'Bhavana#789', '789 Road, pune, India'),
('Chirag Singh', 40, '8901234567', 'Male', 'chirag.singh@gmail.com', 'Chirag789!', '012 Lane, malleshpuram, India'),
('Deepika Kumar', 45, '2345678901', 'Female', 'deepika.kumar@gmail.com', 'Deepika@123', '345 Drive, whitefeild, India'),
('Ekta Joshi', 50, '6789012345', 'Female', 'ekta.joshi@gmail.com', 'Ekta123!', '678 Cross Road, Delhi, India'),
('Farhan Reddy', 55, '1234567890', 'Male', 'farhan.reddy@gmail.com', 'Farhan@456', '901 Avenue, Bangalore, India'),
('Gauri Gupta', 60, '9876543210', 'Female', 'gauri.gupta@gmail.com', 'Gauri#789', '234 Road, pune, India'),
('Hitesh Sharma', 65, '4567890123', 'Male', 'hitesh.sharma@gmail.com', 'Hitesh789!', '567 Lane, malleshpuram, India'),
('Ishaan Patel', 70, '8901234567', 'Male', 'ishaan.patel@gmail.com', 'Ishaan@123', '890 Drive, whitefeild, India');



INSERT INTO delivery_person (deliveryID, customerID, dispatch_date, name, phNo, zip_code, email, passwd) VALUES
(1, 1, '2024-02-10', 'Rahul Gupta', '1234567890', 12345, 'rahul@gmail.com', 'rahul_1@'),
(2, 2, '2024-02-11', 'Priya Patel', '9876543210', 54321, 'priya@gmail.com', 'priya_1@'),
(3, 3, '2024-02-12', 'Arun Kumar', '4567890123', 67890, 'arun@gmail.com', 'arun_1@'),
(4, 4, '2024-02-13', 'Neha Sharma', '8901234567', 90123, 'neha@gmail.com', 'neha_1@'),
(5, 5, '2024-02-14', 'Ravi Singh', '2345678901', 23456, 'ravi@gmail.com', 'ravi_1@'),
(6, 6, '2024-02-15', 'Anjali Desai', '7890123456', 65432, 'anjali@gmail.com', 'anjali1@'),
(7, 7, '2024-02-16', 'Vivek Joshi', '3456789012', 54321, 'vivek@gmail.com', 'vivek_1@'),
(8, 8, '2024-02-17', 'Deepika Mishra', '9012345678', 43210, 'deepika@gmail.com', 'deepik@'),
(9, 9, '2024-02-18', 'Amit Dubey', '0123456789', 32109, 'amit@gmail.com', 'amit_1@'),
(10, 10, '2024-02-19', 'Meera Singhania', '5678901234', 21098, 'meera@gmail.com', 'meera_1@');





INSERT INTO ServiceCategory (categoryId, name, description, startDate) VALUES
(1, 'Plumbing', 'Fixing plumbing issues', '2023-01-01'),
(2, 'Electrical', 'Electrical repairs and installations', '2023-01-01'),
(3, 'Cleaning', 'Professional cleaning services', '2023-01-01'),
(4, 'Landscaping', 'Gardening and landscaping services', '2023-01-01'),
(5, 'Catering', 'Event catering services', '2023-01-01'),
(6, 'IT Services', 'Information technology services', '2023-01-01'),
(7, 'Grooming', 'Get your best look', '2023-01-01'),
(8, 'Painting', 'Interior and exterior painting services', '2023-01-01'),
(9, 'Moving', 'Relocation and moving services', '2023-01-01'),
(10, 'Car Repair', 'Automobile repair services', '2023-01-01'),
(11, 'Healthcare', 'Medical and healthcare services', '2023-01-01');



INSERT INTO serviceProvider (subType, rating, name, email, passwd) VALUES
('Plumber', 4, 'madhav', 'madhav@gmail.com', 'madhav_1@'),
('Electrician', 5, 'Mayank', 'mayank@gmail.com', 'maya_1@'),
('Cleaner', 1, 'Saurab', 'saurab@gmail.com', 'saub_1@'),
('Landscaper', 5, 'Kohli', 'kohli@gmail.com', 'kohli_1@'),
('Caterer', 3, 'Neeraj', 'neeraj@gmail.com', 'nee_1@'),
('IT Consultant', 5, 'Sushant', 'sushant@gmail.com', 'susha1@'),
('Painter', 4, 'tandava', 'tandava@gmail.com', 'tanva_1@'),
('Mover', 3, 'rishab', 'rishab@gmail.com', 'rishab_1@'),
('Mechanic', 3, 'deeraj', 'deeraj@gmail.com', 'deer_1@'),
('Doctor', 2, 'kashish', 'kashish@gmail.com', 'kashh_1@');





INSERT INTO service (serviceId, name, description, categoryId, price,order_date) VALUES
(1, 'Fix Leak', 'Fix plumbing leak', 1,70, '2024-02-10'),
(2, 'Install Lights', 'Install new lights', 2,50, '2024-02-11'),
(3, 'Deep Clean', 'Deep cleaning service', 3, 100,'2024-02-12'),
(4, 'Garden Maintenance', 'Regular garden maintenance', 4, 400,'2024-02-13'),
(5, 'Event Catering', 'Catering for events', 5, 80,'2024-02-14'),
(6, 'IT Consultation', 'Consultation for IT solutions', 6, 700,'2024-02-15'),
(7, 'Interior Painting', 'Interior painting service', 7, 500,'2024-02-16'),
(8, 'Relocation Service', 'Assistance with relocation', 8, 40,'2024-02-17'),
(9, 'Car Repair', 'Car repair and maintenance', 9, 1000,'2024-02-18'),
(10, 'Medical Checkup', 'Routine medical checkup', 10, 2000,'2024-02-19'),
(11, 'Makeup','Get the most elegant and beautiful makeup.',7,3000,'2024-03-29');



INSERT INTO WareHouseManager (managerName, age, email, passwd) VALUES
('Rajesh Patel', 40, 'rajesh.patel@gmail.com', 'Raje1sh!'),
('Priya Sharma', 45, 'priya.sharma@gmail.com', 'Priy56'),
('Amit Singh', 27, 'amit.singh@gmail.com', 'Amit#789'),
('Sunita Gupta', 39, 'sunita.gupta@gmail.com', 'Sun789!'),
('Alok Kumar', 23, 'alok.kumar@gmail.com', 'Alok@123'),
('Deepa Joshi', 21, 'deepa.joshi@gmail.com', 'Deep6!'),
('Vikas Reddy', 42, 'vikas.reddy@gmail.com', 'Vikas#789'),
('Neha Patel', 27, 'neha.patel@gmail.com', 'Neha@456'),
('Rajni Sharma', 31, 'rajni.sharma@gmail.com', 'Raj23!'),
('Sanjay Singh', 34, 'sanjay.singh@gmail.com', 'Sanja456');



INSERT INTO WareHouse (managerId, name, Location) VALUES
(1, 'Warehouse A', 'Cross Road 1, Delhi, India '),
(2, 'Warehouse B', 'Cross Road 2, Mumbai, India '),
(3, 'Warehouse C', 'Cross Road 3, Bangalore, India '),
(4, 'Warehouse D', 'Cross Road 4, Chennai, India '),
(5, 'Warehouse E', 'Cross Road 5, Punjab, India '),
(6, 'Warehouse F', 'Cross Road 6, Karnataka, India '),
(7, 'Warehouse G', 'Cross Road 7, Kerela, India '),
(8, 'Warehouse H', 'Cross Road 8, Hyderabad, India '),
(9, 'Warehouse I', 'Cross Road 9, Himachal, India '),
(10, 'Warehouse J', 'Cross Road 10, Odissa, India ');



INSERT INTO product (productId, categoryId, productName, price, stockLevel, discount) VALUES
(1, 1, 'Pipe Fittings', 10, 150, 5),
(2, 2, 'LED Bulbs', 15, 50, 0),
(3, 3, 'Cleaning Supplies', 20, 10, 10),
(4, 4, 'Gardening Tools', 25, 300, 15),
(5, 5, 'Food Platters', 30, 600, 0),
(6, 6, 'Software Giftcards', 35, 100, 5),
(7, 7, 'Paint Buckets', 40, 350, 10),
(8, 8, 'Moving Boxes', 45, 100, 0),
(9, 9, 'Car Parts', 50, 500, 15),
(10, 10, 'Medical Equipment', 55, 70, 5);



INSERT INTO user (email, passwd)
SELECT email, passwd FROM serviceProvider
UNION
SELECT email, passwd FROM serviceProvider
UNION
SELECT email, passwd FROM WareHouseManager
UNION
SELECT  email, passwd FROM delivery_person
UNION
SELECT  email, passwd FROM customer
UNION
SELECT email, passwd FROM admin;

INSERT INTO orders (orderId, serviceId, userId, productId, Order_date, productprice, servicePrice, productQuantity)
VALUES
(1, NULL, 1, 1, '2024-02-10',10,NULL,2),
(2, NULL, 2, 2, '2024-02-11',15,NULL,7),
(3, NULL, 3, 3, '2024-02-12',20,NULL,2),
(4, NULL, 4, 4, '2024-02-13',25,NULL,5),
(5, NULL, 5, 5, '2024-02-14',30,NULL,6),
(6, NULL, 6, 6, '2024-02-15',35,NULL,7),
(7, NULL, 7, 7, '2024-02-16',40,NULL,5),
(8, NULL, 8, 8, '2024-02-16',48,NULL,2),
(9, NULL, 9, 9, '2024-02-16',490,NULL,10),
(10, NULL, 10, 10, '2024-02-16',400,NULL,20);





INSERT INTO updates (wareHsId, deliveryId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO contains (productId, ordrId, Quantity) VALUES
(1, 1, 10),
(2, 2, 15),
(3, 3, 20),
(4, 4, 25),
(5, 5, 30),
(6, 6, 35),
(7, 7, 40),
(8, 8, 45),
(9, 9, 50),
(10, 10, 55);


INSERT INTO delivers (deliversdateTime, status, ordId) VALUES
('2024-02-12 08:00:00', 'Pending', 1),
('2024-02-13 09:30:00', 'In Transit', 2),
('2024-02-14 10:45:00', 'Delivered', 3),
('2024-02-15 11:20:00', 'Pending', 4);


INSERT INTO stores (prodId, wareHouseId, Quantity, DateOfStored) VALUES
(1, 1, 50, '2024-02-12'),
(2, 2, 45, '2024-02-13'),
(3, 3, 60, '2024-02-14'),
(4, 4, 55, '2024-02-15'),
(5, 5, 70, '2024-02-16'),
(6, 6, 65, '2024-02-17'),
(7, 7, 80, '2024-02-18'),
(8, 8, 75, '2024-02-19'),
(9, 9, 90, '2024-02-20'),
(10, 10, 85, '2024-02-21');


INSERT INTO provides (categoryId, serviceId, prodctId) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);


INSERT INTO pays (custID, payment_mode) VALUES
(1, 'Credit Card'),
(2, 'PayPal'),
(3, 'Debit Card'),
(4, 'Cash'),
(5, 'Bank Transfer'),
(6, 'Credit Card'),
(7, 'PayPal'),
(8, 'Debit Card'),
(9, 'Cash'),
(10, 'Bank Transfer');


INSERT INTO places (orderId, customerId, DateOfOrderPlaced) 
VALUES 
('1', '3', '24-01-02'),
('2', '5', '24-01-07'),
('3', '7', '24-01-11'),
('4', '1', '24-01-13'),
('5', '3', '24-01-13'),
('6', '2', '24-01-16'),
('7', '10', '24-01-19'),
('8', '9', '24-01-27'),
('9', '8', '24-02-07'),
('10', '6', '24-02-09');



-- DELIMITER // 

-- CREATE TRIGGER check_price_before_insert_product BEFORE INSERT ON product
-- FOR EACH ROW
-- BEGIN
--     IF NEW.price < 0 THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'Product price cannot be negative';
--     END IF;
-- END;
-- //










-- CREATE TRIGGER check_deal_combination BEFORE INSERT ON vistacare.delivers
-- FOR EACH ROW
-- BEGIN
--     DECLARE service_person_exists INT;
--     DECLARE product_exists INT;
--     
--     
--     SELECT COUNT(*)
--     INTO service_person_exists
--     FROM orders o
--     JOIN serviceProvider sp ON o.serviceId = sp.provideId
--     WHERE o.orderId = NEW.ordId;
--     
--     
--     SELECT COUNT(*)
--     INTO product_exists
--     FROM orders o
--     JOIN product p ON o.productId = p.productId
--     WHERE o.orderId = NEW.ordId;
--     
--     
--     IF service_person_exists > 0 AND product_exists > 0 THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'Cannot assign a delivery person if a service person and a product are part of a combination deal';
--     END IF;
-- END;
-- //


-- CREATE TRIGGER check_product_quantity_before_insert BEFORE INSERT ON orders
-- FOR EACH ROW
-- BEGIN
--     DECLARE available_stock INT;
--     
--     SELECT stockLevel INTO available_stock
--     FROM product
--     WHERE productId = NEW.productId;
--     
--     IF NEW.productQuantity > available_stock THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'Product quantity in the cart cannot exceed available stock';
--     
--     ELSE 
-- 		UPDATE product
-- 		SET stockLevel = stockLevel - NEW.productQuantity
--         WHERE productId = NEW.productId;
-- 	END IF;
-- END
-- //

-- DELIMITER ;



-- CONFLICTING "PRODUCT" ENTRY

-- INSERT INTO product (productId, categoryId, productName, price, stockLevel, discount) VALUES
-- (11, 1, 'AC Servicing Gun', -1000, 150, 5);



-- CONFLICTINGT "ORDERS" ENTRY

-- INSERT INTO orders (orderId, serviceId, userId, productId, Order_date, productprice, servicePrice, productQuantity)
-- VALUES (5, 5, 5, 5, '2024-02-14',30,80,800);


-- CONFLICTING "DELIVERS" ENTRY

-- INSERT INTO delivers (deliversdateTime, status, ordId) VALUES
-- (10, 10, 10, 10, '2024-02-19',55,3000,7);

-- REST TRIGGERS FRONTEND


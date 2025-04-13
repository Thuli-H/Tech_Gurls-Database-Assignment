--Creating a Bookstore Database
CREATE DATABASE bookstore_db;

--Creating Tables for the Bookstore Database
USE bookstore_db;

-- 1. book
CREATE TABLE book (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20),
    publisher_id INT,
    language_id INT,
    publication_year YEAR,
    price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);
-- 2. author
CREATE TABLE author (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    bio TEXT
); 

-- 3. book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 4. book_language
CREATE TABLE book_language (
    language_id INT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

-- 5. publisher
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50)
);


-- 6. customer
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    phone_number VARCHAR(50)
);

-- 7. customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 8. address_status
CREATE TABLE address_status (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);


-- 9. address
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);


-- 10. country
CREATE TABLE country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- 11. cust_order
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id)
);

-- 12. order_line
CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);


-- 13. shipping_method
CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(10,2)
);
 
-- 14. order_history
CREATE TABLE order_history (
    history_id INT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATE,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- 15. order_status
CREATE TABLE order_status (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(50)
);


--Inserting data into the various tables

--inserting data into book_language table
INSERT INTO book_language (language_id, language_name) VALUES
(1, 'English'),
(2, 'French'),
(3, 'Spanish'),
(4, 'German'),
(5, 'Italian'),
(6, 'Chinese'),
(7, 'Japanese'),
(8, 'Arabic'),
(9, 'Russian'),
(10, 'Portuguese');

INSERT INTO publisher (publisher_id, publisher_name, contact_email, contact_phone) VALUES
(1, 'Pearson Education', 'info@pearson.com', '+1-800-123-4567'),
(2, 'Penguin Random House', 'contact@penguinrandomhouse.com', '+1-800-234-5678'),
(3, 'HarperCollins Publishers', 'support@harpercollins.com', '+1-800-345-6789'),
(4, 'Macmillan Publishers', 'info@macmillan.com', '+1-800-456-7890'),
(5, 'Simon & Schuster', 'service@simonandschuster.com', '+1-800-567-8901');

INSERT INTO book (book_id, title, isbn, publisher_id, language_id, publication_year, price, stock_quantity) VALUES
(1, 'Introduction to SQL', '9780131103627', 1, 1, 2015, 45.99, 50),
(2, 'Advanced Python Programming', '9780135957050', 2, 1, 2019, 59.95, 30),
(3, 'Data Science for Beginners', '9781491912058', 3, 1, 2020, 39.99, 25),
(4, 'Learn Java the Easy Way', '9781680500387', 4, 1, 2018, 49.99, 40),
(5, 'Mastering Web Development', '9781118907443', 5, 2, 2021, 65.00, 20);

INSERT INTO author (author_id, first_name, last_name, bio) VALUES
(1, 'John', 'Doe', 'John Doe is a software engineer and technical writer with over 15 years of experience.'),
(2, 'Jane', 'Smith', 'Jane Smith is an expert in data science and machine learning.'),
(3, 'Robert', 'Brown', 'Robert Brown has authored several books on web development and design.'),
(4, 'Emily', 'Davis', 'Emily Davis is a senior Java developer and university lecturer.'),
(5, 'Michael', 'Johnson', 'Michael Johnson specializes in Python programming and automation.');

INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),  
(2, 2),  
(3, 3),  
(4, 4),  
(5, 5),  
(2, 3),  
(5, 1);

INSERT INTO country (country_id, country_name, continent) VALUES
(1, 'Kenya', 'Africa'),
(2, 'United States', 'North America'),
(3, 'Germany', 'Europe'),
(4, 'India', 'Asia'),
(5, 'Brazil', 'South America'),
(6, 'Australia', 'Oceania'),
(7, 'Canada', 'North America'),
(8, 'South Africa', 'Africa'),
(9, 'China', 'Asia'),
(10, 'France', 'Europe');

INSERT INTO address (address_id, street, city, state, postal_code, country_id) VALUES
(1, '123 Moi Avenue', 'Nairobi', 'Nairobi County', '00100', 1),
(2, '456 Freedom Street', 'Mombasa', 'Mombasa County', '80100', 1),
(3, '789 Sunset Blvd', 'Los Angeles', 'California', '90001', 2),
(4, '12 Wallstraße', 'Berlin', 'Berlin', '10117', 3),
(5, '88 Nehru Road', 'Mumbai', 'Maharashtra', '400001', 4),
(6, '50 Paulista Avenue', 'São Paulo', 'São Paulo', '01310-000', 5),
(7, '20 Sydney Road', 'Sydney', 'New South Wales', '2000', 6),
(8, '100 Yonge Street', 'Toronto', 'Ontario', 'M5C 2W1', 7),
(9, '10 Long Street', 'Cape Town', 'Western Cape', '8001', 8),
(10, '168 Beijing Road', 'Beijing', 'Beijing Municipality', '100000', 9);

INSERT INTO address_status (status_id, status_name) VALUES
(1, 'Current'),
(2, 'Old'),
(3, 'Temporary'),
(4, 'Permanent');

INSERT INTO customer (customer_id, first_name, last_name, email, phone_number) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210'),
(3, 'Emily', 'Johnson', 'emily.johnson@example.com', '555-123-4567'),
(4, 'Michael', 'Brown', 'michael.brown@example.com', '444-987-6543');

INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 2);

INSERT INTO shipping_method (shipping_method_id, method_name, cost) VALUES
(1, 'Standard Shipping', 5.99),
(2, 'Express Shipping', 12.99),
(3, 'Overnight Shipping', 25.00),
(4, 'International Shipping', 40.00);

INSERT INTO cust_order (order_id, customer_id, order_date, shipping_method_id, total_amount) VALUES
(1, 1, '2025-04-01', 2, 49.99),
(2, 2, '2025-04-02', 1, 25.50),
(3, 3, '2025-04-05', 3, 80.00),
(4, 1, '2025-04-10', 4, 120.75);

INSERT INTO order_status (status_id, status_name) VALUES
(1, 'Pending'),
(2, 'Shipped'),
(3, 'Delivered'),
(4, 'Cancelled'),
(5, 'Returned');

INSERT INTO order_history (history_id, order_id, status_id, status_date) VALUES
(1, 1001, 1, '2025-04-01'), 
(2, 1001, 2, '2025-04-02'), 
(3, 1002, 1, '2025-04-03'), 
(4, 1003, 3, '2025-04-04'), 
(5, 1004, 4, '2025-04-05');

INSERT INTO order_history (history_id, status_id, status_date) VALUES
(1, 1, '2025-04-01'), 
(2, 2, '2025-04-02'), 
(3, 3, '2025-04-03'), 
(4, 4, '2025-04-04'); 

INSERT INTO order_line (order_line_id, order_id, book_id, quantity, unit_price) VALUES
(1, 1, 101, 2, 15.99), 
(2, 1, 102, 1, 25.50), 
(3, 2, 103, 3, 12.75), 
(4, 3, 104, 1, 19.99); 

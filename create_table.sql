CREATE DATABASE techcorp;

USE techcorp;

SHOW TABLES FROM techcorp;

CREATE TABLE Products (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT,
    discount DECIMAL(5,2) DEFAULT 0
);

DESCRIBE products;

CREATE TABLE Customers (
 customer_id INT AUTO_INCREMENT PRIMARY KEY,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 email VARCHAR(50) UNIQUE,
 phone VARCHAR(20),
 address VARCHAR(200)
);

DESCRIBE customers;

CREATE TABLE Orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

DESCRIBE orders;

CREATE TABLE OrderDetails (
	order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

DESCRIBE orderdetails;

CREATE TABLE Employees (
	employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    hire_date DATE,
    department VARCHAR(50)
);

DESCRIBE employees;

CREATE TABLE SupportTickets (
	ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    issue TEXT,
    status VARCHAR(20),
    created_at DATETIME,
    resolved_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

DESCRIBE SupportTickets;
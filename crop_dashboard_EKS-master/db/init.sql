-- db/init.sql
CREATE DATABASE IF NOT EXISTS cropdata;
USE cropdata;

CREATE TABLE crop_prices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    crop_name VARCHAR(255) NOT NULL,
    region VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL
);

-- Insert mock data for Rice in USA
INSERT INTO crop_prices (crop_name, region, price, date) VALUES
('Rice', 'USA', 55.50, CURDATE() - INTERVAL 14 DAY),
('Rice', 'USA', 55.75, CURDATE() - INTERVAL 13 DAY),
('Rice', 'USA', 56.00, CURDATE() - INTERVAL 12 DAY),
('Rice', 'USA', 55.90, CURDATE() - INTERVAL 11 DAY),
('Rice', 'USA', 56.20, CURDATE() - INTERVAL 10 DAY),
('Rice', 'USA', 56.50, CURDATE() - INTERVAL 9 DAY),
('Rice', 'USA', 56.40, CURDATE() - INTERVAL 8 DAY),
('Rice', 'USA', 56.80, CURDATE() - INTERVAL 7 DAY),
('Rice', 'USA', 57.00, CURDATE() - INTERVAL 6 DAY),
('Rice', 'USA', 57.10, CURDATE() - INTERVAL 5 DAY),
('Rice', 'USA', 57.30, CURDATE() - INTERVAL 4 DAY),
('Rice', 'USA', 57.25, CURDATE() - INTERVAL 3 DAY),
('Rice', 'USA', 57.50, CURDATE() - INTERVAL 2 DAY),
('Rice', 'USA', 57.80, CURDATE() - INTERVAL 1 DAY);

-- Insert mock data for Wheat in CANADA
INSERT INTO crop_prices (crop_name, region, price, date) VALUES
('Wheat', 'CANADA', 38.00, CURDATE() - INTERVAL 14 DAY),
('Wheat', 'CANADA', 38.20, CURDATE() - INTERVAL 13 DAY),
('Wheat', 'CANADA', 38.10, CURDATE() - INTERVAL 12 DAY),
('Wheat', 'CANADA', 38.50, CURDATE() - INTERVAL 11 DAY),
('Wheat', 'CANADA', 38.70, CURDATE() - INTERVAL 10 DAY),
('Wheat', 'CANADA', 38.60, CURDATE() - INTERVAL 9 DAY),
('Wheat', 'CANADA', 39.00, CURDATE() - INTERVAL 8 DAY),
('Wheat', 'CANADA', 39.10, CURDATE() - INTERVAL 7 DAY),
('Wheat', 'CANADA', 39.30, CURDATE() - INTERVAL 6 DAY),
('Wheat', 'CANADA', 39.20, CURDATE() - INTERVAL 5 DAY),
('Wheat', 'CANADA', 39.50, CURDATE() - INTERVAL 4 DAY),
('Wheat', 'CANADA', 39.60, CURDATE() - INTERVAL 3 DAY),
('Wheat', 'CANADA', 39.80, CURDATE() - INTERVAL 2 DAY),
('Wheat', 'CANADA', 40.00, CURDATE() - INTERVAL 1 DAY);

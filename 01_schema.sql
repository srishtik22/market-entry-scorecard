CREATE TABLE countries (
    country_code CHAR(3) PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL,
    region VARCHAR(30)
);

CREATE TABLE raw_metrics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country_code CHAR(3) NOT NULL,
    metric_name VARCHAR(50) NOT NULL,
    metric_group VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    value DECIMAL(20,4),
    direction ENUM('benefit','cost') NOT NULL,
    source VARCHAR(50),
    notes VARCHAR(255),
    FOREIGN KEY (country_code) REFERENCES countries(country_code)
);

INSERT INTO countries (country_code, country_name, region) VALUES
('VNM', 'Vietnam', 'Southeast Asia'),
('IDN', 'Indonesia', 'Southeast Asia'),
('THA', 'Thailand', 'Southeast Asia'),
('MYS', 'Malaysia', 'Southeast Asia'),
('PHL', 'Philippines', 'Southeast Asia'),
('ARE', 'United Arab Emirates', 'Middle East'),
('SAU', 'Saudi Arabia', 'Middle East'),
('NGA', 'Nigeria', 'Africa'),
('KEN', 'Kenya', 'Africa'),
('EGY', 'Egypt', 'Africa');
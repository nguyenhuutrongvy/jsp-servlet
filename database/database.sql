CREATE DATABASE IF NOT EXISTS servlet;

USE servlet;

CREATE TABLE employee (
    employee_id int AUTO_INCREMENT NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    gender int CHECK (gender >= 0 AND gender <= 2) DEFAULT 0,
    date_of_birth date,
    phone varchar(20),
    address varchar(255),
    department_name varchar(255),
    remark varchar(1000),

    PRIMARY KEY (employee_id)
);
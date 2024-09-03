CREATE DATABASE IF NOT EXISTS demo;

USE demo;

CREATE TABLE users (
    id  int NOT NULL AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    email varchar(40) NOT NULL UNIQUE,
    phone varchar(15),

    PRIMARY KEY (id)
);
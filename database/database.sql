CREATE DATABASE IF NOT EXISTS demo;

USE demo;

CREATE TABLE users (
 id  int NOT NULL AUTO_INCREMENT,
 name varchar(120) NOT NULL,
 email varchar(120) NOT NULL,
 country varchar(120),

 PRIMARY KEY (id)
);
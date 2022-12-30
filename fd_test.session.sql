CREATE TABLE books(
   name varchar(300),
   author varchar(300),
   type varchar(150),
   pages int,
   year date,
   publisher varchar(256)
);
DROP TABLE books;

DROP TABLE users;

ALTER TABLE users
ADD COLUMN height numeric(3,2);

ALTER TABLE users
ADD CONSTRAINT "to_hight_user" CHECK (height < 4.0);

ALTER TABLE users
DROP CONSTRAINT "to_hight_user";

ALTER TABLE users
ADD COLUMN weight numeric(5,2) CHECK (weight  > 0.0);

ALTER TABLE users
ADD CONSTRAINT "two_early_birsday" CHECK (birthday > '1990-01-01');

ALTER TABLE users
DROP CONSTRAINT "users_email_key" ;


INSERT INTO users (first_name,last_name,email,birthday,gender,height)VALUES 
('Clarkr1', 'Kentn', 'super2@marn.com3', '2021-09-09', 'male', 3.0, 2.0),
('Sheva1', 'Man', 'tonestark3@com3', '1992-02-02', 'female', 2.5);

INSERT INTO users (first_name,last_name,email,birthday,gender,height, weight)VALUES 
('Clarkr1', 'Kentn', 'super2@marn.com3', '2021-09-09', 'male', 3.0, 2.0);



INSERT INTO messages VALUES 
( ,'helllo text', 'test user', '2029-09-09', false);

INSERT INTO messages (author, body) VALUES
('test user', 'hellwwwwwwwwwlo text');

ALTER TABLE users DROP CONSTRAINT name_pair ;

CREATE TABLE users( 
    id serial PRIMARY KEY,
    first_name varchar(256) NOT NULL CHECK (first_name != ''),
    last_name varchar(256) NOT NULL CHECK (last_name != ''),
    email varchar(300) NOT NULL UNIQUE CHECK (last_name != ''),
    birthday date CHECK (birthday < current_date),
    gender varchar(100) CHECK (last_name != ''),
    CONSTRAINT name_pair UNIQUE(first_name, last_name)
);


ALTER TABLE products
ADD COLUMN model varchar(200);

ALTER TABLE products
RENAME COLUMN name TO brand;

CREATE TABLE products(
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL CHECK (name !=''),
    category varchar(100),
    price numeric (10,2) NOT NULL CHECK (price >0),
    quantity int CHECK (quantity >0)
);

INSERT INTO products (name,price,quantity)
VALUES
('Samsung', 100, 5),
('iPhone', 500, 1),
('Sony', 200, 3);

CREATE TABLE orders (
    id serial PRIMARY KEY,
    created_at timestamp DEFAULT current_timestamp,
    customer_id int REFERENCES users (id)
);

INSERT INTO orders (customer_id) VALUES
(3) , (7), (10), (10), (3);

DELETE FROM orders_to_products;

CREATE TABLE  orders_to_products (
    product_id int REFERENCES products (id),
    order_id int REFERENCES orders (id),
    quantity int CHECK (quantity >0),
    PRIMARY KEY (product_id, order_id)
);

INSERT INTO orders_to_products (product_id,order_id,quantity) VALUES
(1,1,3), (3,4,5);

ALTER TABLE messages
ADD COLUMN chat_id int REFERENCES chat(id);

CREATE TABLE messages (
    id serial PRIMARY KEY,
    author int REFERENCES users(id) ,
    body text NOT NULL CHECK (body != ''),
    created_at timestamp NOT NULL CHECK (created_at <= current_timestamp) DEFAULT current_timestamp,
    is_read boolean NOT NULL DEFAULT false
);

INSERT INTO messages ( author,body,is_read ) VALUES
(3, 'Help', true) , (7, 'Ytllo', true), (10, 'Hello', false), (10,'RRRRRRRRR', true);

DROP TABLE chat;
ALTER TABLE chat
ADD COLUMN name varchar(200);

CREATE TABLE chat (
    id serial PRIMARY KEY,
    onwer_id int REFERENCES users(id),
    created_at timestamp NOT NULL DEFAULT current_timestamp
);

INSERT INTO chat (onwer_id) VALUES
(10) , (4), (13), (7);

DROP TABLE chat_to_messges;

CREATE TABLE chat_to_messges (
    chat_id int REFERENCES chat (id),
    user_id int REFERENCES users (id) ON DELETE CASCADE,
    PRIMARY KEY (chat_id,user_id)
);


CREATE TABLE content(
    id serial PRIMARY KEY,
    name_content varchar(300) NOT NULL CHECK (name_content !=''),
    description text ,
    created_at timestamp  DEFAULT current_timestamp,
    user_id int REFERENCES users(id)
);

DROP TABLE reaction;
CREATE TABLE  reaction (
    content_id int REFERENCES content(id),
    user_id int REFERENCES users (id),
    is_reactins boolean,
    PRIMARY KEY (content_id,user_id)
);


DROP TABLE coaches;

CREATE TABLE coaches(
    id serial PRIMARY KEY,
    name varchar (300)
   -- team_id int REFERENCES team (id)
);

CREATE TABLE teams (
    id serial PRIMARY KEY,
    name varchar (300),
    coath_id int REFERENCES coaches (id)
);



ALTER TABLE coaches
ADD COLUMN team_id int REFERENCES teams (id);

ALTER TABLE coaches
DROP COLUMN team_id;

UPDATE users
SET last_name = 'DOE'
WHERE  id = 3;

UPDATE users
SET weight  = 60
WHERE  birthday > '1990-01-01';

DELETE FROM users
WHERE  id = 5;

SELECT * FROM users;


SELECT * FROM users
WHERE last_name = 'Kentn';

SELECT * FROM users
WHERE birthday > '1999-01-01';
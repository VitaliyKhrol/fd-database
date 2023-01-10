
CREATE TABLE goods (
    id serial PRIMARY KEY,
    name varchar (300) NOT NULL,
    price nomeric (10, 2) NOT NULL CHECK (price > 0)
);

INSERT INTO goods (name, price)
VALUES 
    ('хлеб', 20),
    ('макароны',40),
    ('пшено', 15),
    ('сахар', 32);

CREATE TABLE customer(
    id serial PRIMARY KEY,
    name varchar (300) NOT NULL UNIQUE,
    phone int NOT NULL,
    the_address varchar (300) NOT NULL
);

INSERT INTO customer (name, phone, the_address)
VALUES
    ('Хлебзавод 1', 2030500, 'г Киев'),
    ('Макаронная фабрика', 4050700, 'г Харьков'),
    ('База №3', 1545890, 'г Полтава'),
    ('Сахарный завод №4', 3245623, 'г Cавинцы');


DROP TABLE orders;
CREATE TABLE orders(
    id serial PRIMARY KEY,
    orders_date timestamp DEFAULT current_timestamp,
    customer_id int REFERENCES customer(id),
    goods_id int REFERENCES goods(id),
    contract_id int REFERENCES сontract (id),
    amount int NOT NULL CHECK (amount > 0)
);

INSERT INTO orders (customer_id,goods_id, amount, contract_id )
VALUES
    (1,1,5,1),
    (2,2,7,2),
    (3,3,9,3),
    (4,4,15,4);


DROP TABLE сontract;
CREATE TABLE сontract (
    id serial PRIMARY KEY,
    сontract_number int NOT NULL,
    сontract_date date NOT NULL DEFAULT current_date,
    customer_id int REFERENCES customer(id),
    CONSTRAINT contract_name UNIQUE (сontract_number, сontract_date)
);

INSERT INTO сontract (сontract_number, сontract_date, customer_id)
VALUES 
    (122, '2022-03-05', 1),
    (125, '2022-01-08', 4),
    (128, '2022-07-012', 3),
    (122, '2022-03-07', 2);

CREATE TABLE contract_to_goods (
    сontract_id int REFERENCES сontract (id),
    goods_id int REFERENCES goods (id),
    amount int NOT NULL CHECK (amount > 0),
    PRIMARY KEY (сontract_id, goods_id)
);

INSERT INTO contract_to_goods (сontract_id, goods_id, amount)
VALUES 
    (1, 2, 30),
    (1, 1, 50),
    (4, 1, 20),
    (3, 3, 100),
    (2, 4, 55);

CREATE TABLE supply(
    id serial PRIMARY KEY,
    order_id int REFERENCES orders(id),
    supply_date timestamp NOT NULL CHECK (supply_date > current_timestamp),
    amount int NOT NULL CHECK (amount > 0)
);

SELECT c.id, c.сontract_number, c.сontract_date, g.name, g.price, ctg.amount, cus.name
FROM сontract AS c
JOIN contract_to_goods AS ctg
ON c.id = ctg.сontract_id
JOIN goods AS g
ON ctg.goods_id = g.id
JOIN customer AS cus
ON c.customer_id= cus.id;
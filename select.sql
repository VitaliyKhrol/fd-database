
SELECT * FROM users
WHERE id =2000;

SELECT * FROM users
WHERE gender = 'male' AND is_subscribe;

SELECT * FROM users
WHERE gender = 'female' AND is_subscribe = 'FALSE';

SELECT * FROM users
WHERE id % 2 = 0;

SELECT email FROM users
WHERE is_subscribe ;

SELECT * FROM users
WHERE id IN (1,10,100,1000);

SELECT * FROM users
WHERE first_name LIKE 'K%';

SELECT * FROM users
WHERE first_name LIKE '_____';

SELECT * FROM users
WHERE first_name LIKE '%a';

UPDATE users
SET weight = 60
WHERE id BETWEEN 2000 AND 2050;

UPDATE users
SET weight = 60
WHERE id BETWEEN 2050 AND 2060
RETURNING *;

SELECT * FROM users
WHERE birthday < '2004-01-01';

SELECT first_name, age (birthday) FROM users;

SELECT email FROM users
WHERE gender = 'male' AND birthday < '2004-01-01';

SELECT * FROM users
WHERE birthday < '2004-01-01';


SELECT first_name, extract("years" from age(birthday)) FROM users;

SELECT * FROM users
WHERE extract("years" from age(birthday)) > 25;



SELECT * FROM users
WHERE extract('month' from birthday) =10;

SELECT email FROM users
WHERE extract ('day' from birthday) = 1 AND extract('month' from birthday) =11;

UPDATE users
SET weight = 80
WHERE gender = 'male' AND
(extract('years' from age(birthday)) BETWEEN 30 AND 50)
RETURNING *;

SELECT * FROM users;

SELECT id AS "Порядковий номер",
first_name AS "Ім`я",
last_name AS "Прізвіще",
email AS "Пошта"
FROM users AS u;


SELECT * FROM users
LIMIT 100;


SELECT * FROM orders
LIMIT 50
OFFSET 100;


SELECT id, concat (first_name,' ' ,last_name) AS full_name
FROM users;


SELECT * FROM (
    SELECT id, concat (first_name,' ' ,last_name) AS full_name
    FROM users
) AS fn
WHERE char_length(fn.full_name) >10;

INSERT INTO workers (id, first_name, salary, birthday)
VALUES (
    id:integer,
    'first_name:character varying',
    'salary:smallint',
    'birthday:date'
  );

CREATE TABLE workers(
id serial PRIMARY KEY,
first_name varchar (256) NOT NULL CHECK (first_name !=''),
salary smallint,
birthday date CHECK(birthday < current_date)
);

INSERT INTO workers (first_name,birthday,salary) VALUES
('ОЛЕГ','1990-02-10',300);

INSERT INTO workers (first_name,salary) VALUES
('Ярослава',1200);

INSERT INTO workers (first_name,birthday,salary) VALUES
('Саша','1985-01-10',1200),
('Маша','1995-12-04',1200);

UPDATE workers
SET salary = 500
WHERE first_name = 'ОЛЕГ';


UPDATE workers
SET birthday= '1987-03-22'
WHERE id = 4;

UPDATE workers
SET salary = 700
WHERE salary> 500;

UPDATE workers
SET birthday = '1999-03-03'
WHERE id BETWEEN 2 AND 5;

UPDATE workers
SET first_name = 'ЖЕНЯ', salary = 1000
WHERE first_name = 'Саша';

SELECT * FROM workers
WHERE salary > 400;

SELECT * FROM workers
WHERE id =4;

SELECT salary,birthday FROM workers
WHERE first_name = 'Саша';

SELECT * FROM workers
WHERE extract("years" from age(birthday)) BETWEEN 25 AND 28;

SELECT salary,birthday FROM workers
WHERE first_name = 'женя';

SELECT max(height)
FROM users;

SELECT count(*)
FROM users
WHERE gender ='female';

SELECT avg(weight)
FROM users
WHERE gender ='male';

SELECT avg(weight), gender
FROM users
GROUP BY gender;

SELECT avg(weight)
FROM users
WHERE birthday > '2000-01-01';

SELECT avg(weight), gender
FROM users
WHERE extract("years" from age(birthday)) > 25
GROUP BY gender;

SELECT *FROM users
WHERE first_name ILIKE 'ALICE'


SELECT min(height),max(height), gender
FROM users
GROUP BY gender;

SELECT count (*)
FROM users
WHERE first_name ILIKE 'Mia';

SELECT count(*)
FROM users
WHERE extract ('years' from age (birthday)) BETWEEN 20 AND 30;


SELECT * FROM users
ORDER BY id  ASC;


SELECT * FROM users
ORDER BY id  DESC;


SELECT * FROM users
ORDER BY first_name ASC;

SELECT * FROM users
ORDER BY height ASC, birthday;

SELECT *
FROM products
ORDER BY quantity;

SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;


SELECT *, extract("years" from age(birthday)) FROM users
ORDER BY extract("years" from age(birthday)),first_name DESC;

SELECT count(*) , age
FROM (
  SELECT *, 
  extract ("years" from age(birthday)) AS age
  FROM users) AS u_w_age
  GROUP BY age
  ORDER BY age;


SELECT count(*) , age
FROM (
  SELECT *, 
  extract ("years" from age(birthday)) AS age
  FROM users) AS u_w_age
  GROUP BY age
  HAVING count(*) >= 5
  ORDER BY age;


SELECT sum(quantity), brand
FROM products
GROUP BY brand
HAVING sum(quantity)>60000;


SELECT count (*)
FROM orders
GROUP BY customer_id
HAVING count (*) >= 3;


CREATE TABLE a
(v char (3),
t int);

CREATE TABLE b
(v char (3));

INSERT INTO a VALUES
('XXX',1), ('XXY',1),('XXZ',1),
('XYX',2),('XYY',2),('XYZ',2),
('YXX',3),('YXY',3),('YXZ',3);

INSERT INTO b VALUES
('ZXX'), ('XXX'), ('ZXZ'), ('YXZ'), ('YXY');

SELECT v FROM A UNION
SELECT * FROM B;

SELECT v FROM A INTERSECT
SELECT * FROM B;

INSERT INTO users (
    first_name,
    last_name,
    email,
    birthday,
    gender
  )
VALUES (
    'Tester1',
    'Tester1',
    'test@test',
    '1990-02-02',
    'male'
  ),
  (
    'Tester2',
    'Tester2',
    'test2@test',
    '1990-02-02',
    'male'
  ),
  (
    'Tester3',
    'Tester3',
    'test3@test',
    '1990-02-02',
    'male'
  );

SELECT id FROM users
INTERSECT
SELECT customer_id FROM orders;


SELECT id FROM users
EXCEPT
SELECT customer_id FROM orders;


SELECT *
FROM A JOIN B ON A.v = B.v;


SELECT * FROM users JOIN orders
ON orders.customer_id = users.id
WHERE users.id = 1968;

SELECT u.*, o.id AS order_id 
FROM users AS u
JOIN orders AS o
ON o.customer_id = u.id
WHERE u.id = 1968;


SELECT p.model
FROM products AS p
JOIN orders_to_products AS otp
ON otp.product_id = p.id
WHERE otp.order_id  = 7;


----LEFT 
SELECT u.id, email, o.id AS order_id
FROM users AS u
LEFT JOIN orders AS o
ON u.id = o.customer_id;

SELECT u.id, email, o.id AS order_id
FROM users AS u
LEFT JOIN orders AS o
ON u.id = o.customer_id
WHERE o.id IS NULL;

SELECT u.id, email, o.id AS order_id
FROM users AS u
FULL JOIN orders AS o
ON u.id = o.customer_id;

SELECT otp.order_id, p.model
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
WHERE brand = 'Samsung';

SELECT p.model, count (*) AS amount
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
WHERE brand = 'Samsung'
GROUP BY p.model;


SELECT email
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
JOIN orders_to_products AS otp
ON o.id = otp.order_id
JOIN products AS p
ON otp.product_id = p.id
WHERE p.model = '96 model 59';


SELECT otp.product_id, sum(p.price*otp.quantity) AS total
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
GROUP BY otp.product_id;

______________________

SELECT otp.order_id
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
WHERE p.brand = 'Samsung';


SELECT u.email, count(*)
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id;


SELECT o.created_at, otp.quantity
FROM orders AS o
JOIN orders_to_products AS otp
ON o.id = otp.order_id;


SELECT otp.order_id, count (*)
FROM orders_to_products AS otp
GROUP BY otp.

*  Знайти найпопулярніший телефон (він купувався найбільшу кількість разів).
1. Вивести всі телефони і кількість їхніх продажів
2. Відсортувати в зворотньому порядку + ліміт 1шт.

SELECT p.brand, p.model, sum (otp.quantity)
FROM products AS p
JOIN orders_to_products AS otp
ON p.id = otp.product_id
GROUP BY p.model, p.brand
ORDER BY sum(otp.quantity) DESC
LIMIT 5;

1. Розрахувати середній чек всього магазину (середня вартість ВСІХ замовлень)
2. Знайти користувача, який зробив найбільше замовлення в магазині.
3. Найпопулярніший бренд (сума продажів всіх екземплярів всіх моделей)

1.
SELECT avg(o_w_sum.order_sum)
FROM (
  SELECT otp.order_id , sum (p.price*otp.quantity) AS order_sum
FROM orders_to_products AS otp
JOIN products AS p
ON p.id = otp.product_id
GROUP BY otp.order_id
) AS o_w_sum;



2.
SELECT u.*, sum (otp.quantity*p.price) AS total_sum
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
JOIN orders_to_products AS otp
ON o.id = otp.order_id
JOIN products AS p
ON otp.product_id = p.id
GROUP BY u.id
ORDER BY total_sum DESC
LIMIT 5;

3.
SELECT p.brand, sum(otp.quantity) AS amount
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
GROUP BY p.brand
ORDER BY amount DESC
LIMIT 1;


4. Витягти всі замовлення вартістю більше середнього чека магазину

--- ЦЕ МОНСТР!! ( 1 ый способ)
SELECT *
  FROM ( 
    SELECT otp.order_id, sum(p.price*otp.quantity) AS total_amount
    FROM orders_to_products AS otp
    JOIN products AS p
    ON p.id = otp.product_id
    GROUP BY otp.order_id) AS order_with_costs
    WHERE order_with_costs.total_amount > (SELECT avg(o_w_sum.order_sum)
       FROM (
            SELECT otp.order_id, sum(p.price*otp.quantity) AS order_sum
            FROM orders_to_products AS otp
            JOIN products AS p
            ON p.id = otp.product_id
            GROUP BY otp.order_id
              ) AS o_w_sum);


WITH "псевдонім" AS (табличний вираз)
SELECT ...
FROM "псевдонім"
*/

-----( 2 ой способ)

WITH orders_with_costs AS (
    SELECT otp.order_id, sum(p.price*otp.quantity) AS total_amount
    FROM orders_to_products AS otp
    JOIN products AS p
    ON p.id = otp.product_id
    GROUP BY otp.order_id
    )
SELECT owc.*
FROM orders_with_costs AS owc
WHERE owc.total_amount > (SELECT avg(o_w_sum.order_sum)
       FROM (
            SELECT otp.order_id, sum(p.price*otp.quantity) AS order_sum
            FROM orders_to_products AS otp
            JOIN products AS p
            ON p.id = otp.product_id
            GROUP BY otp.order_id
              ) AS o_w_sum);
    

5. Витягти всіх юзерів, кількість замовлень яких вище середнього



6. Витягти юзерів і кількість куплених ними моделей телефонів.

SELECT u.id, u.first_name, count (otp.product_id)
FROM users  AS u
JOIN orders AS o
ON u.id = o.customer_id
JOIN orders_to_products AS otp
ON o.id = otp.order_id
GROUP BY u.id;



ALTER TABLE orders
ADD COLUMN status boolean;

SELECT *, (
  CASE
  WHEN is_subscribe= TRUE
      THEN 'Підписаний'
  WHEN is_subscribe= FALSE
      THEN 'Не підписаний'
  ELSE 'Не відомий'
  END
)
FROM users;


SELECT *,(
  CASE extract ('month' from birthday)
    WHEN 1 THEN 'winter'
    WHEN 2 THEN 'winter'
    WHEN 3 THEN 'spring'
    WHEN 4 THEN 'spring'
    WHEN 5 THEN 'spring'
    WHEN 6 THEN 'summer'
    WHEN 7 THEN 'summer'
    WHEN 8 THEN 'summer'
    WHEN 9 THEN 'fall'
    WHEN 10 THEN 'fall'
    WHEN 11 THEN 'fall'
    WHEN 12 THEN 'winter'
    ELSE 'unknown'
  END
) AS "birth birthday"
FROM users;

SELECT *,(
  CASE 
    WHEN extract ('years' from age(birthday)) > 18 THEN 'Повнолітній'
    WHEN extract ('years' from age(birthday)) < 18 THEN 'Не повнолітній'
    ELSE 'невідомий'
    END
) FROM users;

--Вивести всі телефони, в стопці "manufacturer" вивести виробника - 
--якщо бренд - iPhone, то вивести Apple, для всіх інших - вивести "Other"

SELECT * ,(
  CASE 
  WHEN brand = 'iPhone' THEN 'APPLE'
  ELSE 'OTHER'
  END
) AS "MANUFACTURER"
FROM products;

--Вивести всіх користувачів та їхній статус - якщо у користувача > 3 замовлення, то він постійний клієнт,
--якщо від 1 до 3 - то він активний клієнт
--якщо 0 - то він новий клієнт

SELECT u.id,u.first_name,(
  CASE WHEN count(o.id) > 3 THEN 'постійний'
      WHEN count(o.id) > 1 AND count(o.id) <3 THEN 'активний'
  ELSE 'новий'
  END
) 
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id ;



SELECT id, brand, model, price, COALESCE (category, 'smartphone')
FROM products;

SELECT *, LEAST (price, 1000)
FROM products;


SELECT *
FROM users AS u
WHERE u.id IN (
        SELECT o.customer_id
        FROM orders AS o
);


SELECT *
FROM users AS u
WHERE u.id NOT IN (
        SELECT o.customer_id
        FROM orders AS o
);


--Знайти телефони, які ніколи не купували

SELECT *
FROM products AS p
WHERE p.id NOT IN (
        SELECT otp.product_id
        FROM orders_to_products AS otp
);

SELECT EXISTS
    (SELECT o.customer_id
    FROM orders AS o
    WHERE id = 293);

SELECT u.id, u.email, (EXISTS
                    (SELECT o.customer_id
                    FROM orders AS o))
FROM users AS u
WHERE id = 293;


SELECT *
FROM products AS p
WHERE p.id != ALL (
          SELECT otp.product_id
          FROM orders_to_products AS otp
);


CREATE VIEW orders_with_sum_model_count AS (
  SELECT o.* , sum (p.price*otp.quantity), count (otp.product_id)
  FROM orders AS o
  JOIN orders_to_products AS otp
  ON o.id = otp.order_id
  JOIN products AS p
  ON p.id = otp.product_id
  GROUP BY o.id
);

SELECT u.* , sum (owsmc.sum)
FROM users AS u
JOIN orders_with_sum_model_count AS owsmc
ON u.id = owsmc.customer_id
GROUP BY u.id;


SELECT *
FROM 





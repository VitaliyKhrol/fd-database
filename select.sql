
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

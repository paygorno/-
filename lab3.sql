use lab1;
SELECT * FROM BOOKS WHERE book_cost IS NULL OR book_cost = 0;
SELECT * FROM BOOKS WHERE book_cost IS NOT NULL AND tirage IS NULL;
SELECT * FROM BOOKS WHERE publishing_date IS NULL;
SELECT * FROM BOOKS WHERE TIMESTAMPDIFF(YEAR, publishing_date, CURDATE())=0;
SELECT * FROM BOOKS WHERE is_new ORDER BY book_cost ASC;
SELECT * FROM BOOKS WHERE pages_num BETWEEN 300 AND 400 ORDER BY book_name DESC;
SELECT * FROM BOOKS WHERE book_cost BETWEEN 20 AND 40 ORDER BY publishing_date DESC;
SELECT * FROM BOOKS ORDER BY book_cost DESC, book_name ASC;
SELECT * FROM BOOKS WHERE book_cost*100/pages_num < 10;
SELECT LENGTH(book_name) AS num, LEFT(book_name, 20) AS first_20 FROM BOOKS;
SELECT CONCAT(LEFT(book_name, 10), '...', RIGHT(book_name, 10)) FROM BOOKS;
SELECT book_name, publishing_date, DAY(publishing_date) AS PUB_DAY, MONTH(publishing_date) AS PUB_MONTH, YEAR(publishing_date) AS PUB_YEAR FROM BOOKS;
SELECT book_name, publishing_date, DATE_FORMAT(publishing_date, '%d/%m/%Y') FROM BOOKS;
SELECT book_code, book_cost, ROUND(book_cost*24.47, 2) AS UAH, ROUND(book_cost*0.91, 2) AS EUR, ROUND(book_cost*66.78, 2) FROM BOOKS;
SELECT book_code, book_cost, TRUNCATE(book_cost*24.47, 0) AS UAH_TRUNC, ROUND(book_cost*24.47, 0) AS UAH_ROUND FROM BOOKS;
INSERT INTO BOOKS(id, book_code, is_new, book_name, book_cost, publishing_house, pages_num, book_format, publishing_date,tirage, book_topic, book_cathegory)
VALUES (221, 4688, FALSE, 'DEFNAME1', 10.50, 'DEFPH1', 500, '70х100 / 16', '2009-9-29', 5000, 'DEFTOPIC1', 'DEFCATH1');
INSERT INTO BOOKS (id, book_code, book_name, book_cost)
VALUES (222, 4689, 'DEFNAME2', 11.50);
DELETE FROM BOOKS WHERE YEAR(publishing_date)<1990;
UPDATE BOOKS SET publishing_date = CURDATE() WHERE publishing_date IS NULL;
UPDATE BOOKS SET is_new = TRUE WHERE YEAR(publishing_date)>2005;
use lab1;
SELECT COUNT(*), SUM(book_cost), AVG(book_cost), min(book_cost), max(book_cost) from BOOKS;
SELECT COUNT(*) where book_cost is not null;
SELECT COUNT(*), AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost), is_new from BOOKS
group by is_new;
SELECT COUNT(*), AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost), year(publishing_date) from BOOKS
group by year(publishing_date);
SELECT COUNT(*), AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost), year(publishing_date) from BOOKS where book_cost between 10 and 20
group by year(publishing_date);
SELECT COUNT(*) as cnt, AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost), year(publishing_date) from BOOKS
group by year(publishing_date) order by cnt DESC;
SELECT COUNT(*), book_code FROM BOOKS group by book_code;
SELECT COUNT(*), COUNT(book_cost), LEFT(book_name) as f_char FROM BOOKS group BY LEFT(book_name, 1);
SELECT COUNT(*), COUNT(book_cost) FROM BOOKS where book_name not regexp '^[A-Za-z0-9]' group BY LEFT(book_name, 1);
SELECT COUNT(*), COUNT(book_cost), LEFT(book_name) as f_char FROM BOOKS where year(publishing_date)>2000 group BY LEFT(book_name, 1);
SELECT COUNT(*), COUNT(book_cost), LEFT(book_name) as f_char FROM BOOKS where year(publishing_date)>2000 group BY f_char order BY f_char desc;
SELECT COUNT(*), AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost) from BOOKS group by (year(publishing_date), month(publishing_date));
SELECT COUNT(*), AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost) from BOOKS where publishing_date is not null group by (year(publishing_date), month(publishing_date));
SELECT COUNT(*), AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost) from BOOKS group by (year(publishing_date), month(publishing_date)) order by year(publishing_date) DESC, month(publishing_date) DESC;

SELECT is_new, COUNT(book_cost)*24.47 as UAH, COUNT(book_cost)*0.91 as EUR group by is_new;
SELECT is_new, round(COUNT(book_cost)*24.47) as UAH, round(COUNT(book_cost)*0.91, 0) as EUR, round(COUNT(book_cost)*66.78, 0) group by is_new;
SELECT COUNT(*), AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost), publishing_house from BOOKS group by publishing_house;
SELECT COUNT(*), AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost), publishing_house from BOOKS group by (publishing_house, topic);
SELECT COUNT(*), AVG(book_cost), SUM(book_cost), min(book_cost), max(book_cost), publishing_house from BOOKS group by (book_cathegory,topic,publishing_house);
SELECT publishing_house, SUM(book_cost*100) as cost_count, SUM(pages_num) as page_count from BOOKS group by publishing_house; 
SELECT publishing_house, round(SUM(book_cost*100)/SUM(pages_num), 0) as page_cost from BOOKS where page_cost>10 group by publishing_house;

use lab1;

--1
select name.book_name, meta.book_cost, meta.publishing_house
from BookName name, BookMeta meta
    where name.book_code = meta.book_code;
--2
select name.book_name, b_cath.book_cathegory
from BooksCathegorised b_cath inner join BookName name
    on name.book_code = b_cath.book_code;
--3
select name.book_name, meta.book_cost, meta.publishing_house, meta.book_format
from BookName name inner join BookMeta meta
    on name.book_code = meta.book_code;
--4
select cath.book_topic, cath.book_cathegory, name.book_name, meta.publishing_house from
    BooksCathegorised b_cath 
    natural join Cathegories cath
    natural join BookMeta meta
    natural join BookName name
order by cath.book_topic ASC, cath.book_cathegory ASC;
--5
select name.book_name
from BookName name inner join BookMeta meta
    on name.book_code = meta.book_code
where meta.publishing_house = 'BHV С.-Петербург' 
    and year(meta.publishing_date) > 2000;
--6
select cath.book_cathegory,  sum(meta.pages_num) p_sum from 
    BooksCathegorised b_cath
    natural join Cathegories cath
    natural join BookMeta meta
group by cath.book_cathegory
order by p_sum DESC;
--7
select avg(meta.book_cost) avg_cost from 
    BooksCathegorised b_cath
    natural join Cathegories cath
    natural join BookMeta meta
where cath.book_topic = 'Використання ПК' or cath.book_cathegory = 'Linux'; 
--8

--9
select * from 
    BooksCathegorised b_cath
    inner join Cathegories cath
        on b_cath.book_cathegory = cath.book_cathegory
    inner join BookMeta meta
        on meta.book_code = b_cath.book_code
    inner join BookName name
        on b_cath.book_code = name.book_code;
--10

--11
select a_name.book_name, b_name.book_name from
    BookName a_name, BookMeta a, BookName b_name, BookMeta b
    where   a_name.book_code = a.book_code 
        and b_name.book_code = b.book_code
        and a.pages_num = b.pages_num
        and a.book_code != b.book_code;
--12
select a_name.book_name, b_name.book_name, c_name.book_name from
    BookName a_name, BookMeta a, BookName b_name, BookMeta b, BookName c_name, BookMeta c
    where   a_name.book_code = a.book_code 
        and b_name.book_code = b.book_code
        and c_name.book_code = c.book_code
        and a.book_cost = b.book_cost and b.book_cost = c.book_cost
        and a.book_code != b.book_code and a.book_code != c.book_code and b.book_code != c.book_code;
--13
select * from
    (BooksCathegorised b_cath 
    natural join Cathegories cath
    natural join BookMeta meta
    natural join BookName name)
where book_cathegory = 'C & C ++';
--14
select name.book_name from
    BooksCathegorised b_cath
    natural join BookName name
    natural join (select * from BookMeta where publishing_house = 'BHV С.-Петербург' and year(publishing_date)>=2000) meta;
--15
select publishing_house from BookMeta meta
    where not exists (select * from BookMeta where publishing_house = meta.publishing_house and pages_num < 400);
--16
select book_cathegory from Cathegories cath
where (select count(*) from BooksCathegorised where book_cathegory = cath.book_cathegory) > 3;
--17
/* не понял вопроса */
--18
/* не понял вопроса */
--19
select book_name a from v
union (select distinct book_topic a from v)
union (select distinct book_cathegory a from v)
order by a ASC;
--20
select distinct left(book_name, locate(' ', book_name)) a from v
union (select distinct book_cathegory a from v)
order by a DESC;
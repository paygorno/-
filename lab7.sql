use lab1;

--1
drop procedure if exists proc1;
create procedure proc1()
    select name.book_name, meta.publishing_house, meta.book_format
    from BooksCathegorised b_cath
        natural join BookMeta meta
        natural join BookName name;
--2
drop procedure if exists proc2;
create procedure proc2(in topic varchar(30) CHARACTER SET utf8,
                       in cathegory varchar(30) CHARACTER SET utf8)
    select cath.book_topic, cath.book_cathegory, name.book_name, meta.publishing_house
    from BooksCathegorised b_cath
        natural join BookMeta meta
        natural join BookName name
        natural join Cathegories cath
    where cath.book_topic = topic and cath.book_cathegory = cathegory;
--3
drop procedure if exists proc3;
create procedure proc3(in p_house VARCHAR(20) CHARACTER SET utf8,
                       in p_year int)
    select * from v where year(publishing_date)>2000 
                      and publishing_house like p_house;
call proc3('%BHV%', 2000);
--4
drop procedure if exists proc4;
create procedure proc4()
    select book_cathegory, sum(pages_num) overall_pages from v group by book_cathegory
    order by overall_pages asc;
call proc4();
--5
drop procedure if exists proc5;
create procedure proc5(in topic varchar(30) CHARACTER SET utf8,
                       in cathegory varchar(30) CHARACTER SET utf8)
    select avg(book_cost) from v
    where book_cathegory = cathegory and book_topic = topic;
call proc5('Використання ПК', 'Linux');
--6
drop procedure if exists proc6;
create procedure proc6()
    select * from v;
call proc6();
--7
drop procedure if exists proc7;
create procedure proc7()
    select v1.book_name, v2.book_name from v v1, v v2
    where v1.id != v2.id and v1.pages_num = v2.pages_num;
call proc7();
--8
drop procedure if exists proc8;
create procedure proc8()
    select v1.book_name, v2.book_name, v3.book_name from v v1, v v2, v v3
    where v1.id != v2.id
        and v2.id != v3.id
        and v1.id != v3.id
        and v1.book_cost = v2.book_cost and v2.book_cost = v3.book_cost;
call proc8();
--9
drop procedure if exists proc9;
create procedure proc9(in cathegory varchar(30) CHARACTER SET utf8)
    select book_name from v
    where book_cathegory like cathegory;
call proc9('%C ++%');
--10
drop procedure if exists proc10;
create procedure proc10(in num int)
    select publishing_house from BookMeta meta
    where not exists (select * from BookMeta where publishing_house = meta.publishing_house and pages_num < num);
call proc10(400);
--11
drop procedure if exists proc11;
create procedure proc11(in num int)
    select cath.book_cathegory from Cathegories cath
    where (select count(*) from v where book_cathegory = cath.book_cathegory) > num;
call proc11(3);
--12
drop procedure if exists proc12;
create procedure proc12(in p_house VARCHAR(20) CHARACTER SET utf8)
    select view.book_name from v view
    where view.publishing_house like p_house and exists (select * from v where publishing_house like view.publishing_house);
call proc12('%BHV%');
--13
drop procedure if exists proc13;
create procedure proc13(in p_house VARCHAR(20) CHARACTER SET utf8)
    select view.book_name from v view
    where view.publishing_house like p_house and not exists (select * from v where publishing_house like view.publishing_house);
call proc13('%BHV%');
--14
drop procedure if exists proc14;
create procedure proc14()
    select book_name a from v
    union (select book_topic a from v)
    union (select book_cathegory a from v)
    order by a asc;
call proc14();
--15
drop procedure if exists proc15;
create procedure proc15()
    select distinct left(book_name, locate(' ', book_name)) a from v
    union (select distinct book_cathegory a from v)
    order by a DESC;
call proc15();
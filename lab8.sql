use lab1;

--1
CREATE TRIGGER `trigger1insert` BEFORE INSERT ON `Cathegories`
for each row begin
    declare @topics_num int;
    set @topics_num = (select count(cath.book_topic) from Cathegories cath);
    if not exists (select * from Cathegories where book_topic = new.book_topic)
    then
        set @topics_num = @topics_num + 1;
    end if;
    if not @topics_num between 5 and 10 then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка вставки: количество тем должно лежать в диапазоне [5, 10]';
    end if;
end;


create trigger `trigger1delete` before delete on `Cathegories`
for each row begin
    declare @topics_num int;
    set @topics_num = (select count(cath.book_topic) from Cathegories cath);
    if (select count(*) from Cathegories where book_topic = old.book_topic) = 1
    then
        set @topics_num = @topics_num - 1;
    end if;
    if not @topics_num between 5 and 10 then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка удаления: количество тем должно лежать в диапазоне [5, 10]';
    end if;
end;

create trigger `trigger1update` before update on `Cathegories`
for each row begin
    if old.book_topic != new.book_topic
    then
        declare @topics_num int;
        set @topics_num = (select count(cath.book_topic) from Cathegories cath);
        if not exists (select * from Cathegories where book_topic = new.book_topic)
        then
            set @topics_num = @topics_num + 1;
        end if;
        if (select count(*) from Cathegories where book_topic = old.book_topic) = 1
        then
            set @topics_num = @topics_num - 1;
        end if;
        if not @topics_num between 5 and 10 then
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка обновления: количество тем должно лежать в диапазоне [5, 10]';
        end if;
    end if;
end;

/* 2 */
create trigger `trigger2update` before update on `BookMeta`
for each row begin
    if year(current_date()) != year(new.publishing_date) and new.is_new
    then 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка обновления: новинкой может быть только книга изданая в текущем году';
    end if;
end;

create trigger `trigger2insert` before insert on `BookMeta`
for each row begin
    if year(current_date()) != year(new.publishing_date) and new.is_new
    then 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка вставки: новинкой может быть только книга изданая в текущем году';
    end if;
end;

/* 3 */
create trigger `trigger3update` before update on `BookMeta`
for each row begin
    if (new.pages_num < 100 and new.book_cost > 10)
        or (new.pages_num < 200 and new.book_cost > 20)
        or (new.pages_num < 300 and new.book_cost > 30)
    then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка обновления: Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $';
    end if;
end;

create trigger `trigger3insert` before insert on `BookMeta`
for each row begin
    if (new.pages_num < 100 and new.book_cost > 10)
        or (new.pages_num < 200 and new.book_cost > 20)
        or (new.pages_num < 300 and new.book_cost > 30)
    then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка вставки: Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $';
    end if;
end;

/* 4 */
create trigger `trigger4update` before update on `BookMeta`
for each row begin
    if (new.publishing_house like '%BHV%' and new.tirage < 5000)
        or (new.publishing_house like '%Diasoft%' and new.tirage < 10000)
    then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка обновления: Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000';
    end if;
end;

create trigger `trigger4insert` before insert on `BookMeta`
for each row begin
    if (new.publishing_house like '%BHV%' and new.tirage < 5000)
        or (new.publishing_house like '%Diasoft%' and new.tirage < 10000)
    then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка вставки: Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000';
    end if;
end;

/* 5 */
create trigger `trigger5update` before update on `BooksCathegorised`
for each row begin
    if exists (select * from BooksCathegorised where book_code = new.book_code and book_cathegory != new.book_cathegory)
    then 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка обновления: Книги з однаковим кодом повинні мати однакові дані.';
    end if;
end;

create trigger `trigger5insert` before insert on `BooksCathegorised`
for each row begin
    if exists (select * from BooksCathegorised where book_code = new.book_code and book_cathegory != new.book_cathegory)
    then 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка вставки: Книги з однаковим кодом повинні мати однакові дані.';
    end if;
end;
/*Одинаковость остальных данных гарантируется структурой разбиения (см. lab5)*/

/* 8 */
create trigger `trigger8update` before update on `BooksCathegorised`
for each row begin
    declare @p_house VARCHAR(20) CHARACTER SET utf8;
    set @p_house = (select publishing_house from BookMeta where book_code = new.book_code);
    if (@p_house = 'ДМК' or @p_house = 'Еком') and new.book_cathegory = 'підручники'
    then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка обновления: Видавництва ДМК і Еком підручники не видають';
    end if;
end;

create trigger `trigger8insert` before insert on `BooksCathegorised`
for each row begin
    declare @p_house VARCHAR(20) CHARACTER SET utf8;
    set @p_house = (select publishing_house from BookMeta where book_code = new.book_code);
    if (@p_house = 'ДМК' or @p_house = 'Еком') and new.book_cathegory = 'підручники'
    then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка вставки: Видавництва ДМК і Еком підручники не видають';
    end if;
end;

/* 7 */
create trigger `trigger7update` before update on `BookMeta`
for each row begin
    if new.book_cost != old.book_cost and left(user(), locate('@', user)) = 'dbo'
    then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка обновления: Користувач "dbo" не має права змінювати ціну книги.';
    end if;
end;

/* 9 */
create trigger `trigger9update` before update on `BookMeta`
for each row begin
    if year(new.publishing_date) = year(current_date())
    then
        declare @new_books_num int;
        set @new_books_num = (select count(*) from v where year(publishing_date) = year(new.publishing_date) and month(publishing_date) = month(new.publishing_date));
        if @new_books_num >= 10 then
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка обновления: Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року';
        end if;
    end if;
end;

create trigger `trigger9insert` before insert on `BookMeta`
for each row begin
    if year(new.publishing_date) = year(current_date())
    then
        declare @new_books_num int;
        set @new_books_num = (select count(*) from v where year(publishing_date) = year(new.publishing_date) and month(publishing_date) = month(new.publishing_date));
        if @new_books_num >= 10 then
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка вставки: Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року';
        end if;
    end if;
end;
/* 10 */
create trigger `trigger10update` before update on `BookMeta`
for each row begin
    if new.publishing_house = 'BHV' and new.book_format = '60х88 / 16'
    then 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка обновления: Видавництво BHV не випускає книги формату 60х88 / 16';
    end if;
end;

create trigger `trigger10insert` before insert on `BookMeta`
for each row begin
    if new.publishing_house = 'BHV' and new.book_format = '60х88 / 16'
    then 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка вставки: Видавництво BHV не випускає книги формату 60х88 / 16';
    end if;
end;

/*
    Допустим, изначальная таблица не содержит ошибок 
    (например, под номерами 2 и 31 действительно должна храниться одна и та же книга 
    с разными темами и категориями)
    Таблица находится во 2 нормальной форме. Нормализуем ее до нормальной формы Бойса-Кодда
    Приняв за первичный ключ номер книги, обнаруживаем в таблице следующие транзитифные функциональные зависимости:
    1. book_code -> (book_name, book_cost, publishing_house, pages_num, book_format, publishing_date, tirage), вынесем эти поля в отдельную таблицу BookMeta
    1.1. В таблице BookMeta имеется транзитивная зависимость book_name -> (все остальные поля) вынесем book_name и book_code в отдельную таблицу BookName
    2. book_cathegory -> book_topic Вынесем эти поля в отдельную таблицу
*/
use lab1;
Drop table BooksCathegorised;
drop table BookMeta;
Drop table Cathegories;
drop table book_name;

CREATE TABLE BookName(
    book_code INT NOT NULL PRIMARY KEY,
    book_name VARCHAR(100) CHARACTER SET utf8 NOT NULL
);
CREATE TABLE BookMeta(
    book_code INT NOT NULL PRIMARY KEY,
    is_new BOOL DEFAULT TRUE,
    book_cost DECIMAL(5,2) NOT NULL,
    publishing_house VARCHAR(20) CHARACTER SET utf8,
    pages_num INT,
    book_format VARCHAR(20) CHARACTER SET utf8,
    publishing_date DATE	,
	tirage INT,
    FOREIGN KEY (book_code) REFERENCES BookName (book_code)
);
Drop table Cathegories;
CREATE TABLE Cathegories(
    book_cathegory VARCHAR(30) CHARACTER SET utf8 NOT NULL PRIMARY KEY,
    book_topic VARCHAR(30) CHARACTER SET utf8 NOT NULL
);

CREATE TABLE BooksCathegorised(
    id INT NOT NULL PRIMARY KEY,
    book_code INT NOT NULL,
    book_cathegory VARCHAR(30) CHARACTER SET utf8 NOT NULL,
    FOREIGN KEY (book_code) REFERENCES BookMeta (book_code) ON DELETE RESTRICT,
    FOREIGN KEY (book_cathegory) REFERENCES Cathegories (book_cathegory) ON DELETE RESTRICT
);


INSERT INTO Cathegories(book_cathegory, book_topic)
VALUES ('підручники', 'Використання ПК в цілому'),
       ('Апаратні засоби ПК', 'Використання ПК в цілому'),
       ('Захист і безпека ПК', 'Використання ПК в цілому'),
       ('інші книги', 'Використання ПК в цілому'),
       ('Windows 2000', 'Операційні системи'),
       ('Linux', 'Операційні системи'),
       ('Unix', 'Операційні системи'),
       ('Інші операційні системи', 'Операційні системи'),
       ('C & C ++', 'програмування');
INSERT INTO BookName(book_code, book_name)
VALUES  (5110,'Апаратні засоби мультимедія. відеосистема РС'),
        (4985, 'Освой самостійно модернізацію і ремонт ПК за 24 години, 2-е вид.'),
        (5141, 'Структури даних і алгоритми.'),
        (5127, 'Автоматизація інженерно графічних робіт'),
        (5199, 'Залізо IBM 2001.'),
        (3851, 'Захист інформації і безпека комп\'ютерних систем'),
        (3932, 'Як перетворити персональний комп\'ютер у вимірювальний комплекс'),
        (4713, 'Plug- ins. Вбудовувані додатки для музичних програм'),
        (5217, 'Windows МЕ. Новітні версії програм'),
        (4829, 'Windows 2000 Professional крок за кроком з З D'),
        (5170, 'Linux Російські версії'),
        (860, 'Операційна система UNIX'),
        (44, 'Відповіді на актуальні питання по OS / 2 Warp'),
        (5176, 'Windows Ме. супутник користувача'),
        (5462, 'Мова програмування С ++. Лекції і вправи'),
        (4982, 'Мова програмування С. Лекції і вправи'),
        (4687, 'Ефективне використання C ++ .50 рекомендацій щодо поліпшення ваших програм і проектів');
INSERT INTO BookMeta(book_code, is_new, book_cost, publishing_house, pages_num, book_format, publishing_date, tirage)
VALUES  (5110, FALSE, 15.51, 'BHV С.-Петербург', 400, '70х100 / 16', '2000-7-24', 5000),
        (4985, FALSE, 18.90, 'Вільямс', 288, '70х100 / 16', '2000-7-7', 5000),
        (5141, FALSE, 37.80, 'Вільямс', 384, '70х100 / 16', '2000-9-29', 5000),
        (5127, TRUE, 11.58, 'Пітер', 256, '70х100 / 16', '2000-6-15',  5000),
        (5199, FALSE, 30.07, 'МікроАрт', 368, '70х100 / 16', '2000-2-12', 5000),
        (3851, TRUE, 26.00, 'DiaSoft', 480, '84х108 / 16', '1999-2-4', 5000),
        (3932, FALSE, 7.65, 'ДМК', 144, '60х88 / 16', '1999-6-9', 5000),
        (4713, FALSE, 11.41, 'ДМК', 144, '70х100 / 16', '2000-2-22', 5000),
        (5217, FALSE, 16.57, 'Тріумф', 320, '70х100 / 16', '2000-8-25', 5000),
        (4829, FALSE, 27.25, 'Еком', 320,'70х100 / 16', '2000-4-28', 5000),
        (5170, FALSE,24.43, 'ДМК', 346, '70х100 / 16', '2000-9-29', 5000),
        (860, FALSE, 3.50, 'BHV С.-Петербург', 395, '84х100 \ 16', '1997-5-5', 5000),
        (44, FALSE, 5.00, 'DiaSoft', 352, '60х84 / 16', '1996-3-20', 5000),
        (5176, FALSE, 12.79, 'Російська редакція', 306, NULL, '2000-10-10', 5000),
        (5462, FALSE, 29.00, 'DiaSoft', 656, '84х108 / 16', '2000-12-12', 5000),
        (4982, FALSE, 29.00, 'DiaSoft', 432, '84х108 / 16', '2000-7-12', 5000),
        (4687, FALSE, 17.60, 'ДМК', 240, '70х100 / 16', '2000-2-3', 5000);
INSERT INTO BooksCathegorised(id, book_code, book_cathegory)
VALUES (2, 5110, 'підручники'),
        (8, 4985, 'підручники'),
        (9, 5141, 'підручники'),
        (20, 5127, 'підручники'),
        (31, 5110, 'Апаратні засоби ПК'),
        (46, 5199, 'Апаратні засоби ПК'),
        (50, 3851, 'Захист і безпека ПК'),
        (58, 3932, 'інші книги'),
        (59, 4713, 'інші книги'),
        (175, 5217, 'Windows 2000'),
        (176, 4829, 'Windows 2000'),
        (188, 5170, 'Linux'),
        (191, 860, 'Unix'),
        (203, 44, 'Інші операційні системи'),
        (206, 5176, 'Інші операційні системи'),
        (209, 5462, 'C & C ++'),
        (210, 4982, 'C & C ++'),
        (220, 4687, 'C & C ++'); 

/* Полученная таблица нормализована по Бойсу-Кодду */

create view v as select * from BooksCathegorised bookscath
    natural join BookMeta meta
    natural join BookName name
    natural join Cathegories cath;
select * from v;
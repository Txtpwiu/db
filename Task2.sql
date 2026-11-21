--2. Создание таблиц--

--Читатели
create table readers (
    reader_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    telephone VARCHAR(20) NOT NULL
);

create table books (
    isbn VARCHAR(100) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year INT CHECK(publication_year > 0 )
);

--авторы
create table authors(
    author_id SERIAL PRIMARY KEY,
    author_full_name VARCHAR(255) NOT NULL
);

--авторство
create table book_authors(
    book_isbn VARCHAR(100)  NOT NULL REFERENCES books(isbn),
    author_id INT NOT NULL REFERENCES authors(author_id),
    PRIMARY KEY (book_isbn, author_id)
);

--выдача
create table loans(
    id_issue SERIAL PRIMARY KEY,
    id_reader INT NOT NULL REFERENCES readers(reader_id),
    book_isbn VARCHAR(100) NOT NULL REFERENCES books(isbn),
    date_of_issue DATE NOT NULL,
    planned_return_date DATE NOT NULL,
    actual_return_date DATE,

    CHECK (planned_return_date >= date_of_issue),
    CHECK (actual_return_date IS NULL OR actual_return_date >= date_of_issue)
);


--3.Начальное наполнение базы данных--

--читатели
INSERT INTO readers (full_name, telephone)
    VALUES ('Анна Петрова', '+7-900-111-22-33'),
    ('Иван Соколов', '+7-900-222-33-44'),
    ('Мария Ким', '+7-900-333-44-55'),
    ('Олег Васильев', '+7-900-444-55-66');

--авторы
INSERT INTO authors (author_full_name)
    VALUES ('Михаил Булгаков'),
    ('Федор Достоевский'),
    ('Лев Толстой'),
    ('Илья Ильф'),
    ('Евгений Петров'),
    ('Аркадий Стругацкий'),
    ('Борис Стругацкий');

--книги
INSERT INTO books(isbn, title, publication_year)
    VALUES ('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
    ('978-5-389-06256-6', 'Преступление и наказание', 1866),
    ('978-5-04-116716-3', 'Война и мир', 1869),
    ('978-5-699-12014-7', 'Золотой теленок', 1931),
    ('978-5-389-03713-7', 'Пикник на обочине', 1972);

--авторство
INSERT INTO book_authors(book_isbn, author_id)
    VALUES ('978-5-17-118366-8', 1),
    ('978-5-389-06256-6', 2),
    ('978-5-04-116716-3', 3),
    ('978-5-699-12014-7', 4),
    ('978-5-699-12014-7', 5),
    ('978-5-389-03713-7', 6),
    ('978-5-389-03713-7', 7);
    
--Выдачи книг.--

INSERT INTO loans (id_reader, book_isbn, date_of_issue, planned_return_date, actual_return_date)
    VALUES (1, '978-5-17-118366-8', '2026-11-01', '2026-11-15', NULL),--незаконченные выдачи
    (2, '978-5-389-06256-6', '2026-11-03', '2026-11-17', NULL),
    (3, '978-5-04-116716-3', '2026-10-01', '2026-10-15', '2026-10-14'), --законченные выдачи
    (4, '978-5-699-12014-7', '2026-10-05', '2026-10-19', '2026-10-18'),
    (1, '978-5-389-03713-7', '2026-11-05', '2026-11-19', NULL), --вторая выдача Анны
    (2, '978-5-04-116716-3', '2026-11-06', '2026-11-20', '2026-11-10'); --вторая выдача Ивана



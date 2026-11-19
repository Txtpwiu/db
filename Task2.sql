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


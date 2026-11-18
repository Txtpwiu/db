--Читатели
CREATE TABLE readers (
reader_id SERIAL PRIMARY KEY,
full_name VARCHAR(225) NOT NULL,
phone VARCHAR(11) NOT NULL
);

--книги
CREATE TABLE books (
    isbn VARCHAR(13) PRIMARY KEY,
    name VARCHAR(225) NOT NULL,
    publication_year INT CHECK(publication_year >0 )
);

--авторы
CREATE TABLE Authors(
    Author_id INT NOT NULL,
    Author_full_name VARCHAR(255) NOT NULL
);

--авторство
CREATE TABLE Book_authors(
    book_isbn INT NOT NULL REFERENCES book(isbn)
    Author_id INT NOT NULL REFERENCES Authors(Author_id)
    PRIMARY KEY (book_isbn, Author_id)
);

--выдача
CREATE TABLE loans(
    id_issue SERIAL PRIMARY KEY,
    id_raeder INT NOT NULL REFERENCES readers(reader_id),
    book_isbn VARCHAR(13) REFERENCES books(isbn),
    date_of_issue DATE NOT NULL,
    planned_return_date DATE NOT NULL,
    actual_return_date DATE,

    CHECK (planned_return_date >= date_of_issue),
    CHECK (actual_return_date IS NULL OR actual_return_date >= date_of_issue)
);


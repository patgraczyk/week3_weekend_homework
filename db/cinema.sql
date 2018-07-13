DROP TABLE tickets;
DROP TABLE films;
DROP TABLE screenings;
DROP TABLE customers;

CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  funds INT4
);

CREATE TABLE films (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  price INT4
);

CREATE TABLE tickets (
  id SERIAL8 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE screenings (
  id SERIAL8 PRIMARY KEY,
  screening VARCHAR (255),
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE
);

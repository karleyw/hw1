-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions:
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy.
-- - Movie data includes the movie title, year released, MPAA rating,
--   and studio.
-- - There are many studios, and each studio produces many movies, but
--   a movie belongs to a single studio.
-- - An actor can be in multiple movies.
-- - Everything you need to do in this assignment is marked with TODO!

-- User stories:
-- - As a guest, I want to see a list of movies with the title, year released,
--   MPAA rating, and studio information.
-- - As a guest, I want to see the movies which a single studio has produced.
        -- SELECT studios.studio_name, movies.title
        -- FROM studios
        -- INNER join movies
        -- ON studios.id = movies.studio_id;
-- - As a guest, I want to see each movie's cast including each actor's
--   name and the name of the character they portray.
-- - As a guest, I want to see the movies which a single actor has acted in.
        -- SELECT actors.actor_name, movies.title
        -- FROM movies
        -- INNER join troupe
        -- ON movies.id = troupe.movie_id
        -- INNER join actors
        -- ON actors.id = troupe.actor_id
        -- ORDER BY actors.actor_name ASC;

-- * Note: The "guest" user role represents the experience prior to logging-in
--   to an app and typically does not have a corresponding database table.


-- Deliverables
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
-- - Insertion of "Batman" sample data into tables.
-- - Selection of data, so that something similar to the sample "report"
--   below can be achieved.

-- Rubric
--
-- 1. Domain model - 6 points
-- - Think about how the domain model needs to reflect the
--   "real world" entities and the relationships with each other. 
--   Hint: It's not just a single table that contains everything in the 
--   expected output. There are multiple real world entities and
--   relationships including at least one many-to-many relationship.

-- 2. Execution of the domain model (CREATE TABLE) - 4 points
-- - Follow best practices for table and column names
-- - Use correct data column types (i.e. TEXT/INTEGER)
-- - Use of the `model_id` naming convention for foreign key columns

-- Drop existing tables to start fresh each time this script is run:
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS characters;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS studios;
DROP TABLE IF EXISTS troupe;

-- Turn column mode on, headers off:
.mode column
.headers off

-- Create new tables according to domain model:
CREATE TABLE movies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  year TEXT,
  MPAA_rating TEXT,
  studio_id INTEGER
);

CREATE TABLE characters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    character_name TEXT
);

CREATE TABLE actors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    actor_name TEXT,
    character_id INTEGER
);

CREATE TABLE studios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    studio_name TEXT
);

CREATE TABLE troupe (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_id INTEGER,
    actor_id INTEGER
);

-- Insert data into your database using hard-coded foreign key IDs when necessary:
INSERT INTO movies (
    "title",
    "year",
    "MPAA_rating",
    studio_id
) VALUES (
    "Batman Begins",
    "2005",
    "PG-13",
    1
    ),
(   "The Dark Knight",
    "2008",
    "PG-13",
    1
    ),
(   "The Dark Knight Rises",
    "2012",
    "PG-13",
    1
);

INSERT INTO studios (
    "studio_name"
) VALUES (
    "Warner Bros.");

INSERT INTO characters (
    "character_name"
) VALUES (
    "Bruce Wayne"),
    ("Alfred"),
    ("Ra's Al Ghul"),
    ("Rachel Dawes"),
    ("Commissioner Gordon"),
    ("Joker"),
    ("Harvey Dent"),
    ("Bane"),
    ("John Blake"),
    ("Selina Kyle");

INSERT INTO actors (
    "actor_name", character_id) VALUES (
    "Christian Bale", 1), ("Michael Caine", 2),
    ("Liam Neeson", 3), ("Katie Holmes", 4),
    ("Gary Oldman", 5), ("Heath Ledger",6),
    ("Aaron Eckhart",7), ("Maggie Gyllenhaal",4),
    ("Tom Hardy",8), ("Joseph Gordon-Levitt",9),
    ("Anne Hathway",10);

INSERT INTO troupe (movie_id, actor_id) 
VALUES 
(1, 1),(1, 2),(1, 3),(1,4),(1,5),
(2, 1),(2, 6),(2, 7),(2,2),(2,8),
(3, 1),(3, 5),(3, 9),(3, 10),(3, 11);

-- Print a header for the movies output:
.print "Movies"
.print "======"
.print ""

-- The SQL statement for the movies output:
SELECT movies.title, movies.year, movies.MPAA_rating, studios.studio_name
FROM movies
INNER JOIN studios
ON movies.studio_id = studios.id;

-- Print a header for the cast output:
.print ""
.print "Top Cast"
.print "========"
.print ""

-- The SQL statement for the output (MOVIE    ACTOR    CHARACTER):
SELECT movies.title, actors.actor_name, characters.character_name
FROM movies
INNER join troupe
ON movies.id = troupe.movie_id
INNER join actors
ON actors.id = troupe.actor_id
INNER join characters
ON characters.id = actors.character_id;


-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Warner Bros.
-- The Dark Knight        2008           PG-13  Warner Bros.
-- The Dark Knight Rises  2012           PG-13  Warner Bros.

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle
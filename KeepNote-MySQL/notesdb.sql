CREATE SCHEMA `notesdb`;
USE `notesdb`;

-- Note Table
CREATE TABLE Note (
    note_id INT PRIMARY KEY AUTO_INCREMENT,
    note_title VARCHAR(255) NOT NULL,
    note_content TEXT,
    note_status VARCHAR(50),
    note_creation_date DATE
);

-- User Table
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(255) NOT NULL,
    user_added_date DATE,
    user_password VARCHAR(255) NOT NULL,
    user_mobile VARCHAR(15)
);

-- Alter User Table to modify user_added_date
ALTER TABLE User MODIFY COLUMN user_added_date DATE;

-- Category Table
CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL,
    category_descr TEXT,
    category_creation_date DATE,
    category_creator INT,
    FOREIGN KEY (category_creator) REFERENCES User(user_id)
);

-- Reminder Table
CREATE TABLE Reminder (
    reminder_id INT PRIMARY KEY AUTO_INCREMENT,
    reminder_name VARCHAR(255) NOT NULL,
    reminder_descr TEXT,
    reminder_type VARCHAR(50),
    reminder_creation_date DATE,
    reminder_creator INT,
    FOREIGN KEY (reminder_creator) REFERENCES User(user_id)
);

-- NoteCategory Table
CREATE TABLE NoteCategory (
    notecategory_id INT PRIMARY KEY AUTO_INCREMENT,
    note_id INT,
    category_id INT,
    FOREIGN KEY (note_id) REFERENCES Note(note_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- NoteReminder Table
CREATE TABLE NoteReminder (
    notereminder_id INT PRIMARY KEY AUTO_INCREMENT,
    note_id INT,
    reminder_id INT,
    FOREIGN KEY (note_id) REFERENCES Note(note_id),
    FOREIGN KEY (reminder_id) REFERENCES Reminder(reminder_id)
);

-- UserNote Table
CREATE TABLE UserNote (
    usernote_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    note_id INT,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (note_id) REFERENCES Note(note_id)
);

-- Insert into User
INSERT INTO User (user_name, user_added_date, user_password, user_mobile)
VALUES ('John Doe', '2023-10-01', 'password123', '1234567890');

-- Insert into Note
INSERT INTO Note (note_title, note_content, note_status, note_creation_date)
VALUES ('My First Note', 'This is the content of the note.', 'Active', '2023-10-01');

-- Insert into Category
INSERT INTO Category (category_name, category_descr, category_creation_date, category_creator)
VALUES ('Work', 'Notes related to work', '2023-10-01', 1);

-- Insert into Reminder
INSERT INTO Reminder (reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator)
VALUES ('Meeting Reminder', 'Reminder for team meeting', 'Email', '2023-10-01', 1);

-- Insert into NoteCategory
INSERT INTO NoteCategory (note_id, category_id)
VALUES (1, 1);

-- Insert into NoteReminder
INSERT INTO NoteReminder (note_id, reminder_id)
VALUES (1, 1);

-- Insert into UserNote
INSERT INTO UserNote (user_id, note_id)
VALUES (1, 1);

-- Fetch User by Id and Password
SELECT * FROM User WHERE user_id = 1 AND user_password = 'password123';

-- Fetch all Notes based on creation date
SELECT * FROM Note WHERE note_creation_date = '2023-10-01';

-- Fetch all Categories created after a particular date
SELECT * FROM Category WHERE category_creation_date > '2023-09-30';

-- Fetch all Note IDs for a given User
SELECT note_id FROM UserNote WHERE user_id = 1;

-- Update a particular Note
UPDATE Note SET note_title = 'Updated Note Title' WHERE note_id = 1;

-- Fetch all Notes by a particular User
SELECT n.* FROM Note n
JOIN UserNote un ON n.note_id = un.note_id
WHERE un.user_id = 1;

-- Fetch all Notes for a particular Category
SELECT n.* FROM Note n
JOIN NoteCategory nc ON n.note_id = nc.note_id
WHERE nc.category_id = 1;

-- Fetch all Reminder details for a given Note ID
SELECT r.* FROM Reminder r
JOIN NoteReminder nr ON r.reminder_id = nr.reminder_id
WHERE nr.note_id = 1;

-- Fetch Reminder details for a given Reminder ID
SELECT * FROM Reminder WHERE reminder_id = 1;

-- Create a new Note from a particular User
INSERT INTO Note (note_title, note_content, note_status, note_creation_date)
VALUES ('New Note', 'Content of the new note.', 'Active', '2023-10-02');

INSERT INTO UserNote (user_id, note_id)
VALUES (1, LAST_INSERT_ID());

-- Create a new Note from a particular User to a particular Category
INSERT INTO Note (note_title, note_content, note_status, note_creation_date)
VALUES ('New Note in Category', 'Content of the new note.', 'Active', '2023-10-02');

INSERT INTO NoteCategory (note_id, category_id)
VALUES (LAST_INSERT_ID(), 1);

-- Set a Reminder for a particular Note
INSERT INTO Reminder (reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator)
VALUES ('New Reminder', 'Description of the new reminder.', 'Popup', '2023-10-02', 1);

INSERT INTO NoteReminder (note_id, reminder_id)
VALUES (1, LAST_INSERT_ID());

-- Delete a particular Note added by a User
DELETE FROM Note WHERE note_id = 1;
DELETE FROM UserNote WHERE note_id = 1;

-- Delete a particular Note from a particular Category
DELETE FROM NoteCategory WHERE note_id = 1 AND category_id = 1;
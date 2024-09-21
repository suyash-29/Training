-- Tasks 1 
-- 1. Create the database named "TicketBookingSystem" 

CREATE DATABASE TicketBookingSystem
GO

USE TicketBookingSystem

-- Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and 
-- relationships
-- 1. Venue
-- 2. Event
-- 3. Customers
-- 4. Booking 


CREATE TABLE Venue (
    venue_id INT PRIMARY KEY IDENTITY(1,1),
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
)

CREATE TABLE Event (
    event_id INT PRIMARY KEY IDENTITY(1,1),
    event_name NVARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue_id INT NOT NULL FOREIGN KEY (venue_id) REFERENCES Venue(venue_id),
    total_seats INT NOT NULL CHECK (total_seats > 0),
    available_seats INT NOT NULL CHECK (available_seats >= 0),
    ticket_price DECIMAL(10, 2) NOT NULL CHECK (ticket_price >= 0),
    event_type NVARCHAR(50) CHECK (event_type IN ('Movie', 'Sports', 'Concert')),
    booking_id INT NULL,   
)

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    customer_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    phone_number NVARCHAR(15) NOT NULL,
    booking_id INT NULL,  -- This will be updated after booking
    CONSTRAINT CHK_PhoneFormat CHECK (phone_number LIKE '[0-9]%')
)

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    event_id INT NOT NULL,
    num_tickets INT NOT NULL CHECK (num_tickets > 0),
    total_cost DECIMAL(10, 2) NOT NULL CHECK (total_cost >= 0),
    booking_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
)

-- 3. Create an ERD (Entity Relationship Diagram) for the database.  

-- 4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.  

ALTER TABLE Event
ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)

ALTER TABLE Customer
ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)

-- Tasks 2 
--1. Write a SQL query to insert at least 10 sample records into each table.

-- Insert into Venue
INSERT INTO Venue (venue_name, address) VALUES 
('Stadium Arena', '123 Main St'), 
('City Hall', '456 Elm St'),
('Concert Park', '789 Maple Ave'),
('Grand Theater', '321 Oak St'),
('Movie House', '654 Pine St'),
('Convention Center', '987 Birch Blvd'),
('Town Auditorium', '654 Cedar Rd'),
('Sports Complex', '432 Spruce St'),
('Amphitheater', '765 Willow Way'),
('Arena Central', '876 Palm Dr');

-- Insert into Event

INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type)
VALUES 
('Rock Concert', '2024-09-20', '19:00', 1, 20000, 15000, 1500.00, 'Concert'),
('Football Cup Final', '2024-09-25', '17:00', 9, 30000, 28000, 2000.00, 'Sports'),
('Jazz Night', '2024-10-01', '21:00', 3, 5000, 4000, 1200.00, 'Concert'),
('Movie Premiere', '2024-09-23', '18:30', 5, 300, 100, 900.00, 'Movie'),
('Comedy Night', '2024-09-28', '20:00', 7, 1000, 800, 600.00, 'Concert'),
('Soccer Semi-Final', '2024-09-26', '16:00', 9, 25000, 20000, 1800.00, 'Sports'),
('Orchestra Performance', '2024-10-05', '19:30', 6, 8000, 7000, 2200.00, 'Concert'),
('Movie Screening', '2024-09-24', '19:00', 5, 400, 300, 850.00, 'Movie'),
('Cricket World Cup', '2024-11-02', '15:00', 9, 35000, 34000, 2500.00, 'Sports'),
('Classical Music Concert', '2024-11-10', '18:00', 8, 15000, 12000, 1750.00, 'Concert');


-- Insert into Customer
INSERT INTO Customer (customer_name, email, phone_number) VALUES 
('John Doe', 'john@example.com', '1234567890'),
('Jane Smith', 'jane@example.com', '2345678901'),
('Mike Brown', 'mikeb@example.com', '3456789012'),
('Emily White', 'emilyw@example.com', '4567890123'),
('David Clark', 'davidc@example.com', '5678901234'),
('Alice Green', 'aliceg@example.com', '6789012345'),
('Robert Wilson', 'robertw@example.com', '7890123456'),
('Laura Adams', 'lauraa@example.com', '8901234567'),
('Michael Johnson', 'michaelj@example.com', '9012345678'),
('Olivia Martinez', 'oliviam@example.com', '0123456000');

-- Insert into Booking


INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost)
VALUES 
(1, 7, 4, 6000.00),
(2, 8, 6, 12000.00),
(3, 9, 3, 5000.00),  
(4, 10, 4, 3600.00),  
(5, 11, 5, 900.00),   
(6, 12, 6, 3000.00),  
(7, 13, 7, 7200.00),  
(8, 14, 8, 4400.00),  
(9, 15, 9, 1700.00),  
(10, 16, 10, 25000.00);  

-- 2. Write a SQL query to list all Events. 

SELECT * FROM Booking

-- 3. Write a SQL query to select events with available tickets. 
SELECT * FROM Event
WHERE available_seats > 0

--4 Select Events with Name Partial Match 'cup'
SELECT * FROM Event
WHERE event_name LIKE '%cup%'

--5. Write a SQL query to select events with ticket price range is between 1000 to 2500. 

SELECT * FROM Event
WHERE ticket_price BETWEEN 1000 AND 2500

--6. Write a SQL query to retrieve events with dates falling within a specific range. 
SELECT * FROM Event
WHERE event_date BETWEEN '2024-09-20' AND '2024-10-05'

--7. Write a SQL query to retrieve events with available tickets that also have "Concert" in their name. 

SELECT * FROM Event
WHERE available_seats > 0 AND event_type = 'Concert'

--8. Write a SQL query to retrieve users in batches of 5, starting from the 6th user. 

SELECT * FROM Customer
ORDER BY customer_id
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY

--9 Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.

SELECT * FROM Booking
WHERE num_tickets > 4

--10. Write a SQL query to retrieve customer information whose phone number end with ‘000’

SELECT * FROM Customer
WHERE phone_number LIKE '%000'

--11.  Write a SQL query to retrieve the events in order whose seat capacity more than 15000. 
SELECT * FROM Event
WHERE total_seats > 15000
ORDER BY total_seats

--12.  Write a SQL query to select events name not start with x , y , z . 
SELECT * FROM Event
WHERE event_name NOT LIKE '[x-z]%';


-- Tasks 3 Aggregate functions, Having, Order By, GroupBy and Joins:

--1. Write a SQL query to List Events and Their Average Ticket Prices. 
SELECT event_name, AVG(ticket_price) AS avg_ticket_price
FROM Event
GROUP BY event_name

--2. Write a SQL query to Calculate the Total Revenue Generated by Events.
SELECT e.event_name, SUM(b.total_cost) AS total_revenue
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name

--3. Write a SQL query to find the event with the highest ticket sales.

SELECT TOP 1 e.event_name, SUM(b.num_tickets) AS total_tickets_sold
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name
ORDER BY total_tickets_sold DESC

--4. Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event. 
SELECT e.event_name, SUM(b.num_tickets) AS total_tickets_sold
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name

--5. Write a SQL query to Find Events with No Ticket Sales. 
SELECT e.event_name
FROM Event e
LEFT JOIN Booking b ON e.event_id = b.event_id
WHERE b.booking_id IS NULL

--6. Write a SQL query to Find the User Who Has Booked the Most Tickets. 
SELECT TOP 1 c.customer_name, SUM(b.num_tickets) AS total_tickets
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_tickets DESC

--7. Write a SQL query to List Events and the total number of tickets sold for each month. 


--8. Write a SQL query to calculate the average Ticket Price for Events in Each Venue. 
SELECT v.venue_name, AVG(e.ticket_price) AS avg_ticket_price
FROM Event e
JOIN Venue v ON e.venue_id = v.venue_id
GROUP BY v.venue_name

--9. Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type. 
SELECT e.event_type, SUM(b.num_tickets) AS total_tickets_sold
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_type

--10. Write a SQL query to calculate the total Revenue Generated by Events in Each Year. 
SELECT YEAR(e.event_date) AS year, SUM(b.total_cost) AS total_revenue
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY YEAR(e.event_date)

--11. Write a SQL query to list users who have booked tickets for multiple events.
SELECT c.customer_name, COUNT(DISTINCT b.event_id) AS events_booked
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT b.event_id) > 1

--12. Write a SQL query to calculate the Total Revenue Generated by Events for Each User. 
SELECT c.customer_name, SUM(b.total_cost) AS total_revenue
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
GROUP BY c.customer_name

--13. Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue. 
SELECT e.event_type, v.venue_name, AVG(e.ticket_price) AS avg_ticket_price
FROM Event e
JOIN Venue v ON e.venue_id = v.venue_id
GROUP BY e.event_type, v.venue_name

--14. Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 Days.  
SELECT c.customer_name, SUM(b.num_tickets) AS total_tickets_purchased
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
WHERE b.booking_date >= DATEADD(DAY, -30, GETDATE())
GROUP BY c.customer_name

--Tasks4  Subquery and its types 
--1. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery. 
--2. Find Events with More Than 50% of Tickets Sold using subquery. 
--3. Calculate the Total Number of Tickets Sold for Each Event. 
--4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery. 
--5. List Events with No Ticket Sales Using a NOT IN Subquery. 
--6. Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause. 
--7. Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause. 
--8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery. 
--9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause. 
--10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY. 
--11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT. 
--12. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery













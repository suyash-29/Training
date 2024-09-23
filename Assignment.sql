-- Tasks 1 
-- 1. Create the database named "TicketBookingSystem" 

CREATE DATABASE TicketBookingSystem

USE TicketBookingSystem


-- Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and 
-- relationships
-- 1. Venue
-- 2. Event
-- 3. Customers
-- 4. Booking 

-- Create Venue Table
CREATE TABLE Venue (
    venue_id INT PRIMARY KEY, 
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
)

-- Create Event Table
CREATE TABLE Event (
    event_id INT PRIMARY KEY, 
    event_name NVARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue_id INT NOT NULL, 
    total_seats INT NOT NULL CHECK (total_seats > 0),
    available_seats INT NOT NULL CHECK (available_seats >= 0),
    ticket_price DECIMAL(10, 2) NOT NULL CHECK (ticket_price >= 0),
    event_type NVARCHAR(50) CHECK (event_type IN ('Movie', 'Sports', 'Concert')),
    booking_id INT NULL 
)

-- Create Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    phone_number NVARCHAR(15) NOT NULL,
    booking_id INT NULL, 
    CONSTRAINT CHK_PhoneFormat CHECK (phone_number LIKE '[0-9]%')
)

-- Create Booking Table without foreign key initially
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY, 
    customer_id INT NOT NULL,
    event_id INT NOT NULL,
    num_tickets INT NOT NULL CHECK (num_tickets > 0),
    total_cost DECIMAL(10, 2) NOT NULL CHECK (total_cost >= 0),
    booking_date DATETIME DEFAULT GETDATE()
)



-- 3. Create an ERD (Entity Relationship Diagram) for the database.  

-- 4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.  

-- Venue Foreign Key in Event
ALTER TABLE Event 
ADD CONSTRAINT FK_Event_Venue FOREIGN KEY (venue_id) 
REFERENCES Venue(venue_id)
ON DELETE CASCADE
ON UPDATE CASCADE

-- Customer Foreign Key in Booking
ALTER TABLE Booking 
ADD CONSTRAINT FK_Booking_Customer FOREIGN KEY (customer_id)
REFERENCES Customer(customer_id)
ON DELETE CASCADE
ON UPDATE CASCADE

-- Event Foreign Key in Booking
ALTER TABLE Booking 
ADD CONSTRAINT FK_Booking_Event FOREIGN KEY (event_id)
REFERENCES Event(event_id)
ON DELETE CASCADE
ON UPDATE CASCADE

-- Booking Foreign Key in Event and Customer
ALTER TABLE Customer 
ADD CONSTRAINT FK_Customer_Booking FOREIGN KEY (booking_id) 
REFERENCES Booking(booking_id)

ALTER TABLE Event 
ADD CONSTRAINT FK_Event_Booking FOREIGN KEY (booking_id) 
REFERENCES Booking(booking_id)


-- Tasks 2 
--1. Write a SQL query to insert at least 10 sample records into each table.
-- Insert into Venue table
INSERT INTO Venue (venue_id, venue_name, address) VALUES 
(1, 'Mumbai Arena', '123 Marine Drive, Mumbai'), 
(2, 'Bangalore City Hall', '456 MG Road, Bangalore'),
(3, 'Delhi Concert Park', '789 Connaught Place, Delhi'),
(4, 'Chennai Grand Theater', '321 Anna Salai, Chennai'),
(5, 'Hyderabad Movie House', '654 Jubilee Hills, Hyderabad'),
(6, 'Kolkata Convention Center', '987 Salt Lake, Kolkata'),
(7, 'Pune Town Auditorium', '654 FC Road, Pune'),
(8, 'Ahmedabad Sports Complex', '432 CG Road, Ahmedabad'),
(9, 'Goa Amphitheater', '765 Miramar Beach, Goa'),
(10, 'Jaipur Arena Central', '876 Johari Bazaar, Jaipur')

-- Insert into Event table with manual randomized dates
INSERT INTO Event (event_id, event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type)
VALUES 
(1, 'Bollywood Night', '2024-09-18', '19:00', 1, 15000, 10000, 1200.00, 'Concert'),
(2, 'Cricket World Cup Final', '2024-10-03', '17:30', 8, 40000, 35000, 2500.00, 'Sports'),
(3, 'Sufi Music Evening', '2024-11-12', '20:00', 3, 8000, 5000, 1500.00, 'Concert'),
(4, 'Movie Premiere: Tollywood Blockbuster', '2024-09-25', '18:45', 5, 500, 200, 800.00, 'Movie'),
(5, 'Stand-up Comedy Night', '2024-09-30', '21:00', 7, 1200, 900, 700.00, 'Concert'),
(6, 'ISL Semi-Final', '2024-10-07', '18:00', 8, 25000, 20000, 1800.00, 'Sports'),
(7, 'Classical Music Performance', '2024-11-15', '19:30', 6, 9000, 7000, 2200.00, 'Concert'),
(8, 'Bollywood Retro Screening', '2024-09-22', '19:30', 5, 600, 400, 950.00, 'Movie'),
(9, 'Kite Festival', '2024-11-20', '16:00', 9, 15000, 14000, 500.00, 'Sports'),
(10, 'Rajasthan Folk Concert', '2024-11-28', '18:00', 10, 5000, 3000, 1300.00, 'Concert')

-- Insert into Customer table with randomized Indian data
INSERT INTO Customer (customer_id, customer_name, email, phone_number) VALUES 
(1, 'Rahul Sharma', 'rahul.sharma@example.in', '9876543210'),
(2, 'Priya Kapoor', 'priya.kapoor@example.in', '8765432109'),
(3, 'Amit Patel', 'amit.patel@example.in', '7654321098'),
(4, 'Neha Gupta', 'neha.gupta@example.in', '6543210987'),
(5, 'Ravi Kumar', 'ravi.kumar@example.in', '5432109876'),
(6, 'Sneha Reddy', 'sneha.reddy@example.in', '4321098765'),
(7, 'Vikram Singh', 'vikram.singh@example.in', '3210987654'),
(8, 'Anita Mehra', 'anita.mehra@example.in', '2109876543'),
(9, 'Suresh Iyer', 'suresh.iyer@example.in', '1098765432'),
(10, 'Meena Desai', 'meena.desai@example.in', '0987654321')

-- Insert into Booking table with randomized details
INSERT INTO Booking (booking_id, customer_id, event_id, num_tickets, total_cost)
VALUES 
(1, 1, 1, 3, 3600.00),
(2, 2, 2, 5, 12500.00),
(3, 3, 3, 2, 3000.00),  
(4, 4, 4, 4, 3200.00),  
(5, 5, 5, 6, 4200.00),   
(6, 6, 6, 2, 3600.00),  
(7, 7, 7, 5, 11000.00),  
(8, 8, 8, 3, 2850.00),  
(9, 9, 9, 6, 3000.00),  
(10, 10, 10, 2, 2600.00);

-- putting booking_id from booking table into Customer and event table
SELECT booking_id
FROM Booking

UPDATE Event
SET booking_id = b.booking_id
FROM Event e
JOIN Booking b ON e.event_id = b.event_id

UPDATE Customer
SET booking_id = b.booking_id
FROM Customer c
JOIN Booking b ON c.customer_id = b.customer_id

-- Queries to see data in all tabels 
SELECT * FROM Venue
SELECT * FROM Event
SELECT * From Customer
SELECT * FROM Booking



-- 2. Write a SQL query to list all Events. 

SELECT * FROM Event

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
WHERE event_name NOT LIKE '[x-z]%'


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
SELECT e.event_name, DATEPART(MONTH, b.booking_date) AS month, SUM(b.num_tickets) AS total_tickets_sold
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name, DATEPART(MONTH, b.booking_date)


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
SELECT v.venue_name, 
       (SELECT AVG(e.ticket_price)
        FROM Event e
        WHERE e.venue_id = v.venue_id) AS avg_ticket_price
FROM Venue v


--2. Find Events with More Than 50% of Tickets Sold using subquery. 
SELECT e.event_name
FROM Event e
WHERE (SELECT SUM(b.num_tickets)
       FROM Booking b
       WHERE b.event_id = e.event_id) > (e.total_seats * 0.5)


--3. Calculate the Total Number of Tickets Sold for Each Event.
SELECT e.event_name, 
       (SELECT SUM(b.num_tickets)
        FROM Booking b
        WHERE b.event_id = e.event_id) AS total_tickets_sold
FROM Event e


--4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery. 
SELECT c.customer_name
FROM Customer c
WHERE NOT EXISTS (SELECT 1 
                  FROM Booking b 
                  WHERE b.customer_id = c.customer_id)

--5. List Events with No Ticket Sales Using a NOT IN Subquery. 

--6. Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause. 
--7. Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause. 
--8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery. 
--9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause. 
--10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY. 
--11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT. 
--12. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery














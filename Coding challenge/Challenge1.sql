-- Topic : Virtual Art Gallery
-- Creating database

CREATE DATABASE VirtualArtGallery 

USE VirtualArtGallery

-- creating tables

-- artist table
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Biography TEXT,
    Nationality VARCHAR(100)
)

-- categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
)


-- artwork table
CREATE TABLE Artworks (
    ArtworkID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ArtistID INT,
    CategoryID INT,
    Year INT,
    Description TEXT,
    ImageURL VARCHAR(255),
    Price DECIMAL(10, 2),  -- added price field
    SaleStatus VARCHAR(10) DEFAULT 'unsold',  -- added sales status for the artwork
    FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
    FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID),
    CHECK (SaleStatus IN ('sold', 'unsold'))  -- Constraint for sales status
)


-- exhibition table
CREATE TABLE Exhibitions (
    ExhibitionID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Description TEXT
)

-- exhibitionn artwork table
CREATE TABLE ExhibitionArtworks (
    ExhibitionID INT,
    ArtworkID INT,
    PRIMARY KEY (ExhibitionID, ArtworkID),
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
    FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID)
)

-- Inserting data in tables 

INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES 
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'), 
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'), 
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian')

SELECT * FROM Artists

INSERT INTO Categories (CategoryID, Name) VALUES 
(1, 'Painting'), 
(2, 'Sculpture'), 
(3, 'Photography')

SELECT * FROM Categories

INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL, Price, SaleStatus) VALUES 
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg', 1000000, 'unsold'), 
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg', 2000000, 'unsold'), 
(3, 'Guernica', 1, 1, 1937, 'Pablo Picassos powerful anti-war mural.', 'guernica.jpg', 1500000, 'unsold');

SELECT * FROM Artworks

INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES 
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'), 
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

SELECT * FROM Exhibitions

INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES 
(1, 1), 
(1, 2), 
(1, 3), 
(2, 2)

SELECT * FROM ExhibitionArtworks


--1. Retrieve the names of all artists along with the number of artworks they have in the gallery, and 
--   list them in descending order of the number of artworks. 

SELECT a.Name, COUNT(ar.ArtworkID) AS NoOfArtworks
FROM Artists a
LEFT JOIN Artworks ar ON a.ArtistID = ar.ArtistID -- used left join here to ensure artists wiht no artworks also get displayed 
GROUP BY a.Name
ORDER BY NoOfArtworks DESC


--2. List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order 
--   them by the year in ascending order. 

SELECT ar.Title , ar.[Year] as Year
FROM Artworks ar
JOIN Artists a ON ar.ArtistID = a.ArtistID
WHERE a.Nationality IN ('Spanish', 'Dutch')
ORDER BY ar.Year ASC

--3. Find the names of all artists who have artworks in the 'Painting' category, and the number of 
--   artworks they have in this category. 

SELECT a.Name, COUNT(ar.ArtworkID) AS NoOfArtworks
FROM Artists a
JOIN Artworks ar ON a.ArtistID = ar.ArtistID
JOIN Categories c ON ar.CategoryID = c.CategoryID
WHERE c.Name = 'Painting'
GROUP BY a.Name

--4. List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their 
--   artists and categories. 

SELECT ar.Title AS Title, a.Name AS Artist, c.Name AS Category
FROM Artworks ar
JOIN ExhibitionArtworks ea ON ar.ArtworkID = ea.ArtworkID
JOIN Exhibitions e ON ea.ExhibitionID = e.ExhibitionID
JOIN Artists a ON ar.ArtistID = a.ArtistID
JOIN Categories c ON ar.CategoryID = c.CategoryID
WHERE e.Title = 'Modern Art Masterpieces'

--5. Find the artists who have more than two artworks in the gallery. 
SELECT a.Name
FROM Artists a
JOIN Artworks ar ON a.ArtistID = ar.ArtistID
GROUP BY a.Name
HAVING COUNT(ar.ArtworkID) > 2

--6. Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and 
--   'Renaissance Art' exhibitions 
SELECT ar.Title
FROM Artworks ar
JOIN ExhibitionArtworks ea ON ar.ArtworkID = ea.ArtworkID
JOIN Exhibitions e ON ea.ExhibitionID = e.ExhibitionID
WHERE e.Title IN ('Modern Art Masterpieces', 'Renaissance Art')
GROUP BY ar.Title
HAVING COUNT(DISTINCT e.ExhibitionID) = 2

--7.  Find the total number of artworks in each category 

SELECT c.Name AS Category, COUNT(ar.ArtworkID) AS Total
FROM Categories c
LEFT JOIN Artworks ar ON c.CategoryID = ar.CategoryID
GROUP BY c.Name

--8. List artists who have more than 3 artworks in the gallery. 

SELECT a.Name , COUNT(ar.ArtworkID) as Total
FROM Artists a
JOIN Artworks ar ON a.ArtistID = ar.ArtistID
GROUP BY a.Name
HAVING COUNT(ar.ArtworkID) > 3

--9. Find the artworks created by artists from a specific nationality (e.g., Spanish). 

SELECT ar.Title , a.Nationality
FROM Artworks ar
JOIN Artists a ON ar.ArtistID = a.ArtistID
WHERE a.Nationality = 'Spanish'

--10.  List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci. 
SELECT e.Title
FROM Exhibitions e
JOIN ExhibitionArtworks ea ON e.ExhibitionID = ea.ExhibitionID
JOIN Artworks ar ON ea.ArtworkID = ar.ArtworkID
JOIN Artists a ON ar.ArtistID = a.ArtistID
WHERE a.Name IN ('Vincent van Gogh', 'Leonardo da Vinci')
GROUP BY e.Title
HAVING COUNT(DISTINCT a.Name) = 2

--11. Find all the artworks that have not been included in any exhibition.

SELECT ar.Title
FROM Artworks ar
LEFT JOIN ExhibitionArtworks ea ON ar.ArtworkID = ea.ArtworkID
WHERE ea.ExhibitionID IS NULL

--12.  List artists who have created artworks in all available categories. 

SELECT a.Name
FROM Artists a
JOIN Artworks ar ON a.ArtistID = ar.ArtistID
GROUP BY a.Name
HAVING COUNT(DISTINCT ar.CategoryID) = (SELECT COUNT(*) FROM Categories)

--13.  List the total number of artworks in each category. 

SELECT c.Name AS CategoryName, COUNT(ar.ArtworkID) AS TotalArtworks
FROM Categories c
LEFT JOIN Artworks ar ON c.CategoryID = ar.CategoryID
GROUP BY c.Name


--14. Find the artists who have more than 2 artworks in the gallery.

SELECT a.Name
FROM Artists a
JOIN Artworks ar ON a.ArtistID = ar.ArtistID
GROUP BY a.Name
HAVING COUNT(ar.ArtworkID) > 2

--15.  List the categories with the average year of artworks they contain, only for categories with more than 1 artwork. 

SELECT c.Name AS Category, AVG(ar.Year) AS AverageYear
FROM Categories c
JOIN Artworks ar ON c.CategoryID = ar.CategoryID
GROUP BY c.Name
HAVING COUNT(ar.ArtworkID) > 1

--16. Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition. 
SELECT ar.Title
FROM Artworks ar
JOIN ExhibitionArtworks ea ON ar.ArtworkID = ea.ArtworkID
JOIN Exhibitions e ON ea.ExhibitionID = e.ExhibitionID
WHERE e.Title = 'Modern Art Masterpieces'

--17. Find the categories where the average year of artworks is greater than the average year of all artworks. 

SELECT c.Name AS CategoryName
FROM Categories c
JOIN Artworks ar ON c.CategoryID = ar.CategoryID
GROUP BY c.Name
HAVING AVG(ar.Year) > (SELECT AVG(Year) FROM Artworks)

--18. List the artworks that were not exhibited in any exhibition. 

SELECT ar.Title
FROM Artworks ar
LEFT JOIN ExhibitionArtworks ea ON ar.ArtworkID = ea.ArtworkID
WHERE ea.ExhibitionID IS NULL

--19. Show artists who have artworks in the same category as "Mona Lisa." 

SELECT DISTINCT a.Name
FROM Artists a
JOIN Artworks ar ON a.ArtistID = ar.ArtistID
WHERE ar.CategoryID = (SELECT CategoryID FROM Artworks WHERE Title = 'Mona Lisa')

--20.  List the names of artists and the number of artworks they have in the gallery.

SELECT a.Name, COUNT(ar.ArtworkID) AS ArtworkCount
FROM Artists a
LEFT JOIN Artworks ar ON a.ArtistID = ar.ArtistID
GROUP BY a.Name

-- Drop tables if they exists (reverse order for foreign key dependencies)
drop table if exists Books;
drop table if exists Authors;

-- creating a table authors

create table Authors (
	AuthorID SERIAL primary KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50)
);

-- creating a table called book

create table Books (
	BookID serial primary key,
	Title VARCHAR(50),
	AuthorID INT,
	Genre VARCHAR(50),
	PublishedYear INT,
	Quantity INT,
	foreign key (AuthorID) references Authors(AuthorID)
);


-- creating member table

create table Members (
	MemberID SERIAL PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	MembershipDate DATE
);


-- creating borrow table

create table BorrowingRecords (
	RecordID SERIAL primary key,
	MemberID INT,
	BookID INT,
	BorrowDate Date,
	ReturnDate Date,
	foreign key (MemberID) references Members(MemberID), 
	foreign key (BookID) references Books(BookID)
);


-- Inserting values

insert into Authors(FirstName, LastName) values
	('J.K.', 'Rowling'),
	('George', 'Orwell'),
	('J.R.R.', 'Tolkien'),
	('Isaac', 'Asimov'),
	('Agatha', 'Christie'),
	('Mark', 'Twain'),
	('F. Scoot', 'Fitzgerald'),
	('Jane', 'Austen'),
	('Arthur', 'Conan Doyle'),
	('Ernest', 'Hemingway'),
	('Leo', 'Tolstoy'),
	('Charles', 'Dickens'),
	('Mary', 'Shelley'),
	('H.G', 'Wells'),
	('Edgar', 'Allan Poe'),
	('Herman', 'Melville'),
	('Virginia', 'Woolf'),
	('Gabriel', 'Garcia Márquez');



insert into Books(Title, AuthorID, Genre, PublishedYear, Quantity) values
	('Harry Potter and the Sorcerers Stone', 1, 'Fantasy', 1997, 10),
	('1984', 2, 'Dystopian', 1949, 5),
	('The Hobbit', 3, 'Fantasy', 1937, 7),
	('Foundation', 4, 'Science Fiction', 1951, 8),
	('Murder on the Orient Express', 5, 'Mystery', 1934, 12),
	('The Adventures of Tom Sawyer', 6, 'Adventure', 1876, 10),
	('The Great Gatsby', 7, 'Fiction', 1925, 6),
	('Pride and Prejudice', 8, 'Romance', 1813, 9),
	('Harry Potter and the Chamber of Secrets', 1, 'Fantasy', 1998, 10),
	('Animal Farm', 2, 'Dystopian', 1945, 7),
	('The Lord of the Rings', 3, 'Fantasy', 1954, 5),
	('Sherlock Holmes A Study in Scarlet', 9, 'Mystery', 1887, 6),
	('The Old Man and the Sea', 10, 'Literary Fiction', 1952, 8),
	('War and Peace', 11, 'Historical Fiction', 1869, 4),
	('A Tale of Two Cities', 12, 'Historical Fiction', 1859, 9),
	('Frankenstein', 13, 'Science Fiction', 1818, 7),
	('The War of the Worlds', 14, 'Science Fiction', 1898, 5),
	('The Raven', 15, 'Poetry', 1845, 6),
	('Moby Dick', 16, 'Adventure', 1851, 3),
	('To the Lighthouse', 17, 'Literary Fiction', 1927, 5),
	('One Hundred Years of Solitude', 18, 'Magical Realism', 1967, 7),
	('Sherlock Holmes A Study in Scarlet', 9, 'Mystery', 1887, 6),
	('The Old Man and the Sea', 10, 'Literary Fiction', 1952, 8),
	('War and Peace', 11, 'Historical Fiction', 1869, 4),
	('A Tale of Two Cities', 12, 'Historical Fiction', 1859, 9),
	('Frankenstein', 13, 'Science Fiction', 1818, 7),
	('The War of the Worlds', 14, 'Science Fiction', 1898, 5),
	('The Raven', 15, 'Poetry', 1845, 6),
	('Moby Dick', 16, 'Adventure', 1851, 3),
	('To the Lighthouse', 17, 'Literary Fiction', 1927, 5),
	('One Hundred Years of Solitude', 18, 'Magical Realism', 1967, 7);









insert into Members (FirstName, LastName, MembershipDate) values 
	('John', 'Doe', '2023-01-15'),
	('Jane', 'Smith', '2023-02-20'),
	('Sam', 'Brown', '2023-03-05'),
	('Alice', 'Johnson', '2023-03-15'),
	('Bob', 'Williams', '2023-04-10'),
	('Charlie', 'Davis', '2023-05-22'),
	('Diana', 'Miller', '2023-06-30'),
	('Eve', 'Wilson', '2023-07-14'),
	('Frank', 'Parker', '2023-03-18'),
	('Helen', 'Clark', '2023-04-22'),
	('Tom', 'Evans', '2023-05-28'),
	('Emily', 'Adams', '2023-06-05'),
	('Victor', 'Hughes', '2023-07-19'),
	('Grace', 'Turner', '2023-08-01'),
	('Liam', 'Martin', '2023-08-08'),
	('Sophia', 'Lewis', '2023-08-10'),
	('Olivia', 'White', '2023-08-15'),
	('James', 'Hall', '2023-08-20');
	
	

insert into BorrowingRecords (MemberID, BookID, BorrowDate, ReturnDate) values
	(1, 1, '2023-08-01', NULL),
	(2, 2, '2023-08-05', '2023-08-12'),
	(3, 3, '2023-08-07', NULL),
	(1, 4, '2023-08-10', NULL),
	(2, 5, '2023-08-12', '2023-08-19'),
	(3, 6, '2023-08-15', NULL),
	(4, 7, '2023-08-17', NULL),
	(5, 8, '2023-08-19', NULL),
	(1, 9, '2023-08-20', NULL),
	(2, 10, '2023-08-22', NULL),
	(3, 11, '2023-08-24', NULL),
	(6, 19, '2023-08-11', NULL),
	(7, 20, '2023-08-12', NULL),
	(8, 21, '2023-08-13', NULL),
	(9, 22, '2023-08-14', '2023-08-19'),
	(10, 23, '2023-08-15', NULL),
	(11, 24, '2023-08-16', NULL),
	(12, 25, '2023-08-17', NULL),
	(13, 26, '2023-08-18', '2023-08-23'),
	(14, 27, '2023-08-19', NULL),
	(15, 28, '2023-08-20', NULL),
	(6, 1, '2023-08-21', NULL),
	(7, 2, '2023-08-22', NULL),
	(8, 3, '2023-08-23', NULL),
	(9, 4, '2023-08-24', NULL),
	(10, 5, '2023-08-25', NULL),
	(11, 6, '2023-08-26', NULL),
	(12, 7, '2023-08-27', NULL),
	(13, 8, '2023-08-28', NULL),
	(14, 9, '2023-08-29', NULL),
	(15, 10, '2023-08-30', NULL);
	
	
	
select table_name as "Tables"
from information_schema.tables 
where table_schema = 'public'
and table_type = 'BASE TABLE'
order by table_name;






-- Question 1 : Find all books borrowed by John

select 
	firstname || ' ' || lastname as fullname,
	title
from books b
join borrowingrecords b2
	on b.bookid = b2.bookid
join members m
	on b2.memberid = m.memberid
where
	m.firstname like 'John%';


-- Question 2 : List all available books (i.e., not borrowed)

select
	title
from
	books b
where
	b.bookid not in (
	select
		b2.bookid
	from
		borrowingrecords b2);

-- Question 3 : Count the total number of books by each author

select
	count(title) as number_of_books,
	a.firstname || ' ' || a.lastname as authors_name
from
	books b
join
	authors a
	on b.authorid = a.authorid
group by
	a.firstname, a.lastname
order by 
	number_of_books ;


-- Question 4 : List all books by a genre

select
	distinct 
	genre,
	title
from
	books
order by
	genre  ;

-- Question 5 : List members who haven't borrowed any books

select 
	m.firstname || ' ' || m.lastname as members_name
from
	members m
where 
	m.memberid not in (
	select
		b.bookid
	from
		borrowingrecords b );

-- Question 6 : Find the total of books available in the library across all title

select 
	sum(quantity) total_books
from
	books;
	

-- Question 7 : List all authors who have written more than one book in the library

select 
	a.firstname || ' ' || a.lastname as authors_name,
	count(*) as number_of_books
from
	authors a 
join
	books b
	on a.authorid = b.authorid 
group by
	authors_name
having 
	count(*) > 1
order by 
	number_of_books desc;


-- Question 8 : Find the average number of books borrowed by each member

select 
	round(avg(books_count),2) as average -- arrondi à 2 chiffres      -- étape 2 : Faire la moyenne
from (
	select                                                            -- étape 1 : compter le nombre d'occurence
		m.firstname || ' ' || m.lastname as members_name, -- colonne # 1
		count(*) as books_count -- colonne # 2
	from
		members m
	join 
		borrowingrecords b 
		on
		m.memberid = b.memberid
	group by
		members_name
);


-- Question 9 : List all books that have never been borrowed 

select
	title
from 
	books b
left join 
	borrowingrecords b2
	on
	b.bookid = b2.bookid
where 
	b2.bookid is null;

-- une autre solution à cette question

select title 
from books b
where 
	bookid not in (
	select b2.bookid
	from borrowingrecords b2);



-- Question 10 : Find the books borrowed within a specific date range (e.g between '2023-08-01' and '2023-08-15')

select
	title 
from
	books b
join 
	borrowingrecords b2
	on b.bookid = b2.bookid 
where
	b2.borrowdate between '2023-08-01' and '2023-08-15'
order by
 title;





-- Question 11 : Determine the most popular genre in the library based on the number of books borrowed

select 
	b.genre,
	count(*) as number_books_borrowed
from
	books b
join
	borrowingrecords b2
	on b.bookid = b2.bookid
group by
	b.genre
order by
	number_books_borrowed desc; -- organisé par ordre décroissant
	
	
	-- Question 12 : Find overdue books (books that have not been returned in 30 days)
	
select
	m.firstname || ' ' || m.lastname as fullname,
	-- affiche le nom et prénom de l'emprunteur
	b.title,
	b2.borrowdate,
	current_date - b2.borrowdate as date_overdue
from
	books b
join borrowingrecords b2
	on
	b.bookid = b2.bookid
join members m 
	on
	b2.memberid = m.memberid
where
	current_date - b2.borrowdate > 30;
-- affiche uniquement les livres dépassant le délai de 30 jours
	

-- Question 13 : Find all books currently borrowed by members
	
select 
	b.title,
	m.firstname || ' ' || m.lastname as fullname
from
	books b
join borrowingrecords b2 
		on
	b.bookid = b2.bookid
join members m 
	on
	b2.memberid = m.memberid
where 
	b2.returndate is null;

-- Question 14 : Identify members who have borrowed more than one book

select
	m.firstname || ' ' || m.lastname as fullname,
	count(b2.bookid ) as numbers_of_books
from 
	books b
join borrowingrecords b2 
	on b.bookid = b2.bookid 
join members m
	on b2.memberid = m.memberid
group by 
	fullname 
having
	count(b2.bookid) > 1;


-- Question 15 a : List all overdue books along with the days overdue ( consider a book overdue if it hasn't been returned within 30 days)


select 
	m.firstname || ' ' || m.lastname as fullname,
	b.title,
	current_date - b2.borrowdate as days_overdue
from books b
join borrowingrecords b2 
	on b.bookid = b2.bookid 
join members m 
	on b2.memberid = m.memberid 
where
	current_date - b2.borrowdate > 30
	and b2.returndate is null;


-- Question 15 b: List all books and their corresponding authors that have been borrowed at least twice

select
	b.title,
	a.firstname || ' ' || a.lastname as authors_name,
	count(b2.bookid) as numbers_of_booking
from
	books b 
join borrowingrecords b2 
	on b.bookid = b2.bookid 
join authors a 
	on b.authorid = a.authorid 
group by
	authors_name, 
	b.title
having
	count(b2.bookid) > 1;
	
	
-- Question 16 - Find the difference in the number of books borrowed between two specific members (e.g.., 'John Doe' and 'Alice Johnson')

-- méthode cross join

select
	abs(john.no_books - alice.no_books) as books_difference
from 
-- John Doe
	(select count(b2.bookid) as no_books
	from borrowingrecords b2
	join books b on b2.bookid = b.bookid
	join members m on b2.memberid = m.memberid
	where m.firstname || ' ' || m.lastname like 'John%'
	) as john
	cross join
	(select count(b2.bookid) as no_books
	from borrowingrecords b2
	join books b on b2.bookid = b.bookid
	join members m on b2.memberid = m.memberid
	where m.firstname || ' ' || m.lastname like 'Alice%'
	) as alice;


-- méthode Union
select abs(
	(select count(*) from borrowingrecords b2
	join members m on b2.memberid = m.memberid
	where m.firstname || ' ' || m.lastname like 'John%')
	-
	(select count(*) from borrowingrecords b2
	join members m on b2.memberid = m.memberid
	where m.firstname || ' ' || m.lastname like 'Alice%')
) as books_difference;


-- Question 17 : Identify all members who borrowed books by a specific author (e.g., 'George Orwell')

select distinct -- évite les doublons si le même livre a été emprunté plusieurs fois
	m.firstname || ' ' || m.lastname as member_name,
	a.firstname || ' ' || a.lastname as author_name,
	b.title
from
	members m
join borrowingrecords b2
	on b2.memberid = m.memberid
join books b
	on b2.bookid = b.bookid
join authors a 
	on b.authorid = a.authorid
where
	a.firstname || ' ' || a.lastname like 'Geo%';


-- Question 18 : Find the most borrowed book (Advanced)

select title, most_borrowed
from ( 
		select
			b.title,
			count(*) as most_borrowed,
			dense_rank() over (order by count(*) desc) as ranks -- attribue un rang à chaque livre selon ses emprunts (1er = plus emprunté)
		from
			books b 
		join borrowingrecords b2
			on b.bookid = b2.bookid
		group by
			b.title
) ranked
where ranks = 1;


-- Question 19 : Identify the member who has borrowed the most books (advanced)

select member_name, number_books
from ( 
	select
		firstname || ' ' || lastname as member_name,
		count(b2.memberid) as number_books,
		dense_rank() over (order by count(*) desc) as ranks -- attribue un rang à chaque livre selon ses emprunts (1er = plus emprunté)
	from
		members m
	join borrowingrecords b2
		on m.memberid = b2.memberid
	group by
		firstname || ' ' || lastname
) ranked
where ranks = 1;

	


	





	
	
	

	
	
	
	


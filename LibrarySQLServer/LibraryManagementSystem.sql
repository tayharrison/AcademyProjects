CREATE DATABASE LibraryMS

USE LibraryMS

--Create tables--

CREATE TABLE Publisher (
		Name VARCHAR(50) PRIMARY KEY NOT NULL,
		Address VARCHAR(50) NOT NULL,
		Phone VARCHAR(50) NOT NULL
	);

CREATE TABLE Book_Copies (
		Book_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		Branch_id INT NOT NULL,
		No_of_Copies INT NOT NULL
	);

CREATE TABLE Borrower (
		Card_No INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		Name VARCHAR(50) NOT NULL,
		Address VARCHAR(50) NOT NULL,
		Phone VARCHAR(50) NOT NULL,
	);

CREATE TABLE Library_Branch (
		Branch_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		Branch_Name VARCHAR(50) NOT NULL,
		Branch_Address VARCHAR(50) NOT NULL,
	);

CREATE TABLE Book (
		Book_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		Title VARCHAR(50) NOT NULL,
		Publisher_Name VARCHAR(50) NOT NULL CONSTRAINT fk_Name FOREIGN KEY REFERENCES dbo.Publisher(Name),
	);


CREATE TABLE Book_Authors(
		Book_id INT PRIMARY KEY NOT NULL IDENTITY (1,1) CONSTRAINT fk_book_id FOREIGN KEY REFERENCES dbo.Book(Book_id),
		Author_Name VARCHAR(50) NOT NULL
	);


CREATE TABLE Book_Loans ( --PRIMARY KEY SHOULD NOT BE BOOK_ID, BUT UNSURE WHAT IT SHOULD BE--
		Book_id INT PRIMARY KEY NOT NULL,
		Branch_id INT NOT NULL CONSTRAINT fk_Branch_id FOREIGN KEY REFERENCES dbo.Library_Branch(Branch_id),
		Card_No INT NOT NULL CONSTRAINT fk_Card_No FOREIGN KEY REFERENCES dbo.Borrower(Card_No),
		Date_Out DATE NOT NULL,
		Due_Date DATE NOT NULL,
	);



	-- Populate--

	INSERT INTO dbo.Publisher
		(Name, Address, Phone)
		VALUES
		('Green Thumbs United', '445 Green Way', '555-3477'),
		('Cat Lady Press', '700 Meowingtons St', '777-4533'),
		('Ahab Publishing', '12 Oceanview Rd', '888-4532'),
		('Digital House', '142 Microsoft Loop', '956-3421'),
		('Bakestoomuch Corp', '5 Sweets Lane', '222-6537'),
		('Moms Publishing Group', '46 Roses St', '656-4442'),
		('Portland Press', '2235 Too Busy Rd', '456-7856'),
		('Outdoors Media', '12 Treebark St', '555-7267'),
		('Wannabe Walt Group', '45 Magic Way', '777-5665'),
		('Rumplestiltskin Publishing', '1 Storybook Lane', '225-6523'),
		('Marshmallow Press', '35 Cereal Rd', '555-2381'),
		('Nerdy Media', '5671 Anime St', '466-7897')
		;

	INSERT INTO dbo.Book 
		(Title, Publisher_Name)
		VALUES 
		('The Lost Tribe', 'Green Thumbs United'),
		('Cats in SPACE', 'Cat Lady Press'),
		('Whales and How They Sink Ships', 'Ahab Publishing'),
		('Super Computers', 'Digital House'), 
		('How to Make Pies', 'Bakestoomuch Corp'), 
		('Tea Making', 'Green Thumbs United'), 
		('Cats in Greece', 'Cat Lady Press'), 
		('Cats in College', 'Cat Lady Press'), 
		('Cats Save NYC', 'Cat Lady Press'), 
		('Make Your Own Umbrella!', 'Portland Press'), 
		('How to Find Old Records', 'Portland Press'), 
		('Brew Your Own Beer!', 'Portland Press'), 
		('My Mother was Right', 'Moms Publishing Group'), 
		('Deep Sea Diving', 'Outdoors Media'), 
		('Mickey Mouse and the Caped Crusaders', 'Wannabe Walt Group'), 
		('How to Turn that Straw into Gold!', 'Rumplestiltskin Publishing'), 
		('Elephants, Giraffes, and Zebras, Oh My!', 'Outdoors Media'), 
		('How Not to Kill Plants', 'Green Thumbs United'), 
		('Hearts, Stars, and Horseshoes!', 'Marshmallow Press'), 
		('How to Play Video Games AND Meet Girls', 'Nerdy Media')
		;

		INSERT INTO dbo.Book_Authors
		(Author_Name)
		VALUES
		('Harry Jungles'),
		('Mrs. Catlady'),
		('Captain Ahab'),
		('Hacker Man'),
		('Susie Cake'),
		('Stephen King'),
		('Hipster Stache'),
		('Krikey McGee'),
		('Mikey Mouse'),
		('Rumplestiltskin'),
		('Green Man'),
		('Arthur Glasses')
		;

		

		INSERT INTO dbo.Library_Branch
		(Branch_Name, Branch_Address)
		VALUES
		('Central', '180 Downtown St'),
		('Sharpstown', '13 Knife Way'),
		('Northwest', '23rd Street'),
		('Southeast', 'SE 2nd Ave')
		;

		INSERT INTO dbo.Borrower
		(Name, Address, Phone)
		VALUES
		('Jake Jones', '432 Mockingbird Way', '545-1212'),
		('Sarah Smith', '76 Highfield St', '664-3421'),
		('Danny Dimaggio', '6 Wan St', '543-2319'),
		('Nick Nottingham', '8 Spring St', '762-4599'),
		('Mary Marks', '77 Up Rd', '555-2221'),
		('Lindsey Lucky', '455 Seven St', '345-2227'),
		('Hugh Grunt', '23 Old Forge Rd', '466-7001'),
		('Frank Sinatra', '50 Old Blue Eyes Way', '227-8654')
		;

		SELECT * FROM dbo.Borrower

		SELECT * FROM dbo.Book
		SELECT * FROM dbo.Library_Branch

		
		INSERT INTO dbo.Book_Copies
		(Branch_id, No_of_Copies)
		VALUES
		(1, 2),
		(3, 1),
		(2, 4),
		(4, 0),
		(4, 2),
		(2, 1),
		(1, 2),
		(3, 1),
		(2, 2),
		(4, 1),
		(1, 2),
		(2, 1),
		(1, 3),
		(1, 1),
		(3, 2),
		(4, 2),
		(1, 1),
		(1, 2),
		(1, 2),
		(1, 2)
		;
		SELECT * FROM dbo.Book_Copies

		INSERT INTO dbo.Book_Loans
		(Book_id, Branch_id, Card_No, Date_Out, Due_Date)
		VALUES
			(1, 1, 8, '7/1/17', '7/7/17'),
			(2, 3, 3, '7/2/17', '7/8/17'),
			(3, 2, 6, '7/3/17', '7/9/17'),
			(4, 4, 6, '7/3/17', '7/9/17'),
			(5, 4, 2, '7/4/17', '7/10/17'),
			(6, 2, 4, '7/5/17', '7/11/17'),
			(7, 1, 1, '7/6/17', '7/12/17'),
			(8, 3, 2, '7/7/17', '7/13/17'),
			(9, 2, 6, '7/7/17', '7/13/17'),
			(10, 4, 4, '7/8/17', '7/14/17'),
			(11, 1, 3, '7/9/17', '7/15/17'),
			(12, 2, 5, '7/9/17', '7/15/17'),
			(13, 1, 2, '7/10/17', '7/16/17'),
			(14, 1, 7, '7/10/17', '7/16/17'),
			(15, 3, 6, '7/11/17', '7/17/17'),
			(16, 4, 8, '7/12/17', '7/18/17'),
			(17, 1, 3, '7/12/17', '7/18/17'),
			(18, 1, 5, '7/12/17', '7/18/17'),
			(19, 1, 7, '7/12/17', '7/18/17'),
			(20, 1, 6, '7/13/17', '7/19/17')
			;

			Select * FROM dbo.Book_Loans
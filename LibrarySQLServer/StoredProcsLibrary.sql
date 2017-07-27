USE  LibraryManagerPractice

GO

--1. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?--

CREATE PROCEDURE spFindBookinBranch
	@Title nvarchar(30) = NULL, 
	@Branch_Name nvarchar(30) = NULL
AS
	SELECT *
	FROM dbo.Book
	INNER JOIN dbo.Book_Copies ON dbo.Book.Book_id = dbo.Book_Copies.Book_id
	INNER JOIN dbo.Library_Branch ON dbo.Book_Copies.Branch_id = dbo.Library_Branch.Branch_id
	WHERE Title = ISNULL(@Title,Title)
	AND Branch_Name = ISNULL(@Branch_Name,Branch_Name) 
GO

EXEC spFindBookinBranch @Title = 'The Lost Tribe', @Branch_Name = 'Sharpstown'



--2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?--

EXEC spFindBookinBranch @Title = 'The Lost Tribe'



--3. Retrieve the names of all borrowers who do not have any books checked out.--

CREATE PROC spCheckBorrowerNo
	
AS
	SELECT *
	FROM dbo.Borrower
	LEFT JOIN dbo.Book_Loans ON dbo.Borrower.Card_No = dbo.Book_Loans.Card_No
	WHERE book_loans.Card_No IS NULL

EXEC spCheckBorrowerNo



--4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.--

CREATE PROCEDURE spCheckLibrarys
	@Branch_Name nvarchar(30) = NULL, 
	@Title nvarchar(30) = NULL, 
	@Due_Date nvarchar(30) = NULL,
	@Name nvarchar(30) = NULL,
	@Address nvarchar(30) = NULL
AS
	SELECT *
	FROM dbo.Book
	FULL JOIN dbo.Book_Loans ON dbo.Book.Book_id = dbo.Book_Loans.Book_id
	FULL JOIN dbo.Library_Branch ON dbo.Book_Loans.Branch_id = dbo.Library_Branch.Branch_id
	FULL JOIN dbo.Borrower ON dbo.Book_Loans.Card_No = dbo.Borrower.Card_No
	WHERE Title = ISNULL(@Title,Title)
	AND Branch_Name = ISNULL(@Branch_Name,Branch_Name) 
	AND Due_Date = ISNULL(@Due_Date,Due_Date)
	AND Name = ISNULL(@Name,Name)
	AND Address = ISNULL (@Address,Address)
GO

EXEC spCheckLibrarys @Branch_Name = 'Sharpstown', @Due_Date = '7/26/2017' 



--5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

CREATE PROC spBookLoans
	@Branch_Name nvarchar(30) = NULL

AS
	SELECT dbo.Library_Branch.Branch_Name, SUM(dbo.book_loans.Branch_id) AS "BooksLoanedOut"
	FROM dbo.Book_Loans
	INNER JOIN dbo.Library_Branch ON dbo.Book_Loans.Branch_id = dbo.Library_Branch.Branch_id
	WHERE  Branch_Name = ISNULL(@Branch_Name, Branch_Name)
	GROUP BY dbo.Book_Loans.Branch_id, dbo.Library_Branch.Branch_Name

GO

EXEC spBookLoans @Branch_Name = 'Central'



--6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

ALTER PROC spCheckBorrowerBooks
	 @Name nvarchar(30) = NULL,
	 @Address nvarchar(30) = NULL

AS
	SELECT COUNT(dbo.book_loans.Card_No)AS "No. of Books Checked out" , Borrower.Name, Borrower.Address
	FROM dbo.Book_Loans
	INNER JOIN dbo.Borrower ON dbo.Book_Loans.Card_No = dbo.Borrower.Card_No
	WHERE  Name = ISNULL(@Name,Name)
	AND Address = ISNULL(@Address,Address)
	GROUP BY dbo.Borrower.Name, Borrower.Address
	Having Count(*) > 5


EXEC spCheckBorrowerBooks --Again No column name where book loans should be



--7. For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

ALTER PROC spAuthorBranch
	@Branch_Name nvarchar(30) = NULL,
	@Author_Name nvarchar(30) = NULL

AS
	SELECT SUM(dbo.Book_Copies.No_of_Copies) AS "Books In Branch" , Branch_Name, Author_Name
	FROM dbo.Book_Copies
	INNER JOIN dbo.Library_Branch ON dbo.Book_Copies.Branch_id = dbo.Library_Branch.Branch_id
	INNER JOIN dbo.Book ON dbo.Book_Copies.Book_id = dbo.Book.Book_id
	INNER JOIN dbo.Book_Authors ON dbo.Book.Book_id = dbo.Book_Authors.Book_id
	WHERE  Branch_Name = ISNULL(@Branch_Name,Branch_Name)
	AND Author_Name = ISNULL(@Author_Name,Author_Name)
	GROUP BY dbo.Library_Branch.Branch_Name, Author_Name



EXEC spAuthorBranch @Author_Name = 'Stephen King' 
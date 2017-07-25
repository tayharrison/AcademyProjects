USE LibraryMS
GO

--How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?--

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



--How many copies of the book titled "The Lost Tribe" are owned by each library branch?--

EXEC spFindBookinBranch @Title = 'The Lost Tribe'



--Retrieve the names of all borrowers who do not have any books checked out.--

ALTER PROC spCheckLibrary
	@Name nvarchar(30) = NULL, 
	@Address nvarchar(30) = NULL, 
	@Phone nvarchar(30) = NULL, 
	@Title nvarchar(30) = NULL, 
	@Book_id nvarchar(30) = NULL,
	@Due_Date nvarchar(30) = NULL,
	@Branch_Name nvarchar(30) = NULL,
	@No_of_Copies INT = NULL,
	@Author_Name nvarchar(30) = NULL
	
AS
	SELECT *
	FROM dbo.Borrower
	INNER JOIN dbo.Book_Loans ON dbo.Borrower.Card_No = dbo.Book_Loans.Card_No
	INNER JOIN dbo.Book ON dbo.Book_Loans.Book_id = dbo.Book.Book_id
	INNER JOIN dbo.Library_Branch ON dbo.Book_Loans.Branch_id = dbo.Library_Branch.Branch_id
	INNER JOIN dbo.Book_Copies ON dbo.Book.Book_id = dbo.Book_Copies.Book_id
	INNER JOIN dbo.Book_Authors ON dbo.book.Book_id = dbo.Book_Authors.Book_id
	WHERE Name = ISNULL(@Name,Name)
	AND Address = ISNULL(@Address, Address)
	AND Phone = ISNULL(@Phone, Phone)
	AND Title = ISNULL(@Title, Title)
	AND Due_Date = ISNULL(@Due_Date, Due_Date)
	AND dbo.Book_Loans.Book_id = ISNULL(@Book_id, dbo.Book_Loans.Book_id) 
	AND Branch_Name = ISNULL(@Branch_Name, Branch_Name)
	AND No_of_Copies = ISNULL(@No_of_Copies, No_of_Copies)
	AND Author_Name = ISNULL(@Author_Name, Author_Name)

EXEC spCheckLibrary @Book_Id = 0



--For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.--

EXEC spCheckLibrary @Branch_Name = 'Sharpstown', @Due_Date = '7/15/2017' --Note latest date available is 7/15



--For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

CREATE PROC spBooksinBranch
	@Branch_Name nvarchar(30) = NULL,
	@No_of_Copies nvarchar(30) = NULL

AS
	SELECT *
	FROM dbo.Library_Branch
	INNER JOIN dbo.Book_Loans ON dbo.Library_Branch.Branch_id = dbo.Book_Loans.Branch_id
	INNER JOIN dbo.Book_Copies ON dbo.Library_Branch.Branch_id= dbo.Book_Copies.Branch_id
	WHERE  Branch_Name = ISNULL(@Branch_Name, Branch_Name)
	AND No_of_Copies = ISNULL(@No_of_Copies, No_of_Copies)

EXEC spBooksinBranch @Branch_Name = 'Central' --Is there a way to do a sum of all the No-of-Copies column in a PROC?--



--Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

EXEC spCheckLibrary @No_of_Copies = 5 -->5?



--For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

EXEC spCheckLibrary @Author_Name = 'Stephen King'
import sqlite3

rosterValues = (
('Jean-Baptiste Zorg', 'Human', 122),
('Korben Dallas', 'Meat Popsicle', 100),
('Aknot', 'Mangalore', -5)
)
with sqlite3.connect('roster.db') as connection:
    c = connection.cursor()
    c.execute("DROP TABLE IF EXISTS Roster")
    c.execute("CREATE TABLE Roster(Name TEXT, Species TEXT, IQ INT)")
    c.executemany("INSERT INTO Roster VALUES(?, ?, ?)",
    rosterValues)


#Update the Species of Korben Dallas to be Human

c.execute("UPDATE Roster SET Species=? WHERE Name=? AND IQ=?",
('Human', 'Korben Dallas', '100'))


#Display the names and IQs of everyone in the
#table who is classified as Human
c.execute("SELECT Name, IQ FROM Roster WHERE Species == Human")
for row in c.fetchall():
    print(row)

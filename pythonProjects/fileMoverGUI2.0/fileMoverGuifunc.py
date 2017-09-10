# File Mover GUI
# Taylor Harrison
# Python 3.6

from tkinter import *
from tkinter import messagebox
from tkinter import filedialog
import tkinter as ttk
from datetime import *
from datetime import timedelta
import shutil
import os
import sqlite3


import fileMoverGuiMain
import fileMoverGui

# Center the window 
def center_window(self, w, h):
    screen_width = self.master.winfo_screenwidth()
    screen_height = self.master.winfo_screenheight()

    x = int((screen_width/2) - (w/2))
    y = int((screen_height/2) - (h/2))
    centerGeo = self.master.geometry('{}x{}+{}+{}'.format(w, h, x, y))
    return centerGeo



# Browse for the "from" folder when user presses "Browse" next to "Transfer from"
def browse_folder_from(self):
    browse_dir = filedialog.askdirectory()
    self.entry_transfer_from.delete(0,END)
    self.entry_transfer_from.insert(0,browse_dir)


# Browse for the "to" folder when user presses "Browse" next to "Transfer to"
def browse_folder_to(self):
    browse_dir = filedialog.askdirectory()
    self.entry_transfer_to.delete(0,END)
    self.entry_transfer_to.insert(0,browse_dir)

# Ask if the user is sure they want to quick/close when the "X" in the corner is pressed
def ask_quit(self):
    if messagebox.askokcancel("Exit Program", "Are you sure you want to exit?"):
        self.master.destroy()
        os._exit(0)

# Run the file check and transfer files
def run_file_transfer(self):
    # Get the directories from the to and from entry fields
    src = self.entry_transfer_from.get()
    dest = self.entry_transfer_to.get()

    # Only run if the filepaths exists and they're not the same
    if os.path.exists(src) and os.path.exists(dest) and src != dest:

        # Get current time and date 24 hours ago for file timestamp comparison
        currentTime = datetime.now()
        twentyFourHoursAgo = currentTime + timedelta(hours=-24)

        # Filter out folders inside of the directory.  Only get files
        files = [f for f in os.listdir(src) if os.path.isfile(os.path.join(src,f))]

        # Iterate through files from the source directory and compare the last modified date to yesterday at this time
        for f in files:
            src_file = src + '\\' + f
            lastModUnix = os.path.getmtime(src_file)
            lastMod = datetime.fromtimestamp(int(lastModUnix))
            if lastMod >= twentyFourHoursAgo:
                dest_file = dest + '\\' + f
                shutil.copy(src_file, dest_file)
        update_last_run_time(self,currentTime)
        messagebox.showinfo("File Transfer Complete","Success")
    else:
        if src == dest:
            # Error message if the source and destination directories are the same
            messagebox.showerror("Invalid Entry", "Source and destination folders must be different")
        else:
            # Error message if the directory does not exist

            messagebox.showerror("Invalid directory", "Invalid directory")

# Create the db for the last time the file check was run (if needed)
def create_db(self):
    conn = sqlite3.connect('last_run_time.db')
    with conn:
        cur = conn.cursor()
        cur.execute("CREATE TABLE IF NOT EXISTS tbl_last_run( \
            ID INTEGER PRIMARY KEY AUTOINCREMENT, \
            col_month INT, \
            col_day INT, \
            col_year INT, \
            col_hour INT, \
            col_min INT, \
            col_sec INT \
            );")
        conn.commit()
    conn.close()
    check_for_records(self)


# Check if there are any records in the table with the run times
def check_for_records(self):
    conn = sqlite3.connect('last_run_time.db')
    with conn:
        cur = conn.cursor()
        cur, count = count_records(cur)
        if count > 0:
            get_last_run(self,cur)

# Count number of records in the table that has the run times
def count_records(cur):
    count = ""
    cur.execute("SELECT COUNT(*) FROM tbl_last_run")
    count = cur.fetchone()[0]
    return cur, count

# Organize the table with the latest time at the top, and update the displayed time on the gui
def get_last_run(self,cur):
    cur.execute("SELECT *, MAX(ID) FROM tbl_last_run GROUP BY ID ORDER BY ID DESC")
    lr = cur.fetchall()[0]

    # Convert from military time to standard time
    amPm = 'AM'
    hour = int(lr[4])
    if hour > 12:
        hour = hour - 12
        amPm = 'PM'
    last_run = '{}-{}-{} {}:{}:{} {}'.format(str(lr[1]).zfill(2),str(lr[2]).zfill(2),lr[3],str(hour).zfill(2),str(lr[5]).zfill(2),str(lr[6]).zfill(2),amPm)
    self.lr_time.set(last_run)

# Update the records in the last run time table after the file check is run
def update_last_run_time(self,currentTime):
    conn = sqlite3.connect('last_run_time.db')
    with conn:
        cur = conn.cursor()
        cur.execute("INSERT INTO tbl_last_run (col_month,col_day,col_year,col_hour,col_min,col_sec)\
                    VALUES(?,?,?,?,?,?)",(currentTime.month,currentTime.day,currentTime.year,currentTime.hour,currentTime.minute,currentTime.second))
    create_db(self)



if __name__ == "__main__":
    pass

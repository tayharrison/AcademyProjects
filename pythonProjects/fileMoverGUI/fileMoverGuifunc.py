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
        messagebox.showinfo("File Transfer Complete","Success")
    else:
        if src == dest:
            # Error message if the source and destination directories are the same
            messagebox.showerror("Invalid Entry", "Source and destination folders must be different")
        else:
            # Error message if the directory does not exist
            messagebox.showerror("Invalid directory", "Invalid directory")




if __name__ == "__main__":
    pass

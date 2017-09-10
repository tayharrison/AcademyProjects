# File Mover GUI
# Taylor Harrison
# Python 3.6

from tkinter import *
from tkinter import messagebox
import tkinter as ttk
from datetime import *
from datetime import timedelta
import shutil
import os


import fileMoverGui
import fileMoverGuifunc



# Create window for gui
class ParentWindow(Frame):
    def __init__(self, master):
        Frame.__init__(self, master)
        
        # Set master frame size, not resizeable
        self.master = master
        self.master.minsize(500, 260)
        self.master.maxsize(500, 260)

        # Center the window 
        fileMoverGuifunc.center_window(self, 500, 260)
        self.master.title("Transfer Recently Modified Files")
        self.master.configure(bg="LIGHTGOLDENRODYELLOW")

        # Catch the Close
        self.master.protocol("WM_DELETE_WINDOW", lambda: fileMoverGuifunc.ask_quit(self))

        # Load the gui
        fileMoverGui.load_gui(self)


        # Create/Load db for last time program was run
        fileMoverGuifunc.create_db(self)        

        










if __name__ == "__main__":
    root = Tk()
    App = ParentWindow(root)
    root.mainloop()

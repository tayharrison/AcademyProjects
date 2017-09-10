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


import fileMoverGuiMain
import fileMoverGuifunc


def load_gui(self):

    # Create and place the header
    self.lbl_header = ttk.Label(self.master, bg='LIGHTGOLDENRODYELLOW', font=('Roboto',18,'bold'), text='Transfer Recently Modified Files')
    self.lbl_header.grid(row=0, column=0, columnspan=5, padx=(25,5), pady=(10,10), sticky=N)

    # Create and place the labels for the entry text fields
    self.lbl_transfer_from = ttk.Label(self.master, bg='LIGHTGOLDENRODYELLOW', font=('Roboto',12), text='Transfer from:')
    self.lbl_transfer_from.grid(row=1, column=0, columnspan=2, padx=(25,0), pady=(10,0), sticky=N+W)
    self.lbl_transfer_to = ttk.Label(self.master, bg='LIGHTGOLDENRODYELLOW', font=('Roboto',12), text='Transfer to:')
    self.lbl_transfer_to.grid(row=3, column=0, columnspan=2, padx=(25,0), pady=(10,0), sticky=N+W)

    # Create and place the entry text fields
    self.entry_transfer_from = ttk.Entry(self.master, width=50, font=('Arial', 10))
    self.entry_transfer_from.grid(row=2, column=0, columnspan=4, padx=(25, 0), pady=(10, 0), sticky=N+W)
    self.entry_transfer_to = ttk.Entry(self.master, width=50, font=('Arial', 10))
    self.entry_transfer_to.grid(row=4, column=0, columnspan=4,  padx=(25, 0), pady=(10, 0), sticky=N+W)

    # Create and place the Browse buttons, that will look for a directory on the user's computer
    self.btn_browse_from = ttk.Button(self.master, width=10, height=1, bg='LIGHTGOLDENRODYELLOW', text='Browse', command=lambda: fileMoverGuifunc.browse_folder_from(self))
    self.btn_browse_from.grid(row=2, column=4, padx=(25, 0), pady=(7, 0), sticky=N+W)
    self.btn_browse_to = ttk.Button(self.master, width=10, height=1, bg='LIGHTGOLDENRODYELLOW', text='Browse',command=lambda: fileMoverGuifunc.browse_folder_to(self))
    self.btn_browse_to.grid(row=4, column=4, padx=(25, 0), pady=(7, 0), sticky=N+W)

    # Create and place the Run button, that will execute the file check and transfer
    self.btn_run = ttk.Button(self.master,width=8, height=2, bg='LIGHTGOLDENRODYELLOW', text='Run', command=lambda: fileMoverGuifunc.run_file_transfer(self))
    self.btn_run.grid(row=5, column=3, rowspan = 2, padx=(0, 0), pady=(12, 10))

    # Create and place label for the last time the file check was run
    self.lbl_last_run = ttk.Label(self.master, bg='LIGHTGOLDENRODYELLOW', font=('Courier',12), text='Last Run:')
    self.lbl_last_run.grid(row=5, column=0, columnspan=2, padx=(25,0), pady=(10,0), sticky=N+W)

    # Create and place the time the last file check was run
    self.lr_time = StringVar()
    self.lr_time.set('XX-XX-XXXX XX:XX:XX XX')
    self.txt_last_run_time = ttk.Label(self.master, bg='LIGHTGOLDENRODYELLOW', font=('Courier',12), width=22, textvariable=self.lr_time)
    self.txt_last_run_time.grid(row=6, column=0, columnspan=2, padx=(25,0), pady=(0,0), sticky=N+W)






if __name__ == "__main__":
    pass

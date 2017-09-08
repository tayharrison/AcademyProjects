# File Mover
# Taylor Harrison
# Python 2.7

import shutil
import os
from os import path

def main():
  # src = "c:\Users\Student\Desktop\foldera"
  # dst = "c:\Users\Student\Desktop\folderb"

  file_list = os.listdir('c:\Users\Student\Desktop\FolderA')

  #print file_list
  
  for fname in os.listdir('c:\Users\Student\Desktop\FolderA'):
    src_fname = 'c:\Users\Student\Desktop\FolderA\%s' % fname
    dst_fname = 'c:\Users\Student\Desktop\FolderB\%s' % fname

    print 'Moving file : %s ' % (src_fname)
    print '     To loc : %s ' % (dst_fname)
    
    shutil.move(src_fname, dst_fname)
       
      
if __name__ == "__main__":
  main()

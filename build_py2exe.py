""" 
Windows executable build with py2exe
"""

from distutils.core import setup
import py2exe
import os
import sys

data_files = []
base_path = os.path.abspath(os.path.dirname(__file__))
#base_path = os.path.abspath(os.path.dirname(__file__) + '../')
#sys.path.append(base_path)
#import app
#from sub import db

def prep_data_files(dir):
    for root, dirs, files in os.walk(base_path + dir):
        path = root.split('/')
        _tfiles = []
        for file in files:
            _tfiles.append(root + '/' + file)
            #print(path[1], root + '/' + file)
        data_files.append((path[1], _tfiles))

prep_data_files('/static')
prep_data_files('/views')


setup(
    console=['app.py'],
    data_files=data_files,
    #zipfile=None, #--> If zipfile is set to None, the files will be bundled within the executable instead of 'library.zip'.
    options={
        'py2exe': {
            'packages': ['sub', 'pygments.styles'],
            'optimize': 2, #0 - 1 - 2
            'compressed': True,
            #'xref': True,
            #'bundle_files': 3 #1: evryting 2:except python.exe 3:nothing (default)
        }
    }
)

# bof fix: timezone'un eklenmesi
"""
import pygments
import zipfile
zipfile_path = os.path.join("dist/" 'library.zip')
z = zipfile.ZipFile(zipfile_path, 'a')
zoneinfo_dir = os.path.join(os.path.dirname(pygments.__file__), 'styleS')
disk_basedir = os.path.dirname(os.path.dirname(pygments.__file__))
for absdir, directories, filenames in os.walk(zoneinfo_dir):
    assert absdir.startswith(disk_basedir), (absdir, disk_basedir)
    zip_dir = absdir[len(disk_basedir):]
    for f in filenames:
      z.write(os.path.join(absdir, f), os.path.join(zip_dir, f))

z.close()
"""
##eof fix
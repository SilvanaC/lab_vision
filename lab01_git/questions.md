# Warmup Questions

1.  What is the clone url of this repository?
    >   https://github.com/SilvanaC/lab_vision.git

2.  What is the output of the ``cal`` command?

    Febrero 2016
do lu ma mi ju vi sá
1 2 3 4 5 6
7 8 9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29

# Homework Questions

1.  What is the ``grep``command?
    This command 'grep' search text or searches the given file for lines containing a match to the given strings or words

2.  What is a *makefile*?
    It's a easier way to install a programm in linux, it compiles all the files in an executable

4.  What does the ``-prune`` option of ``find`` do? Give an example
    The prune option print the matching files found, if no other options are specified it prevents the command find from recursing        into matching directories.

5.  Where is the ``grub.cfg``  file
    /boot/grub/grub.cfg

6.  How many files with ``gnu`` in its name are in ``/usr/src``
    There are not files using this command.

7.  How many files contain the word ``gpl`` inside in ``/usr/src``
    There are 586 files

8.  What does the ``cut`` command do?
    It removes an item from a place and saves it temporarily while we place it somewhere else.

9.  What does the ``wget`` command do?
    This let us download files knowing the full internet adress.

9.  What does the ``rsync`` command do?
    This command synchronize and copy files local or to a sever.

10.  What does the ``diff`` command do?
    This command compares 2 files, looking for the differences between them and prints the lines that are not equal.

10.  What does the ``tail`` command do?
    It prints the last n lines of the file that enters as a paramete, it will print the last 10 lines by default

10.  What does the ``tail -f`` command do?
    this command updates the file constantly and if it grows it will print the new lines that are added

10.  What does the ``link`` command do?
    This links to files, if one of the files changes the other will be affected

11.  How many users exist in the course server?
    5 users

12. What command will produce a table of Users and Shells sorted by shell (tip: using ``cut`` and ``sort``)
    cat /etc/passwd | sort

13. What command will produce the number of users with shell ``/sbin/nologin`` (tip: using ``grep`` and ``wc``)
     cat /etc/passwd | grep '/sbin/nologin'|wc -l

15. Create a script for finding duplicate images based on their content (tip: hash or checksum)
    You may look in the internet for ideas, but please indicate the source of any code you use
    Save this script as ``find_duplicates.sh`` in this directory and commit your changes to github

16. What is the meaning of ``#! /bin/bash`` at the start of scripts?
    This commands bash decides how an order must be interpreted. this line tells the programm to be interpreted /bin/bash

17. How many unique images are in the ``sipi_images`` database?
    there are not unique images in that dataset
    

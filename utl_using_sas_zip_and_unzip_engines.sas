Using SAS zip qnd unzip engines

Not sure I understand the problem

see
https://goo.gl/snSxAp
https://communities.sas.com/t5/General-SAS-Programming/Export-zip-files-using-ods/m-p/429058

  WPS had the following ERROR

    ERROR: ZIP is not a valid access method

INPUT (csv file)
================

  d:\csv\class.csv

    NAME,SEX,AGE,HEIGHT,WEIGHT
    Alfred,M,14,69,112.5
    Alice,F,13,56.5,84
    Barbara,F,13,65.3,98
    Carol,F,14,62.8,102.5
    Henry,M,14,63.5,102.5
    James,M,12,57.3,83
    Jane,F,12,59.8,84.5
    ....


PROCESS (all the code)
======================

  ZIP the csv file

    filename foo ZIP 'd:\zip\class.zip';
    data _null_;
       infile "d:\csv\class.csv";
       input;
       file foo(class);
       put _infile_;
    run;quit;


  UNZIP the csv file

  filename foo ZIP 'd:\zip\class.zip';
  data _null_;
     infile foo(class);
     input;
     put _infile_;
  run;quit;



OUTPUT
======

 ZIP:  d:\zip\class.zip

   Files in the ZIP file

   MEMNAME

   class

   N = 1

 UNZIP  d:\zip\class.zip

  This will appear in log

    NAME,SEX,AGE,HEIGHT,WEIGHT
    Alfred,M,14,69,112.5
    Alice,F,13,56.5,84
    Barbara,F,13,65.3,98
    Carol,F,14,62.8,102.5
    Henry,M,14,63.5,102.5
    James,M,12,57.3,83
    Jane,F,12,59.8,84.5

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

  dm "dexport sashelp.class 'd:\csv\class.csv' replace";

  or type on Classic editor command line

   dexport sashelp.class 'd:\csv\class.csv' replace

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

  ZIP the csv file

    filename foo ZIP 'd:\zip\class.zip';
    data _null_;
       infile "d:\csv\class.csv";
       input;
       file foo(class);
       put _infile_;
    run;quit;


  UNZIP the csv file

  filename foo ZIP 'd:\zip\class.zip';
  data _null_;
     infile foo(class);
     input;
     put _infile_;
  run;quit;

*    _                         _             _
 ___(_)_ __     ___ ___  _ __ | |_ ___ _ __ | |_ ___
|_  / | '_ \   / __/ _ \| '_ \| __/ _ \ '_ \| __/ __|
 / /| | |_) | | (_| (_) | | | | ||  __/ | | | |_\__ \
/___|_| .__/   \___\___/|_| |_|\__\___|_| |_|\__|___/
      |_|
;

filename inzip zip "d:\zip\class.zip";
/* Read the "members" (files) from the ZIP file */
data contents(keep=memname);
    length memname $200;
    fid=dopen("inzip");
    if fid=0 then
        stop;
    memcount=dnum(fid);
    do i=1 to memcount;
        memname=dread(fid,i);
        output;
    end;
    rc=dclose(fid);
run;
/* create a report of the ZIP contents */
title "Files in the ZIP file";
proc print data=contents noobs N;
run;


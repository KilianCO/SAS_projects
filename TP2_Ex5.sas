/* Question 1 */
/* Import des donn�es */
proc import datafile='U:\Mes documents\M2\Data Mining\EgyptianSkulls.txt'
            dbms=dlm
            out=d
            replace;
     delimiter=',';
     getnames=yes;
run;

proc print data=d;
run;

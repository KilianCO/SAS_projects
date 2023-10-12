/* Description des données */
PROC IMPORT OUT= genes
 DATAFILE= "U:\Mes documents\M2\Data Mining Project\genes.txt"
 DBMS=DLM REPLACE;
 DELIMITER=' ';
 GETNAMES= yes;
 DATAROW=2;
RUN;

proc print data=genes;
run;

proc means data = genes mean std median min max var  ;
	var PLTP PMDCI PON PPARa PPARd PPARg PXR Pex11a RARa RARb2 RXRa RXRb2 RXRg1 S14 SHP1  ;
	output out=stat1 mean=mean_bmq1 ;
run;




PROC IMPORT OUT= agh
 DATAFILE= "U:\Mes documents\M2\Data Mining Project\agh.txt"
 DBMS=DLM REPLACE;
 DELIMITER=' ';
 GETNAMES= yes;
 DATAROW=2;
RUN;

proc print data=agh;
run;

proc means data = agh mean std median min max var  ;
	var C18_3n_6 C20_2n_6 C20_3n_6 C20_4n_6 C22_4n_6 C22_5n_6 C18_3n_3 C20_3n_3 C20_5n_3 C22_5n_3 C22_6n_3   ;
	output out=stat1 mean=mean_bmq1 ;
run;




/* Nutrimouse */

PROC IMPORT OUT= nutrimouse
 DATAFILE= "U:\Mes documents\M2\Data Mining Project\nutrimouse.txt"
 DBMS=DLM REPLACE;
 DELIMITER=' ';
 GETNAMES= yes;
 DATAROW=2;
RUN;

proc print data=nutrimouse;
run;


/* ACC */

proc cancorr data = nutrimouse out = sortie1 red;
	var PLTP PMDCI PON PPARa PPARd PPARg PXR Pex11a RARa RARb2 RXRa RXRb2 RXRg1 S14 SHP1;
	with C18_3n_6 C20_2n_6 C20_3n_6 C20_4n_6 C22_4n_6 C22_5n_6 C18_3n_3 C20_3n_3 C20_5n_3 C22_5n_3 C22_6n_3;
run;

proc print data = sortie1;
run;

proc plot data = sortie1;
	plot v1*v2;
	title "Les deux premières variables canoniques pour X";
run;

proc plot data = sortie1;
	plot w1*w2;
	title "Les deux premières variables canoniques pour Y";
run;

proc plot data = sortie1;
	plot v1*w1;
	title "Combinnes";
run;

proc plot data = sortie1;
	plot v2*w2;
	title "Combinnes";
run;


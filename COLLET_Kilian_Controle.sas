/* CC SAS */
/* Kilian COLLET */

/* Question 1 */
/* Importer ficher */
proc import datafile='U:\Mes documents\M2\CC-SAS\thermometry.csv' out=tempnorm DBMS=CSV replace ;
	delimiter=",";
run;

/* Changer le nom des colonnes */
data tempnorm;
        set tempnorm;
        rename body_temp = tempcorps ;
		rename gender = sexe ;
		rename heart_rate = freqcard ;
run;


/* Afficher */
proc print data=tempnorm;
run;


/* Question 2 */
proc univariate data=tempnorm normal;
	     var tempcorps ;
		 histogram /normal;
		 title "Histogramme des données de température corporelle";
		 axis2 label=("Occurences");
run;



/* Question 3 */
proc means data=tempnorm;
   var tempcorps;
   run;

/* On voit que la température moyenne est de 98.2 °F */

/* Test de Student */
proc ttest data=tempnorm;
    var tempcorps;
	run;


/* Question 4 */
/* Tri d'une table */
proc sort data=tempnorm;
	by tempcorps;
run;

/* Affichage */
proc print data=tempnorm;
run;



/* Question 5 */
 proc ttest data=tempnorm H0=98.6;
    var tempcorps;
	run;


/* Question 6 */
proc means data=tempnorm min mean std Q1 Q3 median max;
	var tempcorps; /* possibilité de calculer les stats sur 2 variables en même temps */
	output out=stat min=the_min mean=the_mean std=the_std Q1=the_quart1 median=the_median Q3=the_quart3 max=the_max ; /* pour stocker les moyennes dans une table */
run;

proc print data=tempnorm;
run;
proc print data=stat;
run;

/* Suppression des colonnes en trop */
data stat;
        set stat;
        drop _type_ _freq_;
run;
proc print data=stat;
run;


/* Question 7 */
data tempnorm_vm;
        set tempnorm;
run;

data tempnorm_vm;
set tempnorm_vm;
if rand('Normal',0.5)<0.01
then tempcorps=.;
if rand('Normal',0.5)<0.01
then freqcard=.;
run;

proc print data=tempnorm_vm;
run;

/* Maxx */
proc sort data=tempnorm_vm;
	by sexe ;
run;

proc means data=tempnorm_vm max;
	by sexe;
	var tempcorps;
	output out=stat_vm max=maxx ;
run;

data stat_vm;
        set stat_vm;
        drop _type_ _freq_;
run;

proc print data=stat_vm;
run;

proc print data=tempnorm_vm;
run;

/* Question 8 */
/* D'abord pour les femmes */
data tempnorm_vm8;
set tempnorm_vm;
if sexe="fema" && tempcorps="."
then tempcorps=100;
run;

proc print data = tempnorm_vm8;
run;

/* Puis pour les hommes */
data tempnorm_vm8;
set tempnorm_vm8;
if sexe="male" && tempcorps="."
then tempcorps=99.5;
run;

proc print data = tempnorm_vm8;
run;



/* Question 9 */
proc means data=tempnorm Q1 median Q3;
	var tempcorps;
run;

data tempnorm;
set tempnorm;
if tempcorps<=97.8 then tempscorps_quant="mod1";
else if 97.8<tempcorps<=98.3 then tempscorps_quant="mod2";
else if 98.3<tempcorps<=98.7 then tempscorps_quant="mod3";
else if tempcorps>98.7 then tempscorps_quant="mod4";
run;

proc print data = tempnorm;
run;


/* Question 10 */
proc means data=tempnorm;
   var tempscorps_quant;
   run;

proc freq data=tempnorm;
	var sexe;
run;

/* Khi 2 */
proc freq DATA=tempnorm9;
TABLE sexe*tempscorps_quant / chisq expected missing;
run;



/* Exercice 2 */

/* Question 1 */
 proc sort data=tempnorm;
  by sexe;
proc boxplot data=tempnorm;
  plot tempcorps*sexe / BOXCONNECT=mean;
  run;



/* Question 2 */
  proc sort data=tempnorm;
  by sexe;
  run;

symbol1 v=plus  c=red;
symbol2 v=circle c=black;

/* Version 1 */
proc sgplot data=tempnorm;
   scatter y=tempcorps x=freqcard / group=sexe;
run;

/* Version 2 */
proc gplot data=tempnorm;
by sexe ;
	plot tempcorps*freqcard / overlay legend;
run;


/* Exercice 3 */

/* Question 1 */
proc print data = stat;
run;

%let moyenne = 98.249230769;
%let ecart_type = 0.733183158;

data outliers;
set tempnorm;
run;

data outliers;
set outliers;
if 98.249230769-3*0.733183158<=tempcorps<=98.249230769+3*0.733183158 then delete;
run;

proc print data=outliers;
run;
/* Une seule observation */



/* Question 2 */
options symbolgen mprint mlogic;
%macro descriptive(Tab,v1,v2,v3,v4);
proc means data=&Tab noprint;
    var &v1 &v2 ;
run;

proc means data=&Tab noprint;
    var &v3 &v4 ;
run;
%mend;

proc print data=tempnorm;
run;

%descriptive(tempnorm9,tempcorps,freqcard,sexe,tempcorps_qual);

/* Cela ne marche pas car je n'ai pas réussi à faire la question 9 dans laquelle la variable "tempcorps_qual" aurait dû être créée */



/* Question 3 */
options symbolgen mprint mlogic;
%macro traitement_vm(y);

%mend;

proc print data=tempnorm;
run;


data tempnorm_no_vm;
%traitement_vm(tempcorps);

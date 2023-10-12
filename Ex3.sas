/* Exo 3 AFD */

/* Import du jeu */
proc import out= Train(keep = STG SCG STR LPR PEG UNS)
    datafile = "U:\Mes documents\M2\Data Mining Project\Data_User_Modeling_Dataset_Hamdi Tolga KAHRAMAN.xls"
	DBMS=XLS replace;
    sheet = "Training_Data";
    getnames = yes;
run;

proc import out= Test(keep = STG SCG STR LPR PEG UNS)
    datafile = "U:\Mes documents\M2\Data Mining Project\Data_User_Modeling_Dataset_Hamdi Tolga KAHRAMAN.xls"
	DBMS=XLS replace;
    sheet = "Test_Data";
    getnames = yes;
run;


/* Première visualisation */
proc print data = Train;
run;

proc print data = Test;
run;

/* Fusion des deux jeux de données */
DATA d;
SET Train Test;
RUN;
proc print data=concat;
run;

/* Means sur variables quantitatives */
proc means data = d mean std median min max var  ;
	var STG SCG STR LPR PEG;
	output out=stat1; /* pour stocker les moyennes dans une table */
run;


/* Freq sur variables qualitatives */
proc freq data = d;
	tables UNS;
run;

/* Split du jeu de données */
data train test;
set d;
if rand("Uniform") > 0.2 then output train;
else output test;
run;


/* AFD */
proc discrim data = Train anova;
	class UNS;
	var STG SCG STR LPR PEG;   
run;
/* On enlève les variables dont la p-value est supérieure à 0.05 */
/* Ici il n'y en a pas */
/* Toutes les variables sont donc significatives */


/* Plusieurs AFD */
proc discrim data = Train crossvalidate anova;
	class UNS;
	var STG SCG STR LPR PEG;
run;

/* k-NN */
proc discrim data = Train method = npar k = 2 crossvalidate out = tab;
	class UNS;
	var STG SCG STR LPR PEG;
run;

proc discrim data = Train method = npar k =3 crossvalidate out = tab;
	class UNS;
	var STG SCG STR LPR PEG;
run;

proc discrim data = Train method = npar k = 4 crossvalidate out = tab;
	class UNS;
	var STG SCG STR LPR PEG;
run;

proc discrim data = Train method = npar k = 5 crossvalidate out = tab;
	class UNS;
	var STG SCG STR LPR PEG;
run;

proc discrim data = Train method = npar k = 25 crossvalidate out = tab;
	class UNS;
	var STG SCG STR LPR PEG;
run;

/* Kernel normal */
proc discrim data = Train method = npar r = 3 crossvalidate kernel = normal;
	class UNS;
	var STG SCG STR LPR PEG;
run;

proc discrim data = Train method = npar kernel = normal r=5.5 crossvalidate out = tab;
	class UNS;
	var STG SCG STR LPR PEG;
run;


/* Test de la meilleure méthode sur notre jeu de données Test */
proc discrim data = train testdata = test method = npar r = 3 kernel = normal;
	class UNS;
	var STG SCG STR LPR PEG;
run;

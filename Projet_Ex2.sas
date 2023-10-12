/* Exercice 2 */

/* Import du fichier */
data a;
infile "U:\Mes documents\M2\Data Mining Project\seismic-bumps.txt" DLM=',';
input seismic$ seismoacoustic$ shift$ genergy gpuls gdenergy gdpuls ghazard$ nbumps nbumps2 nbumps3 nbumps4 nbumps5 nbumps6 nbumps7 nbumps89 energy
maxenergy class$;
run;


/* Affichage */
proc print data=a;
run;


/* Freq sur variables qualitatives */
proc freq data=a ;
	tables seismic seismoacoustic shift ghazard class;
run;


/* Pie charts */
proc gchart data=a;
pie seismic /
percent=arrow
slice=inside value=inside
coutline=black woutline=1;
title "Répartition de la variable seismic";
run; quit;

proc gchart data=a;
pie seismoacoustic /
percent=arrow
slice=inside value=inside
coutline=black woutline=1;
title "Répartition de la variable seismoacoustic";
run; quit;

proc gchart data=a;
pie shift /
percent=arrow
slice=inside value=inside
coutline=black woutline=1;
title "Répartition de la variable shift";
run; quit;

proc gchart data=a;
pie ghazard /
percent=arrow
slice=inside value=inside
coutline=black woutline=1;
title "Répartition de la variable ghazard";
run; quit;

proc gchart data=a;
pie class /
percent=arrow
slice=inside value=inside
coutline=black woutline=1;
title "Répartition de la variable class";
run; quit;


/* Means sur variables quantitatives */
proc means data=a mean std median min max var  ;
	var genergy gpuls gdenergy gdpuls nbumps nbumps2 nbumps3 nbumps4 nbumps5 nbumps6 nbumps7 nbumps89 energy maxenergy;
	output out=stat1 mean=mean_bmq1 mean_bmq2 ; /* pour stocker les moyennes dans une table */
	title "Statistiques descriptives sur les variables numériques";
run;


/* Test de normalité */
proc univariate data=a normal; 
histogram /normal;
   var genergy gpuls gdenergy gdpuls nbumps nbumps2 nbumps3 nbumps4 nbumps5 nbumps6 nbumps7 nbumps89 energy maxenergy;
   title "Test de normalité";
run;
/* Si la p-vlue est inférieure à 5% on rejette HO l'hypothèse de normalité */


/* Matrice corrélation */
PROC CORR data= a ;
VAR genergy gpuls gdenergy gdpuls nbumps nbumps2 nbumps3 nbumps4 nbumps5 nbumps6 nbumps7 nbumps89 energy maxenergy;
run;


/* ACP à quatre dimensions pour avoir 75% de variance expliquée*/
proc princomp data=a out=sortie outstat=st plots(ncomp=4 flip)=(pattern(circles=1.0) score);
title "ACP";
var genergy gpuls gdenergy gdpuls nbumps nbumps2 nbumps3 nbumps4 nbumps5 nbumps6 nbumps7 nbumps89 energy maxenergy;
run;


/* Plots variable seismic*/
proc sgplot data=sortie;
	scatter x=prin1 y=prin2 / group=seismic;
	xaxis grid label="Component 1";
	yaxis grid label="Component 2";
run;

proc sgplot data=sortie;
	scatter x=prin3 y=prin4 / group=seismic;
	xaxis grid label="Component 3";
	yaxis grid label="Component 4";
run;


/* Plots variable seismoacoustic*/
proc sgplot data=sortie;
	scatter x=prin1 y=prin2 / group=seismoacoustic;
	xaxis grid label="Component 1";
	yaxis grid label="Component 2";
run;

proc sgplot data=sortie;
	scatter x=prin3 y=prin4 / group=seismoacoustic;
	xaxis grid label="Component 3";
	yaxis grid label="Component 4";
run;

/* Plots variable shift*/
proc sgplot data=sortie;
	scatter x=prin1 y=prin2 / group=shift;
	xaxis grid label="Component 1";
	yaxis grid label="Component 2";
run;

proc sgplot data=sortie;
	scatter x=prin3 y=prin4 / group=shift;
	xaxis grid label="Component 3";
	yaxis grid label="Component 4";
run;

/* Plots variable class*/
proc sgplot data=sortie;
	scatter x=prin1 y=prin2 / group=class;
	xaxis grid label="Component 1";
	yaxis grid label="Component 2";
run;

proc sgplot data=sortie;
	scatter x=prin3 y=prin4 / group=class;
	xaxis grid label="Component 3";
	yaxis grid label="Component 4";
run;

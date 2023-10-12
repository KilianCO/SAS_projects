/* Import */
data ap;
infile "U:\Mes documents\M2\Data Mining\AirPollution.txt" delimiter=',';
input city$ so2 temp man pop wind rain raindays;
proc print;
run;

/* Rajout de variable catégorique */
data ap;
set ap;
if so2<50 then pol=0;
if 50<so2<70 then pol=1;
if so2>70 then pol=2;
run;
proc print data=ap;
run;

/* AFD */
proc discrim data=ap anova list crosslist crossvalidate;
	class pol;
	var temp man pop wind rain raindays;
	run;

/* On ne garde que man et pop qui sont les deux seules variables explicatives significatives */


proc discrim data=ap crossvalidate;
	class pol;
	var man pop;
	priors equal; /* pk=1/nbclasses */
	run;

proc discrim data=ap crossvalidate;
	class pol;
	var man pop;
	priors prop; /* pk=nk/n */
	run;

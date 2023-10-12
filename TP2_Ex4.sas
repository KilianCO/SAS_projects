data as;
infile "U:\Mes documents\M2\Data Mining\vinbdx.txt";
input annee temp soleil chal pluie qual$;proc print;
run;

/* Question 1 */
/* proc means data=as;
var temp soleil chal pluie;run;*/

/* exemmple d'analyse de variance avec un facteur */

proc glm data=as;
title "Analyse";
class qual; /* c'est l'équivalent de factor sous R */
	model temp=qual;
	run;
	ODS PDF file="U:\Mes documents\M2\Data Mining\vins_sorties_photocopie.pdf";
	startpage=no;

proc discrim data=as anova list crosslist crossvalidate;
	class qual;
	var temp soleil chal pluie;

proc discrim data=as method=npar k=2 crossvalidate;
	class qual;
	var temp soleil chal pluie;

proc discrim data=as method=npar k=5 crossvalidate;
	class qual;
	var temp soleil chal pluie;

proc discrim data=as method=npar kernel=normal r=2 crossvalidate;
	class qual;
	var temp soleil chal pluie;

run;run;


data nouveau;
	input temp soleil chal pluie;
	cards;
	3000 1200 20 400
	;
	run;

proc discrim data=as testdata=nouveau method=npar k=2;
	class qual;
	var temp soleil chal pluie;
	ods pdf close;
run;

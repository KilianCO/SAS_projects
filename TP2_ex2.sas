/* Import des données */
data eaux;
infile 'U:\Mes documents\M2\Data Mining\eaux.txt';
input hco so4 cl ca mg na source$ pays;
run;


data d;
set eaux;
cla=2;
if (source="ond" or source="vit" or source="evi" or source="per") then cla=1;run;

proc print data=d;run;



/* Question 1 */

proc discrim data=d anova list crosslist crossvalidate;
	class cla;
	var hco so4 cl ca mg na;
	run;

/* Question 2 */

proc discrim data=d method=npar kernel=normal r=2 crossvalidate;
	class cla;
	var hco so4 cl ca mg na;
run;

/* Question 3 */

proc discrim data=d method=npar k=2 crossvalidate;
	class cla;
	var hco so4 cl ca mg na;
run;

/* Question 4 */

data TestEau;
	input hco so4 cl ca mg na source$ pays;
	cards;
	1159 8 18 304 17 47 cas 2
	386 1058 6 451 66 8 con 1
	540 333 133 186 48 129 fon 5
	;
run;


proc discrim data=TestEau anova list crosslist crossvalidate;
	class cla;
	var hco so4 cl ca mg na;
	run;

/* Question 1 */
/* Import des données */
data d;
infile 'U:\Mes documents\M2\Data Mining\cardiaques.txt' expandtabs;
input id age exam50 syst50 diast50 height weight50 chol50 status$ clinical$ exam62$ syst62 diast62 chol62 weight62 diagn$ annee$ survie;
run;


/* Statistiques élémentaires */
proc means data=d;
var age syst50 diast50 height weight50 chol50 syst62 diast62 weight62 chol62;
	title "Premières analyses";
run;

/* ACP avec flèches */
proc princomp data=d out=sortie plots(ncomp=4 flip)=(pattern(vector) score);
title "ACP sans param";
var age syst50 diast50 height weight50 chol50 syst62 diast62 weight62 chol62;
run;

/* ACP avec points */
proc princomp data=d out=sortie plots(ncomp=4 flip)=(pattern(circle=1.0) score);
title "ACP sans param";
var age syst50 diast50 height weight50 chol50 syst62 diast62 weight62 chol62;
run;

/* Corrélations */
PROC CORR data= sortie ;
VAR age syst50 diast50 height weight50 chol50 syst62 diast62 weight62 chol62;
run;

/* Plots */
proc plot data=sortie;
title "Premiere comp fonction de la 2e et statu socio-eco";
plot prin1*prin2="*" $status;
run;

proc plot data=sortie;
title "Premiere comp fonction de la 2e et statut clinique";
plot prin1*prin2="*" $clinical;
run;

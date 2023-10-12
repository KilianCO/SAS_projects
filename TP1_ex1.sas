/* Question 1 */
/* Import des données */
data d;
infile 'U:\Mes documents\M2\Data Mining\eaux.txt';
input hco so4 cl ca mg na s$ p;
run;

/* Means */
proc means data = d;
	var hco so4 cl ca mg na p;
	title "Premières analyses";
run;

/* Test de normalité */
proc univariate data=d normal; 
histogram /normal;
   var hco so4 cl ca mg na;
   title "Statistique descriptive";
run;
/* Si la p-vlue est inférieure à 5% on rejette HO l'hypothèse de normalité */


/* Matrice corrélation */
PROC CORR data= d ;
VAR hco so4 cl ca mg na p;
run;


/* ACP */
proc princomp data=d out=sortie outstat=st plots(ncomp=2 flip)=(pattern(circles=1.0) score);
title "ACP pour les eaux";
var hco so4 cl ca mg na;
run;

/* Remarques */
/* L'ACP se fait seulement sur des variables numériques
1 - Statistique descriptive : moyenne, écart-type, corrélations, hist, test de Normalité. Interprétation
2 - Sélectionner le nb de composantes principales q telles que : variance expliquée >75% et Var(z_q+1)<1
3 - Interpréter le lien entre z_j et X_k en regardant le cercle de corrélation 
	Z_j et X_k sont corrélées si abs(Corr(Zj,Xk))~=1 
4 - Expliquer les observations de z_1...z_q en tenant compte de l'étape 3
5 - Représenter un graphique des composantes principales (càd les Z) fonction de variables qualitatives
	Interprétation des observations extrêmes
	Faire des clusters et les interpréter
*/

/* Analyse des résultats */
proc plot data=sortie;
title "Les eaux minérales en fonctions des deux axes";
plot prin2*prin1 = "*" $s;
run;

proc print data=st;
title "Statistique sur les axes principaux";
run;

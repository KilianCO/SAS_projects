/* Question 1 */
/* Import des données */
data d;
infile 'U:\Mes documents\M2\Data Mining\auto.txt' expandtabs;
input mpg 1-4 cylinders 17 displace 33-36 horsepower 49-52 accel 65-69 year 81-82 weight 97-100 origin$ 113 make$ 129-140 model$ 145-156 price :160;
run;
/* On spécifie les numéros de colonnes pour palier aux problèmes de longuer des données ou données manquantes ou espaces dans les caractères */
/* Le 160 à la fin permet de sélectionner depuis la col 160 jusqu'à la fin de la ligne */

/* Means sur les numériques */
proc means data = d;
	var mpg cylinders displace horsepower accel year weight price;
	title "Premières analyses";
run;

/* FREQ sur les qualitatives */
proc freq data=d;
table year origin make;run;

/* Test de normalité */
proc univariate data=d normal; 
histogram /normal;
   var mpg cylinders displace horsepower accel year weight make model price;
   title "Statistique descriptive";
run;
/* Si la p-vlue est inférieure à 5% on rejette HO l'hypothèse de normalité */


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


/* Matrice corrélation */
PROC CORR data= d ;
VAR mpg cylinders displace horsepower accel weight price;
run;


/* ACP sans parmaètres */
proc princomp data=d out=sortie;
title "ACP pour les autos";
var mpg cylinders displace horsepower accel weight price;
run;

/* ACP à deux dimensions pour avoir 75% de variance expliquée */
proc princomp data=d out=sortie outstat=st plots(ncomp=2 flip)=(pattern(circles=1.0) score);
title "ACP pour les autos";
var mpg cylinders displace horsepower accel weight price;
run;

/* Commentaires */
/* z1 corrélée positivement avec weight, displace, cylinders, et horsepower (w,d,c,hp). Négativement avec mpg */
/* z2 corrélée positivement avec accel */
/* Observations 50 et 79 sont dans la moyenne par rapport à w,d,c,hp et de la conso */
/* Ce sont les voitures les plus rapides */

proc plot data=sortie;
title "Les autos en fonctions des deux axes";
plot prin2*prin1 = "*" $make; /* $var permet de labelliser en fonction de cette variable */
run;


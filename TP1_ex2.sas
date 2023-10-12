/* Question 1 */
/* Import des donn�es */
data d;
infile 'U:\Mes documents\M2\Data Mining\auto.txt' expandtabs;
input mpg 1-4 cylinders 17 displace 33-36 horsepower 49-52 accel 65-69 year 81-82 weight 97-100 origin$ 113 make$ 129-140 model$ 145-156 price :160;
run;
/* On sp�cifie les num�ros de colonnes pour palier aux probl�mes de longuer des donn�es ou donn�es manquantes ou espaces dans les caract�res */
/* Le 160 � la fin permet de s�lectionner depuis la col 160 jusqu'� la fin de la ligne */

/* Means sur les num�riques */
proc means data = d;
	var mpg cylinders displace horsepower accel year weight price;
	title "Premi�res analyses";
run;

/* FREQ sur les qualitatives */
proc freq data=d;
table year origin make;run;

/* Test de normalit� */
proc univariate data=d normal; 
histogram /normal;
   var mpg cylinders displace horsepower accel year weight make model price;
   title "Statistique descriptive";
run;
/* Si la p-vlue est inf�rieure � 5% on rejette HO l'hypoth�se de normalit� */


/* Remarques */
/* L'ACP se fait seulement sur des variables num�riques
1 - Statistique descriptive : moyenne, �cart-type, corr�lations, hist, test de Normalit�. Interpr�tation
2 - S�lectionner le nb de composantes principales q telles que : variance expliqu�e >75% et Var(z_q+1)<1
3 - Interpr�ter le lien entre z_j et X_k en regardant le cercle de corr�lation 
	Z_j et X_k sont corr�l�es si abs(Corr(Zj,Xk))~=1 
4 - Expliquer les observations de z_1...z_q en tenant compte de l'�tape 3
5 - Repr�senter un graphique des composantes principales (c�d les Z) fonction de variables qualitatives
	Interpr�tation des observations extr�mes
	Faire des clusters et les interpr�ter
*/


/* Matrice corr�lation */
PROC CORR data= d ;
VAR mpg cylinders displace horsepower accel weight price;
run;


/* ACP sans parma�tres */
proc princomp data=d out=sortie;
title "ACP pour les autos";
var mpg cylinders displace horsepower accel weight price;
run;

/* ACP � deux dimensions pour avoir 75% de variance expliqu�e */
proc princomp data=d out=sortie outstat=st plots(ncomp=2 flip)=(pattern(circles=1.0) score);
title "ACP pour les autos";
var mpg cylinders displace horsepower accel weight price;
run;

/* Commentaires */
/* z1 corr�l�e positivement avec weight, displace, cylinders, et horsepower (w,d,c,hp). N�gativement avec mpg */
/* z2 corr�l�e positivement avec accel */
/* Observations 50 et 79 sont dans la moyenne par rapport � w,d,c,hp et de la conso */
/* Ce sont les voitures les plus rapides */

proc plot data=sortie;
title "Les autos en fonctions des deux axes";
plot prin2*prin1 = "*" $make; /* $var permet de labelliser en fonction de cette variable */
run;


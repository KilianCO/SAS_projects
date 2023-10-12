/* Question 1 */
/* Import des donn�es */
data d;
infile 'U:\Mes documents\M2\Data Mining\eaux.txt';
input hco so4 cl ca mg na s$ p;
run;

/* Means */
proc means data = d;
	var hco so4 cl ca mg na p;
	title "Premi�res analyses";
run;

/* Test de normalit� */
proc univariate data=d normal; 
histogram /normal;
   var hco so4 cl ca mg na;
   title "Statistique descriptive";
run;
/* Si la p-vlue est inf�rieure � 5% on rejette HO l'hypoth�se de normalit� */


/* Matrice corr�lation */
PROC CORR data= d ;
VAR hco so4 cl ca mg na p;
run;


/* ACP */
proc princomp data=d out=sortie outstat=st plots(ncomp=2 flip)=(pattern(circles=1.0) score);
title "ACP pour les eaux";
var hco so4 cl ca mg na;
run;

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

/* Analyse des r�sultats */
proc plot data=sortie;
title "Les eaux min�rales en fonctions des deux axes";
plot prin2*prin1 = "*" $s;
run;

proc print data=st;
title "Statistique sur les axes principaux";
run;

/* Question 1 */
/* Import des donn�es */
data d;
infile 'U:\Mes documents\M2\Data Mining\cardiaques.txt' expandtabs;
input id age exam50 syst50 diast50 height weight50 chol50 status$ clinical$ exam62$ syst62 diast62 chol62 weight62 diagn$ annee$ survie;
run;


proc discrim data=d anova;
	class survie;
	var age syst50 diast50 height weight50 chol50 syst62 diast62 chol62 weight62;
	run;

/* On enl�ve les variables dont la p-value est sup�rieure � 0.05 */

proc discrim data=d crossvalidate anova;
	class survie;
	var age chol62 weight62;
	run;

proc discrim data=d method=npar r=1.75 crossvalidate;
title "Methode non parametrique des plus proches voisins";
	class survie;
	var age chol62 weight62;
	run;

proc discrim data=d method=npar k=7 crossvalidate out=tab;
	class survie;
	var age chol62 weight62;
	run;


/* Etapes pour l'AFD
	1) S�lectionner les variables num�riques qui ont un pouvoir de discrimination
	2) Trouver la meilleure m�thode de pr�vision (description) des classes

On compare pour chaque m�thode :
Taux de mauvais classement sur un ensemble d'apprentissage     -vs-     Taux de mauvais classement par cross-validation   [= le vrai taux)
                        T1                                     -vs-                         T2

==> On peut donc ensuite choisir la meilleure m�thode

Il ne faut pas que T1 << T2 sinon le mod�le n'est pas robuste
T1,T2 < proba � priori
Entre deux mod�les avec des r�sultats identiques on choisit le plus simple
	 
	3) Le mod�le trouv� � 2 sera test� sur un ensemble de test pour lequel je connais les valeurs des classes

	4) On peut utiliser le mod�le sans connaitre la classe



	*/

/* Question 1 */
/* Import des données */
data d;
infile 'U:\Mes documents\M2\Data Mining\cardiaques.txt' expandtabs;
input id age exam50 syst50 diast50 height weight50 chol50 status$ clinical$ exam62$ syst62 diast62 chol62 weight62 diagn$ annee$ survie;
run;


proc discrim data=d anova;
	class survie;
	var age syst50 diast50 height weight50 chol50 syst62 diast62 chol62 weight62;
	run;

/* On enlève les variables dont la p-value est supérieure à 0.05 */

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
	1) Sélectionner les variables numériques qui ont un pouvoir de discrimination
	2) Trouver la meilleure méthode de prévision (description) des classes

On compare pour chaque méthode :
Taux de mauvais classement sur un ensemble d'apprentissage     -vs-     Taux de mauvais classement par cross-validation   [= le vrai taux)
                        T1                                     -vs-                         T2

==> On peut donc ensuite choisir la meilleure méthode

Il ne faut pas que T1 << T2 sinon le modèle n'est pas robuste
T1,T2 < proba à priori
Entre deux modèles avec des résultats identiques on choisit le plus simple
	 
	3) Le modèle trouvé à 2 sera testé sur un ensemble de test pour lequel je connais les valeurs des classes

	4) On peut utiliser le modèle sans connaitre la classe



	*/

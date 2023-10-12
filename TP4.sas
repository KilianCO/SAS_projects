/* Exercice 1 */
data exo1;
	infile "U:\Mes documents\M2\Data Mining\TP4_Exo1.txt";
	input X1 X2 Y1 Y2 Y3 nom$;
run;

ODS PDF file = "U:\Mes documents\M2\Data Mining\TP4_Exo1.pdf" startpage = no;

proc cancorr data = exo1 out = sortie1 red;
	var X1 X2;
	with Y1 Y2 Y3;
run;

proc print data = sortie1;
run;

proc plot data = sortie1;
	plot v1*v2$nom;
	title "Les deux premières variables canoniques pour X";
run;

proc plot data = sortie1;
	plot w1*w2$nom;
	title "Les deux premières variables canoniques pour Y";
run;

proc plot data = sortie1;
	plot v1*w1$nom;
	title "Combinnes";
run;

proc plot data = sortie1;
	plot v2*w2$nom;
	title "Combinnes";
run;

ods pdf close;



/* Exercice 2 */

data d;
infile 'U:\Mes documents\M2\Data Mining\cardiaques.txt' expandtabs;
input id age exam50$ syst50 diast50 height weight50 chol50 status$ clinical$ exam62$ syst62 diast62 chol62 weight62 diagn$ annee$ survie;
run;

proc cancorr data = d out = sortie1 red;
	var syst50 diast50 weight50 chol50;
	with syst62 diast62 chol62 weight62;
run;

proc print data = sortie1;
run;

proc plot data = sortie1;
	plot v1*v2$ID;
	title "Les deux premières variables canoniques pour X";
run;

proc plot data = sortie1;
	plot w1*w2$nomID;
	title "Les deux premières variables canoniques pour Y";
run;

proc plot data = sortie1;
	plot v1*w1$ID;
	title "Combinnes";
run;

proc plot data = sortie1;
	plot v2*w2$ID;
	title "Combinnes";
run;


/* Commentaires Exo 2 
X=(X1,X2,X3,X4) p=4 X1:syst50 ... x4:chol50    ;   u1=X_tild * a1 avec a1=(a1(1)...a4(1))
Y=(Y1...Y4) q=4 Y1=syst62 ... chol62   ;   v1=Y_tild * b1  avec  b1=(b1(1) ... b4(1))

Chercher la plus grande valeur propre des matrices :
Sxx(-1) Sxy Syy(-1) Syx   a1=r1^2 * a1

Syy-(1) Syx Sxx(-1) Sxy   b1=r1^2 * b1

On cherche un deuxième une deuxième transformation :
u2 = X_tild * a2  , v2=Ytild * b2 tq
r2^2 = corr²(u2,v2) max et u1, u2 indep ET v1,v2 indep
r2^2 la deuxième valeur propre des matrices

.
.
.

On continue jusqu'à (u1,v1), si <= min(p,q) = rang(Sxy)

H0 : r1=0 : aucune corrélation entre les deux groupes
H1 : r1=/=0 : il existe au moins un lien entre les deux groupes de variables

==> Stat de test : le max de vraisemblance

R1=(1-r1^2)(1-r2^2)(1-r3^2)(1-r4^2) sur nos données R1=0.14

Stat de test : z1 = -2n log(R1)  ---L--> Chi2(4^2) sous H0

p-value > 10^-4 ==> HO rejetée
==> Il existe un lien entre les groupes de variables



H0 : r2 = 0 | r1=/=0
H1 : r2 = 0

La valeur de la log-vrais : R2 = R1 / (1-r1^2) 

Stat de test :
z2 = -2nlog(R2) -L->(H0) Chi2((4-1)^2) = Chi2(q)
R2 = 0.50 et z2 = 17.03 
pvalue > 10^-4 ==> H0 rejetée
==> Il existe un deuxième lien entre les variables de 1950 et les variables mesurées en 1962

a1=(-0.09 -0.02 1 -0.17)
u1 = (-0.09*Xtild1 - 0.002*Xtild2 + Xtild3 - 0.17*Xtild4)
==> u2 est donné principalement Xtild3

Dans le groupe des var mesurées en 1950, c'est la variable poids qui sera la plus corrélée avec les variables mesurées en 1962
Pour le groupe de 1962 : c'est le poids qui influe le plus v1

==> C'est le poids en 1962 qui est le plus influencé par le poids de 1950

u2 = (0.6  ; 0.25 ; -0.6)
     (syst, diast, chol)

v2 = (0.5 ; 0.37 ; 0.75)

La corrélation r1>0 étant positivz, une personne ayant du poids en 1962 aura aussi du poids en 1950.

33% de la variabilité (significative) des 4 variables mesurées en 1962 est expliquée par les variables de 1950

*/

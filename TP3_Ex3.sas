/* Exercice 3 */
data a;
infile 'U:\Mes documents\M2\Data Mining\afc2.txt';
input v1-v9;run;

proc corresp data=a observed mca outc=coord;
title "AFC sur les conditions de vie: 4 var";
tables v3 v4 v7 v8;
/* %plotit(data=coord, datatype=corresp, HREF=0, vref=0);run; */
run;

proc corresp data=a observed mca outc=coord dim=4;
title "AFC sur les conditions de vie: 4 var";
tables v3 v4 v7 v8;
/* %plotit(data=coord, datatype=corresp, HREF=0, vref=0);run;
%plotit(data=coord, datatype=corresp, plotvars=dim3 dim4,HREF=0, vref=0);run;
*/
run;


/* 9=2+4+2+2=10
X variables avec les modalit�s (v3_1, v3_2, v4_1, ... , v8_2) : 10 modalit�s
H0 : toutes les modalit�s de X sont ind�pendantes : P[(x=v1)inter(x=v2)] = P(x=v1)*P(x=v2)
Test d'ind�p de Chi2 : nD� --> (en loi sous h0) Chi2((10-1)(10-1)) ==> 

z = 668 � R ==> Les modalit�s de X sont corr�l�es
On va trouver ces corr�lations

Sur l'axe 1 : loyer pas une lourge charge est corr�l�e avec le fait de ne pas s'imposer des restrictions.
Ces personnes sont � l'oppos� de ceux qui s'imposent des restrictions et ont des difficult�s avefc le loyer.

Sur l'axe 2 : ceux qui n'ont pas de difficult�s avec le loyer s'opposent � ceux qui ont des maux de dos
et ils ne se sentent pas bien dans la famille



*/

data aa;
	set a;
		if v1 = 1 then w1 = 'v1_1';
	if v1 = 2 then w1 = 'v1_2';
		if v3 = 1 then w3 = 'v3_1';
	if v3 = 2 then w3 = 'v3_2';
		if v4 = 1 then w4 = 'v4_1';
	if v4 = 2 then w4 = 'v4_2';
		if v4 = 3 then w4 = 'v4_3';
	if v4 = 4 then w4 = 'v4_4';
		if v5 = 1 then w5 = 'v5_1';
	if v5 = 2 then w5 = 'v5_2';
		if v6 = 1 then w6 = 'v6_1';
	if v6 = 2 then w6 = 'v6_2';
		if v7 = 1 then w7 = 'v7_1';
	if v7 = 2 then w7 = 'v7_2';
		if v8 = 1 then w8 = 'v8_1';
	if v8 = 2 then w8 = 'v8_2';
		if v9 = 1 then w9 = 'v9_1';
	if v9 = 2 then w9 = 'v9_2';
		if v9 = 3 then w9 = 'v9_3';
	if v9 = 4 then w9 = 'v9_4';

run;

ODS PDF file = "U:\Master 2\Data Mining\afc_exo3.pdf" startpage = no;




proc corresp data = aa observed mca outc = coord dim = 4;
	title 'AFC sur les conditions de vie : 4 variables';
	tables w3 w4 w7 w8;
	ods graphics on;
	%plotit(data = coord, datatype = corresp, HREF = 0, vref = 0); 
	%plotit(data = coord, datatype = corresp, plotvars = dim3 dim4, HREF = 0, vref = 0);

run;

ods graphics off;
ods pdf close;

/* A partir d'ici les sorties ne sont pas imprim�es */


proc corresp observed mca data = aa outc = coord;
	title 'AFC sur les conditions de vie : Toutes les variables';
	tables w1 w3-w9;

run;


proc corresp observed mca data = aa outc = coord dim = 7;
	title 'AFC sur les conditions de vie : Toutes les variables';
	tables w1 w3-w9;
	%plotit(data = coord, datatype = corresp, HREF = 0, vref = 0); /* Pour les 2 premiers axes */

	run;
	%plotit(data = coord, datatype = corresp, plotvars = dim3 dim4, HREF = 0, vref = 0); /* Pour les axes 3 et 4 */
	%plotit(data = coord, datatype = corresp, plotvars = dim5 dim6, HREF = 0, vref = 0); /* Pour les axes 5 et 6 */
run;

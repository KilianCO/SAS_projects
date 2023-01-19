/* Exercice 2 */

/* Import du fichier */
data a;
infile "U:\Mes documents\M2\Data Mining Project\seismic-bumps.txt" DLM=',';
input seismic$ seismoacoustic$ shift$ genergy gpuls gdenergy gdpuls ghazard$ nbumps nbumps2 nbumps3 nbumps4 nbumps5 nbumps6 nbumps7 nbumps89 energy
maxenergy class$;
run;

/* Affichage */
proc print data=a;
run;


/* Question 1 */
/* Oui */

/* ACP */
proc princomp data=a out=sortie outstat=st plots(ncomp=2 flip)=(pattern(circles=1.0) score;
title "ACP";
var genergy gpuls gdenergy gdpuls nbumps nbumps2 nbumps3 nbumps4 nbumps5 nbumps6 nbumps7 nbumps89 energy maxenergy class ;
run;

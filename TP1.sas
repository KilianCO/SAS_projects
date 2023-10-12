data a;
infile 'U:\Mes documents\M2\Data Mining\depart1.txt';
input num deprt$ region$ txcr urbr jeun age chom agri arti cadr empl ouvr prof fisc fe90;
run;

data a;
set aa;
if urbr>1 then urbr=1;run;
ods graphic on;
proc princomp data=a;
var txcr urbr jeun age chom agri arti cadr empl ouvr prof fisc fe90;
title "ACP pour les départements français";run;

ODS PDF file="U:\Mes documents\M2\Data Mining\TP_ACP_depart.pdf" startpage=no; /* c'est pour mettre un fichier pdf dans les sorties */

proc means data = aa;
var txcr urbr jeun age chom agri arti cadr empl ouvr prof fisc fe90;
run;


data a;
set aa;
if urbr>1 then urbr=1; run;
ods graphics on;

proc princomp data=a out=b plots(ncomp=3 flip)=(pattern(circles=1.0) score);
title "ACP pour les départements français";run;
ods graphics on;
option ls=40 ps=60;

/* proc ploc data = b;
plot prin2*prin1$depart;
run; */

proc plot data=b;
plot prin2*prin1$num;
run;

proc plot data=b;
plot prin2*prin1$region;
run;

proc plot data=b;
plot prin3*prin1$num;
run;

proc plot data=b;
plot prin3*prin1$region;
run;

ods pdf close;

proc corr data=b;
var urbr jeun age chom agri arti cadr empl ouvr prof fisc fe90 prin1-prin3;
run;

proc print data=b;
run;

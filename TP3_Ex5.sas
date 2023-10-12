/* Exercice 5 */
data montana;
infile "U:\Mes documents\M2\Data Mining\montanadat.txt" DLM=',';
input age$ sex$ inc$ pol$ area$ fin$ stat$;
proc print;
run;

data Montana2;
set montana;
if Age = 1 then Age1 = "age_1";
if Age = 2 then Age1 = "age_2";
if Age = 3 then Age1 = "age_3";
if Sex = 0 then Sex1 = "H";
if Sex = 1 then Sex1 = "F";
if Inc = 1 then Inc1 = "inc_1";
if Inc = 2 then Inc1 = "inc_2";
if Inc = 3 then Inc1 = "inc_3";
if Pol = 1 then Pol1 = "Dem";
if Pol = 2 then Pol1 = "Ind";
if Pol = 3 then Pol1 = "Rep";
if Area = 1 then Area1 = "Wes";
if Area = 2 then Area1 = "Nor";
if Area = 3 then Area1 = "Sou";
if Fin = 1 then Fin1 = "Wor";
if Fin = 2 then Fin1 = "Sam";
if Fin = 3 then Fin1 = "Bet";
if Stat = 0 then Stat1 = "Bet";
if Stat = 1 then Stat1 = "NotBet";
run;

proc print data=montana2;
run;

proc corresp data = montana2 outc = cood observed mca;
			title "Exercice 5";
			tables  Age1 Sex1 Inc1 Pol1 Area1 Fin1 Stat;
			%plotit(data = sortie, datatype = corresp, HREF = 0, vref = 0);
		run;

proc corresp data = montana2 outc = cood observed mca dim=8;
			title "Exercice 5";
			tables  Age1 Sex1 Inc1 Pol1 Area1 Fin1 Stat;
			%plotit(data = sortie, datatype = corresp, HREF = 0, vref = 0);
		run;


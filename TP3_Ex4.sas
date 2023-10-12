/* Exercice 4 */

data a;
infile 'U:\Mes documents\M2\Data Mining\ehd.txt' firstobs=2;
     input e1$ e2$ e3$ e4$ e5$ e6$ e7$ e8$ e9$ e10$ e11$ e12$ e13$ e14$ e15$ e16$ e17$ e18$ e19$ e20$;
run;

proc print data=a;
run;


data bb;
	set a;
	v1=e1; v2=e2;v3=e3; v4=e4;v5=e5; v6=e6;v7=e7; v8=e8;v9=e9; v10=e10;v11=e11; v12=e12;v13=e13; v14=e14;
	v15=e15; v16=e16;v17=e17; v18=e18;v19=e19; v20=e20;
run;

%MACRO rename1(tab,nb);
data &tab;
	set &tab;
	%do i=1 %to &nb %by 1;
if e&i="0" then v&i="e&i" !! "_" !! "0";
if e&i="1" then v&i="e&i" !! "_" !! "1";
if e&i="2" then v&i="e&i" !! "_" !! "2";
if e&i="3" then v&i="e&i" !! "_" !! "3";
if e&i="4" then v&i="e&i" !! "_" !! "4";
	%end;
run;
%MEND rename1;

%rename1(bb,20);

proc print data=bb;run;

proc corresp data = bb outc = sortie mca;
			title "Exercice 4";
			tables  v1-v20;
			%plotit(data = sortie, datatype = corresp, HREF = 0, vref = 0);
		run;

proc corresp data = bb outc = sortie mca dim=4;
			title "Exercice 4";
			tables  v1-v20;
			%plotit(data = sortie, datatype = corresp, HREF = 0, vref = 0);
		run;

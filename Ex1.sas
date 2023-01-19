/* Exercice 1 */

/* import du fichier .CSV */
proc import datafile="U:\Mes documents\M2\Data Mining Project\Dresses_Attribute_Sales\Attribute DataSet.xlsx"
	DBMS=XLSX
	OUT=a
	replace;
run;


/* Affichage */
proc print data=a;
run;


/* Analyse corrélation AFC */
proc corresp data = a outc = sortie mca dim=4;
			title "AFC sur les variables qualitatives";
			tables  Style Price Size Season NeckLine SleeveLength waiseline Material FabricType Decoration Pattern_Type;
			%plotit(data = sortie, datatype = corresp, HREF = 0, vref = 0);
		run;



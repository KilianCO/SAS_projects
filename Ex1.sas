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

/* Statistique Descriptive */

proc means data = a mean std median min max var  ;
	var Rating ; /* possibilité de calculer les stats sur 2 variables en même temps */
	output out=stat1 mean=mean_bmq1 ; /* pour stocker les moyennes dans une table */
run;

proc freq data = a ;
	tables Style Price Size Season Neckline SleeveLength waiseline Material FabricType Decoration Pattern_type Recommendation;
run;


/* Remplacer valeurs manquantes */
data aa;
        set a;
        if Price="" then Price="Average";
		if Season="" then Season="Summer";
		if NeckLine="" then NeckLine="o-neck";
		if waiseline="" then waiseline="natural";
		if Material="" then Material="cotton";
		if FabricType="" then FabricType="null";
		if Decoration="" then Decoration="null";
		if Pattern_Type="" then Pattern_Type="solid";
run;

proc freq data = aa ;
	tables Style Price Size Season Neckline SleeveLength waiseline Material FabricType Decoration Pattern_type Recommendation;
run;





/* Analyse corrélation AFC */
proc corresp data = a outc = sortie mca dim=4;
	title "AFC sur les variables qualitatives";
	tables  Style Price Size Season NeckLine SleeveLength waiseline Material FabricType Decoration Pattern_Type;
	%plotit(data = sortie, datatype = corresp, HREF = 0, vref = 0);
run;

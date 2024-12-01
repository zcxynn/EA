
PROC IMPORT
	out = ay2425EA	
	datafile = '/home/u64002650/EA_Project/Project_Housing.csv'
	dbms = csv
	replace;
RUN;


proc sql outobs=20;
create table xu as
SELECT *
FROM ay2425EA
ORDER BY index desc;
quit;
proc sql;
SELECT *
FROM xu
ORDER BY index;
quit;

/* Q2*/

PROC IMPORT
	out = ay2425EA	
	datafile = '/home/u64002650/EA_Project/Project_Housing.csv'
	dbms = csv
	replace;
RUN;


proc sql;
    create table avg_receptions as
    select flattype, mean(TOTAL_RECEPTIONS) as avg
    from ay2425EA
    group by flattype;
    
RUN;

proc sql;
create table find as
select flattype , max(avg) as mostReception
from avg_receptions
group by flattype
order by avg desc;

quit;

proc print data=find;
    title "FlatType with the Highest Average Receptions";
run;

proc sgplot data=find;
vbar flattype / response= mostReception;
run;

/*Q3*/

PROC IMPORT
	out = ay2425EA	
	datafile = '/home/u64002650/EA_Project/Project_Housing.csv'
	dbms = csv
	replace;
RUN;

proc sql;
create table avg as
select flattype, mean(price) as avgprice
from ay2425EA
group by flattype
order by avgprice desc;

quit;

proc sql;
create table hotype as
select flattype, count(flattype) as mostcommon
from ay2425EA
group by flattype
order by mostcommon desc;

quit;
proc print data=avg;
    title "avg";
run;

proc print data=hotype;
title "The most common type";
run;

proc sgplot data=hotype;
vbar flattype / response= mostcommon;
run;

/*Q4*/

PROC IMPORT
	out = ay2425EA	
	datafile = '/home/u64002650/EA_Project/Project_Housing.csv'
	dbms = csv
	replace;
RUN;

proc sql;
create table bath as
select flattype, Avg(total_Baths) as avgBath
from ay2425EA
where flattype = 'flat' or flattype eq 'terraced house'
group by flattype
order by avgBath;

quit;

proc print data=bath;
title "bathroom between the flat house and terraced house";

run;

proc sgplot data=bath;
    vbox avgBath / category=flattype;
    xaxis label="Flat Type";
    yaxis label="Total Bathrooms";
    title "Distribution of Total Bathrooms by Flat Type";
run;

/*Q5*/

PROC IMPORT
	out = ay2425EA	
	datafile = '/home/u64002650/EA_Project/Project_Housing.csv'
	dbms = csv
	replace;
RUN;

proc sql outobs=2;
create table qian as
select flattype, count(flattype) as turnover
from ay2425EA
group by flattype
order by turnover desc;
quit;

proc sql outobs=1;
create table dier as
select flattype, turnover
from qian
order by turnover;
quit;
proc print data=qian;
title "the most turnover";
run;

proc print data=dier;
title "the second most turnover";
run;

/*Q6*/

PROC IMPORT
	out = ay2425EA	
	datafile = '/home/u64002650/EA_Project/Project_Housing.csv'
	dbms = csv
	replace;
RUN;

proc sql;
create table fang as
select flattype, count(total_Beds) as totalBed, count(total_Baths) as totalBath, mean(price) as avgprice
from ay2425EA
group by flattype;

quit;

proc print data= fang;

title "between the number of bedrooms, the number of bathrooms and the average price";

run;
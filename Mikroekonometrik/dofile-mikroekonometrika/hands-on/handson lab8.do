* Hands on Lab 7

clear
cd "C:\Users\hisbi\iCloudDrive\"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
log using "$log\handson8"
use "$data/hh_91_practice.dta ", clear
desc

*1. Experimental Sample 
*a. use the set seed command before you draw the lottery tickets. Use the set seed (20221115)
set seed 20221115

di 2^31
*b. Create the variable random which represents the lottery tickets and draw the actual numbers.  
gen random= uniform()

*c. Sort all the households in increasing order with respect to their lottery ticket and select the first 300 
sort random

*d. Create the dummy variable `experiment' to identify the experimental sample (1 for households participating in the evaluation and 0 for the rest) 
gen experiment=(_n<=300)
tab experiment, m

*2. External Validity 
gen experiment_20=(_n<=20)
tab experiment_20, m

*b.
twoway (kdensity exptot) ///
	(kdensity exptot if experiment==1, lpattern(dash)) ///
	(kdensity exptot if experiment_20==1, lpattern(shortdash)), ///
legend(label(1 "population") label(2 "large sample") label(3 "small sample"))

twoway(kdensity exptot) //
	(kdensity exptot if experiment==1, lpattern(dash)) ///
	(kdensity exptot if experiment==20, lpattern(shortdash)), ///
legend (label(1 "population") label (2 "large sample") label(3 "small sample"))

* Kenapa representatif = Distribusi populasi = Distribusi sampel populasi

*3. Treatment and Control Group
*a. Separating the experimental sample into two identical groups: treatment and control. Households with numbers below 0.5 are assigned to the treatment group (T=1), and the rest to the control group (T= 0).  
gen random_T=runiform()
br random_T

gen T=(random_T<0.5) if experiment==1

tab T, m
* 4. Stratification
* a. Separate lottery for the households with a female household head. For each value of sexhead we run a lottery to assign half of the households to the treatment group and half of the households to the control group (The criteria for treatment group same like number 3).   How many female household in the treatment and control group?  
tab T sexhead
sort sexhead random
bysort sexhead: generate random_T_strat = runiform()
order random_T_strat
bysort sexhead: generate T_strat = (random_T_strat < 0.5) if experiment == 1
tab T_strat sexhead

* b. To show that the control group provides a valid counterfactual for the treatment group, run t-test. (Before and After stratification)
* Internal Validity
Internal Validity = Apakah terdapat perbedaan atau tidak 
* Before stratification
ttest exptot, by(T)
* After stratification
ttest exptot, by(T_strat)

*p-value 0.4466  > alpha, H0 tidak dapat ditolak, artinya tidak terdapat 
*p-value 0.8069 > alpha, H0 tidak dapat ditolak

log close

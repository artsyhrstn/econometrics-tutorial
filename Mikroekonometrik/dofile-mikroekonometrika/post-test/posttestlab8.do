* Post Test Lab 8
* Hisbi Asyihristani Rijal
* 120610210018

clear
cd "C:\Users\ThinkPad\iCloudDrive\"
global log "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data"
log using "$log\Hisbi_PostTest_8"


*1. 
use "$data/pratham_data.dta", clear
desc

*2. How many schools are there in this survey?
sum schoolid

*3. Create a random variable to distribute random numbers for each schools in the survey. Use the set seed (20221115) before creating random variable.
set seed 20221115
gen random= runiform()

*4. Sort all the schools in increasing order with respect to their random numbers
sort random

*5. Create the dummy variable `treatment' to identify the experimental sample which equals 1 if treatment and 0 if control. Schools with random numbers above 0.5 are assigned to the treatment group and the rest to the control group. How many schools are there in the treatment and control group?
gen treatment=(random>0.5)
tab treatment

*6. Separate the random numbers for the schools by the language they used. For each value of language, assign half of the schools to the treatment group and half of the schools to the control group (The criteria for treatment group same like number 5).  How many schools in the control group that use Gujarati?
tab  treatment language
sort language random
bysort language: generate random_T_strat = runiform()
order random_T_strat
bysort language: generate T_strat = (random_T_strat > 0.5)
tab T_strat language


*7. Does control group provide a valid counterfactual? Explain. (Use before and after stratification)
ttest pretest_mean, by(treatment)
ttest pretest_mean, by(T_strat)

log close


























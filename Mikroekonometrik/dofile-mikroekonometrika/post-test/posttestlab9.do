* Post Test Lab 9
* Hisbi Asyihristani Rijal
* 120610210018
* RANDOMIZED CONTROLLED TRIAL

clear
cd "C:\Users\ThinkPad\iCloudDrive\"
global log "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data"
log using "$log\Hisbi_PostTest__9"

* Assume that microcredit program is randomly assigned to villages, and further assume no differences between treated and control villages. You want to ascertain the impact of program placement and participation on household's per capita total annual expenditures.
* 1. Impacts of Program Placement in Villages
* Use the1998 household data hh_98.dta. (0%)
use "$data/hh_98", clear
desc

* b. Create the log form of two variables outcome ("exptot") and household's land before joining the microcredit program ("hhland," which is changed to acre from decimal by dividing by 100). (5%)
gen lexptot= ln(1+exptot)
gen lnland= ln(1+hhland/100)

* c. Create dummy variable for microcredit program placement in villages. Two program placement variables are created : one for male programs and the other for female programs.  (10%)
gen vill=thanaid*10+villid

*MALE
egen progvill_m=max(dmmfd), by(vill)
order progvill_m dmmfd vill
*FEMALE
egen progvill_f=max(dfmfd), by(vill)
order progvill_m dfmfd vill
br

* egen = jika hh ada cewe yang masuk program, maka desa tersebut akan mendapatkan program

* d. Use the simplest method to calculate average treatment effect of village program placement for male. compare the outcome between treated and control villages (10%)
ttest lexptot, by(progvill_m)
reg lexptot progvill_m

* dmmfd = HH has male microcredit participant: 1=Y, 0=N
* dfmfd = HH has female microcredit participant: 1=Y, 0=N 

* e. Estimate the same outcome (log of per capita household expenditures) against the village program dummy for male plus other factors that may influence the expenditure (other factor : sexhead. Agehead, educhead, lnland, vaccess, pcirr, rice, wheat, milk, oil, and egg) (10%)
reg lexptot progvill_m sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]

* 2. Impacts of Program Participation
* a. Use the simplest method to calculate average treatment effect of program participation for male (10%)
ttest lexptot, by (dmmfd)
reg lexptot dmmfd

* b. Estimates the equation of village program placement but Include other household- and village-level covariates in the male participation equation (10%)
reg lexptot dmmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]

* 3. Capturing Both Program Placement and Participation
* a. two effects can be combined (estimation 1.e and 2.b) in the same regression (15%)
reg lexptot dmmfd progvill_m sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]

* 4. Impacts of Program Participation in Program Villages
* a. how the impact of male participation in microcredit programs on household expenditure in program villages (15%)
reg lexptot dmmfd if progvill_m==1
reg lexptot dmmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg if progvill_m==1 [pw=weight]

* 5. Measuring Spill over Effects of Microcredit Program Placement
* a. Investigates whether program placement in villages has any impact on nonparticipants. (15%)
reg lexptot progvill_m if dmmfd==0 [pw=weight]
reg lexptot progvill_m sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg if dmmfd==0 [pw=weight]

log close


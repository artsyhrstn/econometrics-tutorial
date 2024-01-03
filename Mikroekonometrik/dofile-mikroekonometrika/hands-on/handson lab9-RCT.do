* Hands-on Lab 9
* Hisbi Asyihristani Rijal
* 120610210018
* RANDOMIZED CONTROLLED TRIAL

clear
cd "C:\Users\ThinkPad\iCloudDrive\"
global log "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data"
log using "$log\Hisbi_HandsOn_9"

* 1. Impacts of Program Placement in Villages. 
*a. Use the1998 household data hh_98.dta.
use "$data/hh_98", clear
desc

dfmfd
dmmfd

*b. Create the log form of two variables outcome ("exptot") and household's land before joining the microcredit program ("hhland," which is changed to acre from decimal by dividing by 100).
gen lexptot= ln(1+exptot)
gen lnland= ln(1+hhland/100)
describe

*c. Create dummy variable for microcredit program placement in villages. Two program placement variables are created : one for female programs and the other for male programs.
gen vill=thanaid*10+villid
egen progvillf=max(dfmfd), by(vill)
help egen

* egen = jika hh ada cewe yang masuk program, maka desa tersebut akan mendapatkan program

*d. Use the simplest method to calculate average treatment effect of village program placement for female. compare the outcome between treated and control villages
ttest lexptot, by(progvillf)
reg lexptot progvillf

* Jadi apabila terdapat dua karakter desa yang sama tetapi salah satu desa mendapatkan program. maka pengeluaran total dari desa tersebut akan lebih besar 12.98% dibandingkan dengan desa yang tidak mendapatkan program. Ceteris paribus

*e. Estimate the same outcome (log of per capita household expenditures) against the village program dummy for female plus other factors that may influence the expenditure (other factor : sexhead. Agehead, educhead, lnland, vaccess, pcirr, rice, wheat, milk, oil, and egg)
reg lexptot progvillf sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]
*weight = untuk menentukan ...
* Setelah ditambahkan faktor lain, progvillf menjadi tidak berpengaruh secara signifikan terhadap outcome yaotu total pengeluaran perkapita dalam rumah tangga.

* 2. Impacts of Program Participation
*a. Use the simplest method to calculate average treatment effect of program participation for female
ttest lexptot, by (dfmfd)
reg lexptot dfmfd
* Pengaruh dari program terhadap partisipan tidak signifikan terhadap outcome yaitu pengeluaran perkapita dalam rumah tangga

*b. Estimates the equation of village program placement but Include other household- and village-level covariates in the female participation equation
reg lexptot dfmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]
*Setelah ditambahkan faktor lain, terdapat perbedaan outcome yang signifikan bahwa program participant untuk perempuan meningkatkan pengeluaran outcome perkapita sebesar 6%. ceteris paribus

*3. Capturing Both Program Placement and Participation
*a. two effects can be combined (estimation 1.e and 2.b) in the same regression
reg lexptot dfmfd progvillf sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]


*4. Impacts of Program Participation in Program Villages
*a. how the impact of female participation in microcredit programs on household expenditure in program villages
reg lexptot dfmfd if progvillf==1
reg lexptot dfmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg if progvillf==1 [pw=weight]

*5. Measuring Spill over Effects of Microcredit Program Placement
*a. Investigates whether program placement in villages has any impact on nonparticipants.
reg lexptot progvillf if dfmfd==0 [pw=weight]
* Ketika p value tidak signifikan=program tidak berpengaruh, program tersebut tidak terdapat spillover terhadap treatment
* Tidak terdapat spillover effect dari program placement sebelum faktor lain ditambahkan
reg lexptot dfmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg if dfmfd==1 [pw=weight]
*Sesudah ditambah faktor lain, bisa disimpulkan bahwa tidak terdapat spillover di program placement karena tidak signifikan secara statisitik(tidak berpengaruh)

log close

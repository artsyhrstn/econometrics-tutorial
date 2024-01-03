* Posttest Lab 11
clear
cd "C:\Users\ThinkPad\iCloudDrive\"
global log "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data"
log using "$log\Hisbi_PostTest_11", replace

use "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data\CIT_2019_Cambridge_Polecon.dta"

*2. Uji untuk melihat apakah terdapat manipulasi pada data? 
rddensity victory
rddensity victory, all

*3. Tunjukkan hasil estimasi dari RD!
rdplot femaleHS victory

*4. Gunakan metode CCT untuk mengimplementasikan berbagai seleksi bandwidth.
rdbwselect femaleHS victory, bwselect(CCT) 
local bw e(h_CCT)
rd femaleHS victory, bw(`bw')

*5. Uji sensitivitas untuk melihat apakah estimasi RD dapat diterapkan atau tidak
rdrobust femaleHS victory, p(2)

************************* PSM *************************
* 1. Bersihkan data dan gunakan data `review10'
use "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data\review10.dta", clear

*2. variabel homeless sebagai treated dan variabel physical condition score (pcs) sebagai outcomenya, lakukan `ttest'
ttest pcs, by(homeless)

* bagaimana pengaruh treatment yang diberikan kepada tunawisma terhadap kondisi fisik mereka

*3. regresi model logit dengan variabel tunawisma sebagai variabel dependen dan umur, mental condition score (mcs), female, dan drinking status (drinkstatus)
logit homeless age mcs female drinkstatus
estat class

*4.
pscore homeless age mcs female drinkstatus, pscore(score) comsup

*5. estimasikan pengaruh dari program terhadap treatment group dengan menggunakan pendekatan Nearest Neighboor
attnd pcs homeless age mcs female drinkstatus, pscore(score)
desc

//melihat t-tabel
count
scalar tcrit=invttail(453,0.025)
display tcrit
//melihat t-tabel
scalar tcrit=invttail(453,0.05)
display tcrit

*6. Bagaimana pengaruh program yang diberikan kepada tunawisma terhadap kondisi fisik mereka?
psmatch2 homeless age mcs female drinkstatus, out(pcs) common logit

*7. 
psgraph

log close













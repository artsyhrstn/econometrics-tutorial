* Nama : Hisbi Asyihristani R
* NPM : 120610210018
* Jadwal Prak : Kamis Sore
* TA Praktikum : Teh Hana
* Dosen Pengantar Ekonometrika : Pak Ferry (B)


cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"

log using "$log/Review_Hisbi"

use "$data/absensi.dta"

* jumlah observasi
describe

* range IP
sum termgpa
sum priGPA
di 3.93-0.857

gen selisihgpa=termgpa-priGPA

* freshman / pertama
tab frosh

* Sophomore / kedua
tab soph

* freshman tidak mengikuti kelas lebih dari 10 pertemuan
sum frosh if skipped > 10

* mengestimasi apakah IPK, persentase kehadiran, dan hasil tes ACT mempengaruhi IP semester tsb
reg termgpa priGPA atndrte ACT

* Menguji Heterosketastisitas
hettest
imtest, white

*2
* menambahkan variabel independen
reg termgpa priGPA atndrte ACT final frosh 

* menguji multikol
vif

* model yang baik
* dilihat dari r2 dan tidak adanya masalah multikol

*3 
use "$data/raw_timeseries.dta", clear

* set dalam satu bulan
tsset ym, monthly

* ts line
tsline urate vrate

* mengandung unit root
dfuller urate
dfuller vrate

* melakukan turunan pertama untuk mengatasi masalah stasioner
dfuller d.urate
dfuller d.vrate

* tes grafik pada turunan pertama
tsline curate cvrate

* estimasi model regresi 
reg urate vrate
bgodfrey

 bgodfrey

* 4
use "$data/raw_panel.dta", clear
xtset nr, year

* reshape
help reshape
reshape long lwage educ exper expersq married black union, i(nr) j(time)

* b
scatter lwage exper 

* c, membuang -2
* membuang dengan mencari manual nilai minimal
sum lwage
* angka paling rendah berada di angka  -3.579079 yang terpantau sebagai outlier di variabel lwage
drop 
* d 











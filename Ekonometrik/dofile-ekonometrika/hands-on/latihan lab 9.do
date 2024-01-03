* Latihan Lab 9
* Hisbi Asyihristani R
* 120610210018
* POOLED CROSS SECTION DAN PANEL
* 1.	Pasang Log dan buka do file editor dalam STATA dan input data Real Estate Investment (canada.dta) di Kanada !  
cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"
//Makro direktori
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
// Buat log file
log using "$log/latihanlab9"
use "$data/traffic1.dta"

br
* 1
* Variabel state menjadi variabel identifier

* 3
* Menggunakan data rental.dta
use "$data/rental.dta", clear
br
* var ind = pop, enroll, rent

/// ANALISIS

* 5 estimasi var y90 
reg lrent y90 lavginc pctstu

di 100*[exp(.2622267)-1]
//29.982118

* 6 Interpretasi lpop dan lavginc
// LPOP : setiap kenaikan pada populasi sebesar 1% akan meningkatkan tingkat harga sewa rata-rata sebesar 0.004%, karena log log, apabila rata-rata income, persentase mahasiswa dibandingkan populasi kota smeuanya pada tahun 1990 (ceteris paribus)

// LAVGINC : Kenaikan pada tingkat rata2 pendapatan sebesar 1% akan meningkatkan tingkat rata-rata harga sewa sebesar 0.57%, ceteris paribus

* 7 Estimasi first difference
br
help reshape
reshape wide rent

keep lrent lavginc lpop pctstu city year
reshape wide lrent lavginc lpop pctstu, i(city) j (year)

//first difference = selisih
//buat variabel first difference
gen dlrent=lrent90-lrent80
gen dlpop=lpop90-lpop80
gen dlavginc=lavginc90-lavginc80
gen dpctstu=pctstu90-pctstu80

// regresi first difference
reg dlrent dlpop dlavginc dpctstu

*8 interpretasi dpctstu

// kenaikan pada perbandingan jumlah mahasiswa dengan populasi (pctstu) sebesar 1% akan meningkatkan harga sewa rata-rata sebesar 1.12%, ceteris paribus.

* 9 Buka ulang data rental
use "$data/rental.dta", clear

* 10 Set data panel 
xtset city year

*11 Estimasi model sama dengan fixed effect, simpan hasil estimasi
xtreg lrent lpop lavginc pctstu, fe
estimates store fe

* 12 Estimasi random effect, simpan hasil estimasi
xtreg lrent lpop lavginc pctstu, re
estimates store re

* 13 Uji Hausman
hausman fe re
// prob > chi2 < alpha (0.---<0.05)
* lebih baik menggunakan fix daripada random effext

* 14
log close

















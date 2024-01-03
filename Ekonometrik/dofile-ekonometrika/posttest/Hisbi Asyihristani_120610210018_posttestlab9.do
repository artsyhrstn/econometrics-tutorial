* Nama : Hisbi Asyihristani
* NPM : 120610210018
* POST TEST LAB 9

* 1.	Pasang Log dan buka do file editor dalam STATA dan input data Real Estate Investment (canada.dta) di Kanada !  
cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"
//Makro direktori
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
// Buat log file
log using "$log/Hisbi_posttestlab9"

// POOLED CROSS SECTION

* 1 Gunakan data sleep75_81
use "$data/sleep75_81.dta"

* 2 Estimasi pengaruh total jam kerja, status pernikahan, kondisi kesehatan, lama pendidikan, dan variabel dummy waktu (d81) terhadap jam tidur malam seseorang

reg slpnap totwrk marr gdhlth educ d81

* 3 Interpretasi variabel d81 dan totwrk

// PANEL DATA ANALYSIS

* 4 Gunakan data crime3.dta (5%)
use "$data/crime3.dta", clear

* 5 Set Panel Data dengan "id_city" sebagai number of observations, dan "year" sebagai subscript waktu 
xtset id_city year

* 6 Estimasikan persamaan diatas dengan mengasumsi bahwa unobserved effect memiliki hubungan fungsional dengan variabel independen. 
xtreg crmrte d87 unem offarea pcinc, fe

// fe = fixed effect
// re = random effect

* 7 Interpretasi variabel d87
// Pada tingkat unem offarea pcinc yang sama, rata rata crime akan mengalami peningkatan crime dalam rasio 1000 individu rata-rata sebesar 38.64543 kasus dalam tahun '82 hingga `87, ceteris paribus.

* 8 estimasi ulang, first difference
keep crmrte unem offarea pcinc id_city year
reshape wide crmrte unem offarea pcinc, i(id_city) j(year)
gen dcrmrte=crmrte87-crmrte82
gen dunem=unem87-unem82
gen doffarea=offarea87-offarea82
gen dpcinc=pcinc87-pcinc82
reg dcrmrte dunem doffarea dpcinc

* 9 interpretasi unemployment rate, first difference
// Saat terjadi peningkatan tingkat pengangguran sebesar 1 persentase poin maka akan menyebabkan peningkatan dalam rata rata crime dalam dalam rasio 100 orang sebesar 2.9 crime, ceteris paribus.

* 10 Tutup
log close



























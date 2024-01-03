* Hisbi Asyihristani Rijal
* 120610210018

* 1. Buatlah macro directory dan log file! (0%)
clear
cd "C:\Users\hisbi\iCloudDrive\"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
log using "$log\Hisbi_120610210018_logfile"

* 2. Gunakan data insurance.dta! (5%)
use "$data/insurance.dta", replace

*** [Multinomial Logit Model]
* 3. Berapakah jumlah observasi dan variabel dari data tersebut? (5%) 
desc
* Jumlah observasi = 644
* Jumlah variabel = 13

* 4. Berapa jumlah observasi pada data untuk setiap outcomes pada variabel insure? (10%)
tab insure
* Outcomes (Indemnity, Prepaid, Uninsure(3, 616))
* Indemnity = 294
* Prepaid = 277
* Uninsure = 45

* 5. Lakukan estimasi multinomial logit dengan uninsurance sebagai base outcome yang dipengaruhi oleh umur (age), jenis kelamin pasien (male), dan ras (nonwhite)! Kemudian, interpretasikan pengaruh (marginal effect) ras dan jenis kelamin pasien pada outcome *indemnity* untuk variabel *insure*! (35%)
global y insure
global x age male nonwhite
mlogit $y $x, baseoutcome(3)

mfx, predict(pr outcome(1))
mfx, predict(pr outcome(2))
mfx, predict(pr outcome(3))

* Pengaruh Jenis Kelamin
*** Apabila terdapat 2 karakteristik yang sama namun salah satu individu adalah male sedangkan yang lain tidak maka kemungkinan individu tersebut akan memilih jalan pengasuransian indemnity(ganti rugi) akan menurun sebesar -16.74%, ceteris paribus

* Pengaruh Ras
*** Apabila terdapat 2 karakteristik yang sama namun salah satu individu adalah nonwhite(black) sedangkan yang lain tidak maka kemungkinan individu tersebut akan memilih jalan pengasuransian indemnity(ganti rugi) akan menurun sebesar -13.83%, ceteris paribus

*** [Ordered Probit Model]

*6. Gunakan data repair.dta! (5%)
use "$data/repair.dta", clear

*7. Berapa jumlah observasi pada data untuk setiap outcomes untuk variabel rep78? (10%)
tab rep78

*Jumlah Observasi
* Poor = 2
* Fair = 8 
* Average = 30
* Good = 18
* Excellent = 11
* Total = 69

*8. Lakukan estimasi ordered probit model untuk variabel rep78 yang dipengaruhi oleh variabel jarak tempuh (mpg) dan harga (price), lalu interpretasikan variabel jarak tempuh untuk outcome average dan excellent! (30%)
global y rep78
global x mpg price

oprobit $y $x
mfx, predict (pr outcome(1))
mfx, predict (pr outcome(2))
mfx, predict (pr outcome(3))
mfx, predict (pr outcome(4))
mfx, predict (pr outcome(5))

* Interpretasi
** \\ MPG
** Average (3)
mfx, predict (pr outcome(3))
* Setiap kenaikan jarak tempuh sebesar 1 Mileage, maka probabilitas Repair record berada pada tingkat rata-rata (average) akan menurun sebesar -1.847 percentage point, ceteris paribus

** Excellent (5)
mfx, predict (pr outcome(5))
* Setiap kenaikan jarak tempuh sebesar 1 Mileage, maka probabilitas Repair record berada pada tingkat bagus sekali (excellent) akan meningkat sebesar 2.045 percentage point, ceteris paribus

log close


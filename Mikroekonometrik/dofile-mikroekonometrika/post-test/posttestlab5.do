* POST TEST LAB 5
* HISBI ASYIHRISTANI R
* 120610210018

* alcohol.dta mencakup informasi mengenai pasar tenaga kerja dengan jumlah observasi sebanyak 9.822 pria. Data ini mencakup informasi kecanduan alkohol dan variabel demografi individu. Dalam pengerjaan posttest ini, Anda diminta untuk menganalisis abuse terhadap employ, yang merupakan variabel dummy dimana 1 adalah pria yang memiliki pekerjaan dan 0 adalah pria yang menganggur atau tidak bekerja.

clear
cd "C:\Users\hisbi\iCloudDrive\"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
log using "$log\Hisbi Asyihristani_120610210018_logFiles5"
use "$data/alcohol"

* 1. Lakukan regresi menggunakan metode LPM untuk melihat pengaruh kecanduan alkohol terhadap pekerjaan, interpretasikan hasil regresi yang didapatkan, selanjutnya kesimpulan apa yang bisa ditarik dari hubungan 2 variabel tersebut? Jangan lupa tampilkan hasil regresi menggunakan formal report dengan memasukkan juga hasil heteroskedasticity-robust standard errors.

br
reg employ abuse
reg employ abuse, robust
outreg2 using abuse2.doc
help robust

reg employ abuse, robust
outreg2 using employ.doc, append
* Interpretasi
* Terdapat hubungan yang negatif antara abuse (kecanduan alkohol) dengan employ (bekerja). Hal ini juga dibuktikan oleh beberapa penelitian bahwa seseorang yang memiliki kecanduan alkohol yang parah dapat mengganggu Kesehatan, kesejahteraan, dan hubungan dengan lingkungan

* 2. Lakukan regresi model probit untuk melihat pengaruh kecanduan alkohol terhadap pekerjaan, apakah variabel kecanduan alkohol signifikan secara statistik dan memiliki tanda yang sama dengan hasil regresi nomor 1?

probit employ abuse
mfx

* Interpretasi
* Jika terdapat 2 laki-laki dengan karakteristik yang sama, apabila individu yang satu memiliki kecanduan terhadap alkohol, maka ia akan memiliki probabilitas untuk bekerja lebih kecil sebesar rata-rata 2,83 percentage point dibandingkan dengan laki-laki yang tidak memiliki kecanduan terhadap alkohol.

* 3. Dengan menggunakan metode LPM, lakukan regresi abuse, age, agesq, educ, educsq, married, famsize, white, northeast, midwest, south, centcity, outercity, qrt1, qrt2, dan qrt3 terhadap employ. Apakah yang terjadi dengan koefisien abuse dan apakah masih signifikan? Bandingkan hasil yang didapatkan dengan menggunakan model logit dan probit.

* Regresi
reg employ abuse age agesq educ educsq married famsize white northeast midwest south centcity outercity qrt1 qrt2 qrt3

* Logit
logit employ abuse age agesq educ educsq married famsize white northeast midwest south centcity outercity qrt1 qrt2 qrt3
mfx

* Probit
probit employ abuse age agesq educ educsq married famsize white northeast midwest south centcity outercity qrt1 qrt2 qrt3
mfx
log close

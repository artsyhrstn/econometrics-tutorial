* Post Test Lab 10
* Hisbi Asyihirstani R
clear
cd "C:\Users\ThinkPad\iCloudDrive\"
global log "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data"
log using "$log\Hisbi_PostTest_10"

use "$data/hh_9198", clear

* 1. 
desc
gen exptot0=exptot if year==0
egen exptot91=max(exptot0), by(nh)

br exptot exptot0 exptot91 year

tab year

* Reshaping
keep if year==1
br

gen lexptot91=ln(1+exptot91)
gen lexptot98=ln(1+exptot)

gen lexptot9891=lexptot98-lexptot91

*b. 
tab dmmfd
br dmmfd lexptot9891

* Lihat estimate impact dari partisipasi perempuan dalam program terhadap exptot
ttest lexptot9891, by(dmmfd)
* Interpretasi . 
* diff = 0.0262587
* Jika terdapat dua laki-laki dengan karakteristik yang sama namun salah satu laki-laki berpartisipasi dalam program. maka total pengeluarannya secara rata-rata lebih kecil sebesar 2.625% daripada laki-laki yang tidak berpartisipasi dalam program
* p-value = 0.5520 (tidak signifikan)

*2. 
*a 
use "$data/hh_9198", clear
* Membuat variabel income
gen lexptot=ln(1+exptot)

gen dmmfd1=dmmfd==1 & year==1
tab dmmfd1
egen dmmfd98=max (dmmfd1), by(nh)
br dmmfd dmmfd1 dmmfd98 nh year

*b
*membuat variabel interaksi  
gen dmmfdyr =dmmfd98*year
br lexptot year dmmfd98 dmmfdyr nh year

*c
reg lexptot year dmmfd98 dmmfdyr
* Interpretasi (dmmfdyr) :
* p-value = 0.633 (tidak signifikan dalam a = 0.10)
* Jika terdapat 2 individu dengan karakteristik yang sama, apabila individu tersebut adalah laki laki yang berpartisipasi dalam program, maka secara rata-rata pengeluarannya lebih besar 2.625 % dibandingkan dengan wanita yang tidak berpartisipasi dalam program

*d
gen lnland=ln(1+hhland)
reg lexptot year dmmfd98 dmmfdyr nh sexhead agehead educhead lnland hhasset vaccess pcirr rice wheat milk oil potato egg [pw=weight]

* Interpretasi = dmmfdyr
* P-value = 0.537 (tidak signifikan dalam a = 0.10)
* Tidak signifikan, variabel dmmfdyr (impact) menjadi tidak signifikan terhadap lexptot

* 3.
*a. 
* Cara 1
xtset nh year
xtreg lexptot year dmmfd98, fe

* Cara 2
xtreg lexptot year dmmfd98 dmmfdyr, fe i (nh)
* p-value dmmfdyr = 0.552
* (dmmfdyr tidak signifikan dalam a = 0.10)

*b.
xtreg lexptot year dmmfdyr sexhead agehead educhead lnland hhasset vaccess pcirr rice wheat milk oil potato egg, fe
* setelah kita mengontrol estimasi menggunakan metode fe, var dmmfdyr tidak signifikan dalam a=0.10 p value sebesar 0.930

* 4.
*a.
use "$data\hh_98", clear
desc
br vill dmmfd 
egen villmmf=max(dmmfd), by(vill)
gen mchoice=villmmf==1 & hhland<50

*b. 
gen lnland=ln(1+hhland)
gen lexptot=ln(1+exptot)
for var agehead-educhead lnland vaccess pcirr rice-oil: gen mchX=mchoice*X
ivreg lexptot agehead-educhead lnland vaccess pcirr rice-oil (dmmfd= agehead-educhead lnland vaccess pcirr rice-oil mch*), first

*Output menunjukkan hasil first-stage dan kemudian hasil second-stage. Berdasarkan output tahap pertama, pendidikan kepala rumah tangga dan aset tanah rumah tangga berpengaruh negatif terhadap partisipasi program kredit mikro; berbeda dengan instrumennya. Hasil second-stage menunjukkan bahwa setelah mengontrol endogeneity partisipasi program, partisipasi laki laki dalam program kredit mikro memiliki dampak yang signifikan (p-value < a, 0.005 < 0.05).

*c
ivendog
*Beberapa tes dapat digunakan untuk menentukan apakah kuadrat terkecil biasa (OLS) atau IV adalah lebih tepat. Stata memiliki perintah "ivendog" yang melakukan uji F dan uji chi-square mengikuti metodologi yang disebut uji Wu-Hausman dan uji Durbin-Wu-Hausman. Hipotesis nolnya adalah bahwa OLS konsisten (dalam hal ini, ini menyiratkan bahwa treatment bersifat eksogen). Jika hipotesis nol tidak ditolak, OLS sudah cukup; jika tidak, metode IV harus digunakan. Hasil penelitian menunjukkan bahwa hipotesis nol ditolak, yang menyiratkan bahwa model IV lebih baik daripada OLS.
 
/*P-Value < 0.05 : Lebih baik menggunakan IV
P-Value > 0.05 : Lebih baik meggunakan OLS*/
* Chi-Square 0.00073
*Maka, 0.00073 < 0.05 : Lebih baik menggunakan IV

*d. 
use "$data\hh_9198", clear
gen lnland=ln(1+hhland)
gen lexptot=ln(1+exptot)
egen villmmf=max(dmmfd), by(vill)
gen mchoice=villmmf==1 & hhland<50
for var agehead-educhead lnland vaccess pcirr rice-oil: gen mchX=mchoice*X

xtivreg lexptot year agehead-educhead lnland vaccess pcirr rice-oil (dmmfd= agehead-educhead lnland vaccess pcirr rice-oil mch*), fe i(nh)

*Dari hasil yang didapatkan, maka lebih baik menggunakan data cross section, dibandingkan data panel

log close








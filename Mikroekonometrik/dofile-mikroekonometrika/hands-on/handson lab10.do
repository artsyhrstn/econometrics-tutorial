clear
cd "C:\Users\ThinkPad\iCloudDrive\"
global log "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data"
log using "$log\handson_10"

use "$data/hh_9198", clear

*1. Simplest Implementation: Simple Comparison Using "ttest"
desc

*membuat var expenditure total ketika tahun 1991
gen exptot0=exptot if year==0
br exptot exptot0 exptot91 year

*membuat var exptot tahun 1991
egen exptot91=max(exptot0), by(nh)
*egen = 

tab year

* reshaping
keep if year==1
br

*membuat variabel logaritma exptot91 dan exptot98
gen lexptot91=ln(1+exptot91)
gen lexptot98=ln(1+exptot)

*differencing before after (pertama)
gen lexptot9891=lexptot98-lexptot91

*b
tab dfmfd
br dfmfd lexptot9891
* Lihat estimate impact dari partisipasi perempuan dalam program terhadap exptot
ttest lexptot9891, by(dfmfd)
* stata 0 dikurangi dengan 1 
*p-value = 0.0023 = signigikan
* interpretadi dfmdf:
* Jika terdapat dua perempuan dengan karakteristik yang sama namun salah satu perempuan berpartisipasi dalam program. maka total pengeluarannya secara rata-rata lebih besar sebesar 11.13% daripada perempuan yang tidak berpartisipasi dalam program

*2. Regression Implementation
use "$data/hh_9198", clear
* buat var income
gen lexptot=ln(1+exptot)

gen dfmfd1=dfmfd==1 & year==1
tab dfmfd1
egen dfmfd98=max (dfmfd1), by(nh)
br dfmfd dfmfd1 dfmfd98 nh year

*b
*membuat variabel interaksi  
gen dfmfdyr =dfmfd98*year
br lexptot year dfmfd98 dfmfdyr nh year

*c
reg lexptot year dfmfd98 dfmfdyr
* Interpretasi (dfmfdyr) :
* Jika terdapat 2 individu dengan karakteristik yang sama, apabila individu tersebut adalah wanita yang berpartisipas dalam program, maka secara rata-rata pengeluarannya lebih besar 11.13% dibandingkan dengan wanita yang tidak berpartisipasi dalam program

*d
gen lnland=ln(1+hhland)
reg lexptot year dfmfd98 dfmfdyr nh sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]
*Interpretasi = dfmfdyr
* Tidak signifikan, variabel dfmfdyr (impact) menjadi tidak signifikan terhadap lexptot

*3. Robustness of DD with Fixed eddects regressions
*a. 
xtset nh year

*a
xtreg lexptot year dfmfd98, fe

*b
* a.
xtreg lexptot year dfmfd98 dfmfdyr, fe i (nh)
*variabel dfmfdyr signifikan, dengan p value sebesat 0.002

* b. 
xtreg lexptot year dfmfdyr sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg, fe
* setelah kita mengontrol estimasi menggunakan metode fe, var dfmfdyr memiliki pengaruh positif signifikan dengan p value sebesar 0.15

*4. Instrumental Variabel
use "$data\hh_98", clear
desc
br vill dfmfd 
egen villfmf=max(dfmfd), by(vill)
gen fchoice=villfmf==1 & hhland<50

***4b
gen lnland=ln(1+hhland)
gen lexptot=ln(1+exptot)
for var agehead-educhead lnland vaccess pcirr rice-oil: gen fchX=fchoice*X
ivreg lexptot agehead-educhead lnland vaccess pcirr rice-oil (dfmfd= agehead-educhead lnland vaccess pcirr rice-oil fch*), first
 
*Output menunjukkan hasil first-stage dan kemudian hasil second-stage. Berdasarkan output tahap pertama, pendidikan kepala rumah tangga dan aset tanah rumah tangga berpengaruh negatif terhadap partisipasi program kredit mikro; begitu juga instrumennya. Hasil second-stage menunjukkan bahwa setelah mengontrol endogeneity partisipasi program, partisipasi perempuan dalam program kredit mikro memiliki dampak yang signifikan.

***4c
ssc install ivendog
ivendog

*Beberapa tes dapat digunakan untuk menentukan apakah kuadrat terkecil biasa (OLS) atau IV adalah lebih tepat. Stata memiliki perintah "ivendog" yang melakukan uji F dan uji chi-square mengikuti metodologi yang disebut uji Wu-Hausman dan uji Durbin-Wu-Hausman. Hipotesis nolnya adalah bahwa OLS konsisten (dalam hal ini, ini menyiratkan bahwa treatment bersifat eksogen). Jika hipotesis nol tidak ditolak, OLS sudah cukup; jika tidak, metode IV harus digunakan. Hasil penelitian menunjukkan bahwa hipotesis nol ditolak, yang menyiratkan bahwa model IV lebih baik daripada OLS.
 
/*P-Value < 0.05 : Lebih baik menggunakan IV
P-Value > 0.05 : Lebih baik meggunakan OLS*/
Chi-Square 0.01705
*Maka, 0.01705 < 0.05 : Lebih baik menggunakan IV


***4d
use "$data\hh_9198", clear
gen lnland=ln(1+hhland)
gen lexptot=ln(1+exptot)
egen villfmf=max(dfmfd), by(vill)
gen fchoice=villfmf==1 & hhland<50
for var agehead-educhead lnland vaccess pcirr rice-oil: gen fchX=fchoice*X

xtivreg lexptot year agehead-educhead lnland vaccess pcirr rice-oil (dfmfd= agehead-educhead lnland vaccess pcirr rice-oil fch*), fe i(nh)

 
*Dari hasil yang didapatkan, maka lebih baik menggunakan data cross section, dibandingkan data panel

log close








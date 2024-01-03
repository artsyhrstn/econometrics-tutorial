
* 1. 
use $data/tugas_akhir.dta, clear
describe

tabstat IQ, by(educ)
tabstat IQ, by(married)

di

* mempengaruhi upah
gen agesq=age^2
// kenapa harus dikuadratkan?
reg wage IQ educ exper tenure age married

// Jika terdapat 2 individu dengan karakteristik yang sama dan variabel lain dianggap konstan. jika salah satunya memiliki IQ lebih tinggi 1 satuan, maka akan meningkatkan rata-rata upah bulanan sebesar 5.14061 $? dibandingkan dengan individu lainnya

* p-value < alpha = signifikan, H0 ditolak
* pada tingkat 5% variabel IQ berpengaruh signifikan terhadap upah.

// Variabel signifikan dengan alpha = 0.01
// iq, educ, exper, married

vif
* Mean vif 1.44 
* 1.44 < 5
* Jika vif lebih besar dari 5 maka tidak ada masalah multikolineartas

*2. 
outreg2 using "$output\tugas_akhir1.doc"
gen agesq=age^2

* cek outlier
graph box wage

gen lwage=log(wage) //kenapa harus dilog kan?
reg lwage IQ educ exper tenure age agesq married urban
* hapus outlier

* hetero
* breusch-pagan (fungsional yang linear) & white test (fungsional yang kuadratik) antara error term dan variabel independen

imtest, white //whitetest fungsional kuadratik
56.54 
p value > alpha = tidak terdapat masalah heteroskedastisitas // H0 tidak dapat ditolak

* membandingkan model dengan menggunakan R2
18.7 menjadi 23.71
// regresi kedua lebih baik karena dapat menjelaskan model sebesar 23.71%

outreg2 using "$output\tugas_akhir2.doc"

3. 
use $data/tugas_magang1.dta, clear

tsset year, yearly

*p value > alpha h0 ditolak
// h0 : tidak stasioner (mengandung unit root)

*p value > alpha h0 ditolak
// ha : stasioner (tidak mengangung unit root)
dfuller linv

reg linv lpop lprice
estat bgodfrey //untuk cek masalah autokorelasi pada model

reg d.linv lpop d.price
estat bgodfrey // masalah autokorelasi
// chi square harus lebih besar dari alpha agar tidak terdapat masalah autokorelasi

4. 
// jika hanya ingin menggunakan tahun tertentu saja
CARA PERTAMA
keep if year==90 | year == 80
gen y90 = (year==90)
drop y90
*CARA KEDUA
gen y90=1 if year==90
tab y90,m
replace y90=0 if year == 80
drop if y90==.









































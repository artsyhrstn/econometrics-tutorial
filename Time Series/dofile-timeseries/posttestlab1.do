* Post Test Lab 1
* TOPIK PRAKTIKUM 1 : TIME SERIES DAN AUTOKOLERASI  
* DATA : us_employ.dta
* Hisbi Asyihristani Rijal
* 120610210018

* 1. Pindahkan working directory, buat macro directory, dan pasang log sebelum pengerjaan  praktikum dimulai, lalu buka data Rasio Pekerja di Amerika Serikat (us_employ.dta)!  (0%) 
cd "C:\Stata_Hisbi"
global log "C:\Stata_Hisbi\0 Time Series\log-file"
global output "C:\Stata_Hisbi\output"
global data "C:\Stata_Hisbi\data\time-series"
use "C:\Stata_Hisbi\data\time-series\us_employ.dta"
log using "$log\hisbi_posttestlab1"

* Buka data
use "C:\Stata_Hisbi\data\time-series\us_employ.dta"

* 2. Set waktu yang menandakan data time series! (0%)  
br
desc
tsset year, yearly

* 3. Buatlah variabel logaritma dari variabel Rasio Pekerja di Amerika Serikat, GNP di  Amerika Serikat, pengangguran di Amerika Serikat, dan minimum coverage!(10%)  
gen lusepop=ln(usepop)
gen lusgnp=ln(usgnp)
gen lusunemp=ln(usunemp)
gen lmincov=ln(mincov)

*4. Lakukan uji stasioneritas untuk variabel Rasio Pekerja di Amerika Serikat, GNP di  Amerika Serikat, pengangguran di Amerika Serikat, dan minimum coverage dengan  menggunakan Augmented Dickey-Fuller Test dan tuliskan hipotesis uji tersebut pada  tingkat signifikansi 5%!(20%)
tsline lusepop lusgnp lusunemp lmincov  
* grafik menunjukkan belum adanya stasioneritas, maka dicoba pada tingkat turunan pertama
tsline d.lusepop d.lusgnp d.lusunemp d.lmincov

* Uji Stasioneritas Augmented Dickey-Fuller Test
dfuller lusepop
dfuller lusgnp 
dfuller lusunemp
dfuller lmincov
* Hanya variabel lusgnp yang stasioner

dfuller d.lusepop
dfuller d.lusgnp 
dfuller d.lusunemp
dfuller d.lmincov
* Keempat variabel sudah stationer karena p-value lebih kecil daripada alpha 0.05

* HIPOTESIS
* Ho: Variabel Rasio Pekerja di AS, GNP di AS, Pengangguran di AS, dan Minimum Coverage Tidak Stasioner (Mengandung Unit Root)
* Ha: Variabel Rasio Pekerja di AS, GNP di AS, Pengangguran di AS, dan Minimum Coverage Stasioner (Tidak Mengandung Unit Root)
* Kriteria
* P. Value < α: Ho ditolak
* P. Value > α: Ho tidak dapat ditolak
* Hasil
* - Dengan tingkat signifikansi 5%, dapat disimpulkan bahwa variabel Rasio Pekerja di AS sudah stasioner di tingkat turunan pertama 
* - Dengan tingkat signifikansi 5%, dapat disimpulkan bahwa variabel GNP di AS sudah stasioner di tingkat level
* - Dengan tingkat signifikansi 5%, dapat disimpulkan bahwa variabel Pengangguran di AS sudah stasioner di tingkat turunan pertama 
* - Dengan tingkat signifikansi 5%, dapat disimpulkan bahwa variabel Minimum Coverage di AS sudah stasioner di tingkat turunan pertama

*5. Lakukan regresi pengaruh GNP di Amerika Serikat, pengangguran di Amerika Serikat,  minimum coverage, dan waktu terhadap Rasio Pekerja di Amerika Serikat! Tuliskan  juga formal reportnya! (20%)
reg lusepop lusgnp lusunemp lmincov year

*6. Interpretasikan hasil variabel GNP di Amerika Serikat, pengangguran di Amerika  Serikat, dan minimum coverage, year, dan R2! (10%)

* Interpretasi
* Konstanta: tanpa ada pengaruh apapun dari variabel lain, setiap tahun, nilai dari lusepop atau Rasio Pekerja di AS menurun sebesar 22.63% 

* lusgnp: model ini memprediksi bahwa setiap peningkatan dari GNP di AS sebesar 1% di setiap tahunnya, maka akan menambah Rasio Pekerja di AS sebesar 0.31%, ceteris paribus

* lusunemp: model ini memprediksi bahwa setiap peningkatan dari Pengangguran di AS sebesar 1% di setiap tahunnya, maka akan menurunkan Rasio Pekerja di AS sebesar 0.072%, ceteris paribus

* lmincov: model ini memprediksi bahwa setiap peningkatan dari Minimum Coverage di AS sebesar 1% di setiap tahunnya, maka akan menurunkan Rasio Pekerja di AS sebesar 0.194%, ceteris paribus

* year: setiap penambahan 1 tahun, maka akan menurunkan Rasio Pekerja di AS sebesar 0.01% ceteris paribus

* r-square: variasi dari variabel lusgnp lusunemp lmincov year mampu menjelaskan variabel lusepop sebesar 88.69% dan sisanya sebesar 11.39% di luar model

* 7. Apakah di dalam model terdapat masalah autokorelasi? Lakukan pengujian  menggunakan Durbin-Watson Test dan Breusch Godfrey Test dengan signifikansi 5%  untuk membuktikannya! (20%)  
DW Test
estat dwatson
alpha: 0.05
k: 5
n: 38
dl: 1.2042 
du: 1.7916
4-dl: 2.7958
4-du: 2.2084
dw: 0.7691063
dw berada di daerah autokorelasi positif
Dengan signifikansi 5%, dapat disimpulkan terdapat masalah autokorelasi positif di dalam model dengan seluruh variabel di tingkat level 

BP Test
estat bgodfrey
prob > chi2: 0.0006
alpha: 0.05
prob > chi2 < alpha
Hipotesis
Ho: di dalam model tidak terdapat masalah otokorelasi
Ha: di dalam model terdapat masalah otokorelasi
Kriteria
Nilai probabilitas χ2 < α (H0 ditolak)
Nilai probabilitas χ2 > α (H0 tidak dapat ditolak)
Kesimpulan
Dengan signifikansi 5% dapat disimpulkan terdapat masalah autokorelasi di dalam model dengan seluruh variabel di tingkat level 

* 8. Jika terdapat masalah autokorelasi, lakukan perbaikan untuk model menggunakan  metode transformasi model turunan pertama dan penambahan waktu! Tuliskan pengujian hipotesis dan hasil pengujian autokolerasi pada model tersebut menggunakan  Durbin  Watson Test dan Breusch Godfrey Test! (20%)
reg d.lusepop d.lusgnp d.lusunemp d.lmincov year

DW Test
estat dwatson
alpha: 0.05
k: 5
n: 37
dl: 1.1901 
du: 1.7950 
4-dl: 2.8099
4-du: 2.205
dw: 2.024662
dw berada di daerah tidak ada autokorelasi
Dengan signifikansi 5%, dapat disimpulkan tidak terdapat masalah autokorelasi positif di dalam model dengan seluruh variabel di tingkat level 

BP Test
estat bgodfrey 
prob > chi2: 0.8830
alpha: 0.05
prob > chi2 > alpha
Hipotesis
Ho: di dalam model tidak terdapat masalah otokorelasi
Ha: di dalam model terdapat masalah otokorelasi
Kriteria
Nilai probabilitas χ2 < α (H0 ditolak)
Nilai probabilitas χ2 > α (H0 tidak dapat ditolak)
Kesimpulan
Dengan signifikansi 5%, dapat disimpulkan tidak terdapat masalah autokorelasi di dalam model dengan seluruh variabel di tingkat level




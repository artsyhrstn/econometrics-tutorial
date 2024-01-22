* Post Test Lab 3

*1. Buatlah logfile sebelum memulai project STATA-mu! (0%).
cd "C:\Users\ThinkPad\iCloudDrive\"
global log "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\output\ts"
global data "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data\ts"

*2. Masukkan data m1 yang sudah didownload, set waktu time-seriesnya dari kuartal 1 tahun 1980! (5%).
use "C:\Users\ThinkPad\iCloudDrive\Stata_Hisbi\data\ts\m1.dta"
gen quarter=tq(1980q1)+_n-1
format quarter %tq
tsset quarter, quarterly
br

*3. Lakukan uji stasioneritas pada variabel m1 dengan tingkat signifikansi 5% (5%).
tsline m1
* Belum stationer dalam bentuk grafiknya
* ADF Test
* Hipotesis
* Ho : Variabel m1 tidak stasioner
* Ha : Variabel m1 stasioner
* Kriteria 
* P value > α = Ho tidak dapat ditolak
* P value > α = Ho ditolak
* dfuller m1
* p-value for Z(t) = 0.9991
* Hasil
* 0.9991 > 0.05
* Dengan tingkat signfikansi 5%, variabel m1 belum stasioner di tingkat level
* dfuller d.m1
* p-value for Z(t) = 0.0000
* Hasil
* 0.0000 < 0.05
* Dengan tingkat signfikansi 5%, variabel m1 sudah stasioner di tingkat turunan pertama
tsline d.m1

*4.	Lakukan pengecekan dengan correlogram variabel m1 (mempertimbangkan asumsi stasioneritas) untuk menentukan model dan ordo yang mungkin dapat dipakai! (15%)
corrgram d.m1

* 5.	Tuliskan Hipotesis dan Uji kriteria pada uji stasioner Augmented Dickey Fuller (ADF) test terhadap residual dan Uji White Noise! (5%)
* ADF Test
* Hipotesis
* H0 : Variabel tidak stasioner (mengandung unit root)
* Ha : Variabel stasioner (tidak mengandung unit root)
* Kriteria
* P. Value < α: H0 ditolak
* P. Value > α: H0 tidak dapat ditolak

* White Noise Test
* Hipotesis
* H0 : Residu variabel white noise
* Ha : Residu variabel tidak white noise
* Kriteria
* P. Value < α: H0 ditolak
* P. Value > α: H0 tidak dapat ditolak

*6.	Lakukan regresi dari model AR, MA dan ARMA di turunan pertama. Juga coba model yang tidak menggunakan konstanta sehingga kamu punya 4 model (ex: model yang kamu estimasi pertama adalah AR sehingga model tersebut yang dijadikan pilihan tanpa konstanta sebagai model ke-4). Jangan lupa untuk melakukan uji asumsi whitenoise, uji deteksi stasioner untuk residual model, dan juga catat hasil AIC, BIC, dan LLnya (30%).
* AR(1)
arima d.m1, arima(1,0,0)nolog
predict ar1,r
dfuller ar1
* p-value for Z(t) 0.0000 < 0.05
* Dengan tingkat signfikansi 5%, variabel m1 sudah stasioner di tingkat turunan pertama
wntestq ar1
* Prob > chi2(40) 0.0295 < 0.05
* Model persamaan di tingkat turunan pertama ini belum menggambarkan keadaan data yang sebenarnya
estat ic
* BIC = 1041.295
* AIC = 1032.107
* LL = -513.0536

* MA(1)
arima d.m1, arima(0,0,1)nolog
predict ma1,r
dfuller ma1
* p-value for Z(t) 0.0000 < 0.05
* Dengan tingkat signfikansi 5%, variabel m1 sudah stasioner di tingkat turunan pertama
wntestq ma1
* Prob > chi2(40) 0.0000 < 0.05
* Model persamaan di tingkat turunan pertama ini belum menggambarkan keadaan data yang sebenarnya
estat ic
* BIC = 1090.199
* AIC = 1081.011
* LL = -537.5057

* ARMA(1)
arima d.m1,arima(1,0,1)nolog
predict arma1,r
dfuller arma1
* p-value for Z(t) 0.0000 < 0.05
* Dengan tingkat signfikansi 5%, variabel m1 sudah stasioner di tingkat turunan pertama
wntestq arma1
* Prob > chi2(40) 0.0976 > 0.05
* Model persamaan di tingkat turunan pertama ini dapat menggambarkan keadaan data yang sebenarnya
estat ic
* BIC = 1034.259
* AIC = 1022.009
* LL = -507.0043

* AR nocons
arima d.m1,arima(1,0,0)nocons nolog
predict arn1
dfuller arn1
* p-value for Z(t) 0.0001 < 0.05
* Dengan tingkat signfikansi 5%, variabel m1 sudah stasioner di tingkat turunan pertama
wntestq arn1
* Prob > chi2(40) 0.0000 < 0.05
* Model persamaan di tingkat turunan pertama ini belum menggambarkan keadaan data yang sebenarnya
estat ic
* BIC = 1043.055
* AIC = 1036.93
* LL = -516.465

*7.	Identifikasi satu model yang terbaik untuk dipergunakan memprediksi nilai m1 dari antara 4 kemungkinan model tersebut (10%).
* Model ARMA(1) sesuai kriteria AIC BIC terkecil dan LL terbesar 

*8.	Setelah mendapatkan model terbaik, lakukan prediksi 1 kuartal dan 5 kuartal kedepan (statis dan dinamis) dan gambarkan grafiknya! (20%)
tsappend, last (2020q4)tsfmt(tq)
arima d.m1, arima (1,0,1) nolog

Statis
predict x,xb
predict statis, y
tsline m1
tsline statis m1

Dinamis
predict dinamis, dynamic(tq(2019q3))y
tsline dinamis m1

*9.	Lakukan uji Theil's U Stat untuk melihat apakah model sudah bisa memprediksi dengan baik! (10%).
ssc install fcstats
fcstats m1 statis
fcstats m1 dinamis
* Theil's U = 0.55686177
* 0.55686177 < 1 
* Model peramalan ARMA(1) pada tingkat turunan  pertama di variabel m1 lebih akurat  dibandingkan peramalan naif.

log close
MA(1)
ac d.m1
AR(1)
pac d.m1
* Kemungkinan model terbaiknya adalah AR(1) dan ARMA(1)



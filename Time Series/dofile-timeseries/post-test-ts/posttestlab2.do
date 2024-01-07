* Post Test Lab 2
* Time Series

* 1. Pasang Log dan buka do file editor dalam STATA dan input data Indeks Harga Perdagangan Besar Amerika Serikat!
cd "C:\Stata_Hisbi"
global log "C:\Stata_Hisbi\econometrics-tutorial\Time Series\log-file"
global output "C:\Stata_Hisbi\output"
global data "C:\Stata_Hisbi\data\time-series"
use "C:\Stata_Hisbi\econometrics-tutorial\data\time-series\IHPB.dta"
log using "$log\hisbi_posttestlab2"

*2. Buat variabel waktu dari tahun 1990 kuartal 1 sampai tahun 2020 kuartal 4 dan gunakan variabel waktu ini sebagai set data pada Time Series (nama variabel dibebaskan)! (5%) 
gen year=tq(1990q1)+_n-1
format year %tq
tsset year, quarterly
br

*3. Tuliskan Hipotesis dan Uji kriteria pada uji stasioner Augmented Dickey Fuller (ADF) test terhadap residual dan Uji White Noise! (5%) 
//ADF
Ho: Variabel ihpb Tidak Stasioner (Mengandung Unit Root)
Ha: Variabel ihpb Stasioner (Tidak Mengandung Unit Root)
P. Value < α: Ho ditolak
P. Value > α: Ho tidak dapat ditolak
Dengan tingkat signifikansi 5%, dapat disimpulkan bahwa variabel ihbp sudah stasioner di tingkat level/turunan pertama/turunan kedua
//White Nose
Ho: residu variabel white noise
Ha: residu variabel tidak white noise
p-value < α -> Ho ditolak -> residu MA(1) tidak white noise
p-value > α -> Ho tidak dapat ditolak -> residu MA(1) white noise
Ho ditolak -> Model persamaan ... di tingkat (level/turunan pertama/turunan kedua) ini belum menggambarkan keadaan data yang sebenarnya
Ho tidak dapat ditolak -> Model persamaan ... di tingkat (level/turunan pertama/turunan kedua) ini dapat menggambarkan keadaan data yang sebenarnya

*4. Lakukan regresi menggunakan AR (1) pada variabel indeks harga di Amerika Serikat pada tingkat level dan tulis persamaan regesinya, Setelah itu, berdasarkan asumsi white noise, lakukan pengecekan stasioneritas pada residu hasil regresi di atas (tulis hasil dan kesimpulan saja) dan masukkan hasil AIC, BIC, dan LogLikelihood ke dalam tabel setelah pengecekan stasioneritas selesai! (10%)
arima ihpb, arima (1,0,0)
* persamaan regresi
predict ar1, r
dfuller ar1
* Sudah stasioner di mana p-value for Z(t)(0.0000) < (0.05) di tingkat level
wntestq ar1
* Menggambarkan data yang sebenernya di tingkat turunan pertama karena Prob > chi2(40) (1.0000) > (0.05)
estat ic
* AIC = 409.8548   
* BIC = 418.3156
* ll = -201.9274

*5. Lakukan regresi menggunakan MA (1) pada variabel indeks harga di Amerika Serikat pada tingkat level dan tulis persamaan regesinya. Setelah itu, berdasarkan asumsi white noise, lakukan pengecekan stasioneritas pada residu hasil regresi di atas (tulis hasil dan kesimpulan saja) dan masukkan hasil AIC, BIC, dan LogLikelihood ke dalam tabel setelah pengecekan stasioneritas selesai! (10%) 
arima ihpb, arima (0,0,1)
* persamaan regresi
predict ma1, r
dfuller ma1
* Belum stasioner di mana p-value for Z(t)(0.4175) > (0.05) di tingkat level
wntestq ma1
* Belum menggambarkan data yang sebenernya di tingkat turunan pertama karena Prob > chi2(40) (0.0000) < (0.05)
estat ic
* AIC = 1039.044   
* BIC = 1047.505
* ll = -516.5222

*6. Lakukan regresi menggunakan ARMA (1,1) pada variabel indeks harga di Amerika Serikat pada tingkat level dan tulis persamaan regesinya. Setelah itu, berdasarkan asumsi white noise, lakukan pengecekan stasioneritas pada residu hasil regresi di atas (tulis hasil dan kesimpulan saja) dan masukkan hasil AIC, BIC, dan LogLikelihood ke dalam tabel setelah pengecekan stasioneritas selesai! (10%) 
arima ihpb, arima(1,0,1)
* persamaan regresi
predict arma1, r
dfuller arma1
* Sudah stasioner di mana p-value for Z(t)(0.0000) < (0.05) di tingkat level
wntestq arma1
* Menggambarkan data yang sebenernya di tingkat turunan pertama karena Prob > chi2(40) (1.0000) > (0.05)
estat ic
* AIC = 353.2209      
* BIC = 364.5021
* ll = -172.6105

*7. Lakukan regresi menggunakan AR (1) pada variabel indeks harga di Amerika Serikat pada tingkat turunan pertama dan tulis persamaan regesinya. Setelah itu, berdasarkan asumsi white noise, lakukan pengecekan stasioneritas pada residu hasil regresi di atas (tulis hasil dan kesimpulan saja) dan masukkan hasil AIC, BIC, dan LogLikelihood ke dalam tabel setelah pengecekan stasioneritas selesai! (10%) 
arima ihpb, arima (1,1,0)
arima d.ihpb, arima (1,0,0)
* persamaan regresi
dfuller d.ar1
* Sudah stasioner di mana p-value for Z(t)(0.0000) < (0.05) di tingkat level
wntestq d.ar1
* Menggambarkan data yang sebenernya di tingkat turunan pertama karena Prob > chi2(40) (1.0000) > (0.05)
estat ic
* AIC = 283.807
* BIC = 292.2435
* ll = -138.9035

*8. Lakukan regresi menggunakan MA (1) pada variabel indeks harga di Amerika Serikat pada tingkat turunan pertama dan tulis persamaan regesinya. Setelah itu, berdasarkan asumsi white noise, lakukan pengecekan stasioneritas pada residu hasil regresi di atas (tulis hasil dan kesimpulan saja) dan masukkan hasil AIC, BIC, dan LogLikelihood ke dalam tabel setelah pengecekan stasioneritas selesai! (10%) 
arima ihpb, arima (0,1,1)
arima d.ihpb, arima (0,0,1)
* persamaan regresi
dfuller d.ma1
* Sudah stasioner di mana p-value for Z(t)(0.0000) < (0.05) di tingkat level
wntestq d.ma1
* Belum menggambarkan data yang sebenernya di tingkat turunan pertama karena Prob > chi2(40) (0.0000) < (0.05)
estat ic
*AIC = 307.5522
*BIC = 315.9887
*ll = -150.7761

*9. Lakukan regresi menggunakan ARIMA (1,1,1)/ ARMA (1,1) di tingkat turunan pertama pada variabel indeks harga di Amerika Serikat dan tulis persamaan regesinya. Setelah itu, berdasarkan asumsi white noise, lakukan pengecekan stasioneritas pada residu hasil regresi di atas (tulis hasil dan kesimpulan saja) dan masukkan hasil AIC, BIC, dan LogLikelihood ke dalam tabel setelah pengecekan stasioneritas selesai! (10%) 
arima ihpb, arima (1,1,1)
* persamaan regresi
dfuller d.arma1
* Sudah stasioner di mana p-value for Z(t)(0.0000) < (0.05) di tingkat level
wntestq d.arma1
* Menggambarkan data yang sebenernya di tingkat turunan pertama karena Prob > chi2(40) (1.0000) > (0.05)
estat ic
* AIC = 278.7026
* BIC = 289.9514
* ll = -135.3513

*10. Dari keenam model di atas, buat tabel perbandingan hasil AIC, BIC dan LL, model manakah yang terbaik? Tuliskan alasannya! (15%) 
* Dengan membandingkan seluruh model, yang menjadi model terbaik adalah model ARIMA (1,1,1) karena memiliki nilai AIC (278.7026) dan BIC (289.9514) dan LogLikelihood (-135.3513) terbesar.

*11. Tuliskan interpretasi dari model terbaik yang sudah ditentukan! (15%) 
* µ = Tanpa adanya perubahan pada variable-variable lain dalam model, Indeks Harga Perdagangan Besar Amerika Serikat pada tahun 1990 sampai tahun 1999 adalah rata-rata sebesar 0.7498197 per tahunnya.
* γd.ihpbt-1 = Model ini menjelaskan apabila terdapat peningkatan pada variabel Indeks Harga Perdagangan Besar di Amerika Serikat sebesar 1 satuan pada tahun sebelumnya (𝑡 − 1), maka akan menaikkan variabel harapan hidup di AS saat ini sebesar 0.8742288, ceteris paribu
* θε_(t-1)= Model ini menjelaskan apabila terdapat peningkatan pada error variable Indeks Harga Perdagangan Besar di Amerika Serikat sebesar 1 satuan pada periode sebelumnya (t-1) , maka akan menurunkan variable Y saat ini sebesar 0.4120458, ceteris paribus.

*12. Tutup log (0%)
log close
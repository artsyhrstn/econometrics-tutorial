// Lab 3 Scatter Plot, Covariance, Correlation, Fitted Value, Residual & SLR
// Hisbi Asyihristani R
// 120610210018

cd "D:\Stata_Hisbi"

global data "D:\Stata_Hisbi\data"
global log "D:\Stata_Hisbi\log"
global output "D:\Stata_Hisbi\output"

log using "$log/Hisbi_posttestlab3"

bcuse gpa1.dta

*SLR
//1. Berapa nilai rata-rata dari variabel ACT serta berapa nilai minimum dan maksimum dari variabel colGPA

sum ACT
sum colGPA

//2. Lakukan regresi sederhana dari ACT terhadap GPA perkuliahan (colGPA) dan tuliskan formal reportnya
reg colGPA ACT

//3. Interpretasikan R-Squared dan variabel ACT! 
* R^2 :  0.0427
* Variasi dari variabel ACT mampu menjelaskan variasi dari variabel colGPA sebesar 4.27%, sementara sisanya sebesar 95.37% oleh variabel-variabel lain diluar model tersebut

* ACT : 0.027064
* Apabila terdapat 2 individu dengan karakter fisik yang sama, namun salah satu individu memiliki ACT (lama jabatan) yang lebih tinggi 1 dibandingkan yang lain, maka individu tersebut memiliki colGPA lebih tinggi rata-rata sebesar 0.027064 dibandingkan dengan individu lainnya 'ceteris paribus'

*MLR
//4. Gunakan data HPRICE1.dta dari boston college!
clear
bcuse hprice1.dta

//5. regresi variabel jumlah kamar, assessed value, ukuran tanah, dan ukuran rumah terhadap harga rumah
reg price bdrms assess lotsize sqrft

save "$output/posttest3"
log close
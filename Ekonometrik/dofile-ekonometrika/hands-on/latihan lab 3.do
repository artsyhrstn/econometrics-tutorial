// Lab 3 SLR dan MLR Latihan
// Hisbi Asyihristani R
// 120610210018

//1. Buka dofile dan hapus dataset
clear

//2. Pindahkan working directory ke folder Stata
cd "D:\Stata_Hisbi"

//3. Buatlah global macro directory
global data "D:\Stata_Hisbi\data"
global log "D:\Stata_Hisbi\log"
global output "D:\Stata_Hisbi\output"

//4. Buatlah log file dengan nama “latihanlab3”
log using "$log/latihanlab33"

//5. Buka data wage2.dta pada folder data
use "$data/wage2.dta"

//6. Lihat variabel dan jumlah observasi
desc
* variabel  = 135 obs
* observasi = 16 variabel

//7. Lakukan regresi variabel lama jabatan kerja (tenure) terhadap upah (wage) dan tuliskan formal report
// wage dependen
// tenure independen
reg wage tenure 
* wage (dependen) pertama
* tenure (independen) kedua

//8. Interpretasi variabel tenure dan R2
*Interpretasi TENURE = 10.21947
*apabila terdapat 2 individu dengan karakter fisik yang sama, namun salah satu individu memiliki tenure (lama jabatan) yang lebih tinggi 1 tahun dinandingkan yang lain, mka individu tersebut memiliki upah lebih tinggi rata-rata sebesar 10,22 dollar per bulan dibandingkan dengan individu lainnya 'ceteris paribus'

*Interpretasi R2 = 0.0165
* Variasi dari variabel tenure mampu menjelaskan variasi dari ariabel wage sebesar 1.65%, sementara sisanya sebesar 98.35% oleh variabel-variabel lain diluar model

//9. Hapus dataset dan regresi
bcuse wage1.dta, clear
reg wage educ

//10. Regresi MLR dan Interpretasi
reg wage educ tenure
*Interpretasi variabel tenure dan R2
*Interpretasi TENURE = 10.21947
*apabila terdapat 2 individu dengan karakter fisik yang sama, namun salah satu individu memiliki tenure (lama jabatan) yang lebih tinggi 1 tahun dinandingkan yang lain, mka individu tersebut memiliki upah lebih tinggi rata-rata sebesar 10,22 dollar per bulan dibandingkan dengan individu lainnya 'ceteris paribus'

*Interpretasi R2 = 0.0165
* Variasi dari variabel tenure mampu menjelaskan variasi dari ariabel wage sebesar 1.65%, sementara sisanya sebesar 98.35% oleh variabel-variabel lain diluar model

//11. Tutup log file

*save
save "$output/latihanlab33"
log close

*residual = (actual - prediksi) selisih antara nilai asli dan prediksi 
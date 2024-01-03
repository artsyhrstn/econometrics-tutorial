* Nama : Hisbi Asyihristani
* NPM : 120610210018
* POST TEST LAB 7

* 1.	Pasang Log dan buka do file editor dalam STATA dan input data Real Estate Investment (canada.dta) di Kanada !  
cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"
//Makro direktori
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
// Buat log file
log using "$log/posttestlab8"
use "$data/canada.dta"

* 2.	Set waktu data time series dalam bentuk tahunan ! 
tsset year, yearly

* 3.	Lakukan analisis grafik untuk mengetahui stasioneritas pada variabel tingkat inflasi IHK (inf), variabel data inventaris (inven), dan variabel GDP di Kanada (gdp) apakah variabel-variabel tersebut mengandung trend ? Gambar grafik pada lembar jawaban dan tulis analisisnya ! (5%)
tsline inf inven gdp

* 4.	Uji Stasioneritas pada variabel inf, inven, dan gdp menggunakan ADF Test dengan tingkat signifikansi 1% ! Jika belum stasioner ubah variabel tersebut menjadi turunan pertama, apakah masih tidak stasioner ? (15%)
dfuller inf
dfuller inven
dfuller gdp

dfuller d.inf
dfuller d.inven
dfuller d.gdp

* 5.  Lakukan regresi yang menyatakan variabel l variabel tingkat inflasi IHK (inf) dan variabel data inventaris (inven) mempengaruhi variabel GDP di Kanada (gdp), tuliskan formal reportnya ! (15%)
reg gdp inf inven 

* 6. Tuliskan interpretasi untuk variabel tingkat inflasi IHK, variabel data inventaris, dan R-square!  (15%)


* 7.	Apakah model tersebut terdapat masalah otokorelasi? Lakukan uji otokorelasi dengan Durbin-Watson ! (10%)
estat dwatson


* 8. Lakukanlah uji Otokorelasi dengan metode Breusch-Godfrey dengan tingkat signifikansi 5% ! (10%)
estat bgodfrey

* 9. Lakukanlah perbaikan jika terdapat masalah otokorelasi dengan menurunkan semua variabel ke turunan pertama. Uji kembali otokorelasi model dengan Durbin Watson dan Breusch-Godfrey ! (30%)
reg d.gdp d.inf d.inven 
estat bgodfrey
estat dwatson



10. Tutup log-file (0%)
log close

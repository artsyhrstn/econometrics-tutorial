* Nama : Hisbi Asyihristani
* NPM : 120610210018

cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"

log using "$log/latihanlab8"

use minwage.dta

* set data dalam tahunan
tsset year, yearly

* 4 trend dengan grafik
tsline lprepop lmincov lprgnp

* 5 Uji stationeritas dengan ADF test
dfuller lprepop
dfuller lmincov
dfuller lprgnp

dfuller d.lprepop
dfuller d.lmincov

d. = menunjukan variabel diturunkan ke turunan pertama

* 6 
reg lprepop lmincov lprgnp year

* 7 Interpretasi 
R2 = variasi dari variabel independen dapat menjelaskan variabel dependen sebesar 87% dan sisanya 13% ditentukan dari luar variabel lain

lprgnp =memprediksi bahwa setiap peningkatan GNP puerto rico sebsar 1% maka akan meningkatkan rasio pekerja di Puerto rico sebesar 0.413%, ceteris paribus

* 8 uji autokorelasi dengan Durbin-Watson
estat dwatson

* alpha 5%
* nilai DW .8632714
* df = 4
* dU = ?
* dL = ?

* 9 uji autokorelasi BG
estat bgodfrey

* 10 perbaikan dalam masalah autokorelasi dengan menurunkan semua var ke turunan pertama
reg d.lprepop d.lmincov d.lprgnp 

* uji dwatson
estat dwatson
df atau k = 3
n = 37
nilai dwatson: 1.85953

dL 
dU 

* Uji bgodfrey
estat bgodfrey













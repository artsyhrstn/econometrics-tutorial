* Nama : Hisbi Asyihristani
* NPM : 120610210018
* Tugas Pengantar Ekonometrika

* Import data dari excel (menggunakan metode click)

* 2. Set waktu data time series dalam bentuk tahunan ! 
tsset year, yearly

* 3. Lakukan analisis grafik untuk mengetahui stasioneritas pada variabel
tsline gdp educexp

* 4 Uji Stasioneritas pada variabel inf, inven, dan gdp menggunakan ADF Test dengan tingkat signifikansi 1%
dfuller gdp
dfuller educexp
// turunan pertama
dfuller d.gdp
dfuller d.educexp

* 5 Lakukan regresi, educexp berpengaruh terhadap tingkat GDP
reg gdp educexp

* 6 Lakukan plotting
scatter gdp educexp

* 7 Regresi turunan pertama
reg d.gdp d.educexp


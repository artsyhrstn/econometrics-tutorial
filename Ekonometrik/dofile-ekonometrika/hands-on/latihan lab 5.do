// Nama : Hisbi Asyihristani R
// 120610210018
// Lab 4

*1. Ganti direktori kerja
cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"

*2. Buatlah global macro directory
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"

*3. Buat Log file
log using "$log/latihanlab5"

*3. Buka data
bcuse wage1.dta

*4. regresi
reg wage educ exper expersq tenure female married

*5 Interpretasi terhadap variabel exper

*exper : Jika terdapat 2 individu dengan karakteristik yang sama namun salah satu memiliki pengalaman lebih banyak selama satu tahun (experience) maka individu tersebut akan mendapat upah lebih besar rata-rata sebsar $0.2004/jam dibandingkan dengan individu lainnya, ceteris paibus

*6. Uji T 2 Arah variabel married
// t-stat : koefisien / standard error

di .0924594 / .2936218 

*Hasil dari t-stat = .31489283

// t-tabel = Degree of Freedom (df) = n - k - 1
// (df) = 526 - 6 - 1 => 519
// alpha = 5%

//Uji hipotesis
// h0 : tidak terdapat pengaruh yang signifikan antara variabel married dan variabel wage
// ha : h0 terdapat pengaruh signifikan antara variabel married dan variabel wage

// Uji kriteria
* -t-tabel <= t stat <= t-tabel (H0 tidak dapat ditolak)
* t-stat > t-tabel atau t-stat < -t-tabel (H0 ditolak)

// Hasil
* t-stat = .31489283
* t-tabel = 1.962
// .31 < 1.962 (H0 tidak dapat ditolak)

// Kesimpulan : maka, dengan tingkat signifikansi 5%, vairiabel married atau status menikah seseorang tidak memilkipengaruh yang signifikan terhadap wage atau upah seseorang.

*7. Uji t dan p-value variabel educ 5%
// t-test (tidak disebutkan maka memakai 2 arah)
* t-stat/t-value
scalar tvalue=(_b[educ]/_se[educ]) //cara 1
// b = beta
// se = standard error

//cara1
display "T-value:"tvalue

//cara2
display "T-stat:"tvalue

//cara3
display tvalue

*r-tabel/t-critical
scalar tcrit=invttail(519, 0.025)

// scalar tcrit=invtail(df, tingkat signifikansi
// stata hanya dapat menghitung dalam satu arah, jadi melakukan penghitungan dengan mengalikan 2 terlebih dahulu.

// cara1
display "t-crit(2.5% one-sided):"tcrit
// cara2
display tcrit

// t-value/t-stat: 10.78
// t-tabel/t-critical : 1.96

//Uji Hipotesis
* H0 : tidak terdapat pengaruh yang signifikan antara variabel educ dan wage (H0 tidak dapat ditolak)
* Ha : terdapat pengaruh signifikan antara variabel educ dan wage (ditolak)

//Kesimpulan : Maka, dengan tingkat signifikansi 5%, variabel educ atau pendidikan seseorang memiliki pengaruh yang signifikan terhadap variabel wage atau upah seseorang.

// p-value
// Uji hipotersis :
* H0 : tidak terdapat pengaruh yang signifikan antara variabel educ dan wage (H0 tidak dapat ditolak)
* Ha : terdapat pengaruh signifikan antara variabel educ dan wage (ditolak)

// Uji Kriteria :
*p-value > alpha (h0 tidak dapat ditolak)
*p-value < alpha (h0 ditolak)

//8. masa jabatan pengaruh positif = uji satu arah, uj-t satu arah variabel masa jaabatan dengan upah(tenure)
scalar tvalue=(_b[tenure]/_se[tenure]) 
display tvalue
//t-value : 6.4577107

scalar tcrit=invttail(519, 0.10)
display tcrit
// tcrit : 1.2831849

// Uji hipotersis :
* H0 : tidak terdapat pengaruh yang signifikan antara variabel tenure dan wage (H0 tidak dapat ditolak)
* Ha : terdapat pengaruh signifikan antara variabel tenure dan wage (ditolak)

* Uji Kriteria
*t-stat <= t-tabel (H0 tidak dapat ditolak)
*t-stat > t-tabe; (h0 ditolak)

//Hsil : 6.45 > 1.28 (h0 ditolak)
//kesimpulan : Maka, dengan tingkat signifikansi 10%, variabel tenure atau wage seseorang memiliki pengaruh yang signifikan terhadap variabel wage atau upah seseorang.

*9. Uji F 
test educ exper expersq female tenure married
//f-stat : 57.37
//prob > F : 0.000

display "fcrit:"invFtail(6,519,0.05)
// Uji hipotersis :
* H0 : Semua variabel independen tidak berpengaruh secara simultan terhadap vatiabel dependen (wage) (H0 tidak dapat ditolak)
* Ha : Minimal ada satu variabel yang berpengaruh secara signifikan terhadap variabel dependen

// Uji kriteria
* f-stat <= f-tabel (h0 tidak dapat ditolak)
* f-stat > f-tabel (h0 ditolak)

// Hasil : 57.37 > 2.116 (H0 ditolak)
// Kesimpulan
* Maka, dengan tingkat signifikansi 5%, minimal ada satu variabel independen yang memiliki pengaruh signifikan terhadap variabel wage













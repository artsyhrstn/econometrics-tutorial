// Nama : Hisbi Asyihristani R
// 120610210018
// Lab 4

// Ganti direktori kerja
cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"

//Makro direktori
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"

// Buat log file
log using "$log/posttestlab4"

// Gunakan data
bcuse campus.dta

// 1. rata-rata variabel police dan crime1.  rata-rata variabel police dan crime
summarize

// Membuat scatter antara kedua variabel dengan vline dan xline
scatter police crime, yline(20.49485) xline(394.4536)

// Interpretasi kovarians dari scatterplot tersebut

// Scatter plot tersebut menunjukan bahwa jumlah hasil observasi paling banyak berada di kuadran 1 dan 3, sehingga hubungan antara crime dan police bersifat positif

// 2. Hitung angka koefisien korelasi variabel police dan crime
correlate police crime

// hitung angka kovarians dari variabel police dan crime
correlate police crime, cov

// 3. Estimasi pengaruh variabel crime terhadap police, buat formal repost dan interpretasi konstanta dan variabel crime. Setelah itu, prediksi fitted values dengan nama variabel policehat dan juga residualnya dengan nama resid.

reg police crime
predict policehat
predict resid, residual

//4. Lihat tampilan spreadsheet untuk price, predicted values dari price, dan residual.  

br police policehat resid

//Buat garis regresi linear (lfit)  pada scatter plot antara police dan crime.
scatter police crime || lfit police crime

*Data Scaling, Logaritma Form, and Quadratic Form

//1. Hapus dataset sebelumnya kemudian bukalah data wage2 dari Boston College dan 

bcuse wage2.dta, clear

// Buatlah variabel baru yaitu hrlywage untuk variabel upah yang dihitung per jam (hrlywage=US$/hour). (note: seluruh pekerja dalam dataset diasumsikan bekerja selama 60 jam per minggu). 

gen hrlywage = wage/60

//2. Lakukan regresi pengaruh tingkat pendidikan, pengalaman, masa jabatan, dan usia terhadap upah dan upah per jam. Tuliskan formal report dan interpretasikan variabel educ dan tenure.

reg wage educ exper tenure age
reg hrlywage educ exper tenure age


//3. Buatlah variabel logaritma dari upah.
gen lnwage = log(wage)

//4. Lakukanlah regresi pengaruh variabel tingkat pendidikan, pengalaman, masa jabatan, dan status menikah (educ, exper, tenure, married) terhadap variabel logaritma dari upah
reg lnwage educ exper tenure married

//5. Buat variabel kuadratik  umur lalu lakukan estimasi pengaruh variabel umur dan kuadratik umur terhadap upah dan berikan interpretasi variabel expersq!

gen expersq = exper^2
reg wage exper expersq

log close



















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
log using "$log/latihanlab4"

*4. Buka data
bcuse ceosal1.dta 

*5. Buka summary stat (rata2 sallary)
summarize

*6. Nilai Maksimum (maks roe)
summarize

*7. scatter (dependen)(independen)
scatter salary roe

*8. scatter (dep)(independen) dengan yline dan x line
scatter salary roe, yline(1281.12) xline(17.18421)

*9. Korelasi salary roe
correl salary roe
// hubungan antara salary dan roe sangat lemah dikarenakan dibawah 0.19 namun tetap positif

*10. 
correl salary roe, cov

*11. regresi salary terhadap roe
reg salary roe
// roe naik 1 satuan maka 
*12. 12.	Hitung predicted values untuk salary dengan nama salaryhat
predict salaryhat

*13. Hitung residual dari regresi tersebut 
predict resid, residual //"resid" bebas untuk nama baru

*14. Lihat tampilan spreadsheet untuk salary, predicted values dari salary, dan residual.

br salary salaryhat resid

*15. Buat garis regresi pada scatter plot antara salary dan roe.
scatter salary roe || lfit salaryhat roe

//b 0 = origin ke titik awal regresi
//ufit untuk u, lfit untuk linear

*16. Buang outlier pada variabel salary yang memiliki nilai lebih dari 5500.
drop if salary > 5500

*17. Lakukan regresi ulang, apa yang berubah? Bagaimana interpretasi koefisien variabel roe?

reg salary roe
// sebelum 18.50, p value 0.098
// sesudah 15.30, p value 0.002 (semakin signifikan)
*apabila terdapat 2 idividu, namun satu individu memiliki pengembalian pada modal lebih tinggi sebanyak 1 satuan dibandingkan individu lain, maka individu tersebut memiliki upah lebih banyak sebanyak $15.30, ceteris paribus


*18.	Buat ulang garis regresi pada scatter plot antara salary dan roe
scatter salary roe || lfit salaryhat roe

/// Data Scaling, Logaritma Form, and Quadratic Form

*1.	Bukalah data wage1 dari Boston College dan buatlah variabel baru bentuk logaritma dari upah (wage)

bcuse wage1.dta, clear
gen lnwage=log(wage)

*2.	Lakukan Estimasi pengaruh tingkat pendidikan (educ), pengalaman (exper), terhadap upah (wage) dan lakukan hal sama tetapi dengan menggunakan variabel logaritma dari upah. 
*Lakukan interpretasi dan bandingkan hasil estimasi dari kedua model.

reg wage educ exper
reg lnwage educ exper

//interpretasi educ = jika terdapat 2 individu dengan karakteristik yang sama dan satu individu memiliki tingkat pendidikan lebih tinggi satu tahun, maka rata rata upah yang diterima lebih tinggi sebesar $0.64 dibandingkan dengan individu lainnya, ceteris paribus

*log-lin
reg lnwage educ exper
di 100*(exp(0.0979356)-1)
//jika terdapat 2 individu dengan karakteristik yang sama dan satu individu memiliki tingkat pendidikan lebih tinggi satu tahun, maka rata rata upah yang diterima lebih tinggi sebesar 9.7% / lebih akuratnya $10.29 dibandingkan dengan individu lainnya, ceteris paribus

//3.	Cek variabel dan buatlah variabel baru pada tingkat pengalaman (exper) satuan tahun menjadi tingkat pengalaman dengan satuan bulanan
des
// ganti exper dari tahun ke bulan
gen mnthlyexp=exper*12

//4.	Lakukan Regresi pengaruh pengalaman (exper), gender (female) , tingkat pendidikan (educ) terhadap upah (wage). Lakukan juga regresi yang sama tetapi dengan menggunakan variabel  baru tingkat pendidikan dalam satuan bulanan. Apakah ada perbedaan di antara kedua model?  

reg wage exper female educ
reg wage mnthlyexp female educ
*bedanya hanya perbedaan selisih per bulanan

*5 close log
log close












// covarriance = arah hubungan antar variabel (hanya melihat positif atau negatif)
// correlation = arah dan kekuatan antara dua variabel (tidak menunujukan kausalitas)
// scatter = hubunagn antara dua variabel, kiri dep kanan indep
// garis = rata2 variabel x dan variabel y

//fitted value = residual
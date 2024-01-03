// Nama : Hisbi Asyihristani
// NPM : 120610210018

// Latihan Lab 7

//1. Membuat Macro directory dan log dengan gunakan data "wage1" dari Boston College

cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"

log using "$log/latihanlab7"

* 4. Bukalah data set "WAGE2.DTA" pada stata!

use "$data/wage2.dta", clear

* 5. Lakukanlah regresi yang menunjukkan pengaruh dari variabel pendidikan, pengalaman, dan kuadrat dari variabel pengalaman (hint: buatlah variabel kuadrat dari exper) terhadap variabel pendapatan! Berdasarkan nilai p-value, variabel apa saja yang memiliki pengaruh signifikan terhadap variabel pendapatan logaritma pada seseorang? 

gen expersq =exper^2
reg wage educ exper expersq

* Jika melihat dari p-value 

* 6. Lakukan predict pada variabel wage dengan nama wagehat dan predict pada residual, kemudian buatlah scatter plot antara wage dan residual! tes heteros dengan grafik

predict wagehat
predict resid, residual
scatter resid wagehat || lfit resid wagehat 

* 7. Lakukan deteksi heteroskedastisitas dengan asumsi terdapat hubungan fungsional yang linear antara error term dan variabel independen dengan menggunakan Breusch-Pagan Test!

hettest
* alpha = 5%
* df = (jumlah variabel independen)
* chi square / k2 = 0.8372

* 8. Dengan mengasumsikan adanya hubungan fungsional antara error term dan variabel independen adalah kuadratik dan terdapat interaksi antara variabel independen, lakukan deteksi heteroskedastisitas menggunakan White Test!

imtest, white
var independen : educ, exper, expersq (3)
var kuadratik : 
var interaksi 

* 9. Berdasarkan pengujian yang dilakukan sebelumnya, diketahui bahwa terdapat masalah heteroskedastisitas. Lakukan koreksi Standard Error untuk mengatasi masalah heteroskedastisitas!

reg wage educ exper expersq, robust
reg wage educ exper expersq

// Outlier dan Outreg
* 10. Bukalah data set "rdintens.dta" pada stata!

use "$data/rdintens.dta", clear


11. Lakukan regresi yang menunjukan pengaruh dari variabel penjualan (sales) dan profit
margin (profmarg) terhadap intensitas R&amp;D (rdintens)! Berdasarkan hasil regresi,
apakah variabel sales dan profmarg berpengaruh signifikan terhadap variabel
rdintens? 

reg rdintens sales profmarg 

tidak signifikan karena p value lebih besar dari tingkat signifikansi (0.05)

12. Buatlah scatter plot antara rdintens dengan sales!

scatter rdintens sales
13. Lakukan kembali regresi antara rdintens, profmarg, dan sales, tanpa outlier!

* Menghapus outlier
* 
reg rdintens sales profmarg if sales<20000

14. Install "outreg2" pada stata!
ssc install outreg2

15. Lakukan regresi kembali seperti pada nomor 11 dan 13. Namun kali ini, tampilkan
hasil outreg dari masing-masing hasil regresi! (Lakukan outreg untuk persamaan pada
nomor 11 bersamaan dengan persamaan pada soal nomor 14). Beri nama file untuk
outreg: outreg_lab7

reg rdintens sales profmarg
outreg2 using outreg_lab7.doc
outreg2 using outreg_lab7.pdf

reg rdintens sales profmarg if sales<20000
outreg2 using outreg_lab7.doc, append




16. Tutup log file

log close
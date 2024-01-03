* Nama : Hisbi Asyihristani R
* NPM : 120610210018
* POST TEST LAB 7

* a. Buat macro directory dan logfile
cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"
//Makro direktori
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
// Buat log file
log using "$log/posttestlab7"

* 1. Buka do-file anda, pindahkan working directory ke folder Stata kalian, lalu buatlah macro directory dan log file dengan nama log file "nama_posttestlab7" (0%)

* 2. Buka data set "affairs.dta" (5%)
use "$data/affairs.dta"

* 3. Lakukan regresi untuk melihat pengaruh dari variabel affairs, unhap, yrsmarr terhadap variabel naffairs! Tuliskan persamaan untuk hasil regresi tersebut! (15%)
reg naffairs affair unhap yrsmarr

* 4. Buatlah scatter plot antara naffairs dan yrsmarr! Dari scatter plot, apakah menurut Anda model di atas terdapat masalah heteroskedastisitas? Mengapa? (10%)
scatter naffairs yrsmarr

* 5. Dengan mengasumsikan bahwa hubungan fungsional antara error term dan variabel independen adalah linear, lakukan deteksi heteroskedastisitas dan tuliskan hipotesis, tingkat signifikansi, kriteria, dan kesimpulan dengan lengkap! (15%)
hettest

* 6. Dengan mengasumsikan bahwa hubungan fungsional antara error term dan variabel independen adalah kuadratik dan terdapat interaksi antara variabel independen, lakukan deteksi heteroskedastisitas dan tuliskan hipotesis, tingkat signifikansi, kriteria, dan kesimpulan dengan lengkap! (15%)
imtest, white

* 7. Lakukan regresi kembali seperti nomor 3 dengan melakukan koreksi pada standard error untuk mengatasi permasalahan heteroskedastisitas, tuliskan pula formal reportnya! (15%)
reg naffairs affair unhap yrsmarr, robust
* melakukan koreksi pada standard error

* 8. Bandingkan hasil regresi pada soal nomor 3 dengan soal nomor 6, apakah ada perubahan pada Estimator (β 0 , β 1 , β 2 , β 3 )? Apa saja nilai yang berubah setelah dilakukan koreksi dengan robust standard error? (10%)
*docx

* 9. Buatlah hasil outreg dari masing-masing hasil regresi, sebelum dan sesudah koreksi standard error secara berdampingan. Beri nama file untuk outreg: outreg_nama_lab7 (15%)
reg naffairs affair unhap yrsmarr
outreg2 using outreg_HisbiA_Lab7.doc
reg naffairs affair unhap yrsmarr, robust
outreg2 using outreg_HisbiA_Lab7.doc, append

* 10. Tutup log file (0%)
log close
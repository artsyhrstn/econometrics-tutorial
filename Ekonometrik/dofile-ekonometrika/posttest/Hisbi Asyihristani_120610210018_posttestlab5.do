// Nama : Hisbi Asyihristani R
// 120610210018
// Lab 4

*1. Ganti direktori kerja
cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"

* Buatlah global macro directory
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"

*2. Buat Log file
log using "$log/Hisbi_posttestlab5"

*3.	Buka data ceosal1.dta dari Boston College 
bcuse ceosal1.dta

*4. Hasil estimasi gaji
reg salary sales roe ros

*5. Interpretasi
*Tertera dalam PDF

*6. Uji F dan lakukan juga uji P-value untuk variabel return on firm's stock pada persamaan tersebut
* Uji menggunakan stata
test sales roe ros
scalar Ftabel=invFtail(3,205,0.05)
dis "Ftabel:" Ftabel

*7. Buka data wage2.dta dari Boston College  
bcuse wage2.dta, clear

*8. 8.	Lakukan regresi wage yang dipengaruhi oleh pendidikan, pengalaman, lamanya jabatan kerja, urban, dan black.
reg wage educ exper tenure urban black

*9. 

*10. 
scalar tstat=(_b[tenure]/_se[tenure])
dis "tstat (2.5% satu sisi): " tstat

scalar ttabel=invttail(205, 0.025)
dis "ttabel (2.5% satu sisi): " ttabel

* Uji satu atah kanan
*Tstat
scalar tstat=(_b[exper]/_se[exper])
dis "tstat (1% satu sisi)" tstat

*Ttabel
scalar ttabel=invttail(205, 0.01)
dis "ttabel (1% satu sisi): " ttabel

*11
log close

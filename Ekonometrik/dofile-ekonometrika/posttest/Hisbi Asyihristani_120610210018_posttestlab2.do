*Nama : Hisbi Asyihristani R
*NPM  : 120610210018
*Post Test Lab 2

//1. Buka Stata

//2. Pindahkan working directory
cd "D:\Stata_Hisbi"

//3. Buatlah Macro Directory
global data "D:\Stata_Hisbi\data"
global log "D:\Stata_Hisbi\log"
global output "D:\Stata_Hisbi\output"

//4. Buat logfile dengan nama
log using "$log/Hisbi Asyihristani_120610210018_posttestlab2"

//5. Gunakan dataset yang telah diunduh
use post2.dta
*simpan terlebih dahulu data "post2.dta" yang telah disiapkan di google classroom di dalam folder yang diinginkan sebelumnya

//6. Mencari jumlah variabel dan jumlah observasi
describe
* Jumlah data observasi : 1260 observasi
* Jumlah variabel       : 17	variabel

//7. Mengubah looks pada semua responden menjadi 4(good looking
//   jika upah lebih besar dari $18

replace looks=4 if wage > 18

//8. Nilai rata-rata looks dan wage berdasarkan educ
tabstat looks wage, by(educ)stat(mean)
*nilai rata-rata looks berdasarkan educ = 3.205556
*nilai rata-rata wage berdasarkan educ = 6.30669

//9. Membuat variabel umur (berisi penjumlahan dari variabel pengalaman dan lama pendidikan)

gen umur = exper+educ

//10. Recode sample dari looks menjadi not good looking dan good looking ( 1-2 not good looking)
//    berikan label, tuliskan jumlah orang yang not good looking dan good looking
recode looks 1/2=0 3/5=1
label define looksitas 0"not good looking" 1"good looking"
label value looks looksitas
tab looks

*not good looking = 152
*good looking     = 1108

//11. Misal terjadi kesalahan
//	  wage menjadi 95 dari semua responden yang memiliki pengalaman selama 20 tahun dan memiliki pendidikan 13 tahun

replace wage=95 if exper==20 & educ==13
tab wage if exper==20 & educ==13

//12. Ubah nama looks menjadi penampilan
rename looks penampilan

//13. Simpan variable lwage, wage, exper, penampilan, union, female, married, dan educ
keep lwage wage exper penampilan union female married educ

//14. Hapus variabel wage, union dan female
drop wage union female

//15. Simpan data yang sudah di olah pada format stata dan excel (xls) 
//    pada folder kerja kalian pada subfolder “output” dengan nama file “penampilan”
save "$output/penampilan"
export excel "$output/penampilan", firstrow(variables)

//16. Tutup log file dan simpan do file dengan nama “Hisbi Asyihristani_120610210018_posttestlab2”
log close

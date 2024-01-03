// Lab 2 do-file
* Nama : Hisbi Asyihristani R
* NPM  : 120610210018

*2 Buat direktori
mkdir "C:\Users\hisbi\OneDrive\Documents\stata"
mkdir "C:\Users\hisbi\OneDrive\Documents\stata\data"
mkdir "C:\Users\hisbi\OneDrive\Documents\stata\log"
mkdir "C:\Users\hisbi\OneDrive\Documents\stata\dofile"
mkdir "C:\Users\hisbi\OneDrive\Documents\stata\output"

*3 ubah direktori
cd "D:\Stata_Hisbi"

*4 Buat macro directory (output, data, log)
global data "D:\Stata_Hisbi\data"
global log "D:\Stata_Hisbi\log"
global output "D:\Stata_Hisbi\output"

*5 buat log file
log using "$log/latihan_lab2"

*6 buka data boston college
ssc install bcuse
bcuse affairs.dta
//bcuse untuk membuka data dari folder sebelumnya

*7 Melihat isi data tersebut
describe //
br //br = browse

*8

*9 Rata rata variabel berdasarkan relig
tab relig
tabstat yrsmarr age, by(relig)stat(mean) //untuk melihat rata-rata

*10 ganti nilai
tab yrsmarr kids
replace age=36 if kids==1 & yrsmarr==4 // mengganti umuur menjadi 36 untuk data kids==1 dan yrsmarr ==4
tab age if kids==1 & yrsmarr==4
//

*11 ganti nilai
replace relig=4 if educ==16 //sebelum sama dengan (=) satu, setelah if sama dengan (=) dua

*12 recode relig
tab relig
recode relig 1/2=0 3/5=1
label define religiusitas 0"tidak religius" 1"religius" // mendefinisikan bahwa 0 tidak kalau 1
la de religiusitas 0"tidak religius" 1"religius"

tab relig

label values relig religiusitas // mengubah 0
la val relig religiusitas

tab relig

*13 simpan beberapa vairiabel
keep id age male yrsmarr kids relig educ affair ratemarr naffairs

*14 mengubah nama variabel dari age menjadi umur
rename age umur //pendeknya ren

*15 hapus var
drop naffairs ratemarr

*16 Simpan file
save "$output/latihan_lab2"

*17 simpan dalam file excel
export excel "$output/latihan_lab2", firstrow(variables) //agara row pertama otomatis dimasukan oleh nama variabel

*18 tutup log file dan hapus dataset
close log
clear


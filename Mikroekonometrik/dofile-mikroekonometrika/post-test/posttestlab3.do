*POST TEST LAB 3
*HISBI ASYIHRISTANI R
*120610210018

*1. Buat macro directory dan bersihkan memory anda, membuat do-file dengan nama "nama_posttestlab2"!
cd "C:\Users\hisbi\iCloudDrive\IFLS"

*2. Buatlah log file dengan nama "posttestlab2panel.smcl"!
global log "C:\Users\hisbi\iCloudDrive\IFLS\log"
global output "C:\Users\hisbi\iCloudDrive\IFLS\output"
global data "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data"
log using "$log/posttestlab2panel", replace

*3. Gunakan data crime2.dta dari folder data
use "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\crime2"

*4. Lakukan estimasi dari variabel tingkat kejahatan per 1000 orang (crmrte) tergantung dari unemployment rate(unem), per capita income (pcinc) dan petugas per mil persegi (offarea) dan variable dummy tahun (d87) menggunakan pooled OLS. Interpretasikan variabel unem dan d87!
reg crmrte unem pcinc offarea d87

* Unem : Jika variabel lain dianggap konstan, kenaikan tingkat pengangguran sebesar 1 satuan akan meningkatkan tingkat kriminalitas dengan rata-rata 0.2738521 kasus per 1000 orang
* d87 : Jika variabel lain dianggap konstan, maka tingkat kejahatan akan meningkatkan 11.0588 satuan dalam kurun waktu lima tahun atau tingkat kejahatan akan meningkat 11.0588 dari tahun 1982 ke 1987

*5. Ubahlah tahun 82 dan 87 dengan nama 1982 dan 1987!
replace year=1982 if d87==0
replace year=1987 if d87==1

*6. Turunkan variabel  crmrte, unem, picnic dan offarea menggunakan metode first difference. hint : cara foreach awalan nama variabel d. Setelah itu lakukan estimasi ulang seperti no 4
foreach x in crmrte unem pcinc offarea{
	bys id_city: gen d`x'=(`x'[_n]-`x'[_n-1])
}
reg dcrmrte dunem dpcinc doffarea d87

*7. Lakukan estimasi ulang bahwa tingkat kejahatan per 1000 orang (crmrte) tergantung dari unemployment rate(unem), per capita income (pcinc) dan petugas per mil persegi (offarea) dan tambahkan variable dummy tahun (d87) dengan asumsi bahwa unobserved effect memiliki hubungan fungsional dengan variabel independen. Kemudian simpan hasil estimasi. Lampirkan screenshot tampilan dari Stata. Jangan lupa set data panel 
xtset id_city year
xtreg crmrte unem pcinc offarea d87, fe
estimates store fe

*8. Lakukan estimasi ulang bahwa tingkat kejahatan per 1000 orang (crmrte) tergantung dari unemployment rate(unem), per capita income (pcinc) dan petugas per mil p	ersegi (offarea) dan tambahkan variable dummy tahun (d87) dengan asumsi bahwa unobserved effect tidak memiliki hubungan fungsional dengan variabel independen. Kemudian simpan hasil estimasi. Lampirkan screenshot tampilan dari Stata
xtreg crmrte unem pcinc offarea d87, re
estimates store re


*9. Di antara pendekatan estimasi di nomor 8 dan 7, pendekatan estimasi manakah yang akan kalian gunakan? Mengapa?
hausman fe re


*10. Simpan data dengan nama "posttestlab2_nama.dta"
save "$output/posttestlab2_nama.dta"

*11. Simpan log file
log close

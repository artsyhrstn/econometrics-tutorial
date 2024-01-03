*LATIHAN LAB 3

*0.Bersihkan memory dan beri nama directory kerja anda!
clear
cd "C:\Users\hisbi\iCloudDrive\IFLS"
*1.Mulai log file dengan nama "posttestlab2"
global data "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data"
global log "C:\Users\hisbi\iCloudDrive\IFLS\log"
global output "C:\Users\hisbi\iCloudDrive\IFLS\output"
*log using "$log/latihanlab2panel", replace

*2. Masukan dataset tahun 1980 yaitu `tute2180.dta'
use "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\tute2180"
describe

*3. Gabungkan dataset tahun 1980 dengan tahun 1990 dan buatlah variabel dummy tahun! 
help append
append using "$data/tute2190", gen (y90)

*4. Buatlah variabel penjelas dimana 0 di variable dummy tahun dengan subscript it bermakna 1980!
gen tahun=1990 if y90==1
br tahun y90
replace tahun=1980 if y90==0

*5. Sort variabel kota dan tahun lalu cek bentuk setelahnya!
br city tahun
sort city tahun

*6. Buat variabel dalam bentuk logaritma dari harga sewa, populasi, dan rata-rata income     dengan menggunakan cara yang cepat!
foreach x in rent pop avginc{
	gen ln`x'=log(`x')
}
reg dcrmrte dunem dpcinc doffarea d87

help foreach

*7. Buatlah variabel pctstu (populasi siswa sebagai persentase populasi kota selama tahun sekolah) hint : rumus wooldridge 
gen pctstu=(enroll/pop)*100

*8. Lalukan estimasi dari variabel y90, lpop, lavginc, dan  pctstu terhadap harga sewa      bentuk logaritma menggunakan pooled OLS. Interpretasikan variabel y90, lavginc, dan pcstu!
* Menggunakan Data Panel
* Turunkan  persamaan dan lakukan estimasi menggunakan OLS
reg lnrent y90 lnpop lnavginc pctstu

* Interpretasi y90 (log-lin)
* tanpa dipengaruhi variabel lain maka harga sewa pada tahun 1990 sebesar 26.22267% atau lebih tepatnya sebesar 29.982118%
* harga sewa rata-rata meningkat sebasar 29.98% daritahun 1980-1990
di 100*(exp(0.2622267)-1)
29.982118

* Interpretasi ln avginc (log-log)
* Jika terjadi kenaikan sebesar 1% pada avginc aka rata rata harga sewa akan ikut meningkat sebesar 0.57%, ceteris paribus

*Interpretasi lpop
* Jika terjadi kenaikan sebesar 1% pada pop maka rata-rata harga sewa meningkat sebesar 0.04%, ceteris paribus

*9. Turunkan semua variabel menggunakan metode first difference!
*bys city:gen dlrent=lrent-lrent[_n-1]
foreach x in lnpop lnrent lnavginc pctstu{
	bys city: gen d`x'=(`x'[_n]-`x'[_n-1])
}

* Pengurangan dari (dataset1-master)

*10. Estimasikan kembali pengaruh dlpop, dlavginc, dpctstu terhadap dlrent menggunakan OLS. Interpretasikan variabel dlpop dan buktikan jumlah observasi yang berkurang!
*Estimasi model dengan menggunakan Fixed Effect 
reg dlnrent dlnpop dlnavginc dpctstu

*Interpretasi dlnpop
* Jika terjadi kenaikan populasi sebesar 1% maka rata-rata harga sewa meingkat 0.07%, ceteris paribus
help xtset
*11. Set data panel
xtset city

*12. Estimasi pengaruh y90, lpop, lavginc, pctstu terhadap lrent menggunakan Fixed Effect 
xtreg lnrent y90 lnpop lnavginc pctstu, fe

*13. Simpan hasil estimasi 
*Estimasi model dengan menggunakan Random Effect
estimates store fe

*14. Estimasi pengaruh y90, lpop, lavginc, pctstu terhadap lrent menggunakan Random Effect 
xtreg lnrent y90 lnpop lnavginc pctstu, re

*15. Simpan hasil estimasi 
estimates store re

*16. Lakukan Uji Hausman test lalu bandingkan hasilnya lebih baik kita menggunakan metode  apa dalam menghilangkan unobserv effect?
hausman fe re
*Prob > chi2 = 0.0100
*a = 0.05

*0.05 > 0.0100
*(a) > (Prob > chi2)

*17. Simpan data dengan nama "latihanlab2panel.dta"
save "$output/latihanlab2panel.dta"

*18. Simpan log file
log close
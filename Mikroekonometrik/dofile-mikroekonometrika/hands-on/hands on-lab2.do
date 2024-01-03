// Hands-on IFLS

* Roster

*1. Bersihkan memory dan beri nama directory kerja anda!
clear

*2. 
cd "C:\Users\hisbi\iCloudDrive\IFLS"

*3. global macro untuk folder penyimpanan data IFLS sesuai dengan format di atas

global hh93 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\1993\HH"
global hh97 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\1997\HH"
global hh00 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\2000\HH"
global hh07 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\2007\HH"
global hh14 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\2014\HH"

global cf93 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\1993\CF"
global cf97 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\1997\CF"
global cf00 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\2000\CF"
global cf07 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\2007\CF"
global cf14 "C:\Users\hisbi\iCloudDrive\IFLS\dokumen\data\2014\CF"

gl pce

*4. mulailah logfile dengan nama "handson_lab2"
global log "C:\Users\hisbi\iCloudDrive\IFLS\log"
global output "C:\Users\hisbi\iCloudDrive\IFLS\output"
log using "$log/handsonlab2", replace

* Roster
*5. Buka file yang terkait dengan kuesioner informasi karakteristik rumah tangga tahun 2014
use "$hh14/bk_ar1"
describe

*6. berapa observasi (individu) pada dataset ini?
count

*7. Cek konsistensi data individu pada dataset tersebut! Apakah terdapat duplicates? 
* 
duplicates report pidlink
duplicates report hhid14 pid14
bys pidlink: gen dup_pidlink=_N /// mengetahui berapa 
sort pidlink
br pidlink dup_pidlink

* buatlah roster untuk rumah tangga tahun 2014
gen member14_ar=(ar01a==1 | ar01a==2 | ar01a==5 | ar01a==11)
bys hhid14: egen hhsize14=sum(member14_ar)
tab ar01a member14_ar
keep if member14_ar==1
save "$output\roster14.dta", replace

*8. Simpan data individu yang telah diolah
save "$output\roster14.dta", replace

** DATA CLEANING

*9. Simpan nomor identifikasi anggota rumah tangga, rumah tangga, variabel panel, variabel jenis kelamin dan variabel umur responden ketika diwawancara
keep hhid14 pid14 pidlink ar07 ar09

*10. Buat label terhadap variabel jenis kelamin dimana 1 adalah "Laki-Laki" dan 3 adalah "Perempuan"
tab ar07, m
label define ar07 1 "Laki-laki" 3 "Perempuan"
label values ar07 ar07

*11. Buatlah variabel lakilaki dan umur
gen lakilaki=(ar07==01)
gen umur=ar09

*12. Buat variabel umur menjadi parabolic shape karena asumsi variabel ekonomi tidak harus dalam keadaan linear (umursq)

gen umursq=ar09^2

*13. Simpan data di folder output sebagai "umurdanjeniskelamin14.dta"
save "$output\umurdanjeniskelamin14.dta", replace

*14. Buka dataset baru mengenai kebiasaan merokok
use "$hh14/b3b_km", clear
describe

*15. Buatlah variabel dummy individu yang merokok dan tidak merokok serta rubah label variabelnya
gen merokok=(km01a==1 & km04==1 & (km01d==1 | km01e==1))
label define merokok 1"1: merokok" 0 "0: tidak merokok"
label values merokok merokok
tab merokok, m 
/// m = missing

*16. Simpan variabel mengenai person id, link person id, household id dan variabel merokok
keep pid14 pidlink hhid14 merokok

*17. Susun variabel person id, link person id, household id secara berurutan dan simpan file dengan nama "merokok14"
order pidlink hhid14 pid14
save "$output\merokok14", replace

*18. Buka data kesehatan yang berisikan tentang berat badan seseorang tahun 2014
use "$hh14\bus_us", clear
des

*19. Cek konsistensi data berat badan dengan kuesioner. Apabila ada outlier, ganti nilainya dengan ".". Ubah nama variabel us06 menjadi beratbadan
tab us06, m
replace us06=. if us06 ==999.0
tab us06, m
ren us06 beratbadan

*20. Simpan data tersebut dalam folder "output" sebagai weight14.dta
save "$output\weight14.dta", replace

*21. 
use $hh14\bus_us, clear
describe

*22. 
keep hhid14 pid14 pidlink us04
tab us04, m
ren us04 tinggibadan

*23. Simpan data tersebut dalam folder "output" sebagai height14.dta
save $output\height14.dta

*24. Gabungkan dataset yang berisikan tentang tinggi badan seseorang dengan berat badannya dengan menggunakan identifier rumah tangga dan individu.
use "$output\height14", clear
merge 1:1 hhid pid14 using $output\weight14.dta
keep if _merge==3
drop _merge

*25. data berat badan dan tinggi badan untuk mengukur indeks massa tubuh (IMT)
*Rumus IMT = berat badan / tinggi badan dalam meter kuadrat).
gen imt=beratbadan/(tinggibadan/100)^2

*26. Klasifikasikan indeks massa tubuh berdasarkan kriteria berikut

replace imt=1 if imt<17
replace imt=2 if imt>=17 & imt<18.5
replace imt=3 if imt>=18.5 & imt<=25
replace imt=4 if imt>25 & imt<=27
replace imt=5 if imt>27

*27.
tab imt
label define indeks_massa_tubuh 1"kekurangan"
label define indeks_massa_tubuh 2"kurus",add
label define indeks_massa_tubuh 3"normal",add
label define indeks_massa_tubuh 4"gemuk ringan",add
label define indeks_massa_tubuh 5"gemuk berat",add

*28
save $output\imt14, replace

*29.
use "$hh14\bk_sc1", clear

*30
keep hhid14 sc05

*31. 
tab sc05,m 
recode sc05 (2=0)
label define kota 1 "1: perkotaan" 0 "0: pedesaan", add modify
label values sc05 sc05

*32
ren sc05 kota
save "$output\urbanrura114.dta", replace

* CLEANING

*33

*34
use "$output/roster07", clear
merge 1:1 hhid07 pid07 using "$output/umurdanjeniskelamin07"
*data master, data using






log close
*POST TEST LAB 2
*HISBI ASYIHRISTANI R
*120610210018

*1.Bersihkan memory dan beri nama directory kerja anda!
clear

*2.Buatlah macro directory
cd "C:\Users\hisbi\iCloudDrive\IFLS"
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

global pce

*3.Mulai log file dengan nama "posttestlab2"
global log "C:\Users\hisbi\iCloudDrive\IFLS\log"
global output "C:\Users\hisbi\iCloudDrive\IFLS\output"
log using "$log/posttestlab2", replace

*4.Buka file yang terkait dengan kuesioner informasi karakteristik rumah tangga tahun 2014
use "$hh14/bk_ar1"

*5.Terdapat berapa observasi (individu) pada dataset ini?
count

*6.Cek konsistensi data individu pada dataset tersebut! Apakah terdapat duplicates?
duplicates report pidlink
duplicates report hhid14 pid14
bys pidlink: gen dup_pidlink=_N
sort pidlink
br pidlink dup_pidlink
gen member14_ar=(ar01a==1 | ar01a==2 | ar01a==5 | ar01a==11)
bys hhid14: egen hhsize14=sum(member14_ar)
tab ar01a member14_ar
keep if member14_ar==1

*7.Simpan data individu yang telah diolah dalam folder output dengan nama "roster14.dta"
save "$output/roster14.dta", replace

*8.Simpan hhid14, pid14, pidlink, ar07, dan ar09
keep hhid14 pid14 pidlink ar07 ar09

*9.Buatlah label terhadap variabel jenis kelamin dimana 1 adalah "Laki-Laki" dan 3 adalah "Perempuan"
label define ar07 1 "Laki-laki" 3 "Perempuan"
label values ar07 ar07
tab ar07

*10.Buatlah variabel lakilaki dan umur
gen laki_laki=(ar07==01)
gen umur=ar09

*11.Buat variabel umur menjadi parabolic shape karena asumsi variabel ekonomi tidak harus dalam keadaan linear (umursq)
gen umursq=(umur^2)

*12.Simpan data di folder output sebagai "umurdanjeniskelamin14.dta"
save "umurdanjeniskelamin14.dta", replace

*13.Buka file yang terkait dengan kesejahteraan rumah tangga, dilihat dari tingkat kepuasan yang dirasa (2014)
use "$hh14/b3a_sw"

*14. Simpan variabel hhid14, pid14, dan sw00
keep hhid14 pid14 sw00

*15. Buatlah variabel dummy dengan nama "Kepuasan", yang menandakan seseorang puas atau tidak puas dengan hidupnya serta rubah label variabel nya
gen kepuasan=sw00
recode kepuasan (1 2 3=1)(4 5 9 .=0)
tab kepuasan,m
label define kepuasan 1"1 : puas" 0 "0 : tidak puas"
label values kepuasan kepuasan
tab kepuasan, m


*16. Simpan variabel mengenai person id, household id dan variabel kepuasan, serta simpan data di folder output sebagai "kepuasan14.dta"
keep pid14 hhid14 kepuasan
save "$output/kepuasan14.dta", replace

*17. Buka file yang terkait dengan status menikah seseorang
use "$hh14/b3a_kw1", replace

*18. Simpan variabel hhid14, pid14, dan kw01a
keep hhid14 pid14 kw01a

*19. Buatlah variabel dummy dengan nama "Menikah", yang menandakan seseorang sedang menikah atau tidak sedang menikah serta rubah label variabelnya

gen menikah=(kw01a)
recode menikah (1 2 .=0) (3/5=1) (6/8=0)
label define menikah 1"1 : menikah" 0 "0 : tidak menikah"
label values menikah menikah
tab menikah, m

*20.Simpan variabel mengenai person id, household id dan variabel menikah, serta simpan data di folder output sebagai "menikah14.dta"
keep pid14 hhid14 menikah
save "$output/menikah14.dta", replace

*21. Gabungkan data roster14, umurdanjeniskelamin14, kepuasan14, menikah14, dan pce14nom dan save hasil gabungan dengan nama "cleaningposttest14"
use "$output/roster14.dta", clear
merge 1:1 hhid14 pid14 using "$output\umurdanjeniskelamin14"
drop if _merge!=3
drop _merge

merge 1:1 hhid14 pid14 using "$output\Kepuasan14"
drop if _merge!=3
drop _merge

merge 1:1 hhid14 pid14 using "$output\Menikah14"
drop if _merge!=3
drop _merge

merge m:1 hhid14 using "$output\pce14nom"
drop if _merge!=3
drop _merge

*22.Simpan variabel hhid14, pid14, pce, umur, umursq, lakilaki, kepuasan dan menikah
keep hhid14 pid14 pce umur umursq laki_laki kepuasan menikah

*23.Lakukan estimasi pengaruh dari umur, bentuk kuadratik dari umur, gender, tingkat kepuasan, dan status pernikahan terhadap pce
reg pce umur umursq laki_laki kepuasan menikah

*23. Tutup
log close


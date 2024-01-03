* Nama : Hisbi Asyihristani R
* NPM : 120610210018
* POST TEST LAB ^

* a. Buat macro directory dan logfile
cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"
//Makro direktori
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
// Buat log file
log using "$log/posttestlab6"

// DUMMY VARIABEL //
* 1. Buka data wage2.dta dari Boston College (0%)
bcuse wage2.dta

* 2. Buatlah variable interaksi antara variable black dengan urban (5%)
gen blackurban=black*urban
gen whiteurban=(1-black)*urban
////////////////////////////////////////////////////////////////////////////////////
* 3. Lakukan regresi pengaruh jam kerja mingguan, tingkat pendidikan, pengalaman, lamanya bekerja, variabel black, variabel urban dan variabel interaksi black dengan urban terhadap tingkat upah. Tuliskan persamaannya dan interpretasikan variabel educ dan black ! (20%)

reg wage hours educ exper tenure black urban blackurban
reg wage hours educ exper tenure black urban whiteurban



* INTERPRETASI
* EDUC = Jika terdapat 2 individu yang memiliki karakterisitik yang sama, namun satu individu memiliki tingkat pendidikan lebih tinggi satu tahun dibandingkan dengan individu lainnya maka individu tersebut akan mendapatkan wage (upah) rata-rata yang lebih tinggi senilai $67.07331 ceteris paribus.

* BLACK = Jika terdapat 2 individu yang memiliki karakterisitik yang sama, namun satu individu memiliki kulit hitam sedangkan individu lainnya tidak maka individu tersebut akan mendapatkan wage (upah) rata-rata yang lebih rendah senilai $140.222 ceteris paribus.
////////////////////////////////////////////////////////////////////////////////////
* 4. Hitunglah perbedaan upah antara orang kulit putih yang tinggal di kota dengan orang kulit hitam yang tinggal di kota! (10%) (hint: tanpa memperhitungkan konstanta, hitung gaji rata-rata pekerja kulit putih yang berada di kota terlebih dahulu. Kemudian, hitung gaji pekerja kulit hitam yang berada di kota. Terakhir, hitung selisih di antara keduanya)

* orang kulit hitam (1)
* orang kulit putih (0)
* penduduk urban (kota) (1)
* penduduk desa (0)

// display -140.222+183.6649+(-76.72602)
// Hasil : -33.283055 (pekerja kulit hitam)
// display (whiteurban)
// urban(1)=183/6649
// Hasil : 

* selisih
di =-33.283055+(-183.6649)

// MULTICOLLINEARITY//
* 5. Bersihkan data dan input data baru yaitu beauty.dta dari Boston College. (0%)

bcuse beauty.dta, clear

* 6. Ubahlah variabel looks menjadi variabel dummy dan Buatlah variabel baru "femmarr" yaitu individu perempuan yang sudah menikah. (10%)

recode looks (1/2=0) (3/5=1)
* / = sampai
* 1 = good looking, 0 = tidak good looking
gen femmarr=female*married

* 7. Lakukan estimasi terhadap variabel logaritma dari upah yang dipengaruhi oleh lama pendidikan, lamapengalaman kerja, wanita menikah, penampilan, dan orang yang bekerja di industri jasa. Tuliskan formal reportnya dan interpretasi variabel educ, looks, dan femmarr! (20%)

reg lwage educ exper looks service femmarr

* 8. Lakukan uji multicolliearity pada regresi sebelumnya (15%)

vif

* 9. Lakukan uji multikol antara variabel exper dan expersq dengan menggunakan correlation matrix. (15%)

correlate exper expersq
* 10. Sebutkan penyebab masalah multikol dari masalah model no 10. (5%)
* pdf
* 11. Tutup log (0%)
log close
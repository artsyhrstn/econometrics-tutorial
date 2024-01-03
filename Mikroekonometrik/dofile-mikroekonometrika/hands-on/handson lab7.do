* Hands on Lab 7

clear
cd "C:\Users\hisbi\iCloudDrive\"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
log using "$log\handson7"
use "$data/mroz.dta", clear
desc

*4. Lakukan tabulasi untuk variable hours dan lihat berapa persen dari wanita yang berstatus menikah yang memiliki jam kerja 0! Buatlah 2 buah histogram yang berisi frekuensi dan persentase jam kerja dari perempuan yang berstatus menikah!
tab hours if hours==0
scatter hours percent
histogram hours, percent  title(labor market perempuan menikah) normal
histogram hours, frequency  title(labor market perempuan menikah) normal

* Kesimpulan : Data dari labor market (perempuan) merupakan model tipe sensor data (dari bawah atau dari kiri) karena untuk variabel hours hanya mengobservasi jam kerja untuk rang yang berkerja dan bernilai nol untuk orang yang tidak berkerja

*5. Tunjukan range dari jam kerja perempuan yang berstatus menikah!
sum hours if hours > 0

* range = 12 hingga 4950

*6. Estimasikan pengaruh dari variable educ, exper, age, kids16 terhadap variable hours! Apakah
variable age dan kids16 memiliki pengaruh yang positif signifikan terhadap variable hours?
tobit hours educ exper age kidsl6, ll(0)
help tobit

* memakai ll (lower limit) karena variabel dependen yang diestimasi memiliki bentuk censored data dari bawah dimana limitnya adalah 0
* upper-limit (ul) ul(100)

*7. Hitunglah marginal effect dari educ, exper, age, kids16 terhadap variable hours untuk perempuan bekerja dan tidak bekerja (censored sample)! Interpretasikan!
help margins
margins, dydx(*) atmeans predict (ystar(0,.))

* Jika terdapat dua perempuan yang sudah menikah, namun salah satu perempuan memiliki tingkat pendidikan yang lebih tinggi 1 tahun maka kemungkinan jam kerja dari perempuan tersebut akan lebih tinggi sebesar 44.372 jam

desc

*8. Lakukan marginal effect dari variable educ untuk wanita yang berstatus menikah dengan usia 42.5 tahun, memiliki 1 anak di rumah, 12.29 tahun pendidikan, dan dengan 10.63 tahun pengalaman kerja! Interpretasikan!
margins, dydx(educ) at(age=42.5 kidsl6=1 educ=12.29 exper=10.63) predict(ystar(0,.))
mfx
* Interpretasi :
* Jika terdapat permpuan yang sudah menikah dan dengan usia 42.5, memiliki 1 anak dirumah, 12.29 tahun lama pendidikan, den dengan tingkat pendidikan 1 tahun lebih tinggi maka kemungknan jam kerja dia akan bertambah sebsesaar 26.66 jam dibandingkan perempan yang lain.

* 9.Lakukan marginal effect dari variable age terhadap variable hours namun hanya untuk truncated sample!
margins, dydx(educ) atmeans predict (e(0,.))

* 10. tutup
log close

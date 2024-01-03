*HANDS ON LAB 5

* charity.dta merupakan data mengenai informasi penghimpunan donasi yang dilakukan oleh salah satu organisasi amal di Belanda. Terdapat variabel respond yaitu variabel dummy dimana 1 merujuk kepada seseorang yang berdonasi setelah menerima pesan terbaru yang dikirimkan, variabel resplast yaitu variabel dummy dimana 1 merujuk kepada seseorang yang pernah membalas pesan terakhir yang telah dikirimkan, dan variabel avggift yaitu rata-rata jumlah donasi yang didapatkan sebelumnya.
clear
cd "C:\Users\hisbi\iCloudDrive\"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
log using "$log\handson5"
use "$data/charity"

* 1. Lakukan estimasi linear probability model untuk melihat pengaruh resplast dan avggift terhadap respond. Tampilkan hasil usual form dan interpretasikan koefisien resplast (Hint: Gunakan outreg2 untuk membuat usual form)
reg respond resplast avggift
br
ssc install outreg2
outreg2 using respond.doc

* Interpretasi = Resplast

* Apabila terdapat dua individu yang sama tetapi individu yang sama namun individu satu membalas pesan terakhir yang dikirimkan, maka probability individu tersebut untuk berdonasi lebih besar sebesar 0.34 daripada individu yang tidak membalas pesan terakhir yang / lebih besar 34.36% (dibandingkan dengan indvidu yang tidak membalas pesan terakhir)


* 2. Lakukan estimasi menggunakan model probit untuk respond, menggunakan variabel independent diantaranya resplast, weekslast, propresp, mailsyear, and avggift. Diantara variabel independent tersebut, variabel mana yang secara statistik signifikan pada alpha 5%?
help probit
probit respond resplast weekslast propresp mailsyear avggift

* log likehood = mencari kemungkinan yang merepresantasikan populasi

margin, dydx(*)
margin, atmean dydx(*)
* rata-rata marginal dari rata-rata populasi

* Variabel yang signifikan (a=0.05) = resplast weekslast propresp mailsyear
help mfx
mfx
* rata-rata marginal dari rata-rata populasi (berdasarkan pembatas)

* 3. Ubahlah hasil estimasi nomor 2 menjadi estimasi logit. Bandingkan koefisien resplast dari dua model estimasi tersebut.
logit respond resplast weekslast propresp mailsyear avggift
* Hasil logit = .11952692
0.07881564 < 0.1912431

* cara membandingkan (rule of thumb)
* lpm - probit = / 2.5
* probit - logit = * 0.625
* logit - probit = / 1.6
* lpm - logit = / 4

di _b[resplast]*0.625
* 0.11952692

log close






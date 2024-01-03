cd "C:\Users\hisbi\iCloudDrive\"

*0. Buatlah log file dengan nama "posttestlab2panel.smcl"!
global log "C:\Users\hisbi\iCloudDrive\"
global output "C:\Users\hisbi\iCloudDrive\"
global data "C:\Users\hisbi\iCloudDrive\"
log using "$log/posttestlab4"

*1.
reg children educ age agesq
* Interpretasi
* Jika 100 wanita menerima pendidikan 1 tahun dan usianya dianggap konstan, maka berkurangnya jumlah anak adalah sebesar 9 anak dari 100 wanita

*2. 
reg educ frsthalf
*frsthalf = 1 = wanita yang lahir di 6 bulan pertama

*korelasi = dari p value (0.000) *asumsi a = 0.05
* dengan melihat nilai p-value, frsthalf signifikan terhadap educ, maka variable frsthalf adalah kandidat yang cocok sebagai IV dari variabel educ

reg educ frsthalf age agesq
*3.
ivregress 2sls children age agesq (educ=frsthalf)
*atau
ivreg children (educ=frsthalf) age agesq
* dengan menggunakan IV 2SLS diketahui bahwa setelah menggunakan firsthalf sebagai instrumen variable, koeiseien educ menjadi lebih baik dan tetap signifikan

help ivregress

*4
reg children educ age agesq protest catholic spirit
* dalam persamaan yang diestimasi OLS dan 2SLS, koefisien spirit menyiratkan bahwa individu yang beragama (spiritual) akan memiliki 0,1 anak lebih banyak dari indivdu lain, ceteris paribus
ivreg children (educ=frsthalf) age agesq protest catholic spirit




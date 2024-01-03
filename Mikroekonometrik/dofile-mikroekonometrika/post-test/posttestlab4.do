*** Hisbi Asyihristani
*** 120610210018
*** Post Test Lab 4


clear
*0. Buatlah log file dengan nama "posttestlab4panel.smcl"!
cd "C:\Users\hisbi\iCloudDrive\"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
*log using "$log/posttestlab4"

use "$data/tute3b", replace
*1.	Berdasarkan tabel di atas, IV untuk pendidikan (nearc4), harus tidak berkorelasi dengan u. bolehkah nearc4 dikorelasikan dengan hal-hal dalam error term, seperti unobserved ability? Jelaskan. 

** Tidak boleh dikorelasikan dengan error term [cov(z, u) = 0: z], karena saat kita melakukan estimasi dengan variabel nearc4 namun berkorelasi dengan error term maka akan menyebabkan estimasi menjadi bias dan juga tidak konsisten. Adanya korelasi terhadap error term juga mengakibatkan persyaratan untuk menemukan instumental variabel tidak terpenuhi

*2. Lakukan regresi nearc4 pada educ untuk memeriksa apakah dibesarkan di dekat perguruan tinggi empat tahun berpengaruh terhadap pendidikan. Apa yang dapat disimpulkan? 
reg educ nearc4
**nearc4 P>|t = 0.000
**Pengaruh dekatnya jarak tempat tinggal dengan area kampus selama 4 tahun di dunia perkuliahan (nearc4) memiliki pengaruh yang signifikan terhadap tingkat pendidikan seseorang, dengan dekatnya jarak tempat tinggal dengan area kampus selama 4 tahun maka akan meningkatkan tingkat pendidikan seseorang selama 0.829019 tahun, ceteris paribus


*3. Lakukan regresi nearc4, exper, expersq, south, black, smsa, smsa66, reg662,...,reg669 terhadap educ. Apakah  educ dan nearc4 berhubungan setelah menggunakan control variable? Bandingkan dengan hasil yang didapatkan pada nomor 2.
reg educ nearc4 exper expersq south black smsa smsa66 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669
** Ya, masih berhubungan karena P>|t masih signifikan terhadap tingkat pendidikan (0.000), hasil tersebut sama dengan output regresi dalam soal nomor 2, namun koefisien pengaruh mengalami penurunan yang awalnya sebesar 0.829019 tahun menjadi 0.3198989 tahun.

*4. Lakukan regresi menggunakan instrumental variabel 2sls pada model di atas terhadap variable lwage. Berikan kesimpulan!
ivregress 2sls lwage exper expersq south black smsa smsa66 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669 (educ=nearc4)
*atau
ivreg lwage (educ=nearc4) exper expersq south black smsa smsa66 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669
**dengan menggunakan IV 2SLS diketahui bahwa setelah menggunakan nearc4 sebagai instrumen variable, koefisien educ menjadi lebih baik dan tetap signifikan (dengan asumsi α=0.05). educ mempengaruhi sebesar 13.15038% terhadap tingkat lwage, ceteris paribus

*0
log close
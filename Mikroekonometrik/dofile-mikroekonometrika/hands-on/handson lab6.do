* HANDS ON LAB 6

clear
cd "C:\Users\hisbi\iCloudDrive\"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
*log using "$log\handson6"
use "$data/fish.dta"
desc

****** MULTINOMIAL LOGIT MODEL

*3. Buatlah group variable yaitu variabel fishmod untuk variabel dependen serta variabel price dan income untuk variabel independen!
 
global y fishmod
global x price inc

help global

*4. Lakukanlah tabulasi untuk variabel fishing mode! Apa yang bisa disimpulkan dari hasil tabulasi?  

tab fishmod
tab $y
* bentuk dependen fishmod adalah / merupakan variabel multinomial atau bersifat unordered

*5. Lakukan estimasi multinomial logit model!
mlogit $y $x
mlogit fishmod price inc
* Jika income meningkat maka expected value dari individu memilih beach sebagai tempat memancing akan lebih tinggi daripada charter(tempat)
** Jika price meningkat maka expected value dari individu memilih private sebagai tempat memancing akan lebih rendah dibandingkan dengan charter(tempat)

*6. Lakukan estimasi multinomial logit model dengan menggunakan private sebagai base outcome!
mlogit $y $x, baseoutcome(3)
mlogit fishmod price inc

*7. Lakukan estimasi multinomial logit dengan marginal effect menggunakan setiap outcome dari keempat fishing mode serta interpretasikan variabel price pada setiap outcome!
mfx, predict(pr outcome(1))
mfx, predict(pr outcome(2))
mfx, predict(pr outcome(3))
mfx, predict(pr outcome(4))

** setiap kenaikan satu unit price, akan menurunkan probabilitas dari orang yang memilih beach sebagai tempat memancing dengan marginal efek sebesar 0.11 percentage point

** setiap kenaikan satu unit price akan menurunkan probabilitas dari orang yang memilih private sebagai tempat memancing dengan marginal effect sebesar 0.22 percentage point

************** Ordered Probit Model
*8. Gunakan data health.dta!
use "$data/health.dta", clear

*9. Buatlah group variable yaitu variabel healthstatus untuk variabel dependen serta variabel linc, age, dan diseases untuk variabel independen! 
global y healthstatus
global x linc age diseases

*10. Lakukan tabulasi data untuk variabel health status!
tab $y

*11. Lakukan estimasi ordered probit model!
oprobit $y $x
* Interpretasi

*12. Lakukan estimasi marginal effect untuk setiap outcome. Bagaimana pengaruh umur terhadap status kesehatan ketika status kesehatan seseorang adalah excellent!
mfx, predict (pr outcome(1))
* Setiap kenaikan linc sebesar satu dollar, maka probabilitas seorang untuk memiliki kesehatan yang oke akan menurun sebesar 2.33 percentage point

mfx, predict (pr outcome(2))

mfx, predict (pr outcome(3))


log close



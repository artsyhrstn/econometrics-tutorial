

clear
cd "C:\Users\hisbi\iCloudDrive\"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
log using "$log\Hisbi_posttest7"

*1. Use the data in fringe.dta first for this exercise.
use "$data/fringe.dta", clear
desc

*2. For what percentage of workers in the sample is pension equal to zero? Show a histogram that contains information frequencies of pension! (5%)
tab pension if pension==0
histogram pension, percent  title(Frequencies of Pension) normal
histogram pension, frequency  title(Frequencies of Pension) normal

*3. Why is tobit model appropriate for modeling pension?
* Tobit model dapat sesuai dengan pemodelan pensiun karena variabel pensiun sendiri tidak terdistrubusi secara normal, pada variabel pensiun histogram menunjukan bahwa nilai terkonsentrasi pada angka 0 yang berada di tingkat 30%, sehingga untuk melakukan estimasi tobit diperlukan untuk memperhitungkan keterbatasan dengan mengakomodasi data yang terpotong, memberikan perkiraan yang lebih realistis.

*4. What is the range of pension for workers with non-zero pension benefits? (5%)
sum pension if pension > 0
* Jangkauan dari 7.28 hingga 2880.27

*5. Estimate a tobit model for pension with exper, age, tenure, educ, depends, married, white, and male as explanatory variables. Which variables are significant at the 1% level? (10%)
tobit pension exper age tenure educ depends married white male, ll(0)
* Signifikan dalam level 1% = tenure, educ dan male
help tobit

*6. How many uncensored observations are in the model? (5%)
* Uncensored observations di tobit model = 444


*7. What's the difference between a censored and truncated regression model?=

*8. Compute the marginal effect of exper for a 35 years old married woman with 16 years of education, 10 years of experience, and 10 years of tenure! Interprete! (20%)
margins, dydx(exper) at(married=1 age=35 male=0 educ=16 exper=10 tenure=10) predict(ystar(0,.))
mfx

*9. Compute the marginal effect for only truncated sample and interpret the marginal effects of age! (20%)
margins, dydx(age) atmeans predict (e(0,.))

*10. Use the data in logit.dta for answering questions below:
use "$data/logit.dta", clear
*a. What is the lowest value of variable gre?
sum gre

*b. What does it mean for our dataset when we had censored data if the range of possible gre scores is 200 to 800?

*c. Estimate a tobit model for gre with all of the explanatory variables! Interpret gpa! (hint: use lower limit and upper limit specified in parentheses)
tobit gre admit topnotch gpa, ll(200)ul(800)
tobit gre admit topnotch gpa, ul(800)
margins, dydx(*) atmeans predict (e(200,800))

log close
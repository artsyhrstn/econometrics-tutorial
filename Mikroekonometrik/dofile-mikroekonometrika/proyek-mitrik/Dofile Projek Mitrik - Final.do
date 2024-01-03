//--------------------------DUPLICATE------------------------------\\
duplicates report pidlink
duplicates report hhid14 pid14

//--------------------Sikat Gigi---------------------------\\
tab fma01a, m
drop if fma01a== "Y"
drop if fma01a== "Z"
drop if fma01a==""
drop if fma01a=="ABCDF"
drop if fma01a=="ABCF"
drop if fma01a=="ABF"
drop if fma01a=="ABCDF"
drop if fma01a=="ACF"
drop if fma01a=="AF"
gen sigit=(fma01a== "AB" | fma01a== "ABC" | fma01a== "ABCD" | fma01a== "ABD" | fma01a== "AC" | fma01a== "ACD" | fma01a== "AD" | fma01a== "BC" | fma01a== "BD" | fma01a== "CD")
tab sigit
br
drop fma01a fma01 module version
clear

//--------------------Frekuensi ke Dokter-----------------------\\
*DROP (karena tidak ada spesifikasi fokter praktek - Dokter Gigi)

//--------------------Makanan Manis-----------------------------\\
clear
drop version module fma03
drop if fma02== 9
keep if fmatype== "Q"
tab fmatype fma02
drop fmatype
br

gen manis=(fma02== 1)
drop fma02

//--------------------Fast Food-----------------------------\\
drop version module fma03
drop if fma02== 9
keep if fmatype== "L"
tab fmatype fma02
drop fmatype
br

gen fasf=(fma02== 1)
drop fma02

//--------------------Gorengan-----------------------------\\
drop version module fma03
drop if fma02== 9
keep if fmatype== "O"
tab fmatype fma02
drop fmatype
br

gen gor=(fma02== 1)
drop fma02
tab gor

//--------------------Soda-----------------------------\\
drop version module fma03
drop if fma02== 9
keep if fmatype== "M"
tab fmatype fma02
drop fmatype
br

gen soda=(fma02== 1)
drop fma02

//--------------------Vitamin-----------------------------\\
drop version module psa02 psa02x
tab psa01, m
drop if psa01== 9
keep if psatype== "E"
tab psatype psa01
drop psatype
br

gen vit=(psa01== 1)
drop psa01

//--------------------Umur Anak-----------------------------\\
keep pidlink hhid14 hhid14_9 pid14 age 
br

//--------------------Sex-----------------------------\\
keep pidlink hhid14 hhid14_9 pid14 sex
tab sex, m
gen kelamin=(sex== 1)
br
drop sex

//--------------------Sayuran Hijau-----------------------------\\
clear
drop version module fma03
drop if fma02== 9
keep if fmatype== "F"
tab fmatype fma02
drop fmatype
br

gen sayur=(fma02== 1)
drop fma02

//--------------------Pendidikan Ortu-----------------------------\\
keep pidlink hhid14 hhid14_9 pid14 baa06
tab baa06, m
drop if baa06==98
drop if baa06==11
drop if baa06==12
drop if baa06==15
drop if baa06==95
drop if baa06==. 
clear
tab baa06
recode baa06 (1 = 1) (2 14 72 = 2) (3 4 73=3) (5 6 74 =4) (60 61 62 63=5)
ren baa06 educp
la de teeth_brush 1"No schooling" 2"Elementary school" 3"Junior high school" 4"Senior high school" 5"University"
la val educp teeth_brush
tab educp if educp==1

duplicates report pidlink 
duplicates report hhid14 pid14
//---------------------MERGER-------------------------\\
//---------------------MERGER-------------------------\\
//---------------------MERGER-------------------------\\

use "C:\Users\user\Documents\MIKROEKONOMETRIKA\Projek\Sakit Gigi.dta", clear
br

duplicates report pidlink 
duplicates report hhid14 pid14

merge 1:1 hhid14 pid14 using "C:\Users\user\Documents\MIKROEKONOMETRIKA\Projek\fastfood.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid14 pid14 using "C:\Users\user\Documents\MIKROEKONOMETRIKA\Projek\gor.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid14 pid14 using "C:\Users\user\Documents\MIKROEKONOMETRIKA\Projek\makanan manis.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid14 pid14 using "C:\Users\user\Documents\MIKROEKONOMETRIKA\Projek\1=2 atau lebih dan 0=2 kurang.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid14 pid14 using "C:\Users\user\Documents\MIKROEKONOMETRIKA\Projek\soda.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid14 pid14 using "C:\Users\user\Documents\MIKROEKONOMETRIKA\Projek\kelamin.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid14 pid14 using "C:\Users\user\Documents\MIKROEKONOMETRIKA\Projek\Umur Anak.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid14 pid14 using "C:\Users\user\Documents\MIKROEKONOMETRIKA\Projek\Sayur.dta"
keep if _merge==3
drop _merge

//---------------------RENAME----------------------------\\
//---------------------RENAME----------------------------\\
//---------------------RENAME----------------------------\\

br
count
rename sagit thache
rename fas fastf
rename gor friedf
rename manis sweetf
rename sigit brusht
rename kelamin sex
rename sayur veg

//---------------------DUMMY AGES----------------------------\\
//---------------------DUMMY AGES----------------------------\\
//---------------------DUMMY AGES----------------------------\\

gen ages=(age==7 | age==8 | age==9 | age==10 | age==11 | age==12 | age==13 | age==14)

//---------------------LIMITATION----------------------------\\
//---------------------LIMITATION----------------------------\\
//---------------------LIMITATION----------------------------\\

keep if age >= 2
count
br
tab age 
tab ages

//---------------------OLS REGRESSION----------------------------\\
//---------------------OLS REGRESSION----------------------------\\
//---------------------OLS REGRESSION----------------------------\\
reg thache sweetf fastf friedf soda brusht ages sex veg
hettest
vif 
reg thache sweetf fastf friedf soda brusht ages sex veg, robust

//---------------------LOGIT REGRESSION----------------------------\\
//---------------------LOGIT REGRESSION----------------------------\\
//---------------------LOGIT REGRESSION----------------------------\\

logit thache sweetf fastf friedf soda brusht ages sex veg, robust
mfx


// Nama : Hisbi Asyihristani
// NPM : 120610210018

// Latihan Lab 6

//1. Membuat Macro directory dan log dengan gunakan data "wage1" dari Boston College

cd "C:\Users\hisbi\iCloudDrive\Stata_Hisbi"
global data "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\data"
global log "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\log"
global output "C:\Users\hisbi\iCloudDrive\Stata_Hisbi\output"

log using "$log/latihanlab6"

bcuse wage1.dta

// DUMMY VARIABEL

// 2. Melihat data apa yang digunakan dan berapa banyak variabel dan jumlah observasi.
desc
// Variabel = 24
// Observasi = 526

//3. Lakukan estimasi nilai pengaruh dari tingkat pendidikan, pengalaman, gender jika perempuan (female), dan status pernikahan (married) terhadap upah. Lakukan interpretasi pada female.

reg wage educ exper female married

// Interpretasi Female
// Jika terdapat 2 individu yang memiliki karakteristik yang sama namun salah satu individu female maka akan memiliki tingkkat upah dibawah rata-rata sebesar $2.06 daripada upah laki laki, ceteris paribus

//4. Buatlah variabel interaksi antara perempuan dan menikah dengan nama "femmarr"

gen femmar=female*married

//5. Lakukan Estimasi nilai dari gaji dipengaruhi oleh tingkat pendidikan, pengalaman, gender jika perempuan, status pernikahan, serta jika individu itu perempuan dan sudah menikah. Lakukan interpretasi pada femmarr.

reg wage educ exper female married femmar
// Interpretasi femmar
// Jika terdapat 2 individu yang memiliki karakteristik yang sama namun salah satu individu merupakan female married (perempuan yang sudah menikah) maka akan memiliki tingkat upah dibawah rata-rata sebesar $-1.0510783 daripada upah laki laki yang belum menikah, ceteris paribus
di -.4237263+2.079997-2.707349

// Base gropunya -- single male, karena 
// female + married + femmar

// ------ Jika variabel interaksi single married dan male ---
gen malmarr=(1-female)*married
reg wage educ exper female married malmarr
// Jika terdapat 2 individu yang memiliki karakteristik yang sama namun salah satu individu merupakan male married (laki laki yang sudah menikah) maka akan memiliki tingkat upah diatas rata-rata sebesar $2.07 daripada upah perempuan yang belum menikah, ceteris paribus
// male + married + malmarr
// -.6273519+2.707349
display -.4237263+(-.6273519)


//6. Hitunglah perbedaan upah antara perempuan yang menikah dengan laki-laki yang menikah
// Married = 2080
// femmarr = -1.0510783
display 2.080-(-1.0510783)
// Hasil = 3.1310783

// Jika terdapat 2 individu dengan karakteristik yang sama namun salah satu individu adalah laki laki yang sudah menikah maka rata rata upah yang diterima lebih tinggi sebesar $3.13 individu lain ceteris paribus.

// -------------------- MULTIKOLINEARITAS --------------------
// 7. Bersihkan data dan input data kembali dari bosten college dengan nama data "discrim.dta"

bcuse discrim.dta, clear

// 8. Melihat Deskripsi data yang digunakan.

describe

// 9. Misal kita ingin melihat apakah restoran makanan cepat saji menjual makanan/minuman lebih mahal di daerah yang orang kulit hitamnya lebih banyak (proporsinya lebih tinggi), sekaligus ingin melihat elastisitas-harga-pendapatan. Lakukan regresi antara log harga kentang goreng, prpblck, log income dan log density.

reg lpfries prpblck lincome ldensity

// 10. Dengan uji VIF, apakah terdapat gejala multikolinearitas pada model di atas?

vif
// Hipotesis
// H0: Tidak terdapat multikolinearitas
// Ha: Terdapat multikolinearitas

Hasil = Mean VIF = 1.34
		R2 = 0.13 /13%
		Mean vif < 5 = Ho tidak terdapat masalah multikolinearitas
		
// Uji Kriteria
// H0 ditolak : Jika nilai mean vif ≥ 5 (0-80% ≥ R^2) atau mean vif ≥10 (90%≥ R^2)
// H0 tidak dapat ditolak : Jika nilai mean vif < 5 dan mean vif < 10
// (jika R squarenya nilainy antara 80-90 maka pake vif nya 5)

// 11. Tambahkan variabel proporsi masyarakat miskin pada model sebelumnya? Apa akibat dari penambahan variabel tersebut?

reg lpfries prpblck lincome ldensity prppov

// Saat menambahkan prppov prpblack menjadi tidak signifikan, sebelumnya tidak signifikan, dimana sebelumnya variabel tersebut signifikan pada tingkat 10% (terjadi perubahan tingakt signifikansi,p value)

// 12. Hitung korelasi antara variabel proporsi masyarakat berkulit hitam (prpblck) dengan proporsi masyarakat yang miskin (prppov), kemudian lakukan uji multikol.

correlate prpblck prppov

// ----- UJI MULTIKOLINEARITAS--------
// Hasil = 0.6803

H0 tidak dapat ditolak

Kesimpulan
dengan tngkat signifikansi 5%, tidak terdapat masalah multikolinearitatas dalam model
// 13. Log Close

log close





































































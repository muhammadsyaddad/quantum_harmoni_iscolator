#import "@preview/charged-ieee:0.1.4": ieee
#let hbar = math.planck.reduce
#let partial  =  math.partial

#show: ieee.with(
  title: [Visualisasi Fungsi Wigner Saat Fock State Pada Osilator Harmonik],
  abstract: [
    The Wigner function represents the state of a quantum system within position and momentum phase space, resembling a probability distribution in classical mechanics.However, unlike the classical case, the Wigner function can take on negative values for certain states, such as Fock states. This negativity serves as an indicator of non-classical properties that are difficult to grasp through visual intuition alone. Therefore, computational assistance is required; in this instance, we will utilize Python libraries
  ],
  authors: (
    (
      name: "Muhammad syaddad",
      department: [Student],
      organization: [UIN JKT],
      location: [Jakarta, Indonesia],
      email: "muhamsyaddad@gmail.com",
    ),
  ),
  index-terms: (
    "Harmonic Oscillator",
    "Wigner Function",
    "Fock State",
    "Visualitation Quantum",
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

= Introduction

Dalam mekanika klasik, objek memiliki perilaku-perilaku yang pasti pada ruang dan waktu. Lebih jauh lagi, kita bisa menghitungnya dengan bilangan riil. Nilai-nilai tersebut pasti dan ada bahkan ketika kita tidak mengamatinya. Kita tidak perlu menggunakan simbol-simbol atau istilah-istilah yang rumit di persoalan ini.

Dalam mekanika kuantum, perilaku dari setiap objek pada ruang dan waktu menghasilkan nilai yang sedikit acak (random). Maka dari itu, tidak ada kepastian yang pasti dijamin selayaknya persoalan klasik. Dalam kasus kuantum, persoalan ini dihitung dengan kemungkinan (probabilitas) dalam prinsip dasar mekanika kuantum @griffiths2018..

Untuk memahami perilaku yang anomali ini, di mekanika kuantum, objeknya sendiri dibayangkan sebagai gelombang, yaitu fungsi gelombang yang didasari oleh fungsi kompleks (z=x+iy). Hal ini bisa diukur melalui penghitungan kemungkinan dari kuadrat nilai mutlak itu sendiri. Ini menunjukkan terdapat perbedaan fundamental.

Kasus yang lain adalah ketika kita menghitung kemungkinan. Pada mekanika klasik, kemungkinan akan selalu positif. Semisal Asep melempar koin selama 100 kali, 60 di antaranya muncul kepala dan sisanya muncul ekor. Kita bisa menghitung kemungkinan dengan membagi jumlah muncul suatu kejadian dengan total berapa kali percobaan. Kita dapatkan untuk kepala = 60% dan ekor = 40%. Dengan dua angka di atas, kita bisa mengambil makna bahwasannya pada percobaan Asep, kemungkinan yang muncul paling banyak setelah 100 kali percobaan adalah kepala. Tidak mungkin dan tidak masuk akal jikalau kita mendapatkan nilai yang minus pada kasus ini. Namun, perilaku di atas tidak selalu berlaku jika kita berada di dunia kuantum (khususnya dalam representasi fungsi Wigner), karena kemungkinan minus bukan merupakan kesalahan atau kecacatan sistem itu sendiri.

Dengan adanya anomali-anomali yang ada di dunia kuantum, kita bisa membantu diri kita memahami apa yang sebenarnya terjadi dengan bantuan komputer. Pendekatan komputasi dan visualisasi semacam ini telah menjadi metode penting dalam pembelajaran fisika kuantum modern @alvarez2023. Di sini kita akan memakai pustaka Python yaitu qmsolve (atau pustaka lain yang relevan). Ada banyak library lain yang bagus di Python untuk menganimasikan ini juga seperti Manim, Qiskit, dan sebagainya.

= Quantum Harmonik Osilator
Persamaan osilator harmonis kuantum satu dimensi dideskripsikan oleh Hamiltonian:

$ H = p^2 / (2m) + 1/2 m omega^2 x^2 $

Tujuannya adalah menghitung energi total. Makna fisis dari rumus ini adalah: Energi total = Energi kinetik $(p^2 / 2m)$ + Energi potensial $(1/2 m omega^2 x^2)$.

Karena persamaan Hamiltonian ini klasik, kita harus mengubah variabel fisik menjadi operator dengan $x -> hat(x)$ dan $p -> -i hbar d/(d x)$. Maka persamaan berubah menjadi:

$ hat(H) = - hbar^2 / (2m) d^2 / (d x^2) + 1/2 m omega^2 hat(x)^2 $

Kemudian kita substitusikan ke persamaan eigen $hat(H)psi(x) = E psi(x)$ yang kemudian menjadi:

$ [- hbar^2 / (2m) d^2 / (d x^2) + 1/2 m omega^2 x^2] psi(x) = E psi(x) $

Kita menggunakan metode deret pangkat untuk menyelesaikan persamaan tersebut, yang menghasilkan solusi energi:

$ E_n = (n + 1/2) hbar omega $

Di sini kita mendapatkan energi eigen. Perhatikan bahwa untuk $n = {0, 1, 2, 3, ...}$, jika kita masukkan $n=0$, kita akan mendapat nilai $E_0 = 1/2 hbar omega$. Ini menandakan bahwa pada state apapun, energi pada mekanika kuantum tidak pernah nol; dengan kata lain, partikel selalu memiliki fluktuasi gerak.

Untuk setiap tingkat energi $n$ di atas, kita memiliki fungsi gelombang yang memberitahu probabilitas posisi partikel, dengan fungsi sebagai berikut:

$ psi_n (x) = N dot e^(-x^2/2) dot H_n (x) $

Di mana $N$ adalah konstanta normalisasi, $e^(-x^2/2)$ adalah fungsi Gaussian (kurva lonceng) yang membuat partikel terlokalisasi di tengah, dan $H_n (x)$ adalah Polinomial Hermite yang memberikan sifat osilasi gelombang (_ripple_).






= Wigner Function

Setelah kita mendapatkan fungsi gelombang $psi_n(x)$ dari persamaan Schrödinger, kita menghadapi masalah baru: fungsi tersebut hanya memberi tahu probabilitas posisi. Di mekanika klasik, kita terbiasa mengetahui posisi $x$ dan momentum $p$ secara bersamaan (Ruang Fase).

Untuk menjembatani hal ini, kita menggunakan transformasi Fungsi Wigner yang pertama kali diperkenalkan pada tahun 1932 @wigner1932. Tujuannya adalah memetakan keadaan kuantum ke dalam ruang fase $(x, p)$ agar bisa dibandingkan dengan intuisi klasik. Definisi matematisnya adalah:

$ W(x,p) = 1 / (pi hbar) integral_(-infinity)^infinity psi^* (x+y) psi (x-y) e^((2i p y)/hbar) d y $

Makna fisis dari rumus integral ini cukup dalam.
Pertama, suku $psi^* (x+y) psi (x-y)$ adalah bentuk "autokorelasi", yang berarti kita membandingkan fungsi gelombang dengan dirinya sendiri yang digeser sejauh $+y$ dan $-y$ dari titik pusat $x$.
Kedua, suku $e^((2i p y)/hbar)$ adalah komponen Transformasi Fourier.

Jadi, persamaan ini melakukan "scanning" terhadap fungsi gelombang di seluruh ruang posisi, lalu menerjemahkan osilasinya menjadi informasi momentum.

Sekarang, kita substitusikan solusi Osilator Harmonis ($psi_n$ yang berisi Polinomial Hermite) ke dalam integral di atas. Proses matematika ini sangat panjang, namun hasil akhirnya sangat elegan:

$ W_n (x,p) = (-1)^n / (pi hbar) dot e^(-(2H)/(hbar omega)) dot L_n ((4H)/(hbar omega)) $

Agar lebih mudah dipahami secara visual, biasanya kita menggunakan satuan tak berdimensi (di mana $hbar=1, m=1, omega=1$), sehingga persamaannya menjadi lebih sederhana:

$ W_n (x,p) = (-1)^n / pi dot e^(-(x^2+p^2)) dot L_n (2(x^2+p^2)) $

Di sini terjadi perubahan matematika yang krusial dan memiliki makna fisis penting:

1.  Transformasi Polinomial: Perhatikan bahwa $H_n$ (Polinomial Hermite) pada fungsi gelombang telah berubah menjadi $L_n$ (Polinomial Laguerre) pada fungsi Wigner. Polinomial Laguerre inilah yang bertanggung jawab menciptakan struktur cincin pada grafik ruang fase.
2.  Amplop Gaussian: Suku $e^{-(x^2+p^2)}$ menunjukkan bahwa probabilitas terdistribusi dalam bentuk bulatan simetris di sekitar titik pusat $(0,0)$.
3.  Negativitas (Tanda Tangan Kuantum): Faktor $(-1)^n$ dan osilasi dari $L_n$ menyebabkan fungsi ini bisa bernilai negatif di daerah tertentu (lembah di antara cincin).

Nilai negatif ini adalah bukti fenomena Interferensi Kuantum. Dalam fisika klasik, probabilitas tidak mungkin negatif. Oleh karena itu, keberadaan nilai negatif pada $W_n(x,p)$ menunjukkan bahwa keadaan Fock State ($n >= 1$) adalah keadaan non-klasik murni, sebuah konsep yang fundamental dalam optika kuantum @gerry2005.
#place(
  top, // Letakkan di bagian atas halaman
  float: true,
  figure(
    image("1.png", width: 100%), // Gunakan 100% agar memenuhi lebar kertas
    caption: [Distribusi fungsi Wigner pada keadaan tereksitasi ($0 < n < 10$)],
  )
) <fig2>


= Computational Visualitation

== Keadaan Dasar ($n=0$)

Visualisasi pertama difokuskan pada keadaan dasar dengan bilangan kuantum $n=0$. Sebagaimana diperlihatkan pada Gambar 1, distribusi fungsi Wigner menampilkan bentuk puncak tunggal Gaussian yang terpusat tepat di titik nol ruang fase ($x=0, p=0$). Karakteristik paling menonjol dari plot ini adalah skema warnanya yang didominasi oleh rona merah dan kuning, yang mengindikasikan bahwa seluruh nilai fungsi adalah positif. Ketiadaan nilai negatif pada fase ini menandakan absennya interferensi kuantum yang bersifat destruktif. Dalam kerangka korespondensi klasik-kuantum, keadaan dasar ini merepresentasikan perilaku yang paling mendekati partikel klasik saat diam di titik kesetimbangan potensial, di mana probabilitas posisi dan momentum terdefinisi dengan baik tanpa gangguan osilasi non-klasik.

#place(
  top, // Letakkan di bagian atas halaman
  float: true,
  scope: "parent", // INI KUNCINYA: agar dia mengambil lebar "induk" (halaman), bukan lebar kolom
  figure(
    image("2.png", width: 100%), // Gunakan 100% agar memenuhi lebar kertas
    caption: [Distribusi fungsi Wigner pada keadaan tereksitasi ($0 < n < 10$)],
  )
) <fig2>

== Keadaan Tereksitasi Rendah ($0 < n < 10$)

Pada bagian kedua yang ditunjukkan oleh Gambar 2, simulasi dilakukan untuk lima variasi bilangan kuantum rendah, yaitu $n=1, 2, 4, 6,$ dan $8$. Perubahan topologi yang drastis terlihat jelas jika dibandingkan dengan keadaan dasar. Struktur distribusi tidak lagi berupa satu puncak pusat, melainkan terpecah menjadi serangkaian cincin konsentris.

Fenomena yang paling signifikan di sini adalah munculnya area berwarna biru gelap di antara cincin-cincin merah tersebut. Area ini merepresentasikan nilai negatif pada fungsi Wigner. Mengingat bahwa probabilitas negatif adalah hal yang mustahil dalam fisika statistik klasik, keberadaan lembah-lembah negatif ini menjadi bukti visual langsung dari sifat non-klasik atau interferensi kuantum sistem. Semakin besar nilai $n$, jumlah cincin atau node akan bertambah menyesuaikan dengan jumlah simpul pada fungsi gelombang Hermite-Laguerre.


#place(
  top, // Letakkan di bagian atas halaman
  float: true,
  scope: "parent", // INI KUNCINYA: agar dia mengambil lebar "induk" (halaman), bukan lebar kolom
  figure(
    image("3.png", width: 100%), // Gunakan 100% agar memenuhi lebar kertas
    caption: [Distribusi fungsi Wigner pada keadaan tereksitasi ($n > 10$)],
  )
) <fig3>


== Keadaan Tereksitasi Tinggi ($n > 10$)

Bagian ketiga pada Gambar 3 menampilkan evolusi sistem pada bilangan kuantum besar, mulai dari $n=10$ hingga $n=50$. Secara intuitif, sering diasumsikan bahwa pada tingkat energi tinggi atau bilangan kuantum besar, sistem kuantum akan berperilaku menyerupai sistem klasik. Namun, visualisasi ini justru mengungkapkan sebuah paradoks.

Meskipun nilai $n$ sudah sangat besar, nilai negatif yang ditandai warna biru tidak menghilang. Osilasi antara nilai positif dan negatif justru menjadi semakin rapat dengan frekuensi yang meningkat drastis. Keberadaan cincin-cincin halus ini menunjukkan bahwa pada skala mikroskopis, sistem tetap mempertahankan sifat gelombangnya. Limit klasik, di mana benda bergerak pada lintasan orbital yang mulus, hanya dapat tercapai jika kita melakukan proses perata-rataan atau averaging atas osilasi cepat ini akibat keterbatasan resolusi alat ukur makroskopis, Studi menunjukkan bahwa tanpa proses smoothing tersebut, jejak kuantum tetap bertahan @mostowski2021.. Tanpa proses tersebut, fungsi Wigner menunjukkan bahwa karakteristik kuantum sistem tetap bertahan bahkan di tingkat energi tinggi.


= Conclusion

Berdasarkan studi komputasi dan visualisasi fungsi Wigner untuk osilator harmonik kuantum pada keadaan Fock, dapat ditarik beberapa kesimpulan utama mengenai karakteristik topologi sistem. Terdapat perbedaan yang sangat drastis antara keadaan dasar ($n=0$) dan keadaan tereksitasi ($n > 0$). Keadaan dasar menampilkan distribusi Gaussian yang sepenuhnya positif menyerupai distribusi probabilitas partikel klasik yang diam, sedangkan keadaan tereksitasi justru menampilkan pola cincin konsentris dengan osilasi nilai fungsi. Simulasi pada rentang bilangan kuantum rendah secara spesifik memperlihatkan keberadaan area bernilai negatif yang mengonfirmasi bahwa fungsi Wigner tidak dapat dianggap sebagai distribusi probabilitas konvensional. Negativitas ini berfungsi sebagai indikator visual utama dari sifat non-klasik dan interferensi kuantum yang inheren pada sistem tersebut.

Selain itu, hasil komputasi pada bilangan kuantum besar ($n=10$ hingga $n=50$) mengungkapkan adanya paradoks limit klasik, di mana sifat non-klasik ternyata tidak menghilang seiring bertambahnya energi. Alih-alih menyatu menjadi lintasan klasik yang mulus, fungsi Wigner justru menunjukkan osilasi yang semakin rapat dan kompleks dengan nilai negatif yang tetap bertahan. Fenomena ini mengindikasikan bahwa transisi ke limit klasik tidak terjadi semata-mata dengan menaikkan bilangan kuantum, melainkan memerlukan mekanisme perata-rataan atau averaging akibat keterbatasan resolusi pengukuran makroskopis. Secara keseluruhan, pendekatan komputasi ini terbukti efektif untuk memvisualisasikan konsep abstrak ruang fase kuantum, khususnya dalam mendemonstrasikan bagaimana fitur non-klasik tetap bertahan jauh melampaui keadaan dasar.

// ... (Bagian Conclusion di atas sini) ...

= Code Availability

Semua code yang ada untuk membuat keberadan makalah ini ada link bawah

1.  Source Code Naskah: Dokumen ini ditulis menggunakan Typst (`.typ`) untuk memastikan format yang konsisten dan dapat direproduksi.
2.  Simulasi Komputasi: Kode Python yang digunakan untuk menghasilkan plot Fungsi Wigner dan animasi visualisasi.

Repositori lengkap dapat diakses melalui tautan berikut:
#align(center)[
  #link("https://github.com/muhammadsyaddad/quantum_harmoni_iscolator")[https://github.com/muhammadsyaddad/quantum_harmoni_iscolator]
]

// ... (Bagian Bibliography di bawah sini) ...

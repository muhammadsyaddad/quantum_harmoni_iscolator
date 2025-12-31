#import "@preview/charged-ieee:0.1.4": ieee
#let hbar = math.planck.reduce

#show: ieee.with(
  title: [Visualisasi Fungsi Wigner Saat Fock State Pada Osilator Harmonik],
  abstract: [
    Fungsi Wigner merepresentasikan keadaan sistem kuantum dalam ruang fase posisi dan momentum, menyerupai distribusi probabilitas pada mekanika klasik. Namun, berbeda dengan kasus klasik, fungsi Wigner dapat memiliki nilai negatif pada keadaan tertentu, seperti pada keadaan Fock. Negativitas ini merupakan indikator sifat non-klasik yang sulit dipahami hanya melalui intuisi visual. Oleh karena itu, bantuan komputer di perlukan untuk ini, di kasus ini kita memakai pustaka python qmsolve.
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
    "Oscilator Harmonik",
    "Fungis Wigner",
    "Fock State",
    "Visualisasi Quantum",
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

= Introduction

Dalam mekanika klasik, objek memiliki perilaku-perilaku yang pasti pada ruang dan waktu. Lebih jauh lagi, kita bisa menghitungnya dengan bilangan riil. Nilai-nilai tersebut pasti dan ada bahkan ketika kita tidak mengamatinya. Kita tidak perlu menggunakan simbol-simbol atau istilah-istilah yang rumit di persoalan ini.

Dalam mekanika kuantum, perilaku dari setiap objek pada ruang dan waktu menghasilkan nilai yang sedikit acak (random). Maka dari itu, tidak ada kepastian yang pasti dijamin selayaknya persoalan klasik. Dalam kasus kuantum, persoalan ini dihitung dengan kemungkinan (probabilitas).

Untuk memahami perilaku yang anomali ini, di mekanika kuantum, objeknya sendiri dibayangkan sebagai gelombang, yaitu fungsi gelombang yang didasari oleh fungsi kompleks (z=x+iy). Hal ini bisa diukur melalui penghitungan kemungkinan dari kuadrat nilai mutlak itu sendiri. Ini menunjukkan terdapat perbedaan fundamental.

Kasus yang lain adalah ketika kita menghitung kemungkinan. Pada mekanika klasik, kemungkinan akan selalu positif. Semisal Asep melempar koin selama 100 kali, 60 di antaranya muncul kepala dan sisanya muncul ekor. Kita bisa menghitung kemungkinan dengan membagi jumlah muncul suatu kejadian dengan total berapa kali percobaan. Kita dapatkan untuk kepala = 60% dan ekor = 40%. Dengan dua angka di atas, kita bisa mengambil makna bahwasannya pada percobaan Asep, kemungkinan yang muncul paling banyak setelah 100 kali percobaan adalah kepala. Tidak mungkin dan tidak masuk akal jikalau kita mendapatkan nilai yang minus pada kasus ini. Namun, perilaku di atas tidak selalu berlaku jika kita berada di dunia kuantum (khususnya dalam representasi fungsi Wigner), karena kemungkinan minus bukan merupakan kesalahan atau kecacatan sistem itu sendiri.

Dengan adanya anomali-anomali yang ada di dunia kuantum, kita bisa membantu diri kita memahami apa yang sebenarnya terjadi dengan bantuan komputer. Di sini kita akan memakai pustaka Python yaitu qmsolve (atau pustaka lain yang relevan). Ada banyak library lain yang bagus di Python untuk menganimasikan ini juga seperti Manim, Qiskit, dan sebagainya.

= Quantum Harmonik Oscilator
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

Di mana $N$ adalah konstanta normalisasi, $e^(-x^2/2)$ adalah fungsi Gaussian (kurva lonceng) yang membuat partikel terlokalisasi di tengah, dan $H_n (x)$ adalah Polinoma Hermite yang memberikan sifat osilasi gelombang (_ripple_).






= Wigner Function

Setelah kita mendapatkan fungsi gelombang $psi_n(x)$ dari persamaan Schrödinger, kita menghadapi masalah baru: fungsi tersebut hanya memberi tahu probabilitas posisi. Di mekanika klasik, kita terbiasa mengetahui posisi $x$ dan momentum $p$ secara bersamaan (Ruang Fase).

Untuk menjembatani hal ini, kita menggunakan transformasi Fungsi Wigner. Tujuannya adalah memetakan keadaan kuantum ke dalam ruang fase $(x, p)$ agar bisa dibandingkan dengan intuisi klasik. Definisi matematisnya adalah:

$ W(x,p) = 1 / (pi hbar) integral_(-infinity)^infinity psi^* (x+y) psi (x-y) e^((2i p y)/hbar) d y $

Makna fisis dari rumus integral ini cukup dalam.
Pertama, suku $psi^* (x+y) psi (x-y)$ adalah bentuk "autokorelasi", yang berarti kita membandingkan fungsi gelombang dengan dirinya sendiri yang digeser sejauh $+y$ dan $-y$ dari titik pusat $x$.
Kedua, suku $e^((2i p y)/hbar)$ adalah komponen Transformasi Fourier.

Jadi, persamaan ini melakukan "scanning" terhadap fungsi gelombang di seluruh ruang posisi, lalu menerjemahkan osilasinya menjadi informasi momentum.

Sekarang, kita substitusikan solusi Osilator Harmonis ($psi_n$ yang berisi Polinoma Hermite) ke dalam integral di atas. Proses matematika ini sangat panjang, namun hasil akhirnya sangat elegan:

$ W_n (x,p) = (-1)^n / (pi hbar) dot e^(-(2H)/(hbar omega)) dot L_n ((4H)/(hbar omega)) $

Agar lebih mudah dipahami secara visual, biasanya kita menggunakan satuan tak berdimensi (di mana $hbar=1, m=1, omega=1$), sehingga persamaannya menjadi lebih sederhana:

$ W_n (x,p) = (-1)^n / pi dot e^(-(x^2+p^2)) dot L_n (2(x^2+p^2)) $

Di sini terjadi perubahan matematika yang krusial dan memiliki makna fisis penting:

1.  Transformasi Polinoma: Perhatikan bahwa $H_n$ (Polinoma Hermite) pada fungsi gelombang telah berubah menjadi $L_n$ (Polinoma Laguerre) pada fungsi Wigner. Polinoma Laguerre inilah yang bertanggung jawab menciptakan struktur cincin pada grafik ruang fase.
2.  Amplop Gaussian: Suku $e^{-(x^2+p^2)}$ menunjukkan bahwa probabilitas terdistribusi dalam bentuk bulatan simetris di sekitar titik pusat $(0,0)$.
3.  Negativitas (Tanda Tangan Kuantum): Faktor $(-1)^n$ dan osilasi dari $L_n$ menyebabkan fungsi ini bisa bernilai negatif di daerah tertentu (lembah di antara cincin).

Nilai negatif ini adalah bukti fenomena Interferensi Kuantum. Dalam fisika klasik, probabilitas tidak mungkin negatif. Oleh karena itu, keberadaan nilai negatif pada $W_n(x,p)$ menunjukkan bahwa keadaan Fock State ($n >= 1$) adalah keadaan non-klasik murni.
// == Paper overview
// In this paper we introduce Typst, a new typesetting system designed to streamline the scientific writing process and provide researchers with a fast, efficient, and easy-to-use alternative to existing systems. Our goal is to shake up the status quo and offer researchers a better way to approach scientific writing.

// By leveraging advanced algorithms and a user-friendly interface, Typst offers several advantages over existing typesetting systems, including faster document creation, simplified syntax, and increased ease-of-use.

// To demonstrate the potential of Typst, we conducted a series of experiments comparing it to other popular typesetting systems, including LaTeX. Our findings suggest that Typst offers several benefits for scientific writing, particularly for novice users who may struggle with the complexities of LaTeX. Additionally, we demonstrate that Typst offers advanced features for experienced users, allowing for greater customization and flexibility in document creation.

// Overall, we believe that Typst represents a significant step forward in the field of scientific writing and typesetting, providing researchers with a valuable tool to streamline their workflow and focus on what really matters: their research. In the following sections, we will introduce Typst in more detail and provide evidence for its superiority over other typesetting systems in a variety of scenarios.

// = Methods <sec:methods>
// #lorem(45)

// $ a + b = gamma $ <eq:gamma>

// #lorem(80)

// #figure(
//   placement: none,
//   circle(radius: 15pt),
//   caption: [A circle representing the Sun.],
// ) <fig:sun>

// In @fig:sun you can see a common representation of the Sun, which is a star that is located at the center of the solar system.

// #lorem(120)

// #figure(
//   caption: [The Planets of the Solar System and Their Average Distance from the Sun],
//   placement: top,
//   table(
//     // Table styling is not mandated by the IEEE. Feel free to adjust these
//     // settings and potentially move them into a set rule.
//     columns: (6em, auto),
//     align: (left, right),
//     inset: (x: 8pt, y: 4pt),
//     stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
//     fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0 { rgb("#efefef") },

//     table.header[Planet][Distance (million km)],
//     [Mercury], [57.9],
//     [Venus], [108.2],
//     [Earth], [149.6],
//     [Mars], [227.9],
//     [Jupiter], [778.6],
//     [Saturn], [1,433.5],
//     [Uranus], [2,872.5],
//     [Neptune], [4,495.1],
//   ),
// ) <tab:planets>

// In @tab:planets, you see the planets of the solar system and their average distance from the Sun.
// The distances were calculated with @eq:gamma that we presented in @sec:methods.

// #lorem(240)

// #lorem(240)

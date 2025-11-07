# Pro Kit App

A very cool Football Shop.

## Pertanyaan README.md - Tugas 7

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.\
Jawaban:
    * **Widget tree** adalah kumpulan banyak widget/object yang membentuk suatu fitur User Interface pada suatu aplikasi.
    * Setiap widget berada dalam induknya dan mendapat "context" yang berasal dari induk. Cara bekerjanya, data dikirimkan kepada anak2nya melalui argumen constructor atau context
2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.\
Jawaban:
    * Custom widgets (dideklarasikan di file):
        * ```ProKitApp``` — root app widget yang mengembalikan ```MaterialApp```.
        * ```BasePage``` — halaman utama (home) yang membangun struktur UI utama (AppBar, body, grid).
        * ```InfoCard``` — kartu kecil untuk menampilkan judul + isi (NPM, Name, Class).
        * ```ItemHomepage``` — model data untuk item grid (nama, ikon, warna).
        * ```ItemCard``` — kartu grid untuk setiap ```ItemHomepage```, menampilkan ikon + nama dan menangani tap (menampilkan SnackBar).
    * Flutter framework widgets yang dipakai di dalam file dan fungsinya:
        * ```MaterialApp``` — konfigurasi aplikasi berbasis Material (tema, home, title).
        * ```Scaffold``` — struktur dasar halaman (AppBar + body).
        * ```AppBar``` — bar atas dengan judul dan ikon.
        * ```Row``` / ```Column``` — susunan horizontal / vertikal elemen.
        * ```Icon``` / ```Text``` — menampilkan ikon dan teks.
        * ```Padding``` / ```SizedBox``` / ```Center``` — spacing & alignment.
        * ```GridView.count``` — grid tiga kolom untuk menampilkan ItemCard.
        * ```Card``` / ```Container``` — elemen kotak untuk layout dan styling.
        * ```MediaQuery``` — membaca ukuran layar untuk responsif.
        * ```Material``` / ```InkWell``` — efek material dan deteksi tap pada ItemCard.
        * ```ScaffoldMessenger``` / ```SnackBar``` — menampilkan pesan saat item ditekan.
3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.\
Jawaban:
    * Fungsinya yaitu untuk membentuk aplikasi yang menggunakan Material Design. Widget ini sering digunakan sebagai root, karena mengimplementasi Material Design milik Google, sehingga menghasilkan komponen dan sifat Android-style UI 
4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?\
Jawaban:
    * **StatelessWidget** adalah widget yang tidak berubah (immutable). Bentuknya dan propertinya akan tetap terus. Sedangkan **StatefulWidget** adalah widget yang bisa berubah ketika aplikasi berjalan/run-time (mutable). Hal ini dikarenakan adanya fungsi state changes
    * **StatelessWidget** dipakai ketika UI yang kita buat tidak bergantung pada apapun kecuali pembuatan UI itu sendiri. Sedangkan **StatefulWidget** dipakai ketika UI yang kita buat ingin berubah sewaktu-waktu secara dinamis 
5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?\
Jawaban:
    * **BuildContext** adalah objek yang merepresentasi lokasi suatu widget dalam widget tree. Penting, karena **BuildContext** menyimpan banyak data terkait widget tersebut dan juga menghasilkan fungsionalitas esensial seperti mengambil styling inheritance dari parent, melakukan navigasi ke halaman yang diinginkan, melakukan responsif suatu aplikasi, dan lain-lain.
    * Cara penggunaannya, setiap widget di dalam aplikasi ketika dideklarasi, mempunyai element yang dibuat. Element ini memegang informasi runtime tentang widget, termasuk posisinya, parent, dan childrennya. Ketika mendapat **BuildContext** dari fungsi **build(BuildContext context)** sebenarnya kita memberikan informasi referensi ke Element itu tentang lokasinya di dalam tree. 
6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".\
Jawaban:
    * "Hot Reload" adalah fitur yang membantu kita untuk eksperimen dengan cepat dan mudah, dalam membangun User Interface, menambahkan fitur, dan memperbaiki bug serta hanya re-builds widget tree serta masih menyimpan app state. 
    * "Hot Restart" adalah fitur yang juga sama seperti "Hot Reload" tetapi bedanya, dia restart aplikasi dan reset app state aplikasinya. Sehingga seolah-olah mengulang semuanya dari nol
7. Jelaskan bagaimana kamu menambahkan navigasi untuk berpindah antar layar di aplikasi Flutter.\
Jawaban:
    * Pertama-tama kita membuat 2 route atau 2 widget utama yang mengextend **StatelessWidget**
    * Kedua, kita membuat sebuah tombol di suatu halaman, lalu isi ```onPressed:``` dengan alat bantu ```Navigator.push()```
    * Apabila ingin kembali ke halaman sebelumnya, isi ```onPressed:``` dengan alat bantu ```Navigator.pop()```
    * Untuk implementasi di keadaan lain, untuk membantu melakukan navigasi wajib/kudu ada ```Navigator.push()``` di dalam konstruktor ```onPressed:```


## Pertanyaan README.md - Tugas 8

1. Jelaskan perbedaan antara ```Navigator.push()``` dan ```Navigator.pushReplacement()``` pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Jawaban:
    * ```Navigator.pushReplacement(context, route)``` — mengganti route saat ini dengan route baru (route lama dihapus dari stack). Tidak memungkinkan kembali ke route yang digantikan.
    * ```Navigator.push(context, route)``` — menambahkan route baru ke atas stack. Pengguna bisa kembali ke route sebelumnya (pakai ```Navigator.pop()```). push mengembalikan object ```Future``` yang bisa dipakai untuk menerima hasil dari route yang dibuka.

    **Penggunaan dalam aplikasi Football shop:**
    * Kita memakai ```Navigator.push(context, route)``` untuk navigasi halaman yang ingin pengguna bisa kembali. Contohnya membuka detail produk, membuka halaman "Create Product" (supaya setelah selesai user bisa kembali atau mengirim data balik)
    * Kita memakai ```Navigator.pushReplacement(context, route)``` untuk alur yang tidak kembali, contohnya setelah login/splash -> home atau setelah checkout sukses agar user tidak kembali ke halaman pembayaran

2. Bagaimana kamu memanfaatkan hierarchy widget seperti ```Scaffold```, ```AppBar```, dan ```Drawer``` untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
    * Prinsipnya: gunakan ```Scaffold``` sebagai kerangka halaman, ```AppBar``` untuk title/aksi global yang bisa dilakukan user, dan ```Drawer``` untuk navigasi utama. Meletakkan logika/tampilan yang konsisten di satu tempat supaya semua halaman seragam dan mudah dipelihara
    * Praktik:
        * Membuat widget pembungkus (misal: ```Scaffold()``` yang menerima title, body, dan opsi (selected menu). Semua halaman pakai pembungkus)
        * Simpan item ```Drawer (ListTile)``` dalam satu sumber data (list of routes) lalu gunakan ```Navigator.push()``` / ```Navigator.pushReplacement()``` saat menavigasi
        * Taro aksi umum di ```AppBar()``` seperti Search, Cart agar konsisten
        * Gunakan ```ThemeData``` untuk warna yang konsisten dan gunakan responsive layout (```Drawer``` → NavigationRail / permanent drawer di tablet)
        * Tangani back/navigation secara konsisten (misal: highlight item aktif di Drawer)

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti ```Padding```, ```SingleChildScrollView```, dan ```ListView``` saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu
    * Kelebihan
        * ```Padding```: memberikan jarak konsisten antar elemen sehingga UI rapi dan mudah dibaca
        * ```SingleChildScrollView()```: mencegah overflow saat keyboard muncul atau layar kecil. Cocok untuk form pendek atau terbatas
        * ```ListView()```: otomatis scrollable dan mendukung lazy loading untuk form panjang atau daftar input dinamis (lebih hemat memori)
        * Kombinasi semuanya meningkatkan aksesibilitas, responsivitas, dan konsistensi tampilan 
    * Kapan dipakai:
        * Kita menggunakan ```SingleChildScrollView()``` + ```Column()``` untuk form singkat
        * Kita menggunakan ```ListView()``` untuk form panjang atau saat input dibuat/dihapus secara dinamis 


4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
    * Pilih 1-2 warna utama brand (primary & secondary) + warna netral (background, surface, text)
    * Terapkan di satu tempat memakai ```ThemeData```/ ```ColorScheme``` supaya konsisten di seluruh widget (```AppBar```, ```Button```, ```FloatingActionButton```, ```BottomNavigationBar```, ```Text```, ```Input```)
    * Gunakan nama warna/variabel (hex) daripada hardcode di banyak file. Panggil lewat ```Theme.of(context).colorScheme``` atau ```Theme.of(context).textTheme```.
    * Sesuaikan komponen penting: ```AppBarTheme```, ```ElevatedButtonTheme```, ```InputDecorationTheme```, ```BottomNavigationBarTheme```, dan ```TextTheme```.
    * Simpan logo/asset dan gunakan pada ```AppBar```/```Drawer``` untuk penguatan brand.
    * Lalu uji di beberapa ukuran layar dan gunakan hot reload untuk tes pengulangan secara cepat.
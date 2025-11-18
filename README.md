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



## Pertanyaan README.md - Tugas 9
1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan ```Map<String, dynamic>``` tanpa model (terkait validasi tipe, null-safety, maintainability)?
Jawaban:
    * Type-safety dan null-safety: Model dengan field bertipe jelas + constructor/validator mencegah runtime error (misal akses key salah/nullable). Dengan model, kesalahan tipe terdeteksi saat compile.
    * Konsistensi dan maintainability: Satu sumber kebenaran untuk struktur data. Perubahan skema backend cukup di satu tempat (model), tidak menyebar di seluruh kode.
    * Otomatisasi serialisasi: Memiliki factory fromJson/toJson membuat parsing/serialisasi andal dan mudah dites
    * IDE support: Autocomplete dan refactor aman.
    * Kalau langsung Map<String, dynamic>: raw keys rentan typo, nilai bisa null/tidak sesuai tipe, validasi menyebar, sulit dites dan dirawat.

2. Apa fungsi package _http_ dan _CookieRequest_ dalam tugas ini? Jelaskan perbedaan peran _http_ vs _CookieRequest_\
Jawaban:
    * http: Klien HTTP generik. Kamu mengelola header, cookie, dan autentikasi sendiri. Cocok untuk endpoint publik/stateless.
    *  CookieRequest (pbp_django_auth): Abstraksi di atas HTTP yang otomatis menyimpan/menyertakan session cookie (sessionid), menangani login/logout, dan (untuk web) dukung kredensial. Cocok untuk endpoint Django yang butuh sesi login.
    * Ringkasnya: http = manual, fleksibel; CookieRequest = stateful session dengan Django, login-aware.
3. Jelaskan mengapa _instance_ CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter\
Jawaban:
    * Session persistence: Login menyetel cookie sesi di satu instance. Semua request berikutnya harus memakai instance yang sama agar cookie (sessionid/CSRF) terkirim; kalau tidak dibagi, status login “hilang”.
    *  Satu sumber status autentikasi: Mudah membaca state (mis. loggedIn) di seluruh widget tree.
    * Praktik: Injeksi via dependency injection (mis. Provider/InheritedWidget) di root app, lalu diakses di layar mana pun.

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
Jawaban:
    * ALLOWED_HOSTS: Tambahkan "10.0.2.2" (bridge Android emulator ke host) agar Django menerima request dari emulator. Tanpa ini: 400 Bad Request (Invalid host header).
    *  CORS/credentials (terutama untuk Flutter Web): Aktifkan django-cors-headers, izinkan origin frontend, aktifkan CORS_ALLOW_CREDENTIALS bila pakai sesi. Tanpa ini: browser memblokir request/credential, cookie tak terkirim.
    * CSRF/Trusted origins: Tambahkan http://10.0.2.2:8000 pada CSRF_TRUSTED_ORIGINS agar Django menerima cookie CSRF untuk form/POST. Tanpa ini: 403 CSRF verification failed.
    * Cookie SameSite/secure (tergantung platform): Atur agar cookie sesi dapat terkirim lintas origin saat perlu (Web). Salah konfigurasi membuat login tak tersimpan.
    * Android Internet permission: Tambah ```<uses-permission android:name="android.permission.INTERNET" />``` di AndroidManifest. Tanpa ini: SocketException/Network unreachable.
5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.\
Jawaban:
    *  Input di Flutter: Form memvalidasi dan mengumpulkan data (lihat pola di CreateProduct).
    * Kirim ke backend:
        * Auth-aware:
        CookieRequest.postJson("http://10.0.2.2:8000/api/products/create/", jsonEncode(body));
        * Non-auth:
        http.post(uri, body/json)
    * Django menerima: View mem-parse body, validasi, simpan ke DB, dan mengembalikan JSON (mis. data item yang disimpan atau daftar terbaru).
    * Flutter menerima respons: Decode JSON → ubah ke model (Product.fromJson) → setState/State management untuk memicu rebuild UI.
    * Tampilkan: Gunakan ListView/GridView untuk merender list model.
6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter\
Jawaban:
    * Register:
        * Flutter kirim data akun (username, password, dst.) ke endpoint Django register.
        * Django buat User, balas sukses/err.
    * Login:
        * Flutter kirim credential ke endpoint login (CookieRequest.login).
        * Django autentikasi; jika benar, set session cookie (sessionid). CookieRequest menyimpan cookie tersebut.
        * Setelah login sukses, semua request berikutnya via CookieRequest otomatis menyertakan cookie sesi.
    * Protected request:
        * Endpoint Django memeriksa session; jika valid, kembalikan data; jika tidak, 401/403.
        * Protected request = request HTTP ke endpoint yang butuh autentikasi (mis. create product, list milik user, dsb.). Ini harus lewat CookieRequest yang sudah login.
        * Halaman bisa “diproteksi” jika kontennya bergantung pada protected request. Jika BasePage memanggil endpoint yang butuh login, maka BasePage sebaiknya dijaga (redirect ke Login jika belum login).
    * Logout:
        * Flutter panggil CookieRequest.logout ke endpoint logout.
        * Django menghapus sesi; CookieRequest mengosongkan cookie lokal.
    * UI Flutter:
        * Berdasarkan status CookieRequest (mis. loggedIn) tampilkan menu/halaman sesuai (mis. redirect ke home setelah login, sembunyikan menu protektif bila belum login).

7. Jelaskan bagaimana cara kamu mengimplementasikan _checklist_ di atas secara _step-by-step_! (bukan hanya sekadar mengikuti tutorial)\
Jawaban:\
Saya mengikuti alur besar dari tutorial, tapi di setiap langkah menyesuaikan dengan kebutuhan proyek “Pro Kit”:

    1. **Menyiapkan model dan endpoint Django**
        - Di sisi Django saya tidak memakai `NewsEntry`, tetapi membuat model baru `ProductEntry` yang sesuai dengan aplikasi Football Shop (field seperti `name`, `price`, `description`, `thumbnail`, `category`, `stock`, `rating`, dan `is_featured`).
        - Fungsi‑fungsi view dan URL seperti `create_product_flutter`, `show_json`, dan `show_json_by_user` saya sesuaikan agar memakai model produk ini, bukan model dari tutorial.
        - Saya memastikan struktur JSON yang dikirim dari Django sudah cocok dengan field tersebut karena nanti akan dipakai di Dart.

    2. **Membuat model Dart untuk JSON**
        - Di Flutter saya membuat file model `ProductEntry` (bukan `NewsEntry`) agar namanya konsisten dengan backend.
        - Saya menulis ulang `factory ProductEntry.fromJson` dan `toJson()` supaya field‑nya persis sama dengan atribut di model Django (nama key, tipe data, dan kemungkinan null).
        - Bagian ini paling berpengaruh, karena jika ada field yang salah nama/tipe, parsing JSON dari Django akan gagal dan halaman list/detail tidak bisa menampilkan data.

    3. **Menyesuaikan struktur folder dan import**
        - Package dan path saya rapikan: model diletakkan di folder `models/`, widget kartu di `widgets/`, dan halaman di `screens/`.
        - Semua import diganti agar menunjuk ke file yang tepat di proyek saya sendiri (misalnya `product_entry.dart`, `product_entry_list.dart`, `product_detail.dart`), bukan nama file dari tutorial.
        - Ini mencegah error “file not found” dan membuat dependency antar komponen lebih jelas.

    4. **Menghubungkan halaman dan route Flutter**
        - Saya menyesuaikan semua navigasi dengan widget yang sudah ada di proyek:
            - Menu di `BasePage` dan `ProKitDrawer` diarahkan ke `ProductEntryListPage`, `CreateProduct`, dan halaman `LoginPage`.
            - Kartu produk (`ProductEntryCard`) ketika ditekan akan membuka `ProductDetailPage(product: ...)`.
        - Nama class dan tipe parameter juga saya betulkan (misalnya `StatefulWidget`/`State` yang tadinya mengikuti tutorial saya ganti menjadi `ProductEntryListPage` dan `_ProductEntryListPageState`, dll.) agar konsisten dan mudah dibaca.

    5. **Menyesuaikan tampilan list dan detail dengan data produk**
        - Di halaman daftar produk saya menampilkan atribut yang diminta checklist: `name`, `price`, `description`, `thumbnail`, `category`, dan `is_featured` (plus field tambahan seperti `rating` dan `stock` sesuai desain aplikasi).
        - Di halaman detail produk saya menampilkan seluruh atribut model, dan menambahkan tombol kembali ke halaman daftar menggunakan `Navigator.pop(context)`.

    6. **Menghubungkan autentikasi Django–Flutter**
        - Saya menggunakan `CookieRequest` sebagai _single instance_ (dibagikan lewat `Provider` di `main.dart`) sehingga status login tersimpan dan bisa dipakai di semua halaman.
        - Endpoint login, register, dan logout saya sesuaikan dengan URL di proyek Django milik saya, lalu saya pakai di `LoginPage`, `ProKitDrawer`, dan kartu “Logout”.
        - Untuk checklist “hanya menampilkan item milik user login”, saya menambahkan parameter query `?mine=1` pada endpoint JSON dan membuat halaman `ProductEntryListPage(onlyMine: true)` yang memanggil URL tersebut.

    7. **Testing dan perbaikan error**
        - Setelah setiap perubahan besar (model, endpoint, atau halaman baru) saya jalankan aplikasi, mencoba login, menambah produk, melihat daftar produk, membuka detail, dan menguji filter “My Products”.
        - Saat terjadi error (misalnya backend mengembalikan HTML alih‑alih JSON), saya membaca pesan error di Flutter, mengecek kembali URL dan view Django, lalu menyesuaikan hingga responsnya berupa JSON list yang bisa diparse oleh `ProductEntry.fromJson`.
        
        Dengan cara ini, saya tidak hanya menyalin kode dari tutorial, tetapi benar‑benar menyesuaikan nama model, struktur data, URL, dan navigasi agar sesuai dengan aplikasi Pro Kit yang saya bangun.

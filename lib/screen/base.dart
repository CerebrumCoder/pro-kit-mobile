import 'package:flutter/material.dart';
import 'package:pro_kit/widgets/prokit_card.dart';
import 'package:pro_kit/widgets/prokit_drawer.dart';
import 'package:pro_kit/screen/create_product.dart';


// Ini adalah halaman dasar (base page) dari aplikasi Pro Kit.
class BasePage extends StatelessWidget {
  BasePage({super.key});

  final String nama = "Neal Guarddin";
  final String npm = "2406348282";
  final String kelas = "PBP E";

  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.my_library_books, Colors.blue),
    ItemHomepage("My Products", Icons.shopping_cart, Colors.green),
    ItemHomepage("Create Product", Icons.add, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // === APPBAR ===
      appBar: AppBar(
        title: Text("Pro Kit"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      // === DRAWER ===
      drawer: const ProKitDrawer(),

      // === BODY ===
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            // Memberikan jarak vertikal 16 unit.
            const SizedBox(height: 16.0),
            // Menempatkan widget berikutnya di tengah halaman.
            Center(
              child: Column(
                // Menyusun teks dan grid item secara vertikal.

                children: [
                  // Menampilkan teks sambutan dengan gaya tebal dan ukuran 18.
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di Football News',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // Grid untuk menampilkan ItemCard dalam bentuk grid 3 kolom.
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    // Agar grid menyesuaikan tinggi kontennya.
                    shrinkWrap: true,

                    // Menampilkan ItemCard untuk setiap item dalam list items.
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


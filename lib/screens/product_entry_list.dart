import 'package:flutter/material.dart';
import 'package:pro_kit/models/product_entry.dart';
import 'package:pro_kit/widgets/prokit_drawer.dart';
import 'package:pro_kit/screens/product_detail.dart';
import 'package:pro_kit/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  /// onlyMine = true → pakai filter ?mine=1 di show_json
  final bool onlyMine;

  const ProductEntryListPage({super.key, this.onlyMine = false});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    const baseUrl = "http://localhost:8000";

    final url = widget.onlyMine
        ? "$baseUrl/json/?mine=1"
        : "$baseUrl/json/";

    // Pakai CookieRequest.get, tapi cek dulu tipe datanya
    final response = await request.get(url);

    if (response is! List) {
      // Kalau bukan List, berarti backend mengirim HTML atau object lain
      throw FormatException(
        'Expected JSON list but got: ${response.runtimeType}\n$response',
      );
    }

    return response
        .where((e) => e != null)
        .map((e) => ProductEntry.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onlyMine ? 'My Products' : 'All Products'),
      ),
      drawer: const ProKitDrawer(),
      body: FutureBuilder<List<ProductEntry>>(
        future: fetchProducts(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              (snapshot.data == null && !snapshot.hasError)) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // TAMPILKAN pesan error mentah agar kelihatan jika isinya HTML
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return Center(
              child: Text(
                widget.onlyMine
                    ? 'No products found for your account.'
                    : 'No products available.',
                style: const TextStyle(fontSize: 16, color: Color(0xff59A5D8)),
              ),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) => ProductEntryCard(
              product: items[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: items[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
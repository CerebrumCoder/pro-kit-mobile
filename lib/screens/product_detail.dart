import 'package:flutter/material.dart';
import 'package:pro_kit/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.thumbnail, width: double.infinity, height: 200, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox()),
            const SizedBox(height: 12),
            Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(product.priceFormatted, style: const TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 6),
            Text('Category: ${product.category}'),
            const SizedBox(height: 6),
            Text('Stock: ${product.stock}'),
            const SizedBox(height: 6),
            Row(children: [
              // simple stars
              ...List.generate(5, (i) {
                return Icon(i < product.rating.round() ? Icons.star : Icons.star_border, color: Colors.amber, size: 18);
              }),
              const SizedBox(width: 8),
              Text(product.rating.toStringAsFixed(1)),
            ]),
            const SizedBox(height: 12),
            Text(product.description),
            const SizedBox(height: 12),
            Text('Views: ${product.productViews}'),
          ],
        ),
      ),
    );
  }
}
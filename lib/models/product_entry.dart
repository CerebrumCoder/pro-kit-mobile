import 'dart:convert';
import 'package:intl/intl.dart';

List<ProductEntry> productEntryFromJson(String str) =>
    List<ProductEntry>.from(
      json.decode(str).map((x) => ProductEntry.fromJson(x)),
    );

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Format double jadi Rupiah Indonesia.
String formatRupiah(double value) {
  final f = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return f.format(value);
}

// Parser robust untuk angka / string Rupiah.
double _parseRupiahToDouble(dynamic v, [double defaultValue = 0.0]) {
  if (v == null) return defaultValue;
  if (v is num) return v.toDouble();
  final s = v.toString().trim();
  if (s.isEmpty) return defaultValue;

  var cleaned = s.replaceAll(RegExp(r'(?i)rp'), '').replaceAll(' ', '');
  if (cleaned.contains(',') && cleaned.contains('.')) {
    cleaned = cleaned.replaceAll('.', '').replaceAll(',', '.');
  } else {
    cleaned = cleaned.replaceAll('.', '');
    cleaned = cleaned.replaceAll(',', '.');
  }
  return double.tryParse(cleaned) ?? defaultValue;
}

// Public alias, biar pemanggil lama tetap jalan.
double parseRupiahToDouble(dynamic v, [double defaultValue = 0.0]) =>
    _parseRupiahToDouble(v, defaultValue);

class ProductEntry {
  final String name;
  final double price;
  final String description;
  final String thumbnail;
  final String category;
  final int stock;
  final double rating;
  final bool isFeatured;
  final int productViews;
  final int id;

  ProductEntry({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.stock,
    required this.rating,
    required this.isFeatured,
    required this.productViews,
  });

  String get priceFormatted => formatRupiah(price);

  factory ProductEntry.fromJson(Map<String, dynamic> json) {
    final pv = json['productViews'] ?? json['product_views'] ?? 0;

    return ProductEntry(
      id: (json['id'] is int)
          ? json['id'] as int
          : int.tryParse('${json['id']}') ?? 0,
      name: json['name']?.toString() ?? '',
      price: parseRupiahToDouble(json['price']),
      description: json['description']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      stock: (json['stock'] is num)
          ? (json['stock'] as num).toInt()
          : int.tryParse('${json['stock']}') ?? 0,
      rating: (json['rating'] is num)
          ? (json['rating'] as num).toDouble()
          : double.tryParse('${json['rating']}') ?? 0.0,
      isFeatured: (json['is_featured'] is bool)
          ? json['is_featured'] as bool
          : (json['is_featured']?.toString() == '1'),
      productViews: (pv is num) ? pv.toInt() : int.tryParse('$pv') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'description': description,
        'thumbnail': thumbnail,
        'category': category,
        'stock': stock,
        'rating': rating,
        'is_featured': isFeatured,
        'product_views': productViews,
      };
}

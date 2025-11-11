import 'package:flutter/material.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbNailController = TextEditingController();
  String? _selectedCategory;
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  
  final List<String> _categories = [
    'Shirt',
    'Ball',
    'Accessory',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbNailController.dispose();
    _stockController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  String? _notEmpty(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Field ini wajib diisi';
    }
    return null;
  }

  String? _priceValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Price wajib diisi';
    };
    if (double.tryParse(v.trim()) == null) {
      return 'Price harus berupa angka';
    }
    return null;
  }

  String? _intValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Field ini wajib diisi';
    }
    if (int.tryParse(v.trim()) == null) {
      return 'Harus berupa bilangan bulat';
    }
    return null;
  }

  String? _ratingValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Rating wajib diisi';
    }
    final d = double.tryParse(v.trim());

    if (d == null) {
      return 'Rating harus berupa angka';
    }
    if (d < 0 || d > 5) {
      return 'Rating harus antara 0 dan 5';
    }
    return null;
  }

  // Opsional: validasi URL sederhana untuk thumbnail
  String? _thumbnailValidator(String? v) {
    // Thumbnail sekarang opsional: tidak validasi jika kosong.
    if (v == null || v.trim().isEmpty) {
      return 'Thumbnail wajib diisi!';
    }
    final uri = Uri.tryParse(v.trim());

    if (uri == null || !uri.isAbsolute) {
      return 'Masukkan URL yang valid';
    }
    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final price = double.tryParse(_priceController.text.trim());
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Price harus berupa angka!')),
      );
      return;
    }

    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final category = _selectedCategory ?? '';
    final thumbnailRaw = _thumbNailController.text.trim();
    final String? thumbnail = thumbnailRaw.isEmpty ? null : thumbnailRaw;
    

    final stock = int.tryParse(_stockController.text.trim());
    final rating = double.tryParse(_ratingController.text.trim());

    if (stock == null || rating == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali input numeric')),
      );
      return;
    }

    final product = {
      'name': name,
      'price': price,
      'description': description,
      'thumbnail': thumbnail,
      'category': category,
      'stock': stock,
      'rating': rating,
    };
    

    // Fungsi bawaan dari Flutter untuk munculin dialog
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text("Product Created"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Name: ${product['name']}'),
                Text('Price: Rp ${product['price']}'),                
                Text('Description: ${product['description']}'),
                Text('Thumbnail URL: ${product['thumbnail']}'),
                Text('Category: ${product['category']}'),
                Text('Stock: ${product['stock']}'),
                Text('Rating (0-5): ${product['rating']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                _formKey.currentState!.reset();
                _nameController.clear();
                _priceController.clear();
                _descriptionController.clear();
                _thumbNailController.clear();
                _selectedCategory = null;
                _stockController.clear();
                _ratingController.clear();
                setState(() {});
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: _notEmpty,
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: _priceValidator,
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 4,
                  validator: _notEmpty,
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _thumbNailController,
                  decoration: const InputDecoration(labelText: 'Thumbnail URL'),
                  validator: _thumbnailValidator,
                ),
                const SizedBox(height: 12,),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),

                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  
                  validator: _notEmpty,
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _stockController,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                  validator: _intValidator,
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _ratingController,
                  decoration: const InputDecoration(labelText: 'Rating (0-5)'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: _ratingValidator,
                ),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: _save, child: const Text('Save Product'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
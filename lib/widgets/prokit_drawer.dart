import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:pro_kit/screens/base.dart';
import 'package:pro_kit/screens/create_product.dart';
import 'package:pro_kit/screens/login.dart';
import 'package:pro_kit/screens/product_entry_list.dart';
import 'package:provider/provider.dart';

class ProKitDrawer extends StatelessWidget {
  const ProKitDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Text(
                  "Pro Kit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                Padding(padding: EdgeInsets.all(10)),

                Text(
                  "All Products will be displayed here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                )
                
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => BasePage()));
            },
          ),

          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Add Product'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateProduct()));
            },
          ),
          ListTile(
              leading: const Icon(Icons.add_reaction_rounded),
              title: const Text('Product List'),
              onTap: () {
                  // Route to Product list page
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
                  );
              },
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text("Logout"),
            onTap: () async {
              final response = await request.logout("http://localhost:8000/auth/logout/");

              String message = response["message"] ?? "Logged out";
              bool status = response["status"] ?? false;

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );

              if (status) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                ); 
              }
            },
          ),
        ],
      ),
    );
  }
}
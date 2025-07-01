import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx_flutter/components/my_drawer.dart';
import 'package:shopx_flutter/components/my_product_tile.dart';
import 'package:shopx_flutter/models/shop.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Shop>().shop;

    // Filter products based on search
    final filteredProducts = products.where((product) {
      final nameLower = product.name.toLowerCase();
      final queryLower = searchQuery.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Shop Page"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/cart_page"),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          const SizedBox(height: 10),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Subtitle
          Center(
            child: Text(
              "Pick from a selected list of premium products",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Product List
          SizedBox(
            height: 650,
            child: filteredProducts.isEmpty
                ? const Center(child: Text("No products found."))
                : ListView.builder(
                    itemCount: filteredProducts.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return MyProductTile(product: product);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx_flutter/models/product.dart';
import 'package:shopx_flutter/models/shop.dart';

class MyProductTile extends StatefulWidget {
  final Product product;

  const MyProductTile({super.key, required this.product});

  @override
  State<MyProductTile> createState() => _MyProductTileState();
}

class _MyProductTileState extends State<MyProductTile> {
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 1) quantity--;
    });
  }

  void addToCart(BuildContext context) {
    for (int i = 0; i < quantity; i++) {
      context.read<Shop>().addToCart(widget.product);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${widget.product.name} added x$quantity")),
    );

    setState(() {
      quantity = 1; // reset
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // product image
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  child: Image.asset(widget.product.imagePath),
                ),
              ),

              const SizedBox(height: 25),

              // product name
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),

              // product description
              Text(
                widget.product.description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // product price + cart icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rs. ${widget.product.price.toStringAsFixed(2)}"),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => addToCart(context),
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // quantity button: - 1 +
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: decreaseQuantity,
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: increaseQuantity,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

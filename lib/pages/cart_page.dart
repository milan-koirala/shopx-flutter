import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx_flutter/components/my_button.dart';
import 'package:shopx_flutter/models/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = context.watch<Shop>();
    final cart = shop.cart;
    final selected = shop.selectedForCheckout;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? const Center(child: Text("Your cart is empty."))
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      final isSelected = selected.contains(item);

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Checkbox (centered)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (value) {
                                    context.read<Shop>().toggleProductSelection(item, value!);
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(width: 10),

                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.imagePath,
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name,
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text("Unit: Rs. ${item.price.toStringAsFixed(2)}"),
                                  Text("Total: Rs. ${(item.price * item.quantity).toStringAsFixed(2)}"),
                                ],
                              ),
                            ),

                            // Delete + Quantity Controller
                            Column(
                              children: [
                                // Delete Icon
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () {
                                    context.read<Shop>().removeFromCart(item);
                                  },
                                ),

                                // Quantity Controller
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: () =>
                                          context.read<Shop>().decreaseQuantity(item),
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () =>
                                          context.read<Shop>().increaseQuantity(item),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Checkout button
          if (selected.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(30),
              child: MyButton(
                child: const Text("Proceed to Checkout"),
                onTap: () {
                  Navigator.pushNamed(context, "/checkout_page");
                },
              ),
            ),
        ],
      ),
    );
  }
}

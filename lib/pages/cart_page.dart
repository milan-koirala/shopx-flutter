import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx_flutter/components/my_button.dart';
import 'package:shopx_flutter/models/product.dart';
import 'package:shopx_flutter/models/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // remove item from cart with confirmation
  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item from your cart?"),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<Shop>().removeFromCart(product);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  // increase quantity
  void increaseQuantity(BuildContext context, Product product) {
    context.read<Shop>().increaseQuantity(product);
  }

  // decrease quantity
  void decreaseQuantity(BuildContext context, Product product) {
    final currentQuantity = product.quantity;
    if (currentQuantity > 1) {
      context.read<Shop>().decreaseQuantity(product);
    } else {
      // confirm removal when quantity is 1
      removeItemFromCart(context, product);
    }
  }

  // pay button action
  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("User wants to pay! Connect this app to your payment backend."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;

    final total = cart.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cart Page"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // cart list
          Expanded(
            child: cart.isEmpty
                ? const Center(child: Text("Your cart is empty.."))
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.imagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                        title: Text(item.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Unit: Rs. ${item.price.toStringAsFixed(2)}"),
                            Text("Total: Rs. ${(item.price * item.quantity).toStringAsFixed(2)}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => decreaseQuantity(context, item),
                            ),
                            Text(
                              item.quantity.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => increaseQuantity(context, item),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // grand total
          if (cart.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "Grand Total: Rs. ${total.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

          // pay button
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: MyButton(
              onTap: () => payButtonPressed(context),
              child: const Text("PAY NOW"),
            ),
          ),
        ],
      ),
    );
  }
}

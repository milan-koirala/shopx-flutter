import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx_flutter/models/shop.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPayment = 'cash';

  @override
  Widget build(BuildContext context) {
    final selectedItems = context.watch<Shop>().selectedForCheckout;

    final total = selectedItems.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Payment Method:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            RadioListTile<String>(
              value: 'cash',
              groupValue: selectedPayment,
              title: const Text("Cash on Delivery"),
              onChanged: (value) => setState(() => selectedPayment = value!),
            ),
            RadioListTile<String>(
              value: 'esewa',
              groupValue: selectedPayment,
              title: const Text("eSewa"),
              onChanged: (value) => setState(() => selectedPayment = value!),
            ),
            RadioListTile<String>(
              value: 'khalti',
              groupValue: selectedPayment,
              title: const Text("Khalti"),
              onChanged: (value) => setState(() => selectedPayment = value!),
            ),

            const SizedBox(height: 20),

            Text("Total: Rs. ${total.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text("Payment method: $selectedPayment\n\nOrder placed successfully!"),
                    ),
                  );
                  context.read<Shop>().clearSelectedForCheckout();
                },
                child: const Text("Confirm Payment"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

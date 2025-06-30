import 'package:flutter/material.dart';
import 'package:shopx_flutter/components/my_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated logo
              Icon(
                Icons.shopping_bag_rounded,
                size: 100,
                color: colorScheme.primary,
              ),

              const SizedBox(height: 20),

              // App title
              const Text(
                "ShopX",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              // App subtitle
              Text(
                "Premium Quality Products",
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.inversePrimary,
                  letterSpacing: 0.5,
                ),
              ),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                child: MyButton(
                  onTap: () => Navigator.pushNamed(context, "/shop_page"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

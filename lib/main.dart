import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx_flutter/models/shop.dart';
import 'package:shopx_flutter/pages/cart_page.dart';
import 'package:shopx_flutter/pages/checkout_page.dart';
import 'package:shopx_flutter/pages/intro_page.dart';
import 'package:shopx_flutter/pages/languages_page.dart';
import 'package:shopx_flutter/pages/settings_page.dart';
import 'package:shopx_flutter/pages/shop_page.dart';
import 'package:shopx_flutter/themes/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => Shop()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        "/intro_page": (context) => const IntroPage(),
        "/shop_page": (context) => const ShopPage(),
        "/cart_page": (context) => const CartPage(),
        "/setting_page": (context) => SettingsPage(),
        "/checkout_page": (context) => const CheckoutPage(),
        "/language_page": (context) => const LanguagesPage(),
      },
    );
  }
}

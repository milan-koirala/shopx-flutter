import 'package:flutter/material.dart';
import 'package:shopx_flutter/models/product.dart';

class Shop extends ChangeNotifier {
  // products for sale
  final List<Product> _shop = [
    // 1st product
    Product(
      name: "Apple Iphone 14 4GB 256GB",
      price: 150000,
      description: "Powerful phone with a great display and plenty of storage.",
      
      imagePath: "assets/iphone14.jpeg",
    ),

    // 2nd product
    Product(
      name: "Smart Watch 2",
      price: 4999,
      description: "Stay connected and track your fitness with Smart Watch 2.",
      imagePath: "assets/digitalwatch.jpg",
    ),

    // 3rd product
    Product(
      name: "Realme Phone Original Charger",
      price: 1599,
      description: "Fast and reliable charging with the original Realme adapter.",
      imagePath: "assets/mobilecharger.jpeg",
    ),

    // 4th product
    Product(
      name: "Apple HeadSet 2025",
      price: 25999,
      description: "Enjoy clear sound and comfortable fit, perfect for calls and music.",
      imagePath: "assets/headphone.jpg",
    ),
  ];

  // user cart
  List<Product> _cart = [];

  // get product list
  List<Product> get shop => _shop;

  // get user cart
  List<Product> get cart => _cart;

  // add item to cart
  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  // remove item from cart
  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}

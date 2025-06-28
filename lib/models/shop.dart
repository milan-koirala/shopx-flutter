import 'package:flutter/material.dart';
import 'package:shopx_flutter/models/product.dart';

class Shop extends ChangeNotifier {
  // products for sale
  final List<Product> _shop = [
    // 1st product
    Product(
      name: "Product 1",
      price: 999,
      description: "This is the first product",
      // imagePath: imagePath
    ),

    // 2nd product
    Product(
      name: "Product 2",
      price: 1299,
      description: "This is the second product",
      // imagePath: imagePath
    ),

    // 3rd product
    Product(
      name: "Product 3",
      price: 1299,
      description: "This is the third product",
      // imagePath: imagePath
    ),

    // 4th product
    Product(
      name: "Product 4",
      price: 1299,
      description: "This is the fourth product",
      // imagePath: imagePath
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

import 'package:flutter/material.dart';
import 'package:shopx_flutter/models/product.dart';

class Shop extends ChangeNotifier {
  // products for sale
  final List<Product> _selectedForCheckout = [];
  final List<Product> _wishlist = [];
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
      description:
          "Fast and reliable charging with the original Realme adapter.",
      imagePath: "assets/mobilecharger.jpeg",
    ),

    // 4th product
    Product(
      name: "Apple HeadSet 2025",
      price: 25999,
      description:
          "Enjoy clear sound and comfortable fit, perfect for calls and music.",
      imagePath: "assets/headphone.jpg",
    ),
  ];

  // user cart
  List<Product> _cart = [];

  // get product list
  List<Product> get shop => _shop;

  // get user cart
  List<Product> get cart => _cart;

  // get wishlist
  List<Product> get wishlist => _wishlist;

  // add item to cart
  void addToCart(Product product) {
    final index = _cart.indexWhere((item) => item.name == product.name);

    if (index != -1) {
      // Already in cart → increase quantity
      _cart[index].quantity += 1;
    } else {
      // Not in cart → add with quantity = 1
      _cart.add(product.copyWithQuantity(1));
    }

    notifyListeners();
  }

  // remove item from cart
  void removeFromCart(Product product) {
    final index = _cart.indexWhere((item) => item.name == product.name);

    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity -= 1;
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  // increase quantity of a product in cart
  void increaseQuantity(Product product) {
    final index = _cart.indexWhere((item) => item.name == product.name);
    if (index != -1) {
      _cart[index].quantity++;
      notifyListeners();
    }
  }

  // decrease quantity of a product in cart
  void decreaseQuantity(Product product) {
    final index = _cart.indexWhere((item) => item.name == product.name);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  // store user-selected products for checkout
  List<Product> get selectedForCheckout => _selectedForCheckout;

  // Add or remove a product from the selected checkout list
  // - If [isSelected] is true, adds the product (if not already present)
  // - If false, removes it from the selection
  void toggleProductSelection(Product product, bool isSelected) {
    if (isSelected) {
      if (!_selectedForCheckout.contains(product)) {
        _selectedForCheckout.add(product);
      }
    } else {
      _selectedForCheckout.remove(product);
    }
    notifyListeners();
  }

  // Clears all selected items after a successful checkout
  void clearSelectedForCheckout() {
    _selectedForCheckout.clear();
    notifyListeners();
  }

  // Wishlist logic
  void toggleWishlist(Product product) {
    final exists = _wishlist.any((item) => item.name == product.name);
    if (exists) {
      _wishlist.removeWhere((item) => item.name == product.name);
    } else {
      _wishlist.add(product);
    }
    notifyListeners();
  }

  bool isInWishlist(Product product) {
    return _wishlist.any((item) => item.name == product.name);
  }
}

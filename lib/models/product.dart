class Product {
  final String name;
  final double price;
  final String description;
  final String imagePath;
  int quantity; // <-- NEW

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.quantity = 1,
  });

  Product copyWithQuantity(int qty) {
    return Product(
      name: name,
      price: price,
      description: description,
      imagePath: imagePath,
      quantity: qty,
    );
  }
}

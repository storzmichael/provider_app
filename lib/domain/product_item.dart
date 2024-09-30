class Product {
  final String? title;
  final String? description;
  final double? price;
  int availability;
  int quantity;

  Product({
    required this.title,
    required this.description,
    required this.price,
    this.availability = 10,
    this.quantity = 1,
  });
}

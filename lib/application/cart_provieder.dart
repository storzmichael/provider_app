import 'package:flutter/material.dart';
import 'package:provider_app/data/product_list.dart';

import 'package:provider_app/domain/product_item.dart';

class CartProvider with ChangeNotifier {
  List<Product> get _selectedProducts => selectedProducts;
  List<Product> get _products => products;

  int get totalProducts => _selectedProducts.fold(0, (sum, product) => sum + product.quantity);

  double get totalPrice {
    double total = 0.0;
    for (var product in _selectedProducts) {
      total += product.price! * product.quantity;
    }
    return total;
  }

  void add(Product product, BuildContext context) {
    if (product.availability > 0) {
      final existingProduct = _selectedProducts.firstWhere(
        (prod) => prod.title == product.title,
        orElse: () => Product(title: '', description: '', price: 0, availability: 0),
      );

      if (existingProduct.title != '') {
        existingProduct.quantity++;
      } else {
        _selectedProducts.add(Product(
          title: product.title,
          description: product.description,
          price: product.price,
          availability: product.availability,
          quantity: 1,
        ));
      }

      product.availability--;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dieses Produkt ist nicht mehr verfügbar.'),
        ),
      );
    }
  }

  void removeProduct(Product product, BuildContext context) {
    final existingProduct = _selectedProducts.firstWhere(
      (prod) => prod.title == product.title,
      orElse: () => Product(title: '', description: '', price: 0, availability: 0), // Platzhalter
    );

    if (existingProduct.title != '') {
      if (existingProduct.quantity > 1) {
        existingProduct.quantity--;
      } else {
        _selectedProducts.remove(existingProduct);
      }

      product.availability++;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dieses Produkt ist nicht im Warenkorb.'),
        ),
      );
    }
  }

  void clearCart() {
    for (var product in _selectedProducts) {
      final originalProduct = _products.firstWhere((product) => product.title == product.title);
      originalProduct.availability += product.quantity;
    }
    _selectedProducts.clear();
    notifyListeners();
  }
}

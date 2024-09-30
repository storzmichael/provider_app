import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/application/cart_provieder.dart';
import 'package:provider_app/data/product_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = selectedProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Warenkorb'),
        actions: [
          IconButton(
            onPressed: () {
              if (cartItems.isNotEmpty) {
                cartProvider.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Warenkorb wurde geleert.'),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Der Warenkorb ist leer'),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartItems[index];
                        return ListTile(
                            leading: Text(
                              '${product.quantity.toString()} x',
                              style: const TextStyle(fontSize: 18),
                            ),
                            title: Text(product.title!),
                            subtitle: Text(
                              'Gesamt: ${(product.price! * product.quantity).toStringAsFixed(2)}€',
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  cartProvider.removeProduct(product, context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Produkt wurde aus dem Warenkorb entfernt.'),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                )));
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Gesamtpreis: ${cartProvider.totalPrice.toStringAsFixed(2)}€',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Checkout noch nicht implementiert'),
                        ),
                      );
                    },
                    child: const Text('Zur Kasse'),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/domain/product_item.dart';
import 'package:provider_app/application/cart_provieder.dart';

class DetailPage extends StatelessWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produktdetails'),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 32,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Consumer<CartProvider>(
                  builder: (context, shoppingProvider, child) {
                    return shoppingProvider.totalProducts > 0
                        ? Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            child: Text(
                              '${shoppingProvider.totalProducts}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Titel:\n${product.title}'),
            const SizedBox(height: 12),
            Text('Beschreibung:\n${product.description}'),
            const SizedBox(height: 12),
            Text('Preis:\n${product.price}€'),
            const SizedBox(height: 12),
            Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text('Verfügbarkeit:\n${product.availability} Stück');
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CartProvider>(context, listen: false).add(product, context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/data/product_list.dart';

import 'package:provider_app/presentation/detail_page.dart';
import 'package:provider_app/application/cart_provieder.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key});

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
                  Navigator.pushNamed(context, '/cart'); // Zum Warenkorb navigieren
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 32,
                ),
              ),
              // Badge, der die Anzahl der Produkte im Warenkorb anzeigt
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
                        : Container(); // Leeres Widget, wenn keine Artikel im Warenkorb sind
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
      body: Center(
        child: Column(
          children: [
            const Text('Produkte'),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  var product = products[index];
                  return ListTile(
                    title: Text(product.title!),
                    subtitle: Text(product.description!),
                    trailing: Text('${product.price}€'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(product: product),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

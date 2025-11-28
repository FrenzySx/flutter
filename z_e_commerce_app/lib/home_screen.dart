import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'models/cart.dart';
import 'models/product.dart';

class HomeScreen extends StatelessWidget {
  final Cart cart;
  const HomeScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        actions: [
          ListenableBuilder(
            listenable: cart,
            builder: (context, _) => IconButton(
              tooltip: 'Cart',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartScreen(cart: cart)),
                );
              },
              icon: Badge(
                isLabelVisible: cart.count > 0,
                label: Text('${cart.count}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, i) =>
            _ProductCard(product: products[i], cart: cart),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final Cart cart;
  const _ProductCard({required this.product, required this.cart});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Icon(product.icon, size: 64)),
            Text(product.name, style: textTheme.titleMedium),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                cart.add(product);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('${product.name} added to cart')),
                  );
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

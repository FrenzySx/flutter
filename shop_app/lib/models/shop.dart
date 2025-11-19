import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class Shop extends ChangeNotifier {
  final List<Product> _shop = [
    Product(name: 'Product 1', price: 99.99, description: 'Item Description'),

    Product(name: 'Product 2', price: 49.99, description: 'Item Description'),

    Product(name: 'Product 3', price: 39.99, description: 'Item Description'),

    Product(name: 'Product 4', price: 79.99, description: 'Item Description'),
  ];

  final Map<Product, int> _cart = {};

  List<Product> get shop => _shop;

  List<Product> get cart => _cart.keys.toList();

  int quantityOf(Product item) => _cart[item] ?? 0;

  int get itemCount => _cart.values.fold(0, (sum, q) => sum + q);

  double get total =>
      _cart.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void addToCart(Product item) {
    _cart.update(item, (q) => q + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeFromCart(Product item) {
    final q = _cart[item];
    if (q == null) return;
    if (q > 1) {
      _cart[item] = q - 1;
    } else {
      _cart.remove(item);
    }
    notifyListeners();
  }
}

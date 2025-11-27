import 'package:flutter/foundation.dart';
import 'product.dart';

class Cart extends ChangeNotifier {
  final Map<Product, int> _items = {};

  List<Product> get products => _items.keys.toList();

  int quantityOf(Product product) => _items[product] ?? 0;

  int get count => _items.values.fold(0, (sum, q) => sum + q);

  double get total =>
      _items.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  void add(Product product) {
    _items.update(product, (q) => q + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void remove(Product product) {
    final q = _items[product];
    if (q == null) return;
    if (q > 1) {
      _items[product] = q - 1;
    } else {
      _items.remove(product);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

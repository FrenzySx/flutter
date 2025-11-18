import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Dunk',
      price: '120',
      imagePath: 'lib/images/dunk.png',
      description: 'Fly low signature shoe',
    ),

    Shoe(
      name: 'Runner',
      price: '180',
      imagePath: 'lib/images/runner.png',
      description: 'Runner shoe dih',
    ),

    Shoe(
      name: 'Zoom',
      price: '250',
      imagePath: 'lib/images/zoom.png',
      description: 'Zoom shoe is cool',
    ),

    Shoe(
      name: 'airmax',
      price: '180',
      imagePath: 'lib/images/airmax.png',
      description: 'AirMaxxing',
    ),
  ];

  final Map<Shoe, int> userCart = {};

  List<Shoe> getShoeList() {
    return shoeShop;
  }

  List<Shoe> getUserCart() {
    return userCart.keys.toList();
  }

  int quantityOf(Shoe shoe) => userCart[shoe] ?? 0;

  double get total => userCart.entries.fold(
    0,
    (sum, e) => sum + double.parse(e.key.price) * e.value,
  );

  void clearCart() {
    userCart.clear();
    notifyListeners();
  }

  void addItemToCart(Shoe shoe) {
    userCart.update(shoe, (q) => q + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeItemFromCart(Shoe shoe) {
    final q = userCart[shoe];
    if (q == null) return;
    if (q > 1) {
      userCart[shoe] = q - 1;
    } else {
      userCart.remove(shoe);
    }
    notifyListeners();
  }
}

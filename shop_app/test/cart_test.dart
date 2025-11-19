import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/models/shop.dart';

void main() {
  test('cart groups same product and tracks quantity', () {
    final shop = Shop();
    final item = shop.shop.first;
    shop.addToCart(item);
    shop.addToCart(item);
    expect(shop.cart.length, 1);
    expect(shop.itemCount, 2);
    expect(shop.total, item.price * 2);
    shop.removeFromCart(item);
    shop.removeFromCart(item);
    expect(shop.cart, isEmpty);
  });
}

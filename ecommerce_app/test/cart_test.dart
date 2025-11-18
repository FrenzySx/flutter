import 'package:ecommerce_app/models/cart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('cart groups same shoe and tracks quantity', () {
    final cart = Cart();
    final shoe = cart.getShoeList().first;
    cart.addItemToCart(shoe);
    cart.addItemToCart(shoe);
    expect(cart.getUserCart().length, 1);
    expect(cart.quantityOf(shoe), 2);
    expect(cart.total, double.parse(shoe.price) * 2);
    cart.removeItemFromCart(shoe);
    cart.removeItemFromCart(shoe);
    expect(cart.getUserCart(), isEmpty);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:z_e_commerce_app/main.dart';
import 'package:z_e_commerce_app/models/cart.dart';
import 'package:z_e_commerce_app/models/product.dart';

void main() {
  test('cart tracks quantity and total', () {
    final cart = Cart();
    final p = products.first;
    cart.add(p);
    cart.add(p);
    expect(cart.count, 2);
    expect(cart.products.length, 1);
    expect(cart.total, p.price * 2);
    cart.remove(p);
    cart.remove(p);
    expect(cart.products, isEmpty);
  });

  testWidgets('add product then checkout empties cart', (tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Store'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Add').first);
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byTooltip('Cart'));
    await tester.pumpAndSettle();
    expect(find.text(products.first.name), findsOneWidget);

    await tester.tap(find.text('Checkout'));
    await tester.pumpAndSettle();
    expect(find.text('Order placed!'), findsOneWidget);
  });
}
